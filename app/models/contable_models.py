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
                r.tipo_monto,
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
            sql = """
                SELECT u.*, r.nom_rol, r.estado_rol, u.foto, u.admin
                FROM usuario u
                JOIN rol r ON u.id_rol = r.id_rol
                WHERE u.id_usuario = %s
            """
            cursor.execute(sql, (user_id,))
            resultado = cursor.fetchone()
            if resultado:
                user = {
                    'id_usuario': resultado['id_usuario'],
                    'usua': resultado['usua'],
                    'contra': resultado['contra'],
                    'estado_usuario': resultado['estado_usuario'],
                    'id_rol': resultado['id_rol'],
                    'foto': resultado['foto'],
                    'admin': resultado['admin'],  # Asegúrate de incluir este campo
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


def actualizar_rol_usuario(user_id, new_role_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = "UPDATE usuario SET id_rol = %s WHERE id_usuario = %s"
            cursor.execute(sql, (new_role_id, user_id))
        conexion.commit()  # Mover el commit fuera del bloque with
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




def eliminar_cuenta_contable(cuenta_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            # Verificar si la cuenta está siendo usada en reglas de contabilización
            sql_validacion_reglas = """
                SELECT COUNT(*) AS conteo
                FROM reglas_contabilizacion
                WHERE cuenta_debe = %s OR cuenta_haber = %s;
            """
            cursor.execute(sql_validacion_reglas, (cuenta_id, cuenta_id))
            if cursor.fetchone()['conteo'] > 0:
                print("La cuenta está siendo utilizada en las")
                raise ValueError("La cuenta está siendo utilizada en las reglas de contabilización y no puede ser eliminada.")

            # Verificar si la cuenta es cuenta padre
            sql_validacion_padre = """
                SELECT COUNT(*) AS conteo
                FROM cuenta
                WHERE cuenta_padre = %s;
            """
            cursor.execute(sql_validacion_padre, (cuenta_id,))
            if cursor.fetchone()['conteo'] > 0:
                print("La cuenta es una cuenta padre y")
                raise ValueError("La cuenta es una cuenta padre y no puede ser eliminada.")

            # Si pasa las validaciones, proceder a desactivar la cuenta
            sql = "UPDATE cuenta SET estado_cuenta = 0 WHERE id_cuenta = %s"
            cursor.execute(sql, (cuenta_id,))
            conexion.commit()

    except Exception as e:
        conexion.rollback()  # Asegura que cualquier cambio parcial sea revertido
        print(f"Error al intentar eliminar la cuenta: {e}")
        raise  # Re-lanza la excepción para manejo adicional si es necesario
    finally:
        conexion.close()  # Asegura que la conexión se cierre apropiadamente


# Backend - usuarios
def agregar_usuario(id_rol, usua, contra, estado_usuario, admin):
    conexion = obtener_conexion()
    try:
        if not all([id_rol, usua, contra]):
            return {"error": "Bad Request. Please fill all fields."}

        with conexion.cursor() as cursor:
            query = """
                INSERT INTO usuario (id_rol, usua, contra, estado_usuario, admin)
                VALUES (%s, %s, %s, %s, %s)
            """
            cursor.execute(query, (id_rol, usua, contra, estado_usuario, admin))
            conexion.commit()

        return {"code": 1, "message": "Usuario añadido"}
    except Exception as error:
        return {"error": str(error)}
    finally:
        conexion.close()




def actualizar_usuario(id_usuario, id_rol, usua, contra, estado_usuario, admin):
    conexion = obtener_conexion()
    try:
        # Verifica que todos los campos estén presentes
        if not all([id_rol, usua, contra, estado_usuario]):
            return {"error": "Por favor, completa todos los campos."}

        with conexion.cursor() as cursor:
            # Verifica si el nombre de usuario ya existe en otro registro
            query_check = "SELECT id_usuario FROM usuario WHERE usua = %s AND id_usuario != %s"
            cursor.execute(query_check, (usua, id_usuario))
            existing_user = cursor.fetchone()
            if existing_user:
                return {"error": "El nombre de usuario ya está en uso. Por favor, elige otro."}

            # Actualiza el usuario
            query = """
                UPDATE usuario 
                SET id_rol=%s, usua=%s, contra=%s, estado_usuario=%s, admin=%s
                WHERE id_usuario=%s
            """
            values = (id_rol, usua, contra, estado_usuario, admin, id_usuario)
            cursor.execute(query, values)
            conexion.commit()

            # Verificar si se actualizó algún registro
            if cursor.rowcount == 0:
                print("No se encontró el usuario con ID:", id_usuario)
                return {"code": 0, "message": "Usuario no encontrado"}

            print("Usuario actualizado correctamente.")
            return {"code": 1, "message": "Usuario modificado"}
    except Exception as error:
        print("Error en la actualización:", str(error))
        return {"error": str(error)}
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
                SELECT id_usuario, U.id_rol, nom_rol, usua, contra, estado_usuario, admin
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

def agregar_regla_en_db(nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado, tipo_monto):
    connection = obtener_conexion()  
    try:
        with connection.cursor() as cursor:
            sql = """
            INSERT INTO reglas_contabilizacion 
            (nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado, tipo_monto)
            VALUES (%s, %s, %s, %s, %s, %s)  -- Placeholder corregido para 6 valores
            """
            print("Ejecutando SQL:", sql)
            print("Valores:", (nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado, tipo_monto))
            
            cursor.execute(sql, (nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado, tipo_monto))
            connection.commit()
            
            return cursor.rowcount > 0  
    except Exception as e:
        print("Error en agregar_regla_en_db:", e)  
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
                query += " AND a.fecha_asiento BETWEEN %s AND %s"
                params.extend([start_date, end_date])

            cursor.execute(query, params)
            resultados = cursor.fetchall()

        # Procesamiento de resultados
        asientos_agrupados = defaultdict(lambda: {"detalles": []})
        global_total_debe = 0.0
        global_total_haber = 0.0
        correlativo = 1
        
        for row in resultados:
            id_asiento = row["id_asiento"]
            if id_asiento not in asientos_agrupados:
                fecha_asiento = row["fecha_asiento"]
                if isinstance(fecha_asiento, str):
                    fecha_asiento = datetime.strptime(fecha_asiento, '%Y-%m-%d')
                asientos_agrupados[id_asiento].update({
                    "numero_correlativo": correlativo,
                    "fecha_asiento": fecha_asiento,
                    "glosa": row["glosa"],
                    "num_comprobante": row["num_comprobante"],
                    "detalles": [],
                    "total_debe": float(row["total_debe"]),
                    "total_haber": float(row["total_haber"])
                })
                correlativo += 1
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


def obtener_asientos_agrupados_excel(tipo_registro='Todas', start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            query = """
                SELECT 
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

            # Filtro por rango de fechas
            if start_date and end_date:
                query += " AND a.fecha_asiento BETWEEN %s AND %s"
                params.extend([start_date, end_date])

            query += " ORDER BY a.id_asiento"
            cursor.execute(query, params)
            resultados = cursor.fetchall()

        asientos_agrupados = defaultdict(lambda: {"detalles": []})
        global_total_debe = 0.0
        global_total_haber = 0.0
        correlativo = 1

        for row in resultados:
            id_asiento = row["id_asiento"]
            if id_asiento not in asientos_agrupados:
                fecha_asiento = row["fecha_asiento"]
                if isinstance(fecha_asiento, str):
                    fecha_asiento = datetime.strptime(fecha_asiento, '%Y-%m-%d')
                asientos_agrupados[id_asiento].update({
                    "numero_correlativo": correlativo,
                    "fecha_asiento": fecha_asiento,
                    "glosa": row["glosa"],
                    "num_comprobante": row["num_comprobante"],
                    "detalles": [],
                    "total_debe": float(row["total_debe"]),
                    "total_haber": float(row["total_haber"])
                })
                correlativo += 1
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

def obtener_libro_mayor_agrupado_por_fecha(start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            # Modificar la consulta para incluir el filtro de fechas
            query = """
                SELECT cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento, 
                    SUM(d.debe) AS total_debe, SUM(d.haber) AS total_haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                WHERE (%(start_date)s IS NULL OR a.fecha_asiento >= %(start_date)s)
                AND (%(end_date)s IS NULL OR a.fecha_asiento <= %(end_date)s)
                GROUP BY cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento
                ORDER BY cu.codigo_cuenta, a.fecha_asiento
            """
            params = {'start_date': start_date, 'end_date': end_date}
            cursor.execute(query, params)
            resultados = cursor.fetchall()

        # Procesamiento de resultados, como agrupar y calcular el saldo por cuenta
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

def obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica(start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            query = """
                SELECT 
                    cu.codigo_cuenta, 
                    cu.nombre_cuenta, 
                    a.fecha_asiento, 
                    CASE
                        WHEN LOCATE('SEGÚN', REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', '')) > 0 THEN 
                            LEFT(REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', ''), LOCATE('SEGÚN', REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', '')) - 1)
                        WHEN LOCATE('PROVEEDOR', REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', '')) > 0 THEN 
                            SUBSTRING(REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', ''), 1, LOCATE('PROVEEDOR', REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', '')) + LENGTH('PROVEEDOR') - 1)
                        ELSE 
                            REPLACE(REPLACE(MIN(a.glosa), 'AL ALMACÉN', ''), 'EL REGISTRO DE', '')
                    END AS glosa,
                    SUM(d.debe) AS total_debe, 
                    SUM(d.haber) AS total_haber
                FROM 
                    asiento_contable a
                INNER JOIN 
                    detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN 
                    cuenta cu ON cu.id_cuenta = d.id_cuenta
                WHERE TRUE
            """

            params = []

            # Aplicar filtro de fecha si se proporcionan las fechas
            if start_date and end_date:
                query += " AND a.fecha_asiento BETWEEN %s AND %s"
                params.extend([start_date, end_date])

            query += """
                GROUP BY 
                    cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento
                ORDER BY 
                    cu.codigo_cuenta, a.fecha_asiento;
            """

            cursor.execute(query, params)
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

def obtener_registro_ventas(start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            # Consulta SQL con filtro de fechas
            query = """
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY v.id_venta) AS numero_correlativo,
                    v.f_venta AS fecha,
                    v.f_venta AS fechaV,
                    COALESCE(cl.dni, cl.ruc) AS documento_cliente,
                    COALESCE(CONCAT(cl.nombres, ' ', cl.apellidos), cl.razon_social) AS nombre_cliente,
                    c.num_comprobante AS num_comprobante,
                    SUM((dv.cantidad * dv.precio) - dv.descuento) AS importe,
                    SUM((dv.cantidad * dv.precio) - dv.descuento) * 0.18 AS igv,
                    SUM((dv.cantidad * dv.precio) - dv.descuento) * 1.18 AS total
                FROM venta v
                INNER JOIN detalle_venta dv ON v.id_venta = dv.id_venta
                INNER JOIN comprobante c ON c.id_comprobante = v.id_comprobante
                INNER JOIN cliente cl ON cl.id_cliente = v.id_cliente
                WHERE (%(start_date)s IS NULL OR v.f_venta >= %(start_date)s)
                AND (%(end_date)s IS NULL OR v.f_venta <= %(end_date)s)
                GROUP BY 
                    v.id_venta
                ORDER BY 
                    v.id_venta;
            """
            params = {'start_date': start_date, 'end_date': end_date}
            cursor.execute(query, params)
            resultados = cursor.fetchall()

        # Inicializar variables para almacenar totales y detalles
        total_importe_global = Decimal("0.00")
        total_igv_global = Decimal("0.00")
        total_general_global = Decimal("0.00")
        registro_ventas = []

        for row in resultados:
            importe = Decimal(row["importe"]) or Decimal("0.00")
            igv = Decimal(row["igv"]) or Decimal("0.00")
            total = Decimal(row["total"]) or Decimal("0.00")

            # Agregar detalles de cada registro
            registro_ventas.append({
                "numero_correlativo": row["numero_correlativo"],
                "fecha": row["fecha"],
                "fechaV": row["fechaV"],
                "documento_cliente": row["documento_cliente"],
                "nombre_cliente": row["nombre_cliente"],
                "num_comprobante": row["num_comprobante"],
                "importe": float(importe),
                "igv": float(igv),
                "total": float(total),
            })

            # Acumular totales globales
            total_importe_global += importe
            total_igv_global += igv
            total_general_global += total

        # Totales finales en un diccionario
        totales = {
            "total_importe": float(total_importe_global),
            "total_igv": float(total_igv_global),
            "total_general": float(total_general_global),
        }

        return registro_ventas, totales
    finally:
        conexion.close()

def obtener_registro_compras(start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            # Consulta SQL con filtro de fechas
            query = """
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY co.id_compra) AS numero_correlativo,
                    co.f_compra AS fecha,
                    co.f_compra AS fechaV,
                    pr.ruc AS documento_cliente,
                    pr.razon_social AS nombre_cliente,
                    co.nro_comprobante AS num_comprobante,
                    SUM(dc.cantidad * dc.precio) AS importe,
                    SUM(dc.cantidad * dc.precio) * 0.18 AS igv,
                    SUM(dc.cantidad * dc.precio) * 1.18 AS total
                FROM compra co
                INNER JOIN detalle_compra dc ON co.id_compra = dc.id_compra
                INNER JOIN proveedor pr ON pr.id_proveedor = co.id_proveedor
                WHERE (%(start_date)s IS NULL OR co.f_compra >= %(start_date)s)
                AND (%(end_date)s IS NULL OR co.f_compra <= %(end_date)s)
                GROUP BY 
                    co.id_compra
                ORDER BY 
                    co.id_compra;
            """
            params = {'start_date': start_date, 'end_date': end_date}
            cursor.execute(query, params)
            resultados = cursor.fetchall()

        # Inicializar variables para almacenar totales y detalles
        total_importe_global = Decimal("0.00")
        total_igv_global = Decimal("0.00")
        total_general_global = Decimal("0.00")
        registros_compras = []

        for row in resultados:
            importe = Decimal(row["importe"]) or Decimal("0.00")
            igv = Decimal(row["igv"]) or Decimal("0.00")
            total = Decimal(row["total"]) or Decimal("0.00")

            # Agregar detalles de cada registro
            registros_compras.append({
                "numero_correlativo": row["numero_correlativo"],
                "fecha": row["fecha"],
                "fechaV": row["fechaV"],
                "documento_cliente": row["documento_cliente"],
                "nombre_cliente": row["nombre_cliente"],
                "num_comprobante": row["num_comprobante"],
                "importe": float(importe),
                "igv": float(igv),
                "total": float(total),
            })

            # Acumular totales globales
            total_importe_global += importe
            total_igv_global += igv
            total_general_global += total

        # Totales finales en un diccionario
        totales = {
            "total_importe": float(total_importe_global),
            "total_igv": float(total_igv_global),
            "total_general": float(total_general_global),
        }

        return registros_compras, totales
    finally:
        conexion.close()

# xd
def obtener_libro_caja(start_date=None, end_date=None):
    conexion = obtener_conexion()
    try:
        with conexion.cursor(DictCursor) as cursor:
            query = """
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
                WHERE (%(start_date)s IS NULL OR ac.fecha_asiento >= %(start_date)s)
                AND (%(end_date)s IS NULL OR ac.fecha_asiento <= %(end_date)s)
                GROUP BY ac.id_asiento, cu.id_cuenta, cu.nombre_cuenta
                HAVING (debe > 0 OR haber > 0)
                ORDER BY ac.fecha_asiento, cu.codigo_cuenta;
            """
            params = {'start_date': start_date, 'end_date': end_date}
            cursor.execute(query, params)
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

        return resultados, total_caja 
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
        
def insertar_cuenta(codigo_cuenta, nombre, naturaleza, estado_cuenta):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql_cuenta_padre = f"SELECT id_cuenta, nivel, tipo_cuenta FROM cuenta WHERE codigo_cuenta LIKE '{codigo_cuenta[:-1]}%'"
            cursor.execute(sql_cuenta_padre)
            result = cursor.fetchone()
            cuenta_padre = result['id_cuenta']
            tipo_cuenta = result['tipo_cuenta']
            nivel = int(result['nivel']) + 1
            
            query = """INSERT INTO cuenta (codigo_cuenta, nombre_cuenta, tipo_cuenta, naturaleza, estado_cuenta, cuenta_padre, nivel) 
            VALUES (%s, %s, %s, %s, %s, %s, %s)"""
            cursor.execute(query, (codigo_cuenta, nombre, tipo_cuenta, naturaleza, estado_cuenta, cuenta_padre, nivel))
            conexion.commit()
            
    finally:
        conexion.close()
