import pymysql
from config import Config

# Conexión a la base de datos
def obtener_conexion():
    conexion = pymysql.connect(
        host=Config.DATABASE_HOST,
        user=Config.DATABASE_USER,
        password=Config.DATABASE_PASSWORD,
        database=Config.DATABASE_NAME,
        port=int(Config.DATABASE_PORT),
        cursorclass=pymysql.cursors.DictCursor
    )
    return conexion
