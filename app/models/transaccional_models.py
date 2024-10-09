from app.models.conexion import obtener_conexion
from flask import Blueprint, request, jsonify       

def obtener_marcas():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_marca, nom_marca, estado_marca
            FROM marca
            ORDER BY nom_marca
            """
            cursor.execute(sql)
            resultado = cursor.fetchall()
            marcas = []
            for marca in resultado:
                marcas.append({
                    'id_marca': marca['id_marca'],
                    'nom_marca': marca['nom_marca'],
                    'estado_marca': marca['estado_marca']
                }
            ) 
            return marcas
    
    finally:
        conexion.close()



def obtener_categorias():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_categoria, nom_categoria, estado_categoria
            FROM categoria
            """
            cursor.execute(sql)
            resultado = cursor.fetchall()
            categorias = []
            for categoria in resultado:
                categorias.append({
                    'id_categoria': categoria['id_categoria'],
                    'nom_categoria': categoria['nom_categoria'],
                    'estado_categoria': categoria['estado_categoria']
                }
            ) 
            return categorias
    
    finally:
        conexion.close()


# Controlador de las notas de ingreso
def obtener_ingresos():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT 
                DATE_FORMAT(n.fecha, '%Y-%m-%d') AS fecha,
                c.num_comprobante AS documento,
                COALESCE(d.razon_social, CONCAT(d.nombres, ' ', d.apellidos)) AS proveedor,
                n.glosa AS concepto,
                COALESCE(ad.nom_almacen, 'Almacen externo') AS almacen_D,
                CASE 
                    WHEN n.estado_nota = 0 THEN 'Activo' 
                    WHEN n.estado_nota = 1 THEN 'Inactivo' 
                    ELSE 'Desconocido' 
                END AS estado,
                COALESCE(u.usua, '') as usuario
            FROM 
                nota n
            LEFT JOIN 
                destinatario d ON n.id_destinatario = d.id_destinatario
            LEFT JOIN comprobante c ON n.id_comprobante = c.id_comprobante
            LEFT JOIN almacen ad ON n.id_almacenD = ad.id_almacen
            LEFT JOIN usuario u ON n.id_usuario = u.id_usuario
            WHERE 
                n.id_tiponota = 1
            ORDER BY 
                n.fecha, documento;
            """
            cursor.execute(sql)
            return cursor.fetchall()  # Asegúrate de retornar solo los datos
    except Exception as e:
        print(f"Error: {e}")
        return []


# def obtener_ingresos():
#     fecha_i = request.args.get('fecha_i', '2022-01-01')
#     fecha_e = request.args.get('fecha_e', '2027-12-27')
#     razon_social = request.args.get('razon_social', '')
#     almacen = request.args.get('almacen', '%')
#     usuario = request.args.get('usuario', '')
#     documento = request.args.get('documento', '')
#     estado = request.args.get('estado', '%')

#     try:
#         conexion = obtener_conexion()
#         with conexion.cursor() as cursor:
#             sql = """
#             SELECT 
#                 n.id_nota AS id,
#                 DATE_FORMAT(n.fecha, '%Y-%m-%d') AS fecha,
#                 c.num_comprobante AS documento,
#                 ao.nom_almacen AS almacen_O,
#                 COALESCE(ad.nom_almacen,'Almacen externo') AS almacen_D,
#                 COALESCE(d.razon_social, CONCAT(d.nombres, ' ', d.apellidos)) AS proveedor,
#                 n.glosa AS concepto,
#                 n.estado_nota AS estado,
#                 ROUND(IFNULL(SUM(dn.total), 0), 2) AS total_nota,
#                 COALESCE(u.usua, '') as usuario
#             FROM 
#                 nota n
#             LEFT JOIN 
#                 destinatario d ON n.id_destinatario = d.id_destinatario
#             LEFT JOIN comprobante c ON n.id_comprobante = c.id_comprobante
#             LEFT JOIN almacen ao ON n.id_almacenO = ao.id_almacen
#             LEFT JOIN almacen ad ON n.id_almacenD = ad.id_almacen
#             LEFT JOIN detalle_nota dn ON n.id_nota = dn.id_nota
#             LEFT JOIN usuario u ON n.id_usuario = u.id_usuario
#             WHERE 
#                 n.id_tiponota = 1
#                 AND c.num_comprobante LIKE %s
#                 AND DATE_FORMAT(n.fecha, '%%Y-%%m-%%d') >= %s
#                 AND DATE_FORMAT(n.fecha, '%%Y-%%m-%%d') <= %s
#                 AND (d.razon_social LIKE %s OR CONCAT(d.nombres, ' ', d.apellidos) LIKE %s)
#                 {}
#                 {}
#                 {}
#             GROUP BY 
#                 id, n.fecha, documento, almacen_O, almacen_D, proveedor, concepto, estado
#             ORDER BY 
#                 n.fecha, documento;
#             """.format(
#                 "AND n.id_almacenD = %s" if almacen != '%' else "",
#                 "AND n.estado_nota LIKE %s" if estado != '%' else "",
#                 "AND (u.usua LIKE %s OR u.usua IS NULL)" if usuario else ""
#             )
            
