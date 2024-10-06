from app.models.conexion import obtener_conexion

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
def obtener_cuentas(page, per_page):
    conexion = obtener_conexion()
    offset = (page - 1) * per_page
    try:
        with conexion.cursor() as cursor:
            sql = "SELECT * FROM cuenta LIMIT %s OFFSET %s"
            cursor.execute(sql, (per_page, offset))
            cuentas = cursor.fetchall()
        return cuentas
    finally:
        conexion.close()
