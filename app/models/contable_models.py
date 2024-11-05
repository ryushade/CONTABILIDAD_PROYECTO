from app.models.conexion import obtener_conexion
import pymysql
from collections import defaultdict
from datetime import datetime
from decimal import Decimal
from pymysql.cursors import DictCursor
from flask import request, jsonify

# Obtener un usuario por nombre
def obtener_usuario_por_nombre(username):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
                SELECT u.*, r.nom_rol, r.estado_rol
                FROM usuario u
                JOIN rol r ON u.id_rol = r.id_rol
                WHERE u.usua = %s
            """
            cursor.execute(sql, (username,))
            resultado = cursor.fetchone()
            if resultado:
                user = {
                    'id_usuario': resultado['id_usuario'],
                    'usua': resultado['usua'],
                    'contra': resultado['contra'],
                    'estado_usuario': resultado['estado_usuario'],
                    'id_rol': resultado['id_rol'],
                    'rol': {
                        'id_rol': resultado['id_rol'],
                        'nom_rol': resultado['nom_rol'],
                        'estado_rol': resultado['estado_rol']
                    }
                }
                return user
            else:
                return None
    finally:
        conexion.close()


def obtener_usuario_por_id_2(usuario_id):
    connection = obtener_conexion()
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = """
                SELECT usuario.*, rol.nom_rol AS rol
                FROM usuario
                LEFT JOIN rol ON usuario.id_rol = rol.id_rol
                WHERE usuario.id_usuario = %s
            """
            cursor.execute(sql, (usuario_id,))
            usuario = cursor.fetchone()
            return usuario
    finally:
        connection.close()

def obtener_regla_por_id(regla_id):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = """
            SELECT 
                r.id_regla, 
                r.nombre_regla,
                r.tipo_transaccion,
                r.estado,
                c_debe.codigo_cuenta AS cuenta_debe_codigo,
                c_debe.nombre_cuenta AS cuenta_debe_nombre,
                c_haber.codigo_cuenta AS cuenta_haber_codigo,
                c_haber.nombre_cuenta AS cuenta_haber_nombre
            FROM 
                reglas_contabilizacion r
            LEFT JOIN 
                cuenta c_debe ON r.cuenta_debe = c_debe.id_cuenta
            LEFT JOIN 
                cuenta c_haber ON r.cuenta_haber = c_haber.id_cuenta
            WHERE
                r.id_regla = %s
            """
            cursor.execute(sql, (regla_id,))
            regla = cursor.fetchone()
            return regla
    finally:
        connection.close()

def obtener_usuario_por_id(user_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            # Consulta que une la tabla usuario con rol e incluye la columna de foto
            sql = """
                SELECT u.*, r.nom_rol, r.estado_rol, u.foto 
                FROM usuario u
                JOIN rol r ON u.id_rol = r.id_rol
                WHERE u.id_usuario = %s
            """
            cursor.execute(sql, (user_id,))
            resultado = cursor.fetchone()
            if resultado:
                # Estructurar el resultado para incluir el rol y la foto como un diccionario
                user = {
                    'id_usuario': resultado['id_usuario'],
                    'usua': resultado['usua'],
                    'contra': resultado['contra'],
                    'estado_usuario': resultado['estado_usuario'],
                    'id_rol': resultado['id_rol'],
                    'foto': resultado['foto'],  # Agregar la foto al diccionario del usuario
                    'rol': {
                        'id_rol': resultado['id_rol'],
                        'nom_rol': resultado['nom_rol'],
                        'estado_rol': resultado['estado_rol']
                    }
                }
                return user
            else:
                return None
    finally:
        conexion.close()


def guardar_foto_usuario(user_id, foto_path):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = "UPDATE usuario SET foto = %s WHERE id_usuario = %s"
            cursor.execute(sql, (foto_path, user_id))
            conexion.commit()
            return True 
    except Exception as e:
        print(f"Error al actualizar la foto del usuario en la base de datos: {e}")
        return False  
    finally:
        conexion.close()

# Verificar la contraseña
def verificar_contraseña(usuario, password):
    return usuario['contra'] == password    

# Obtener cuentas paginadas
def obtener_cuentas(page, per_page, tipo_cuenta=None, naturaleza=None):
    conexion = obtener_conexion()
    offset = (page - 1) * per_page
    try:
        with conexion.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "SELECT * FROM cuenta"
            filters = []
            params = []
            if tipo_cuenta:
                filters.append("tipo_cuenta = %s")
                params.append(tipo_cuenta)
            if naturaleza:
                filters.append("naturaleza = %s")
                params.append(naturaleza)
            if filters:
                sql += " WHERE " + " AND ".join(filters)
            sql += " ORDER BY codigo_cuenta LIMIT %s OFFSET %s"
            params.extend([per_page, offset])
            cursor.execute(sql, params)
            cuentas = cursor.fetchall()
        return cuentas
    finally:
        conexion.close()

def obtener_total_cuentas(tipo_cuenta=None, naturaleza=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "SELECT COUNT(*) AS total FROM cuenta"
            filters = []
            params = []
            if tipo_cuenta:
                filters.append("tipo_cuenta = %s")
                params.append(tipo_cuenta)
            if naturaleza:
                filters.append("naturaleza = %s")
                params.append(naturaleza)
            if filters:
                sql += " WHERE " + " AND ".join(filters)
            cursor.execute(sql, params)
            result = cursor.fetchone()
            total_cuentas = result['total']
        return total_cuentas
    finally:
        conexion.close()




def eliminar_cuenta(cuenta_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = "DELETE FROM cuenta WHERE id_cuenta = %s"
            cursor.execute(sql, (cuenta_id,))
            conexion.commit()
    finally:
        conexion.close()


# Backend - usuarios
def agregar_usuario(id_rol, usua, contra, estado_usuario):
    conexion = obtener_conexion()
    try:
        if id_rol is None or usua is None or contra is None:
            return {"error": "Bad Request. Please fill all fields."}

        usuario = {
            "id_rol": id_rol,
            "usua": usua.strip(),
            "contra": contra.strip(),
            "estado_usuario": estado_usuario
        }

        with conexion.cursor() as cursor:
            cursor.execute(
                "INSERT INTO usuario SET id_rol=%s, usua=%s, contra=%s, estado_usuario=%s",
                (usuario["id_rol"], usuario["usua"], usuario["contra"], usuario["estado_usuario"])
            )
            conexion.commit()

        return {"code": 1, "message": "Usuario añadido"}
    except Exception as error:
        return {"error": str(error)}
    finally:
        conexion.close()



def actualizar_usuario(usuario_id):
    conexion = obtener_conexion()
    try:
        datos = request.get_json()
        id_rol = datos.get("id_rol")
        usua = datos.get("usua")
        contra = datos.get("contra")
        estado_usuario = datos.get("estado_usuario")

        if id_rol is None or usua is None or contra is None or estado_usuario is None:
            return jsonify({"message": "Bad Request. Please fill all fields."}), 400

        usuario = {
            "id_rol": id_rol,
            "usua": usua.strip(),
            "contra": contra.strip(),
            "estado_usuario": estado_usuario
        }

        with conexion.cursor() as cursor:
            query = "UPDATE usuario SET id_rol=%s, usua=%s, contra=%s, estado_usuario=%s WHERE id_usuario=%s"
            values = (usuario["id_rol"], usuario["usua"], usuario["contra"], usuario["estado_usuario"], usuario_id)
            cursor.execute(query, values)
            conexion.commit()

            if cursor.rowcount == 0:
                return jsonify({"code": 0, "message": "Usuario no encontrado"}), 404

        return jsonify({"code": 1, "message": "Usuario modificado"})
    except Exception as error:
        return jsonify({"error": str(error)}), 500
    finally:
        conexion.close()

def eliminar_usuario(usuario_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("SELECT 1 FROM vendedor WHERE id_usuario = %s", (usuario_id,))
            is_user_in_use = cursor.fetchone() is not None

            if is_user_in_use:
                cursor.execute("UPDATE usuario SET estado_usuario = 0 WHERE id_usuario = %s", (usuario_id,))
                conexion.commit()
            else:
                cursor.execute("DELETE FROM usuario WHERE id_usuario = %s", (usuario_id,))
                conexion.commit()
    finally:
        conexion.close()

def obtener_roles():
    conexion = obtener_conexion()
    try:
        with conexion.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("SELECT id_rol, nom_rol, estado_rol FROM rol")
            roles = cursor.fetchall()
        return roles
    finally:
        conexion.close()
## ----------------------------

def eliminar_regla_bd(regla_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = "DELETE FROM reglas_contabilizacion WHERE id_regla = %s"
            cursor.execute(sql, (regla_id,))
            conexion.commit()
            print(f"Regla con id {regla_id} eliminada correctamente")
    except Exception as e:
        print(f"Error al eliminar la regla: {e}")
    finally:
        conexion.close()





def obtener_cuenta_por_id(cuenta_id):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM cuenta WHERE id_cuenta = %s"
            cursor.execute(sql, (cuenta_id,))
            cuenta = cursor.fetchone()
            return cuenta
    finally:
        connection.close()

def actualizar_cuenta(cuenta_id, codigo_cuenta, nombre_cuenta, naturaleza, estado_cuenta):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = """
                UPDATE cuenta SET
                    codigo_cuenta = %s,
                    nombre_cuenta = %s,
                    naturaleza = %s,
                    estado_cuenta = %s
                WHERE id_cuenta = %s
            """
            cursor.execute(sql, (codigo_cuenta, nombre_cuenta, naturaleza, estado_cuenta, cuenta_id))
            connection.commit()
    finally:
        connection.close()

def obtener_cuentas_excel():
    connection = obtener_conexion()
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "SELECT codigo_cuenta, nombre_cuenta, tipo_cuenta, naturaleza FROM cuenta;"
            cursor.execute(sql)
            cuentas = cursor.fetchall()
            return cuentas
    finally:
        connection.close()



def obtener_usuarios(page, per_page):
    connection = obtener_conexion()       
    try: 
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            offset = (page - 1) * per_page
            sql = """
                SELECT id_usuario, U.id_rol, nom_rol, usua, contra, estado_usuario
                FROM usuario U
                INNER JOIN rol R ON U.id_rol = R.id_rol
                ORDER BY id_usuario DESC
                LIMIT %s OFFSET %s
            """
            cursor.execute(sql, (per_page, offset))
            usuarios = cursor.fetchall()
            
            # Consultar el total de resultados
            cursor.execute("SELECT COUNT(*) as total FROM usuario")
            total_results = cursor.fetchone()['total']
            
            return usuarios, total_results
    finally:
        connection.close()

# def obtener_reglas():
#     connection = obtener_conexion()
#     try:
#         with connection.cursor(pymysql.cursors.DictCursor) as cursor:
#             sql = """
#                 SELECT 
#                     r.id_regla, 
#                     r.nombre_regla, 
#                     r.tipo_transaccion, 
#                     cd.codigo_cuenta AS cuenta_debe_codigo,
#                     cd.nombre_cuenta AS cuenta_debe_nombre, 
#                     ch.codigo_cuenta AS cuenta_haber_codigo,
#                     ch.nombre_cuenta AS cuenta_haber_nombre
#                 FROM 
#                     reglas_contabilizacion r
#                 INNER JOIN 
#                     cuenta cd ON r.cuenta_debe = cd.id_cuenta
#                 INNER JOIN 
#                     cuenta ch ON r.cuenta_haber = ch.id_cuenta
#             """
#             cursor.execute(sql)
#             return cursor.fetchall()
#     finally:
#         connection.close()