#             params = [
#                 f"%{documento}%", fecha_i, fecha_e, f"%{razon_social}%", f"%{razon_social}%",
#                 *( [almacen] if almacen != '%' else [] ),
#                 *( [f"%{estado}%"] if estado != '%' else [] ),
#                 *( [f"%{usuario}%"] if usuario else [] )
#             ]
            
#             cursor.execute(sql, params)
#             ingresos_result = cursor.fetchall()

        # Obtener detalles de cada ingreso
        ingresos = []
        for ingreso in ingresos_result:
            with conexion.cursor() as cursor:
                sql_detalles = """
                SELECT p.id_producto AS codigo, m.nom_marca AS marca, sc.nom_subcat AS categoria, 
                    p.descripcion AS descripcion, dn.cantidad AS cantidad, p.undm AS unidad, 
                    dn.precio AS precio, dn.total AS total
                FROM producto p 
                INNER JOIN marca m ON p.id_marca = m.id_marca
                INNER JOIN sub_categoria sc ON p.id_subcategoria = sc.id_subcategoria
                INNER JOIN detalle_nota dn ON p.id_producto = dn.id_producto
                WHERE dn.id_nota = %s
                """
                cursor.execute(sql_detalles, (ingreso['id'],))
                detalles = cursor.fetchall()
                ingreso['detalles'] = detalles
                ingresos.append(ingreso)

        return jsonify({'code': 1, 'data': ingresos})

    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500
    

# Obtener almacenes

def obtener_almacenes():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT a.id_almacen AS id, a.nom_almacen AS almacen, 
                COALESCE(s.nombre_sucursal,'Sin Sucursal') AS sucursal 
            FROM almacen a 
            LEFT JOIN sucursal_almacen sa ON a.id_almacen = sa.id_almacen
            LEFT JOIN sucursal s ON sa.id_sucursal = s.id_sucursal
            WHERE a.estado_almacen = 1;
            """
            cursor.execute(sql)
            almacenes = cursor.fetchall()
            return jsonify({'code': 1, 'data': almacenes})

    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500


def obtener_productos():
    descripcion = request.args.get('descripcion', '')
    almacen = request.args.get('almacen', 1)
    cod_barras = request.args.get('cod_barras', '')

    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT p.id_producto AS codigo, p.descripcion AS descripcion, 
                m.nom_marca AS marca, COALESCE(i.stock, 0) AS stock, p.cod_barras as cod_barras 
            FROM producto p 
            INNER JOIN marca m ON p.id_marca = m.id_marca 
            INNER JOIN inventario i ON p.id_producto = i.id_producto AND i.id_almacen = %s
            WHERE i.stock > 0
            """
            params = [almacen]
            if descripcion:
                sql += " AND p.descripcion LIKE %s"
                params.append(f"%{descripcion}%")
            if cod_barras:
                sql += " AND p.cod_barras LIKE %s"
                params.append(f"%{cod_barras}%")

            sql += " GROUP BY p.id_producto, p.descripcion, m.nom_marca, i.stock"
            cursor.execute(sql, params)
            productos = cursor.fetchall()

        return jsonify({'code': 1, 'data': productos})

    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500

'''
Consultas Nota de Salida
'''
def obtener_nota_salida():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT 
                N.fecha,
                C.num_comprobante,
                COALESCE(NULLIF(D.razon_social, ''), CONCAT(D.nombres, ' ', D.apellidos)) AS nombre_o_razon_social,
                N.glosa,
                CASE 
                    WHEN N.estado_nota = 0 THEN 'Activo' 
                    WHEN N.estado_nota = 1 THEN 'Inactivo' 
                    ELSE 'Desconocido' 
                END AS estado,
                U.usua
            FROM nota N 
            INNER JOIN tipo_nota TN ON TN.id_tiponota = N.id_tiponota
            INNER JOIN comprobante C ON N.id_comprobante = C.id_comprobante
            INNER JOIN destinatario D ON D.id_destinatario = N.id_destinatario
            INNER JOIN usuario U ON U.id_usuario = N.id_usuario
            WHERE N.id_tiponota = 2;
            """

            cursor.execute(sql)
            return cursor.fetchall()  # Asegúrate de retornar solo los datos
    except Exception as e:
        print(f"Error: {e}")
        return []
    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500
    


'''
Consultas Productos
'''
#Obtener todos los productos
def obtener_inventario():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT PR.id_producto, PR.descripcion as descripcion, CA.nom_subcat as nom_marca, MA.nom_marca as nom_subcat, PR.undm as undm, 
                CAST(PR.precio AS DECIMAL(10, 2)) AS precio, PR.cod_barras as cod_barras, PR.estado_producto AS estado
            FROM producto PR INNER JOIN marca MA ON MA.id_marca = PR.id_marca
            INNER JOIN sub_categoria CA ON CA.id_subcategoria = PR.id_subcategoria
            ORDER BY PR.id_producto DESC;"""
            cursor.execute(sql)
            return cursor.fetchall()
    except Exception as e:
        print(f"Error: {e}")
        return []

