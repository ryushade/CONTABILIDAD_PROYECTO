import json
import os
from urllib import response
from app.models.contable_models import obtener_usuario_por_id
from flask import abort, current_app, make_response, render_template, send_file, session
from flask_jwt_extended import jwt_required, get_jwt_identity

from flask import render_template, send_file, request, jsonify, redirect, url_for, flash
from app.models.transaccional_models import obtener_productos, obtener_ventas, obtener_marcas, obtener_categorias, obtener_ingresos, obtener_nota_salida, obtener_inventario, obtener_subcategorias_por_categoria, agregar_producto, obtener_inventario_vigente, listarClientes, obtener_id_sucursal, obtener_ultimo_comprobante, obtener_ventas_con_detalles, obtener_proveedor, obtener_almacen, obtener_compras_con_detalles
from functools import wraps
from flask_jwt_extended import get_jwt_identity

import app.models.transaccional_models as transac 
from app.models.transaccional_models import generate_barcode
from . import transactional_bp

def role_required(*roles):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            user_id = get_jwt_identity()
            user = obtener_usuario_por_id(user_id)
            
            if not user:
                print("Error: Usuario no encontrado")
                return abort(403)
            
            user_role = user['rol']['nom_rol'].strip().upper() 
            print(f"Usuario rol: {user_role}")  

            if user_role not in [role.upper() for role in roles]: 
                print("Error: Rol no permitido")
                return abort(403)  

            return f(*args, **kwargs)
        return decorated_function
    return decorator



# Modulo de almacen
@transactional_bp.route('/almacen', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
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
@jwt_required()
def obtener_subcategorias():
    categoria_id = request.args.get('categoria_id')
    print("Categoria ID:", categoria_id)  # Para depurar
    if not categoria_id:
        return jsonify([])
    
    subcategorias = obtener_subcategorias_por_categoria(categoria_id)
    print("Subcategorias:", subcategorias)  # Para depurar
    return jsonify(subcategorias)

@transactional_bp.route('/add_producto', methods=['POST'])
@jwt_required()
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
@jwt_required()
def barcode(code):
    response = generate_barcode(code)
    
    if response is None:
        return "Error generando el código de barras", 500

    return response

@transactional_bp.route('/nueva_nota', methods=['GET'])
@jwt_required()

def nueva_nota():
    return render_template('transaccional/almacen/nueva_nota.html')
#----------------------------------------------

# Modulo de productos


@transactional_bp.route('/marcas')
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def marcas():
    return render_template('transaccional/productos/marcas.html')

@transactional_bp.route('/categorias')
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def categorias():
    return render_template('transaccional/productos/categorias.html')

@transactional_bp.route('/subcategorias')
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def subcategorias():
    return render_template('transaccional/productos/subcategorias.html')

#----------------------------------------------


@transactional_bp.route('/productos', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def productos():
    productos = obtener_productos()
    marcas = obtener_marcas()
    categorias = obtener_categorias()
    return render_template('transaccional/productos/productos.html', productos=productos, marcas=marcas, categorias=categorias)

@transactional_bp.route('/descargar_pdf/<filename>')
@jwt_required()
def descargar_pdf(filename):
    print("asdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    file_path = os.path.join(current_app.root_path, 'static', 'PDF', filename)
    return send_file(file_path, as_attachment=True, download_name=filename)

@transactional_bp.route('/ventas', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def ventas():
    pdf_filename = session.pop('pdf_filename', None)
    total_ventas = obtener_ventas()
    ventas_con_detalles = obtener_ventas_con_detalles()
    datos_inventario = obtener_inventario_vigente()
    clientes = listarClientes()

    if pdf_filename:
        return render_template(
            'transaccional/ventas/ventas.html',
            pdf_filename=pdf_filename,
            download_url=url_for('transaccional.descargar_pdf', filename=pdf_filename),
            total_ventas=total_ventas,
            ventas_con_detalles=ventas_con_detalles,
            datos_inventario=datos_inventario,
            clientes=clientes
        )
    else:
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
        usuario = 1  # Usuario obtener de cookie
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
        id_venta, numero_com = transac.vender(id_sucursal, comprobante_pago, id_cliente, estado_venta, igv, monto_total, base_imponible, metodo_pago, id_anular, id_anular_b, observacion, venta_data)
        
        session['pdf_filename'] = f'{numero_com}.pdf'
        # Redirige a la página de inicio
        response = make_response(redirect(url_for('transaccional.ventas')))
        response.delete_cookie('ventaData')
        return response
    except Exception as e:
        return str(e)

# Modulo de compras


@transactional_bp.route('/compras', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'EMPLEADO')
def compras():
    compras_con_detalles = obtener_compras_con_detalles()
    proveedor = obtener_proveedor()
    almacen = obtener_almacen()
    datos_inventario = obtener_inventario_vigente()
    return render_template('transaccional/compras/compras.html', proveedor=proveedor, almacen=almacen, datos_inventario=datos_inventario,compras=compras_con_detalles)




@transactional_bp.route('/registrar_compra', methods=['POST'])
def registrar_compra():
    try:
        # Obtener los datos de la cookie
        compra_data = request.cookies.get('compraData')
        print("Datos de la cookie compraData:", compra_data)

        # Asegurar que compra_data no sea None
        if compra_data:
            productos = json.loads(compra_data)
        else:
            return jsonify({'success': False, 'message': 'No hay datos de productos en la cookie.'})

        # Capturar otros datos del formulario
        proveedor = request.form.get('proveedor')
        nro_comprobante = request.form.get('nro_comprobante')
        almacen = request.form.get('almacen')
        fecha = request.form.get('fecha')
        igv = request.form.get('igv')
        monto_total = request.form.get('monto_total')

        print(f"Proveedor: {proveedor}, Nro Comprobante: {nro_comprobante}, Almacén: {almacen}, Fecha: {fecha}, IGV: {igv}, Monto Total: {monto_total}")
        print("Productos:", productos)  # Verifica la estructura de productos

        # Llamar a la función para registrar la compra
        result = transac.registrar_compra(proveedor, nro_comprobante, almacen, fecha, igv, monto_total, productos)

        # Preparar la respuesta
        response = make_response(jsonify(result))
        
        # Si el registro es exitoso, eliminar la cookie
        if result['success']:
            response = make_response(redirect(url_for('transaccional.compras')))
            response.delete_cookie('compraData')

        return response
    except Exception as e:
        print("Error en registrar_compra:", str(e))
        return jsonify({'success': False, 'message': 'Error al registrar la compra.'})
