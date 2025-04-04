from datetime import datetime
from barcode.writer import ImageWriter
from app.models.conexion import obtener_conexion
from flask import Blueprint, request, jsonify, send_file
import barcode
import io
import random
from barcode.writer import ImageWriter
import json
from spire.xls import *
from spire.xls.common import *
# from asposecells.api import Workbook as wk
import openpyxl

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

def obtener_subcategorias_por_categoria(categoria_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_subcategoria, nom_subcat
            FROM sub_categoria
            WHERE id_categoria = %s AND estado_subcat = 1
            """
            cursor.execute(sql, (categoria_id,))
            resultado = cursor.fetchall()
            subcategorias = [
                {
                    'id_subcategoria': subcat['id_subcategoria'],
                    'nom_subcat': subcat['nom_subcat']
                }
                for subcat in resultado
            ]
            return subcategorias
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
            resultados = cursor.fetchall()
            print("Resultados de inventario:", resultados)  # Para depurar
            return resultados
    except Exception as e:
        print(f"Error: {e}")
        return []
    
# Obtener productos de ventas según la sucursal
def obtener_inventario_vigente():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
                SELECT PR.id_producto AS codigo, PR.descripcion AS nombre, 
                    CAST(PR.precio AS DECIMAL(10, 2)) AS precio, 
                    inv.stock AS stock
                FROM producto PR
                INNER JOIN inventario inv ON inv.id_producto = PR.id_producto
                WHERE PR.estado_producto = 1 AND inv.stock > 0
                ORDER BY PR.id_producto DESC;
            """
            cursor.execute(sql)
            resultados = cursor.fetchall()
            return resultados
    except Exception as e:
        print(f"Error: {e}")
        return []

'''
Consultas Compras
'''
#Obtener todos las compras
def obtener_compras():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT c.id_compra, pr.razon_social, c.f_compra, sc.nom_subcat, dc.total FROM compra c INNER JOIN detalle_compra dc ON c.id_compra = dc.id_compra
            INNER JOIN proveedor pr ON c.id_proveedor = pr.id_proveedor INNER JOIN producto p ON p.id_producto = dc.id_producto
            INNER JOIN sub_categoria sc ON p.id_subcategoria = sc.id_subcategoria
            """
            cursor.execute(sql)
            return cursor.fetchall()  # Asegúrate de retornar solo los datos
    except Exception as e:
        print(f"Error: {e}")
        return []
    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500
    

def obtener_proveedor():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_proveedor, razon_social FROM proveedor WHERE estado_proveedor = '1'
            """
            cursor.execute(sql)
            return cursor.fetchall()  # Asegúrate de retornar solo los datos
    except Exception as e:
        print(f"Error: {e}")
        return []
    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500
    

def obtener_almacen():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_almacen, nom_almacen FROM almacen WHERE estado_almacen = '1'
            """
            cursor.execute(sql)
            return cursor.fetchall()  # Asegúrate de retornar solo los datos
    except Exception as e:
        print(f"Error: {e}")
        return []
    except Exception as e:
        return jsonify({'code': 0, 'message': str(e)}), 500

def generate_barcode(code):
    try:
        barcode_class = barcode.get_barcode_class('code128')
        bar_code = barcode_class(code, writer=ImageWriter())
        
        buffer = io.BytesIO()
        bar_code.write(buffer)
        buffer.seek(0)

        return send_file(buffer, mimetype='image/png')
    except Exception as e:
        print(f"Error generando código de barras: {e}")
        return None

def generate_barcode_value(id_producto):
    prefix = "P0000000"  # Prefijo para el código de barras
    barcode_value = f"{prefix}{id_producto:04}"  # El ID de producto con ceros iniciales hasta alcanzar 4 dígitos
    return barcode_value

def agregar_producto(id_marca, id_subcategoria, descripcion, undm, precio, cod_barras, estado_producto):
    conexion = obtener_conexion()
    try:
        # Inserta el producto y recupera el ID generado
        with conexion.cursor() as cursor:
            sql_insert = """
            INSERT INTO producto (id_marca, id_subcategoria, descripcion, undm, precio, estado_producto)
            VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql_insert, (id_marca, id_subcategoria, descripcion, undm, precio, estado_producto))
            id_producto = cursor.lastrowid  # Obtener el ID autogenerado por la BD
            
            # Generar el código de barras con el ID del producto
            cod_barras = generate_barcode_value(id_producto)
            
            # Actualizar el producto con el código de barras generado
            sql_update = "UPDATE producto SET cod_barras = %s WHERE id_producto = %s"
            cursor.execute(sql_update, (cod_barras, id_producto))
            
            conexion.commit()
        
        return {'code': 1, 'message': 'Producto añadido', 'cod_barras': cod_barras}
    except Exception as e:
        print(f"Error al agregar producto: {e}")
        return {'code': 0, 'message': str(e)}
    finally:
        conexion.close()

