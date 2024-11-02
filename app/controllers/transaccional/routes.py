
from urllib import response
from flask import current_app, make_response, render_template, send_file

from flask import render_template, send_file, request, jsonify, redirect, url_for, flash
from app.models.transaccional_models import obtener_productos, obtener_ventas, obtener_marcas, obtener_categorias, obtener_ingresos, obtener_nota_salida, obtener_inventario, obtener_subcategorias_por_categoria, agregar_producto, obtener_inventario_vigente, listarClientes, obtener_id_sucursal, obtener_ultimo_comprobante, obtener_ventas_con_detalles, obtener_compras

import app.models.transaccional_models as transac 
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
    id_marca = request.form.get('marca')
    id_subcategoria = request.form.get('sub_categoria_id')
    descripcion = request.form.get('descripcion')
    undm = request.form.get('unidad_medida')
    precio = request.form.get('precio')
    estado_producto = request.form.get('estado')

    if not all([id_marca, id_subcategoria, descripcion, undm, precio, estado_producto]):
        flash('Todos los campos son obligatorios.', 'error')
        return redirect(url_for('transaccional.almacen'))

    resultado = agregar_producto(id_marca, id_subcategoria, descripcion, undm, precio, None, estado_producto)
    
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

@transactional_bp.route('/nueva_nota', methods=['GET'])
def nueva_nota():
    return render_template('transaccional/almacen/nueva_nota.html')
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
@transactional_bp.route('/ventas', methods=['GET'])
def ventas():
    total_ventas = obtener_ventas()
    ventas_con_detalles = obtener_ventas_con_detalles()  # Nueva función para obtener ventas detalladas
    datos_inventario = obtener_inventario_vigente()  
    clientes = listarClientes()

    return render_template(
        'transaccional/ventas/ventas.html',
        total_ventas=total_ventas,
        ventas_con_detalles=ventas_con_detalles,
        datos_inventario=datos_inventario,
        clientes=clientes
    )

@transactional_bp.route('/addVenta', methods=['POST'])
def add_venta():
    try:
        venta_data = request.cookies.get('ventaData')
        print(venta_data)
        usuario = 1 # Usuario obtener de cookie
        id_sucursal = 1
        comprobante_pago = request.form.get('comprobante_pago')
        id_cliente = request.form.get('cliente')
        estado_venta = 2
        igv = request.form.get('igv')
        monto_total = request.form.get('monto_total')
        base_imponible = None
        metodo_pago = request.form.get('metodo_pago') + ":" + monto_total
        id_anular = 4
        id_anular_b = 5
        observacion = request.form.get('observacion')
        transac.vender(id_sucursal, comprobante_pago, id_cliente, estado_venta, igv, monto_total, base_imponible, metodo_pago, id_anular, id_anular_b, observacion, venta_data)

        # Crea la redirección y elimina la cookie en la respuesta
        response = make_response(redirect(url_for('transaccional.ventas')))
        response.delete_cookie('ventaData')
        return response
    except Exception as e:
        return str(e)

# Modulo de compras

@transactional_bp.route('/compras')
def compras():
    compras = obtener_compras()
    return render_template('transaccional/compras/compras.html', compras=compras)
#----------------------------------------------