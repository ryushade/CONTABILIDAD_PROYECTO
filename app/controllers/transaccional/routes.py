from flask import render_template
from app.models.transaccional_models import obtener_productos, obtener_marcas, obtener_categorias, obtener_ingresos
from . import transactional_bp

# Modulo de inicio
@transactional_bp.route('/')
def index():
    return render_template('transaccional/index.html')
#----------------------------------------------

# Modulo de almacen
@transactional_bp.route('/almacen')
def almacen():
    datos_almacen = obtener_ingresos()
    return render_template('transaccional/almacen/almacen.html', datos_almacen=datos_almacen)
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