def getTotalVentas():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """SELECT COUNT(*) as total FROM venta"""
            cursor.execute(sql)
            resultado = cursor.fetchone()
            return resultado['total']
    finally:
        conexion.close()

def totalEfectivo():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """SELECT 
                ROUND(SUM(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(metodo_pago, 'EFECTIVO:', -1), ',', 1) AS DECIMAL(10, 2))), 2) AS total_efectivo
                FROM 
                venta
                WHERE 
                metodo_pago LIKE '%EFECTIVO%';"""
            cursor.execute(sql)
            resultado = cursor.fetchone()
            return resultado['total_efectivo']
    finally:
        conexion.close()
    
def obtener_ventas(nom_tipocomp='', razon_social='', nombre_sucursal='', fecha_i='2022-01-01', fecha_e='2027-12-27'):
    nom_tipocomp_array = [item.strip() for item in nom_tipocomp.split(',') if item.strip() != '']
    in_clause = '1=1'  # Default to no filtering
    params = []

    if nom_tipocomp_array:
        in_clause = f"tp.id_tipocomprobante IN ({', '.join(['%s'] * len(nom_tipocomp_array))})"
        params.extend(nom_tipocomp_array)

    params.extend([f'%{razon_social}%', f'%{razon_social}%', f'%{nombre_sucursal}%', fecha_i, fecha_e])

    connection = obtener_conexion()

    try:
        with connection.cursor() as cursor:
            # Get sales data without pagination
            sql = f"""
                SELECT v.id_venta AS id, SUBSTRING(com.num_comprobante, 2, 3) AS serieNum, SUBSTRING(com.num_comprobante, 6, 8) AS num,
                CASE WHEN tp.nom_tipocomp = 'Nota de venta' THEN 'Nota' ELSE tp.nom_tipocomp END AS tipoComprobante,
                CONCAT(cl.nombres, ' ', cl.apellidos) AS cliente_n, cl.razon_social AS cliente_r,
                cl.dni AS dni, cl.ruc AS ruc, DATE_FORMAT(v.f_venta, '%Y-%m-%d') AS fecha, v.igv AS igv,
                SUM(dv.total) AS total, CONCAT(ve.nombres, ' ', ve.apellidos) AS cajero, ve.dni AS cajeroId,
                v.estado_venta AS estado, s.nombre_sucursal, s.ubicacion, cl.direccion, v.fecha_iso, v.metodo_pago,
                anl.id_anular, anl.anular, anlb.id_anular_b, anlb.anular_b, v.estado_sunat, vb.id_venta_boucher, usu.usua, v.observacion
                FROM venta v
                INNER JOIN comprobante com ON com.id_comprobante = v.id_comprobante
                INNER JOIN tipo_comprobante tp ON tp.id_tipocomprobante = com.id_tipocomprobante
                INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
                INNER JOIN detalle_venta dv ON dv.id_venta = v.id_venta
                INNER JOIN sucursal s ON s.id_sucursal = v.id_sucursal
                INNER JOIN vendedor ve ON ve.dni = s.dni
                INNER JOIN anular_sunat anl ON anl.id_anular = v.id_anular
                INNER JOIN anular_sunat_b anlb ON anlb.id_anular_b = v.id_anular_b
                INNER JOIN venta_boucher vb ON vb.id_venta_boucher = v.id_venta_boucher
                INNER JOIN usuario usu ON usu.id_usuario = ve.id_usuario
                WHERE {in_clause} AND (cl.razon_social LIKE %s OR CONCAT(cl.nombres, ' ', cl.apellidos) LIKE %s)
                AND s.nombre_sucursal LIKE %s
                AND DATE_FORMAT(v.f_venta, '%Y-%m-%d') >= %s
                AND DATE_FORMAT(v.f_venta, '%Y-%m-%d') <= %s
                GROUP BY id, serieNum, num, tipoComprobante, cliente_n, cliente_r, dni, ruc, DATE_FORMAT(v.f_venta, '%Y-%m-%d'), igv, cajero, cajeroId, estado
                ORDER BY v.id_venta DESC
            """
            cursor.execute(sql, params)
            ventas_result = cursor.fetchall()

            # Get sales details for each sale
            ventas = []
            for venta in ventas_result:
                cursor.execute("""
                    SELECT dv.id_detalle AS codigo, pr.descripcion AS nombre, dv.cantidad AS cantidad,
                    dv.precio AS precio, dv.descuento AS descuento, dv.total AS subtotal, pr.undm AS undm,
                    m.nom_marca AS marca
                    FROM detalle_venta dv
                    INNER JOIN producto pr ON pr.id_producto = dv.id_producto
                    INNER JOIN marca m ON m.id_marca = pr.id_marca
                    WHERE dv.id_venta = %s
                """, (venta['id'],))
                detalles = cursor.fetchall()
                venta['detalles'] = detalles
                ventas.append(venta)

            return {'code': 1, 'data': ventas}
    except Exception as e:
        print(f"Error fetching sales data: {e}")
        return {'code': 0, 'error': str(e)}
    finally:
        connection.close()

