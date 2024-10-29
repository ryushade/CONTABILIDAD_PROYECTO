from app.models.conexion import obtener_conexion
import pymysql
from collections import defaultdict
from decimal import Decimal

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


def obtener_usuario_por_id(user_id):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            # Consulta que une la tabla usuario con rol
            sql = """
                SELECT u.*, r.nom_rol, r.estado_rol
                FROM usuario u
                JOIN rol r ON u.id_rol = r.id_rol
                WHERE u.id_usuario = %s
            """
            cursor.execute(sql, (user_id,))
            resultado = cursor.fetchone()
            if resultado:
                # Estructurar el resultado para incluir el rol como un diccionario
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


def obtener_usuarios():
    connection = obtener_conexion()       
    try: 
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "SELECT id_usuario, U.id_rol, nom_rol, usua, contra, estado_usuario FROM usuario U INNER JOIN rol R ON U.id_rol = R.id_rol ORDER BY id_usuario desc"
            cursor.execute(sql)
            usuarios = cursor.fetchall()
            return usuarios
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


def obtener_reglas():
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = """SELECT id_regla, tipo_transaccion, cuenta_debe, cuenta_haber, nombre_regla, estado FROM reglas_contabilizacion"""
            cursor.execute(sql)
            reglas = cursor.fetchall()  
            return reglas  
    finally:
        connection.close()

def actualizar_reglas(id_regla, nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado):
    connection = obtener_conexion()
    try:
        with connection.cursor() as cursor:
            sql = """
                UPDATE reglas_contabilizacion SET
                    nombre_regla = %s,
                    tipo_transaccion = %s,
                    cuenta_debe = %s,
                    cuenta_haber = %s,
                    estado = %s
                WHERE id_cuenta = %s
            """
            cursor.execute(sql, (nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado, id_regla))
    finally:
        connection.close()

def obtener_asientos_agrupados():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("""
                SELECT a.id_asiento, a.fecha_asiento, a.glosa, co.num_comprobante, cu.codigo_cuenta, cu.nombre_cuenta, d.debe, d.haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                INNER JOIN comprobante co ON co.id_comprobante = a.id_comprobante
                ORDER BY a.id_asiento
            """)
            resultados = cursor.fetchall()
        
        # Agrupar resultados
        asientos_agrupados = defaultdict(lambda: {"detalles": []})
        
        for row in resultados:
            id_asiento = row["id_asiento"]
            if "fecha_asiento" not in asientos_agrupados[id_asiento]:
                asientos_agrupados[id_asiento].update({
                    "fecha_asiento": row["fecha_asiento"],
                    "glosa": row["glosa"],
                    "num_comprobante": row["num_comprobante"],
                    "detalles": []
                })
            asientos_agrupados[id_asiento]["detalles"].append({
                "codigo_cuenta": row["codigo_cuenta"],
                "nombre_cuenta": row["nombre_cuenta"],
                "debe": row["debe"],
                "haber": row["haber"]
            })
        
        return asientos_agrupados
    finally:
        conexion.close()


def obtener_libro_mayor():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            cursor.execute("""
                SELECT cu.codigo_cuenta, cu.nombre_cuenta, a.fecha_asiento, co.num_comprobante, d.debe, d.haber
                FROM asiento_contable a
                INNER JOIN detalle_asiento d ON a.id_asiento = d.id_asiento
                INNER JOIN cuenta cu ON cu.id_cuenta = d.id_cuenta
                INNER JOIN comprobante co ON co.id_comprobante = a.id_comprobante
                ORDER BY cu.codigo_cuenta, a.fecha_asiento
            """)
            resultados = cursor.fetchall()

        # Agrupar y calcular el saldo por cuenta
        libro_mayor = defaultdict(lambda: {"detalles": [], "saldo": Decimal("0.00")})
        
        for row in resultados:
            codigo_cuenta = row["codigo_cuenta"]
            debe = row["debe"] or Decimal("0.00")
            haber = row["haber"] or Decimal("0.00")

            # Actualizar saldo
            libro_mayor[codigo_cuenta]["saldo"] += debe - haber

            # Guardar el registro con el saldo actual
            libro_mayor[codigo_cuenta]["detalles"].append({
                "fecha_asiento": row["fecha_asiento"],
                "num_comprobante": row["num_comprobante"],
                "debe": debe,
                "haber": haber,
                "saldo": libro_mayor[codigo_cuenta]["saldo"]
            })

            # Información adicional de la cuenta
            if "nombre_cuenta" not in libro_mayor[codigo_cuenta]:
                libro_mayor[codigo_cuenta].update({
                    "nombre_cuenta": row["nombre_cuenta"]
                })
        
        return libro_mayor
    finally:
        conexion.close()

