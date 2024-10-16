from flask import render_template, send_file
from app.models.transaccional_models import obtener_productos, obtener_marcas, obtener_categorias, obtener_ingresos, obtener_nota_salida, obtener_inventario
from app.models.transaccional_models import generate_barcode
from . import transactional_bp


# Modulo de almacen
@transactional_bp.route('/almacen')
def almacen():
    datos_almacen_entrada = obtener_ingresos()
    datos_almacen_salida = obtener_nota_salida()
    datos_inventario = obtener_inventario()
    return render_template('transaccional/almacen/almacen.html', datos_almacen_entrada=datos_almacen_entrada, datos_almacen_salida=datos_almacen_salida, datos_inventario=datos_inventario)

@transactional_bp.route('/barcode/<string:code>', methods=['GET'])
def barcode(code):
    response = generate_barcode(code)
    
    if response is None:
        return "Error generando el código de barras", 500

    return response

#----------------------------------------------

# Modulo de productos


@transactional_bp.route('/marcas')
def marcas():
    return render_template('transaccional/productos/marcas.html')

@transactional_bp.route('/categorias')
def categorias():
    return render_template('transaccional/productos/categorias.html')

@transactional_bp.route('/subcategorias')
def subcategorias():
    return render_template('transaccional/productos/subcategorias.html')

#----------------------------------------------


@transactional_bp.route('/productos', methods=['GET'])
def productos():
    productos = obtener_productos()
    marcas = obtener_marcas()
    categorias = obtener_categorias()
    return render_template('transaccional/productos/productos.html', productos=productos, marcas=marcas, categorias=categorias)

# Modulo de ventas
@transactional_bp.route('/ventas')
def ventas():
    return render_template('transaccional/ventas/ventas.html')

#----------------------------------------------


# Modulo de compras

@transactional_bp.route('/compras')
def compras():
    return render_template('transaccional/compras/compras.html')
#----------------------------------------------