def obtener_id_sucursal(usuario):
    connection = obtener_conexion()
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT id_sucursal FROM sucursal su
            INNER JOIN vendedor ve ON ve.dni = su.dni
            INNER JOIN usuario u ON u.id_usuario = ve.id_usuario
            WHERE u.usua = %s
        """, (usuario,))
        result = cursor.fetchone()
    connection.close()
    return result['id_sucursal'] if result else None
      
#*
# ------------------ VENTAS ------------------ 
# *#

def listarClientes():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
                SELECT id_cliente,
                    CASE 
                        WHEN (nombres IS NULL OR nombres = '') AND (apellidos IS NULL OR apellidos = '') 
                        THEN razon_social 
                        ELSE CONCAT_WS(' ', nombres, apellidos) 
                    END AS nombre_completo
                FROM 
                    cliente;
            """
            cursor.execute(sql)
            resultados = cursor.fetchall()
            return resultados
    except Exception as e:
        print(f"Error: {e}")
        return []
    
def obtener_ultimo_comprobante(tipoComprobante):
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            # Ejecuta el procedimiento almacenado
            sql_procedure = "CALL insert_comprobante(%s);"
            cursor.execute(sql_procedure, (tipoComprobante,))
            
            # Luego realiza la consulta para obtener el último id_comprobante
            sql_select = "SELECT id_comprobante FROM comprobante ORDER BY id_comprobante DESC LIMIT 1;"
            cursor.execute(sql_select)
            
            # Obtén el id_comprobante
            id_comprobante = cursor.fetchone()
            print("id_comprobante", id_comprobante['id_comprobante'])
            
            return id_comprobante['id_comprobante']

    except Exception as e:
        print("Error en obtener_ultimo_comprobante:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para que sea manejada externamente

def obtener_numero_comprobante(idComprobante):
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            # Luego realiza la consulta para obtener el último id_comprobante
            sql_select = "SELECT num_comprobante FROM comprobante WHERE id_comprobante = %s"
            cursor.execute(sql_select,(idComprobante))
            
            # Obtén el id_comprobante
            id_comprobante = cursor.fetchone()
            return id_comprobante['num_comprobante']

    except Exception as e:
        print("Error en obtener_numero_comprobante:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para que sea manejada externamente

def obtener_cliente(idCliente):
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            # Luego realiza la consulta para obtener el último id_comprobante
            sql_select = """SELECT 
                                id_cliente,
                                CASE 
                                    WHEN ruc IS NOT NULL AND ruc <> '' THEN ruc 
                                    ELSE dni 
                                END AS identificacion,
                                CASE 
                                    WHEN nombres IS NOT NULL AND nombres <> '' AND apellidos IS NOT NULL AND apellidos <> '' 
                                        THEN CONCAT(nombres, ' ', apellidos)
                                    ELSE razon_social 
                                END AS nombre_completo,
                                direccion
                            FROM cliente
                            WHERE id_cliente = %s;"""
            cursor.execute(sql_select,(idCliente))
            
            # Obtén el id_comprobante
            cliente = cursor.fetchone()
            return cliente
    except Exception as e:
        print("Error en obtener_numero_comprobante:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para que sea manejada externamente

def obtener_ultimo_boucher():
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            # Inserta un nuevo registro en venta_boucher
            sql_insert = "INSERT INTO venta_boucher () VALUES ();"
            cursor.execute(sql_insert)
            
            # Obtén el último id_venta_boucher
            sql_select = "SELECT id_venta_boucher FROM venta_boucher ORDER BY id_venta_boucher DESC LIMIT 1;"
            cursor.execute(sql_select)
            id_venta_boucher = cursor.fetchone()
            
            # Confirma la transacción
            conexion.commit()

            return id_venta_boucher['id_venta_boucher']  # Devuelve solo el primer valor de la tupla

    except Exception as e:
        print("Error en obtener_ultimo_boucher:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para que sea manejada externamente

def obtener_id_producto_nombre(nombre):
    try:
        conexion = obtener_conexion()
        with conexion.cursor() as cursor:
            sql = """
                SELECT id_producto FROM producto WHERE descripcion = %s
            """
            cursor.execute(sql, (nombre))
            id_producto = cursor.fetchone()
            print("id_producto:",  id_producto['id_producto'])
            return id_producto['id_producto']
        
    except Exception as e:
        print("Error en vender:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para ver el error completo

def vender(id_sucursal, comprobante_pago, id_cliente, estado_venta, igv, monto_total, base_imponible, metodo_pago, id_anular, id_anular_b, observacion, venta_data, tipos_transaccion):
    try:
        conexion = obtener_conexion()
        id_comprobante = obtener_ultimo_comprobante(comprobante_pago)
        print("comprobante_pago", comprobante_pago)
        f_venta = datetime.now().strftime("%Y-%m-%d")
        fecha_iso = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z'
        estado_sunat = None
        id_venta_baucher = obtener_ultimo_boucher()

        with conexion.cursor() as cursor:
            # Insertar en la tabla venta
            sql = """
            INSERT INTO venta (
                id_sucursal, id_comprobante, id_cliente, estado_venta, f_venta, igv, monto_total,
                base_imponible, fecha_iso, metodo_pago, estado_sunat, id_anular, id_anular_b, id_venta_boucher, observacion
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
            """
            cursor.execute(sql, (
                id_sucursal, id_comprobante, id_cliente, estado_venta, f_venta, igv, monto_total,
                base_imponible, fecha_iso, metodo_pago, estado_sunat, id_anular, id_anular_b, id_venta_baucher, observacion
            ))
            id_venta = conexion.insert_id()
            conexion.commit()

            # Procesar los productos en venta_data
            venta_data = json.loads(venta_data)
            for producto in venta_data:
                id_producto = obtener_id_producto_nombre(producto['nombre'])
                cantidad = producto['cantidad']
                precio = producto['precio']
                descuento = producto['descuento']
                total = producto['subtotal']

                # Insertar en detalle_venta
                sql = """
                INSERT INTO detalle_venta (id_producto, id_venta, cantidad, precio, descuento, total) 
                VALUES (%s, %s, %s, %s, %s, %s);
                """
                cursor.execute(sql, (id_producto, id_venta, cantidad, precio, descuento, total))
                
                # Comprobar si el producto y el almacén existen antes de intentar actualizar el stock
                sql_check = "SELECT stock FROM inventario WHERE id_producto = %s AND id_almacen = 1;"
                cursor.execute(sql_check, (id_producto,))
                stock_result = cursor.fetchone()
                
                sql = """
                UPDATE inventario SET stock = stock - %s WHERE id_producto = %s AND id_almacen = 1;
                """
                cursor.execute(sql, (cantidad, id_producto))
                
            conexion.commit()
            
            if stock_result:
                    # Disminuir stock del producto
                    sql_update_stock = """
                    UPDATE inventario SET stock = stock - %s WHERE id_producto = %s AND id_almacen = 1;
                    """
                    cursor.execute(sql_update_stock, (cantidad, id_producto))
                    print(f"Stock actualizado para producto {id_producto} en almacen 1: -{cantidad}")
            else:
                    print(f"Producto {id_producto} no encontrado en inventario para almacen 1")

            conexion.commit()
             # Llamar al procedimiento almacenado procesar_venta
            print("procedimiento almacenado procesar_venta", id_venta, tipos_transaccion)
            cursor.callproc('procesar_venta', (id_venta, tipos_transaccion))
            conexion.commit()

            print("Venta registrada exitosamente y procedimiento procesar_venta ejecutado")
            generarPDF(f_venta, id_comprobante, id_cliente, venta_data, igv, monto_total)
            print("vendido y generado PDF")
            return id_venta, obtener_numero_comprobante(id_comprobante)
    except Exception as e:
        print("Error en vender:", str(e))
        print(repr(e))  # Información detallada del error
        raise  # Propaga la excepción para ver el error completo

import openpyxl
from openpyxl.styles import Border, Side

def generarPDF(fecha, idComprobante, id_cliente, venta_data, igv, monto_total):
    try:
        # Cargar el archivo Excel
        workbook = openpyxl.load_workbook('./app/templates/contable/plantillas/factura2.xlsx')
        sheet = workbook['Factura']

        # Obtener información del cliente
        cliente = obtener_cliente(id_cliente)
        sheet['F2'] = fecha  # Fecha de venta
        sheet['F3'] = obtener_numero_comprobante(idComprobante)  # Número de factura
        sheet['F4'] = str(cliente['identificacion'])  # RUC del cliente

        # Información del cliente
        sheet['A9'] = cliente['nombre_completo']  # Nombre del cliente
        sheet['A10'] = cliente['direccion']  # Dirección del cliente

        # Estilo de borde lateral y formato de número
        thin_border = Border(left=Side(style='thin'), right=Side(style='thin'))
        number_format = '0.00'  # Formato para dos decimales

        # Iterar sobre cada producto en venta_data
        fila_inicial = 13
        fila_base_totales = 18  # Fila inicial para Subtotal si no hay productos adicionales
        for i, producto in enumerate(venta_data):
            fila_actual = fila_inicial + i
            sheet.insert_rows(fila_actual)
            
            # Establecer datos del producto y formato
            sheet[f'A{fila_actual}'] = f"{producto['nombre']} - cantidad: {producto['cantidad']} - precio un.: S/. {producto['precio']}"
            sheet[f'F{fila_actual}'] = producto['subtotal']
            sheet[f'F{fila_actual}'].number_format = number_format
            
            # Aplicar bordes
            for col in ['A', 'F']:
                cell = sheet[f'{col}{fila_actual}']
                cell.border = thin_border

            fila_base_totales += 1

        # Ajustar las filas de subtotal, IGV y total con formato numérico
        fila_subtotal = fila_base_totales
        fila_impuesto = fila_subtotal + 2
        fila_total = fila_impuesto + 2
        
        sheet[f'F{fila_subtotal}'] = float(monto_total) - float(igv)
        sheet[f'F{fila_subtotal}'].number_format = number_format
        
        sheet[f'F{fila_impuesto}'] = float(igv)
        sheet[f'F{fila_impuesto}'].number_format = number_format
        
        sheet[f'F{fila_total}'] = float(monto_total)
        sheet[f'F{fila_total}'].number_format = number_format

        # Guardar y convertir a PDF
        workbook.save('./app/static/PDF/factura2_copia.xlsx')
        workbook = Workbook()
        workbook.LoadFromFile("./app/static/PDF/factura2_copia.xlsx")
        sheet = workbook.Worksheets['Factura']
        workbook.ConverterSetting.SheetFitToPage = True
        sheet.SaveToPdf(f"./app/static/PDF/{obtener_numero_comprobante(idComprobante)}.pdf")
        workbook.Dispose()

    except Exception as e:
        print("Error en generar PDF:", str(e))
        raise  # Propaga la excepción para manejarla más arriba

def obtener_ventas_con_detalles():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
                SELECT dv.id_venta, pr.descripcion, dv.cantidad, dv.total AS total_producto, ve.f_venta, ve.monto_total
                FROM detalle_venta AS dv
                INNER JOIN venta AS ve ON dv.id_venta = ve.id_venta
                INNER JOIN producto AS pr ON dv.id_producto = pr.id_producto
                ORDER BY dv.id_venta, ve.f_venta;
            """
            cursor.execute(sql)
            ventas = cursor.fetchall()
            
            # Agrupar los productos por venta
            ventas_dict = {}
            for venta in ventas:
                id_venta = venta['id_venta']
                if id_venta not in ventas_dict:
                    ventas_dict[id_venta] = {
                        'f_venta': venta['f_venta'],
                        'monto_total': venta['monto_total'],
                        'productos': []
                    }
                ventas_dict[id_venta]['productos'].append({
                    'descripcion': venta['descripcion'],
                    'cantidad': venta['cantidad'],
                    'total_producto': venta['total_producto']
                })
            return ventas_dict
    finally:
        conexion.close()


def registrar_compra(proveedor, nro_comprobante, almacen, fecha, igv, monto_total, productos, tipo_compra):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            # Insertar la compra
            sql_compra = """
                INSERT INTO compra (id_proveedor, nro_comprobante, estado_compra, f_compra, igv, monto_total)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql_compra, (proveedor, nro_comprobante, 1, fecha, igv, monto_total))
            id_compra = cursor.lastrowid

            # Insertar detalles de la compra
            sql_detalle_compra = """
                INSERT INTO detalle_compra (id_compra, id_producto, cantidad, precio, total)
                VALUES (%s, %s, %s, %s, %s)
            """
            for producto in productos:
                id_producto = obtener_id_producto_nombre(producto['nombre'])
                cantidad = producto['cantidad']
                precio = producto['precio']
                total = cantidad * precio

                print(f"Insertando detalle: id_producto={id_producto}, cantidad={cantidad}, precio={precio}, total={total}")
                
                cursor.execute(sql_detalle_compra, (id_compra, id_producto, cantidad, precio, total))

                # Actualizar el stock en la tabla inventario
                sql_update_stock = """
                    UPDATE inventario SET stock = stock + %s
                    WHERE id_producto = %s AND id_almacen = %s
                """
                cursor.execute(sql_update_stock, (cantidad, id_producto, almacen))
                print(f"Actualizando stock: id_producto={id_producto}, cantidad={cantidad}, almacen={almacen}")

            conexion.commit()
            
             # Llamar al procedimiento almacenado procesar_venta
            cursor.callproc('procesar_compra', (id_compra, tipo_compra))
            conexion.commit()
            return {'success': True, 'message': 'Compra registrada exitosamente'}
    except Exception as e:
        conexion.rollback()
        print("Error al registrar la compra:", str(e))
        return {'success': False, 'message': str(e)}
    finally:
        conexion.close()


def obtener_compras_con_detalles():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
                SELECT co.id_compra, co.f_compra, co.monto_total, 
                       pr.descripcion, dc.cantidad, dc.total
                FROM compra AS co
                INNER JOIN detalle_compra AS dc ON co.id_compra = dc.id_compra
                INNER JOIN producto AS pr ON pr.id_producto = dc.id_producto
                ORDER BY co.id_compra
            """
            cursor.execute(sql)
            resultados = cursor.fetchall()

            compras = {}
            for row in resultados:
                id_compra = row['id_compra']
                if id_compra not in compras:
                    compras[id_compra] = {
                        'id_compra': id_compra,
                        'f_compra': row['f_compra'],
                        'monto_total': row['monto_total'],
                        'productos': []
                    }
                compras[id_compra]['productos'].append({
                    'descripcion': row['descripcion'],
                    'cantidad': row['cantidad'],
                    'total': row['total']
                })
            return compras
    except Exception as e:
        print(f"Error en obtener_compras_con_detalles: {e}")
        return {}
    finally:
        conexion.close()