def obtener_asientodiario():
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = """
                UPDATE cuenta SET
                    codigo_cuenta = %s,
                    nombre_cuenta = %s,
                    naturaleza = %s,
                    estado_cuenta = %s
                WHERE id_cuenta = %s
            """
            cursor.execute(sql)
    finally:
        connection.close()

def agregar_regla_en_db(nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado):
    connection = obtener_conexion()  # Asegúrate de que esta función esté bien configurada
    try:
        with connection.cursor() as cursor:
            sql = """
            INSERT INTO reglas_contabilizacion (nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado)
            VALUES (%s, %s, %s, %s, %s)
            """
            print("Ejecutando SQL:", sql)
            print("Valores:", (nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado))
            cursor.execute(sql, (nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado))
            connection.commit()
            return cursor.rowcount > 0  # Retorna True si se agregó una fila
    except Exception as e:
        print("Error en agregar_regla_en_db:", e)  # Imprime el error específico en la consola
        return False
    finally:
        connection.close()


def actualizar_regla_en_db(id_regla, nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            # Construir dinámicamente la consulta SQL
            campos = ["nombre_regla = %s", "tipo_transaccion = %s", "estado = %s"]
            valores = [nombre_regla, tipo_transaccion, int(estado)]

            if cuenta_debito is not None:
                campos.append("cuenta_debe = %s")
                valores.append(cuenta_debito)
            else:
                campos.append("cuenta_debe = NULL")

            if cuenta_credito is not None:
                campos.append("cuenta_haber = %s")
                valores.append(cuenta_credito)
            else:
                campos.append("cuenta_haber = NULL")

            sql = f"UPDATE reglas_contabilizacion SET {', '.join(campos)} WHERE id_regla = %s"
            valores.append(id_regla)

            print("Ejecutando consulta SQL:", sql)
            print("Con parámetros:", valores)

            cursor.execute(sql, valores)
            connection.commit()
            print("Filas afectadas:", cursor.rowcount)
            return True  
    except Exception as e:
        print("Error al ejecutar la consulta UPDATE:", e)
        return False
    finally:
        connection.close()




def obtener_reglas(page, per_page):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            offset = (page - 1) * per_page
            sql = """
            SELECT 
                r.id_regla, 
                r.tipo_transaccion, 
                c_debe.codigo_cuenta AS cuenta_debe_codigo, 
                c_debe.nombre_cuenta AS cuenta_debe_nombre,
                c_haber.codigo_cuenta AS cuenta_haber_codigo, 
                c_haber.nombre_cuenta AS cuenta_haber_nombre,
                r.nombre_regla, 
                r.estado 
            FROM 
                reglas_contabilizacion r
            LEFT JOIN 
                cuenta c_debe ON r.cuenta_debe = c_debe.id_cuenta
            LEFT JOIN 
                cuenta c_haber ON r.cuenta_haber = c_haber.id_cuenta
            LIMIT %s OFFSET %s
            """
            cursor.execute(sql, (per_page, offset))
            reglas = cursor.fetchall()
            
            # Obtener el total de resultados
            cursor.execute("SELECT COUNT(*) as total FROM reglas_contabilizacion")
            total_results = cursor.fetchone()['total']
            
            return reglas, total_results
    finally:
        connection.close()

def obtener_asientos_agrupados(tipo_registro='Todas', start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            query = """
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY a.id_asiento) AS numero_correlativo,
                    a.id_asiento, 
                    a.fecha_asiento, 
                    a.glosa, 
                    co.num_comprobante, 
                    cu.codigo_cuenta, 
                    cu.nombre_cuenta, 
                    d.debe, 
                    d.haber,
                    a.total_debe, 
                    a.total_haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                INNER JOIN comprobante co ON co.id_comprobante = a.id_comprobante
                WHERE TRUE
            """

            params = []
            
            # Filtro por tipo de registro
            if tipo_registro == 'Ventas':
                query += " AND LOWER(a.glosa) LIKE %s"
                params.append('%venta%')
            elif tipo_registro == 'Compras':
                query += " AND (LOWER(a.glosa) LIKE %s OR LOWER(a.glosa) LIKE %s OR LOWER(a.glosa) LIKE %s OR LOWER(a.glosa) LIKE %s OR LOWER(a.glosa) LIKE %s)"
                params.extend([
                    '%compra%',
                    '%ingreso%',
                    '%almacen%', 
                    '%pago%',
                    '%proveedor%'
                ])
            

            # Filtro por rango de fechas o por mes completo
            if start_date and end_date:
                if start_date == end_date:
                    query += " AND a.fecha_asiento BETWEEN %s AND LAST_DAY(%s)"
                    params.extend([start_date, start_date])
                else:
                    query += " AND a.fecha_asiento BETWEEN %s AND %s"
                    params.extend([start_date, end_date])

            cursor.execute(query, params)
            resultados = cursor.fetchall()
        
        # Procesamiento de resultados
        asientos_agrupados = defaultdict(lambda: {"detalles": []})
        global_total_debe = 0.0
        global_total_haber = 0.0
        
        for row in resultados:
            id_asiento = row["id_asiento"]
            if id_asiento not in asientos_agrupados:
                fecha_asiento = row["fecha_asiento"]
                if isinstance(fecha_asiento, str):
                    fecha_asiento = datetime.strptime(fecha_asiento, '%Y-%m-%d')
                asientos_agrupados[id_asiento].update({
                    "numero_correlativo": row["numero_correlativo"],
                    "fecha_asiento": fecha_asiento,
                    "glosa": row["glosa"],
                    "num_comprobante": row["num_comprobante"],
                    "detalles": [],
                    "total_debe": float(row["total_debe"]),
                    "total_haber": float(row["total_haber"])
                })
                global_total_debe += float(row["total_debe"])
                global_total_haber += float(row["total_haber"])
            
            asientos_agrupados[id_asiento]["detalles"].append({
                "codigo_cuenta": row["codigo_cuenta"],
                "nombre_cuenta": row["nombre_cuenta"],
                "debe": float(row["debe"]),
                "haber": float(row["haber"]),
            })
        
        totales = {
            "total_debe": global_total_debe,
            "total_haber": global_total_haber
        }
        
        return asientos_agrupados, totales
    finally:
        conexion.close()



def obtener_asientos_agrupados_excel():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY a.id_asiento) AS numero_correlativo,
                    a.id_asiento, 
                    a.fecha_asiento, 
                    a.glosa, 
                    co.num_comprobante, 
                    cu.codigo_cuenta, 
                    cu.nombre_cuenta, 
                    d.debe, 
                    d.haber,
                    a.total_debe, 
                    a.total_haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                INNER JOIN comprobante co ON co.id_comprobante = a.id_comprobante
                ORDER BY a.id_asiento
            """)
            resultados = cursor.fetchall()
        
        asientos_agrupados = defaultdict(lambda: {"detalles": []})
        global_total_debe = 0.0
        global_total_haber = 0.0
        
        for row in resultados:
            id_asiento = row["id_asiento"]
            if id_asiento not in asientos_agrupados:
                fecha_asiento = row["fecha_asiento"]
                if isinstance(fecha_asiento, str):
                    fecha_asiento = datetime.strptime(fecha_asiento, '%Y-%m-%d')
                asientos_agrupados[id_asiento].update({
                    "numero_correlativo": row["numero_correlativo"],
                    "fecha_asiento": fecha_asiento,
                    "glosa": row["glosa"],
                    "num_comprobante": row["num_comprobante"],
                    "detalles": [],
                    "total_debe": float(row["total_debe"]),
                    "total_haber": float(row["total_haber"])
                })
                global_total_debe += float(row["total_debe"])
                global_total_haber += float(row["total_haber"])
            
            asientos_agrupados[id_asiento]["detalles"].append({
                "codigo_cuenta": row["codigo_cuenta"],
                "nombre_cuenta": row["nombre_cuenta"],
                "debe": float(row["debe"]),
                "haber": float(row["haber"]),
            })
        
        totales = {
            "total_debe": global_total_debe,
            "total_haber": global_total_haber
        }
        
        return asientos_agrupados, totales
    finally:
        conexion.close()

def obtener_libro_mayor_agrupado_por_fecha():
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            cursor.execute("""
                SELECT cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento, 
                    SUM(d.debe) AS total_debe, SUM(d.haber) AS total_haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                GROUP BY cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento
                ORDER BY cu.codigo_cuenta, a.fecha_asiento
            """)
            resultados = cursor.fetchall()

        # Agrupar y calcular el saldo por cuenta
        total_debe_global = Decimal("0.00")
        total_haber_global = Decimal("0.00")
        libro_mayor = defaultdict(lambda: {"detalles": [], "saldo": Decimal("0.00")})
        
        for row in resultados:
            codigo_cuenta = row["codigo_cuenta"]
            debe = row["total_debe"] or Decimal("0.00")
            haber = row["total_haber"] or Decimal("0.00")

            # Actualizar saldo
            libro_mayor[codigo_cuenta]["saldo"] += debe - haber

            # Guardar el registro con el saldo actual
            libro_mayor[codigo_cuenta]["detalles"].append({
                "fecha_asiento": row["fecha_asiento"],
                "debe": debe,
                "haber": haber,
                "saldo": libro_mayor[codigo_cuenta]["saldo"]
            })

            # Información adicional de la cuenta
            if "nombre_cuenta" not in libro_mayor[codigo_cuenta]:
                libro_mayor[codigo_cuenta]["nombre_cuenta"] = row["nombre_cuenta"]

            # Sumar totales globales
            total_debe_global += debe
            total_haber_global += haber

        return libro_mayor, total_debe_global, total_haber_global
    finally:
        conexion.close()


def obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica():
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            cursor.execute("""
                SELECT 
                    cu.codigo_cuenta, 
                    cu.nombre_cuenta, 
                    a.fecha_asiento, 
                    LEFT(MIN(a.glosa), LOCATE('SEGÚN', MIN(a.glosa)) - 1) AS glosa,
                    SUM(d.debe) AS total_debe, 
                    SUM(d.haber) AS total_haber
                FROM 
                    asiento_contable a
                INNER JOIN 
                    detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN 
                    cuenta cu ON cu.id_cuenta = d.id_cuenta
                GROUP BY 
                    cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento
                ORDER BY 
                    cu.codigo_cuenta, a.fecha_asiento;
            """)
            resultados = cursor.fetchall()

        libro_mayor = defaultdict(list)

        for row in resultados:
            libro_mayor[row['codigo_cuenta']].append({
                'fecha_asiento': row['fecha_asiento'],
                'glosa': row['glosa'],
                'total_debe': row['total_debe'],
                'total_haber': row['total_haber']
            })

        return libro_mayor
    finally:
        conexion.close()

def obtenerCuentas():
    try:
        conexion = obtener_conexion()  # Establece conexión a la base de datos llamando a la función obtener_conexion.
        with conexion.cursor() as cursor:  # Utiliza un cursor para ejecutar consultas, que se cierra automáticamente al terminar el bloque.
            sql = """
                SELECT id_cuenta, codigo_cuenta, nombre_cuenta AS Nombre, nivel, cuenta_padre, estado_cuenta, naturaleza
                FROM cuenta
                ORDER BY nivel, cuenta_padre, id_cuenta;
                """  # Consulta SQL que selecciona y ordena las cuentas para facilitar la jerarquización.
            cursor.execute(sql)  # Ejecuta la consulta SQL en la base de datos.
            cuentas = cursor.fetchall()  # Obtiene todos los registros de la consulta y los almacena en la variable cuentas.
            return construir_jerarquia(cuentas)  # Llama a la función para construir la jerarquía de cuentas con los datos obtenidos.
    except Exception as e:
        print("Error en obtenerCuentas:", str(e))  # Imprime un mensaje de error si ocurre una excepción.
        raise  # Vuelve a lanzar la excepción para ser manejada por un controlador de excepciones superior o para detener el programa.

def construir_jerarquia(cuentas):
    from collections import defaultdict  # Importa defaultdict de collections para crear diccionarios con valores predeterminados.
    estructura = defaultdict(list)  # Crea un diccionario donde cada clave se inicializa como una lista.
    nodos = {cuenta['id_cuenta']: dict(cuenta, hijos=[]) for cuenta in cuentas}  # Crea un diccionario de nodos, cada uno con una lista de hijos.

    for cuenta in cuentas:
        nodo = nodos[cuenta['id_cuenta']]  # Obtiene el nodo para la cuenta actual basado en su ID.
        if cuenta['cuenta_padre']:  # Verifica si la cuenta tiene un nodo padre.
            nodos[cuenta['cuenta_padre']]['hijos'].append(nodo)  # Si tiene padre, agrega el nodo actual a la lista de hijos del padre.
        else:
            estructura[cuenta['nivel']].append(nodo)  # Si no tiene padre, agrega el nodo al nivel superior en la estructura jerárquica.

    return estructura  # Devuelve la estructura jerárquica construida.
def insertar_regla(nombre_regla, tipo_transaccion, cuenta_debito_id, cuenta_credito_id, estado):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
                INSERT INTO reglas_contabilizacion (nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (nombre_regla, tipo_transaccion, cuenta_debito_id, cuenta_credito_id, estado))
            conexion.commit()
    finally:
        conexion.close()

def obtener_registro_ventas():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("""
                SELECT 
                ROW_NUMBER() OVER (ORDER BY v.id_venta) AS numero_correlativo,
                v.f_venta as fecha,
                v.f_venta AS fechaVencimiento,
                COALESCE(cl.dni, cl.ruc) AS documento_cliente,
                COALESCE(CONCAT(cl.nombres, ' ', cl.apellidos), cl.razon_social) AS nombre_cliente,
                c.num_comprobante as num_comprobante,
                SUM((dv.cantidad * dv.precio) - dv.descuento) AS importe,
                SUM((dv.cantidad * dv.precio) - dv.descuento) * 0.18 AS igv,
                SUM((dv.cantidad * dv.precio) - dv.descuento) * 1.18 AS total
            FROM venta v
            INNER JOIN detalle_venta dv ON v.id_venta = dv.id_venta
            INNER JOIN comprobante c ON c.id_comprobante = v.id_comprobante
            INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
            GROUP BY 
                v.id_venta
            ORDER BY 
                v.id_venta;
            """)
            resultados = cursor.fetchall()

        # Inicializar variables para almacenar los totales
        total_igv = 0.0
        total_importe = 0.0
        total_general = 0.0
        registros_ventas = []

        for row in resultados:
            # Convertir la fecha a formato datetime si es necesario
            fecha = row["fecha"]
            if isinstance(fecha, str):
                fecha = datetime.strptime(fecha, '%Y-%m-%d')
            fechaV = row["fechaVencimiento"]
            if isinstance(fechaV, str):
                fechaV = datetime.strptime(fechaV, '%Y-%m-%d')
            # Agregar cada registro a la lista de registros de compras
            registros_ventas.append({
                "numero_correlativo": row["numero_correlativo"],
                "fecha": fecha,
                "fechaV":fechaV,
                "documento_cliente": row["documento_cliente"],
                "nombre_cliente": row["nombre_cliente"],
                "num_comprobante": row["num_comprobante"],
                "importe": float(row["importe"]),
                "igv": float(row["igv"]),
                "total": float(row["total"])
            })
            
            # Acumular los totales
            total_importe += float(row["importe"])
            total_igv += float(row["igv"])
            total_general += float(row["total"])

        # Diccionario con los totales
        totales = {
            "total_importe": total_importe,
            "total_igv": total_igv,
            "total_general": total_general
        }

        return registros_ventas, totales
    finally:
        conexion.close()

def obtener_registro_compras():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY co.id_compra) AS numero_correlativo,
                    co.f_compra as fecha,
                    co.f_compra AS fechaVencimiento,
                    pr.ruc AS documento_cliente,
                    pr.razon_social AS nombre_cliente,
                    co.nro_comprobante as num_comprobante,
                    SUM(dc.cantidad * dc.precio) AS importe,
                    SUM(dc.cantidad * dc.precio) * 0.18 AS igv,
                    SUM(dc.cantidad * dc.precio) * 1.18 AS total
                FROM compra co
                INNER JOIN detalle_compra dc ON co.id_compra = dc.id_compra
                INNER JOIN proveedor pr ON pr.id_proveedor = co.id_compra
                GROUP BY 
                    co.id_compra
                ORDER BY 
                    co.id_compra;
            """)
            resultados = cursor.fetchall()

        # Inicializar variables para almacenar los totales
        total_igv = 0.0
        total_importe = 0.0
        total_general = 0.0
        registros_compras = []

        for row in resultados:
            # Convertir la fecha a formato datetime si es necesario
            fecha = row["fecha"]
            if isinstance(fecha, str):
                fecha = datetime.strptime(fecha, '%Y-%m-%d')
            fechaV = row["fechaVencimiento"]
            if isinstance(fechaV, str):
                fechaV = datetime.strptime(fechaV, '%Y-%m-%d')
            
            # Agregar cada registro a la lista de registros de compras
            registros_compras.append({
                "numero_correlativo": row["numero_correlativo"],
                "fecha": fecha,
                "fechaV": fechaV,
                "documento_cliente": row["documento_cliente"],
                "nombre_cliente": row["nombre_cliente"],
                "num_comprobante": row["num_comprobante"],
                "importe": float(row["importe"]),
                "igv": float(row["igv"]),
                "total": float(row["total"])
            })
            
            # Acumular los totales
            total_importe += float(row["importe"])
            total_igv += float(row["igv"])
            total_general += float(row["total"])

        # Diccionario con los totales
        totales = {
            "total_importe": total_importe,
            "total_igv": total_igv,
            "total_general": total_general
        }

        return registros_compras, totales
    finally:
        conexion.close()



