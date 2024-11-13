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

import subprocess

import pymysql

def fetch_table_data(cursor, table_name):
    cursor.execute(f"SELECT * FROM {table_name}")
    rows = cursor.fetchall()
    return rows

def fetch_tables(cursor):
    cursor.execute("SHOW TABLES")
    return [table[0] for table in cursor.fetchall()]

def backup_database(output_file):
    connection = pymysql.connect(host=Config.DATABASE_HOST, user=Config.DATABASE_USER, password=Config.DATABASE_PASSWORD, database=Config.DATABASE_NAME)
    try:
        with connection.cursor() as cursor:
            tables = fetch_tables(cursor)
            with open(output_file, 'w') as f:
                for table in tables:
                    # Create table statement
                    cursor.execute(f"SHOW CREATE TABLE {table}")
                    create_table_stmt = cursor.fetchone()[1]
                    f.write(f"{create_table_stmt};\n\n")
                    
                    # Table data
                    data = fetch_table_data(cursor, table)
                    for row in data:
                        values = ', '.join([f"'{str(item).replace("'", "''")}'" if isinstance(item, str) else str(item) for item in row])
                        f.write(f"INSERT INTO {table} VALUES ({values});\n")
                    f.write("\n")
        print("Backup realizado con éxito.")
    except Exception as e:
        print(f"Error al realizar el backup de la base de datos: {e}")
    finally:
        connection.close()

# Uso de la función
backup_database('./app/static/files/backupBD.sql')
