from flask import render_template, send_file, request, jsonify, redirect, url_for, flash
from app.models.transaccional_models import obtener_productos, obtener_marcas, obtener_categorias, obtener_ingresos, obtener_nota_salida, obtener_inventario, obtener_subcategorias_por_categoria, agregar_producto
from app.models.transaccional_models import generate_barcode
from . import transactional_bp


# Modulo de almacen
@transactional_bp.route('/almacen', methods=['GET'])
def almacen():
    datos_almacen_entrada = obtener_ingresos()
    datos_almacen_salida = obtener_nota_salida()
    datos_inventario = obtener_inventario()
    categorias = obtener_categorias()
    
    return render_template(
        'transaccional/almacen/almacen.html',
        datos_almacen_entrada=datos_almacen_entrada,
        datos_almacen_salida=datos_almacen_salida,
        datos_inventario=datos_inventario,
        categorias=categorias
    )

@transactional_bp.route('/obtener_subcategorias', methods=['GET'])
def obtener_subcategorias():
    categoria_id = request.args.get('categoria_id')
    print("Categoria ID:", categoria_id)  # Para depurar
    if not categoria_id:
        return jsonify([])
    
    subcategorias = obtener_subcategorias_por_categoria(categoria_id)
    print("Subcategorias:", subcategorias)  # Para depurar
    return jsonify(subcategorias)

@transactional_bp.route('/add_producto', methods=['POST'])
def add_producto():
    # Obtén los datos del formulario
    id_marca = request.form.get('marca')
    id_subcategoria = request.form.get('sub_categoria_id')
    descripcion = request.form.get('descripcion')
    undm = request.form.get('unidad_medida')
    precio = request.form.get('precio')
    estado_producto = request.form.get('estado')

    # Verifica que los campos requeridos no estén vacíos
    if not all([id_marca, id_subcategoria, descripcion, undm, precio, estado_producto]):
        flash('Todos los campos son obligatorios.', 'error')
        return redirect(url_for('transaccional.almacen'))

    # Llama a la función de modelo para agregar el producto
    resultado = agregar_producto(id_marca, id_subcategoria, descripcion, undm, precio, None, estado_producto)
    
    # Redirige a la página de almacen si el producto se agregó correctamente
    if resultado['code'] == 1:
        flash('Producto agregado correctamente.', 'success')
    else:
        flash('Error al agregar el producto.', 'error')
    
    return redirect(url_for('transaccional.almacen'))


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