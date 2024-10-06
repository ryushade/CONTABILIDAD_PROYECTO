from app.models.conexion import obtener_conexion


def obtener_productos():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
            SELECT PR.id_producto, PR.descripcion, CA.nom_subcat, MA.nom_marca, PR.undm, 
                CAST(PR.precio AS DECIMAL(10, 2)) AS precio, PR.cod_barras, PR.estado_producto as estado
                FROM producto PR
                INNER JOIN marca MA ON MA.id_marca = PR.id_marca
                INNER JOIN sub_categoria CA ON CA.id_subcategoria = PR.id_subcategoria
                ORDER BY PR.id_producto DESC
            """
            cursor.execute(sql)
            resultado = cursor.fetchall()
            productos = []
            for producto in resultado:
                productos.append({
                    'id_producto': producto['id_producto'],
                    'descripcion': producto['descripcion'],
                    'nom_subcat': producto['nom_subcat'],
                    'nom_marca': producto['nom_marca'],
                    'undm': producto['undm'],
                    'precio': producto['precio'],
                    'cod_barras': producto['cod_barras'],
                    'estado': producto['estado']
                }
            ) 
            return productos
    
    finally:
        conexion.close()
        

def obtener_marcas():
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            sql = """
            SELECT id_marca, nom_marca
            FROM marca
            ORDER BY nom_marca
            """
            cursor.execute(sql)
            resultado = cursor.fetchall()
            marcas = []
            for marca in resultado:
                marcas.append({
                    'id_marca': marca['id_marca'],
                    'nom_marca': marca['nom_marca']
                }
            ) 
            return marcas
    
    finally:
        conexion.close()