# xd
def obtener_libro_caja():
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            cursor.execute("""
                SELECT ac.fecha_asiento as fecha, ac.glosa as glosa, cu.codigo_cuenta as cod_cuenta, 
                cu.nombre_cuenta as nombre_cuenta,
                    CASE 
                        WHEN ac.tipo_asiento = 'venta_contado' THEN SUM(da.debe) 
                        ELSE 0 
                    END AS debe,
                    CASE 
                    WHEN ac.tipo_asiento = 'compra_contado' THEN SUM(da.haber) 
                        ELSE 0 
                    END AS haber
                FROM asiento_contable ac
                INNER JOIN detalle_asiento da ON da.id_asiento = ac.id_asiento
                INNER JOIN cuenta cu ON da.id_cuenta = cu.id_cuenta
                GROUP BY ac.id_asiento, cu.id_cuenta, cu.nombre_cuenta
                HAVING (debe > 0 OR haber > 0);
            """)
            resultados = cursor.fetchall()

        total_debe_caja = Decimal("0.00")
        total_haber_caja = Decimal("0.00")
        
        for row in resultados:
            debe = row["debe"] or Decimal("0.00")
            haber = row["haber"] or Decimal("0.00")
            total_debe_caja += debe
            total_haber_caja += haber

            total_caja = {
                "debe": total_debe_caja,
                "haber": total_haber_caja
            }

        return  resultados, total_caja 
    finally:
        conexion.close()


