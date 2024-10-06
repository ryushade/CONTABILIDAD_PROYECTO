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
                    'estado_producto': producto['estado'],
                    'undm': producto['undm'],
                    'precio': producto['precio'],
                    'cod_barras': producto['cod_barras'],
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

  