from app.models.conexion import obtener_conexion
import pymysql

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