def obtener_libro_caja_cuenta_corriente():
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            cursor.execute("""
                SELECT ac.fecha_asiento AS fecha, vb.formadepago AS forma_pago, cu.nombre_cuenta AS nombre_cuenta, vb.nombre_cliente AS nombre, c.num_comprobante AS comprobante,
                cu.codigo_cuenta AS codigo, cu.nombre_cuenta AS denominacion, da.debe AS debe, da.haber AS haber FROM asiento_contable ac 
                INNER JOIN comprobante c ON ac.id_comprobante = c.id_comprobante
                INNER JOIN detalle_asiento da ON da.id_asiento = ac.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = da.id_cuenta
                INNER JOIN venta v ON v.id_comprobante = c.id_comprobante
                INNER JOIN venta_boucher vb ON v.id_venta_boucher = vb.id_venta_boucher
                WHERE vb.formadepago <> 'EFECTIVO' AND vb.formadepago <> 'YAPE' AND vb.formadepago <> 'PLIN';
            """)
            resultados = cursor.fetchall()

        total_debe_caja = Decimal("0.00")
        total_haber_caja = Decimal("0.00")
        
        for row in resultados:
            debe = row["debe"] or Decimal("0.00")
            haber = row["haber"] or Decimal("0.00")
            total_debe_caja += debe
            total_haber_caja += haber

        total_caja_corriente = {
            "debe": total_debe_caja,
            "haber": total_haber_caja
        }

        return  resultados, total_caja_corriente
    finally:
        conexion.close()

def obtener_id_cuenta(codigo_cuenta):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            query = "SELECT id_cuenta FROM cuenta WHERE codigo_cuenta = %s"
            cursor.execute(query, (codigo_cuenta,))
            result = cursor.fetchone()
            print("Resultado de obtener_id_cuenta:", result)
            return result['id_cuenta'] if result else None
    finally:
        conexion.close()
