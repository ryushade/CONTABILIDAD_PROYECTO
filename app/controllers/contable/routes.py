from app.models.conexion import obtener_conexion
from flask import json, abort, request, redirect, url_for, flash, session, jsonify, render_template, send_file, current_app, send_from_directory
from flask_jwt_extended import jwt_required, create_access_token, set_access_cookies, unset_jwt_cookies, get_jwt_identity, verify_jwt_in_request
from app.models.contable_models import actualizar_regla_en_db, agregar_regla_en_db, obtener_id_cuenta, obtener_regla_por_id, obtener_roles, obtener_usuario_por_nombre, agregar_usuario, actualizar_usuario, eliminar_usuario, verificar_contraseña, obtener_asientos_agrupados,obtener_reglas, obtener_cuentas, obtener_usuarios, obtener_total_cuentas, eliminar_cuenta, eliminar_regla_bd, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta, obtener_cuentas_excel, obtener_libro_mayor_agrupado_por_fecha, obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica,obtener_registro_ventas,obtener_asientos_agrupados_excel,obtener_registro_compras
from app.models.contable_models import actualizar_regla_en_db, agregar_regla_en_db, guardar_foto_usuario, obtener_regla_por_id, obtener_roles, obtener_usuario_por_nombre, agregar_usuario, actualizar_usuario, eliminar_usuario, verificar_contraseña, obtener_asientos_agrupados,obtener_reglas, obtener_cuentas, obtener_usuarios, obtener_total_cuentas, eliminar_cuenta, eliminar_regla_bd, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta, obtener_cuentas_excel, obtener_libro_mayor_agrupado_por_fecha, obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica,obtener_registro_ventas, obtener_asientos_agrupados_excel, obtener_libro_caja, obtener_libro_caja_cuenta_corriente
from functools import wraps

from . import accounting_bp
import pandas as pd
import io
import os
from openpyxl.utils import get_column_letter
from openpyxl.styles import Font, Alignment, PatternFill
from datetime import datetime
from openpyxl.styles import Border, Side, Alignment, Font
from fpdf import FPDF
from io import BytesIO
from werkzeug.utils import secure_filename
from flask_jwt_extended import get_jwt_identity

def role_required(*roles):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            user_id = get_jwt_identity()
            user = obtener_usuario_por_id(user_id)
            
            if not user:
                print("Error: Usuario no encontrado")
                session['show_permission_alert'] = True  # Activa el mensaje en la sesión
                return abort(403)
            
            user_role = user['rol']['nom_rol'].strip().upper()
            print(f"Usuario rol: {user_role}")

            if user_role not in [role.upper() for role in roles]:
                print("Error: Rol no permitido")
                session['show_permission_alert'] = True  # Activa el mensaje en la sesión
                return abort(403)

            return f(*args, **kwargs)
        return decorated_function
    return decorator

from flask import Flask, request, redirect, url_for, render_template, flash, make_response

@accounting_bp.route('/login', methods=['GET', 'POST'])
def login():
    try:
        # Verifica si hay un JWT en la solicitud
        verify_jwt_in_request(optional=True)
        if get_jwt_identity():  # Si el usuario ya tiene un JWT válido
            return redirect(url_for('inicio'))  # Redirigir a la página principal
    except:
        pass  # Si no hay un JWT válido, continúa con el proceso de inicio de sesión

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Consulta el usuario por nombre
        user = obtener_usuario_por_nombre(username)

        # Verifica si el usuario existe y la contraseña es correcta
        if user and verificar_contraseña(user, password):
            # Generar el token de acceso JWT
            access_token = create_access_token(identity=user['id_usuario'])
            response = make_response(redirect(url_for('inicio')))
            set_access_cookies(response, access_token)  # Guardar el token en una cookie segura
            response.set_cookie('username', username, httponly=True)  # Guarda el username en una cookie
            session['username'] = username
            print(session.get('username'))
            return response
        else:
            flash("Usuario o contraseña incorrectos", "error")

    return render_template('contable/login.html')


@accounting_bp.route('/logout')
def logout():
    response = redirect(url_for('contable.login'))
    unset_jwt_cookies(response)  # Elimina el token de la cookie
    return response

@accounting_bp.route('/reportes', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'CONTADOR')
def reportes():
    active_tab = request.args.get('active_tab', 'libro-diario')
    tipo_registro = request.args.get('tipo_registro', 'Todas')
    daterange = request.args.get('daterange', '')
    daterange_mayor = request.args.get('daterangemayor', '')  # Segundo rango de fechas específico para el Libro Mayor
    daterange_caja = request.args.get('daterangecaja', '')
    start_date, end_date = None, None
    start_date_mayor, end_date_mayor = None, None
    start_date_caja, end_date_caja = None, None

    from datetime import datetime, timedelta

    # Procesa el rango de fechas para el Libro Diario
    if daterange:
        try:
            dates = daterange.split(' to ')
            if len(dates) == 2:
                start_date = datetime.strptime(dates[0].strip(), '%m/%Y').date()
                end_date = datetime.strptime(dates[1].strip(), '%m/%Y').date()
                # Calcular el último día del mes para el segundo mes
                end_date = end_date.replace(day=1) + timedelta(days=31)
                end_date = end_date.replace(day=1) - timedelta(days=1)
            elif len(dates) == 1:
                # Si solo hay un mes, se usa como inicio y fin del mes
                start_date = datetime.strptime(dates[0].strip(), '%m/%Y').date()
                end_date = start_date.replace(day=1) + timedelta(days=31)
                end_date = end_date.replace(day=1) - timedelta(days=1)
        except (ValueError, IndexError) as e:
            print(f"Error processing date range for Libro Diario: {e}")

    # Procesa el rango de fechas para el Libro Mayor
    if daterange_mayor:
        try:
            dates_mayor = daterange_mayor.split(' to ')
            if len(dates_mayor) == 2:
                start_date_mayor = datetime.strptime(dates_mayor[0].strip(), '%m/%Y').date()
                end_date_mayor = datetime.strptime(dates_mayor[1].strip(), '%m/%Y').date()
                # Calcular el último día del mes para el segundo mes
                end_date_mayor = end_date_mayor.replace(day=1) + timedelta(days=31)
                end_date_mayor = end_date_mayor.replace(day=1) - timedelta(days=1)
            elif len(dates_mayor) == 1:
                # Si solo hay un mes, se usa como inicio y fin del mes
                start_date_mayor = datetime.strptime(dates_mayor[0].strip(), '%m/%Y').date()
                end_date_mayor = start_date_mayor.replace(day=1) + timedelta(days=31)
                end_date_mayor = end_date_mayor.replace(day=1) - timedelta(days=1)
        except (ValueError, IndexError) as e:
            print(f"Error processing date range for Libro Mayor: {e}")

    if daterange_caja:
        try:
            dates_caja = daterange_caja.split(' to ')
            if len(dates_caja) == 2:
                start_date_caja = datetime.strptime(dates_caja[0].strip(), '%m/%Y').date()
                end_date_caja = datetime.strptime(dates_caja[1].strip(), '%m/%Y').date()
                # Calcular el último día del mes para el segundo mes
                end_date_caja = end_date_caja.replace(day=1) + timedelta(days=31)
                end_date_caja = end_date_caja.replace(day=1) - timedelta(days=1)
            elif len(dates_caja) == 1:
                # Si solo hay un mes, se usa como inicio y fin del mes
                start_date_caja = datetime.strptime(dates_caja[0].strip(), '%m/%Y').date()
                end_date_caja = start_date_caja.replace(day=1) + timedelta(days=31)
                end_date_caja = end_date_caja.replace(day=1) - timedelta(days=1)
        except (ValueError, IndexError) as e:
            print(f"Error processing date range for Libro Caja: {e}")

    # Obtiene los datos aplicando el filtro de fechas correspondiente
    asientos, totales = obtener_asientos_agrupados(tipo_registro, start_date, end_date)
    libro_mayor_data, total_debe, total_haber = obtener_libro_mayor_agrupado_por_fecha(start_date_mayor, end_date_mayor)
    lista_libro_caja, total_caja = obtener_libro_caja(start_date_caja, end_date_caja)
    lista_libro_caja_cuenta_corriente, total_caja_corriente = obtener_libro_caja_cuenta_corriente()

    registro_venta_data, totale = obtener_registro_ventas()
    registro_compra_data, totales_compra = obtener_registro_compras()
    
    return render_template(
        'contable/reportes/reportes.html', 
        asientos=asientos, 
        totales=totales, 
        libro_mayor=libro_mayor_data, 
        total_debe=total_debe, 
        total_haber=total_haber, 
        registros_ventas=registro_venta_data, 
        totale=totale, 
        registros_compras=registro_compra_data,
        totalesCompras=totales_compra,
        lista_libro_caja=lista_libro_caja, 
        total_caja=total_caja, 
        lista_libro_caja_cuenta_corriente=lista_libro_caja_cuenta_corriente, 
        total_caja_corriente=total_caja_corriente,
        active_tab=active_tab
    )



import app.models.contable_models as conta
@accounting_bp.route('/cuentas', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'CONTADOR')
def cuentas():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 50, type=int)
    tipo_cuenta = request.args.get('tipo_cuenta')
    naturaleza = request.args.get('naturaleza')
    cuentas = conta.obtenerCuentas()
    # print(json.dumps(estructura_cuentas, indent=2))
    total_cuentas = obtener_total_cuentas(tipo_cuenta=tipo_cuenta, naturaleza=naturaleza)
    total_pages = (total_cuentas + per_page - 1) // per_page
    # Obtener el mensaje de error
    error_message = session.pop('error_message', None)
    print(error_message)
    return render_template(
        'contable/cuentas/cuentas2.html',
        cuentas = cuentas,
        page=page,
        total_pages=total_pages,
        per_page=per_page,
        total_results=total_cuentas,
        tipo_cuenta=tipo_cuenta,
        naturaleza=naturaleza,
        error_message = error_message,
        max=max,
        min=min
    )


@accounting_bp.route('/exportar_excel', methods=['GET'])
@jwt_required()
def exportar_excel():
    cuentas = obtener_cuentas_excel()

    df = pd.DataFrame(cuentas)

    # Renombrar los encabezados
    df.rename(columns={
        'codigo_cuenta': 'Código de Cuenta',
        'nombre_cuenta': 'Nombre de Cuenta',
        'tipo_cuenta': 'Tipo de Cuenta',
        'naturaleza': 'Naturaleza'
    }, inplace=True)

    output = io.BytesIO()

    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df.to_excel(writer, sheet_name='Plan de cuentas', index=False)

        workbook = writer.book
        worksheet = writer.sheets['Plan de cuentas']

        header_font = Font(bold=True, color="FFFFFF")
        header_fill = PatternFill(start_color="4F81BD", end_color="4F81BD", fill_type="solid")
        alignment = Alignment(horizontal="center", vertical="center")

        for col_num, column_title in enumerate(df.columns, 1):
            cell = worksheet[f'{get_column_letter(col_num)}1']
            cell.font = header_font
            cell.fill = header_fill
            cell.alignment = alignment

        for col_num, column in enumerate(df.columns, 1):
            max_length = max([len(str(value)) for value in df[column]]) + 2
            worksheet.column_dimensions[get_column_letter(col_num)].width = max_length

    output.seek(0)

    return send_file(output, download_name="plan_de_cuentas.xlsx", as_attachment=True)


# routes.py
@accounting_bp.route('/exportar_pdf', methods=['GET'], endpoint='exportar_pdf')
@jwt_required()
def descargar_pdf():
    return send_from_directory(
        directory='static/files',  
        path='PCGE.pdf',
        as_attachment=True,
        download_name="PCGE.pdf"
    )


@accounting_bp.route('/cuentas/obtener/<int:cuenta_id>', methods=['GET'])
def obtener_cuenta(cuenta_id):
    cuenta = obtener_cuenta_por_id(cuenta_id)
    if cuenta:
        return jsonify(cuenta)
    else:
        return jsonify({'error': 'Cuenta no encontrada'}), 404
    




@accounting_bp.route('/cuentas/editar/<int:cuenta_id>', methods=['POST'])
def editar_cuenta(cuenta_id):
    codigo_cuenta = request.form['codigo_cuenta']
    nombre_cuenta = request.form['nombre_cuenta']
    naturaleza = request.form['naturaleza']
    estado_cuenta = request.form['estado_cuenta']

    actualizar_cuenta(cuenta_id, codigo_cuenta, nombre_cuenta, naturaleza, estado_cuenta)

    return redirect(url_for('contable.cuentas'))

@accounting_bp.route('/cuentas/registrar', methods=['POST'])
def registrar_cuenta():
    try:
        codigo_cuenta = request.form['codigo_cuenta_agregar']
        nombre_cuenta = request.form['nombre_cuenta_agregar']
        naturaleza = request.form['naturaleza_agregar']
        estado_cuenta = request.form['estado_cuenta_agregar']
        print(codigo_cuenta)
        print(nombre_cuenta)
        print(naturaleza)
        print(estado_cuenta)
        conta.insertar_cuenta(codigo_cuenta, nombre_cuenta, naturaleza, estado_cuenta)
        return redirect(url_for('contable.cuentas'))
    except Exception as e:
        session['error_message'] = str(e)
        return redirect(url_for('contable.cuentas'))


@accounting_bp.route('/reglas/agregar', methods=['POST'])
def agregar_regla():
    data = request.get_json()

    nombre_regla = data.get("nombre_regla")
    tipo_transaccion = data.get("tipo_transaccion")
    cuenta_debito_codigo = data.get("cuenta_debito") or None
    cuenta_credito_codigo = data.get("cuenta_credito") or None
    estado = data.get("estado")
    tipo_monto = data.get("tipo_monto")

    print("Datos recibidos en agregar_regla:")
    print("Nombre de la regla:", nombre_regla)
    print("Tipo de transacción:", tipo_transaccion)
    print("Cuenta débito código:", cuenta_debito_codigo)
    print("Cuenta crédito código:", cuenta_credito_codigo)
    print("Estado:", estado)

    if tipo_transaccion is None:
        print("Error: tipo_transaccion es None")
        return jsonify({"success": False, "message": "El tipo de transacción no puede ser None"}), 400

    # Convertir los códigos de cuenta a id_cuenta antes de agregar la regla
    cuenta_debito = obtener_id_cuenta(cuenta_debito_codigo) if cuenta_debito_codigo else None
    cuenta_credito = obtener_id_cuenta(cuenta_credito_codigo) if cuenta_credito_codigo else None

    print("Cuenta Débito ID:", cuenta_debito)
    print("Cuenta Crédito ID:", cuenta_credito)

    try:
        resultado = agregar_regla_en_db(nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado, tipo_monto)
        
        if resultado:
            return jsonify({"success": True})
        else:
            return jsonify({"success": False, "message": "No se pudo agregar la regla."}), 400
       
    except Exception as e:
        print("Error al agregar la regla:", e)
        return jsonify({"success": False, "message": "Error interno del servidor."}), 500

       
    except Exception as e:
        print("Error al agregar la regla:", e)  # Imprime el error en la consola
        return jsonify({"success": False, "message": "Error interno del servidor."}), 500


@accounting_bp.route('/upload_photo', methods=['POST'])
def upload_photo():
    if 'photo' not in request.files:
        return redirect(url_for('inicio'))

    file = request.files['photo']
    if file.filename == '':
        return redirect(url_for('inicio'))

    username = request.cookies.get('username', None)
    if not username:
        return redirect(url_for('inicio'))  # Si no hay cookie, redireccionar al inicio

    filename = secure_filename(username)
    if not filename:
        return redirect(url_for('inicio'))

    file_extension = os.path.splitext(file.filename)[1]
    filename += file_extension

    # Asegura que estás usando el directorio correcto
    upload_folder = current_app.config['UPLOAD_FOLDER']
    print("upload_folder", upload_folder)
    # Crea la carpeta si no existe
    if not os.path.exists(upload_folder):
        os.makedirs(upload_folder)

    filepath = os.path.join(upload_folder, filename)
    file.save(filepath)

    # Genera la ruta para almacenar en la base de datos
    foto_path = f"/app/static/fotos_perfil/{filename}"
    print(f"Ruta URL para la base de datos: {foto_path}")

    user_id = request.form.get('user_id')
    if not user_id:
        return redirect(url_for('inicio'))

    # Guardar la ruta en la base de datos
    if guardar_foto_usuario(user_id, foto_path):
        return redirect(url_for('inicio'))
    else:
        return redirect(url_for('inicio'))
    
@accounting_bp.route('/upload_photo/obtener/<int:user_id>', methods=['GET'])
def obtener_foto_usuario(user_id):
    foto = obtener_foto_usuario_db(user_id)
    def obtener_foto_usuario_db(user_id):
        conexion = obtener_conexion()
        try:
            with conexion.cursor() as cursor:
                query = "SELECT foto FROM usuario WHERE id_usuario = %s"
                cursor.execute(query, (user_id,))
                result = cursor.fetchone()
                if result:
                    return result['foto']
                else:
                    return None
        except Exception as e:
            print(f"Error al obtener la foto del usuario: {e}")
            return None
        finally:
            conexion.close()
    if foto:
        return jsonify({"foto_path": foto})
    else:
        return jsonify({"foto_path": None})
    

@accounting_bp.route('/reglas/actualizar_regla/<int:id_regla>', methods=['POST'])
def actualizar_regla(id_regla):
    data = request.get_json()

    nombre_regla = data.get("nombre_regla")
    tipo_transaccion = data.get("tipo_transaccion")
    cuenta_debito_codigo = data.get("cuenta_debito") or None
    cuenta_credito_codigo = data.get("cuenta_credito") or None
    estado = data.get("estado")

    # Añade estos prints
    print("Datos recibidos:")
    print("ID Regla:", id_regla)
    print("Nombre Regla:", nombre_regla)
    print("Tipo Transacción:", tipo_transaccion)
    print("Cuenta Débito Código:", cuenta_debito_codigo)
    print("Cuenta Crédito Código:", cuenta_credito_codigo)
    print("Estado:", estado)

       # Convertir los códigos de cuenta a id_cuenta antes de actualizar
    cuenta_debito = obtener_id_cuenta(cuenta_debito_codigo) if cuenta_debito_codigo else None
    cuenta_credito = obtener_id_cuenta(cuenta_credito_codigo) if cuenta_credito_codigo else None

    print("Cuenta Débito ID:", cuenta_debito)
    print("Cuenta Crédito ID:", cuenta_credito)

    resultado = actualizar_regla_en_db(id_regla, nombre_regla, tipo_transaccion, cuenta_debito, cuenta_credito, estado)

    if resultado:
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "message": "No se encontró la regla o no se pudo actualizar."}), 404

@accounting_bp.route('/reglas', methods=['GET'])
@jwt_required()
@role_required('ADMIN', 'CONTADOR')
def reglas():
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=5, type=int)

    reglas, total_results = obtener_reglas(page, per_page)

    total_pages = (total_results + per_page - 1) // per_page

    return render_template(
        'contable/reglas/reglas.html',
        reglas=reglas,
        page=page,
        per_page=per_page,
        total_results=total_results,
        total_pages=total_pages,
        max = max,
        min = min,
    )


@accounting_bp.route('/usuarios', methods=['GET'])
@jwt_required()
@role_required('ADMIN')
def usuarios():
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=5, type=int)

    usuarios, total_results = obtener_usuarios(page, per_page)
    roles = obtener_roles()

    total_pages = (total_results + per_page - 1) // per_page

    return render_template(
        'contable/usuarios/usuarios.html',
        usuarios=usuarios,
        roles=roles,
        page=page,
        per_page=per_page,
        total_results=total_results,
        total_pages=total_pages,
        max=max,  
        min=min   
    )


@accounting_bp.route('/usuarios/obtener/<int:id_usuario>', methods=['GET'])
def obtener_usuario(id_usuario):
    conexion = obtener_conexion()
    try:
        with conexion.cursor() as cursor:
            # Consulta para obtener datos del usuario y el nombre del rol
            query = """
                SELECT usuario.id_rol, usuario.usua, usuario.contra, usuario.estado_usuario, rol.nombre_rol 
                FROM usuario 
                JOIN rol ON usuario.id_rol = rol.id_rol
                WHERE usuario.id_usuario = %s
            """
            cursor.execute(query, (id_usuario,))
            usuario = cursor.fetchone()

            if usuario:
                return jsonify({
                    "id_rol": usuario[0],
                    "usua": usuario[1],
                    "contra": usuario[2],
                    "estado_usuario": usuario[3],
                    "nombre_rol": usuario[4]  # Nombre del rol
                })
            else:
                return jsonify({"error": "Usuario no encontrado"}), 404
    except Exception as error:
        return jsonify({"error": str(error)}), 500
    finally:
        conexion.close()


@accounting_bp.route('/reglas/detalles/<int:regla_id>', methods=['GET'])
def obtener_detalles_regla(regla_id):
    regla = obtener_regla_por_id(regla_id)
    if regla:
        return jsonify({
            "nombre_regla": regla.get("nombre_regla"),
            "tipo_transaccion": regla.get("tipo_transaccion"),
            "estado": "Activo" if regla.get("estado") == 1 else "Inactivo",
            "cuenta_debito_codigo": regla.get("cuenta_debe_codigo"),
            "cuenta_debito_nombre": regla.get("cuenta_debe_nombre"),
            "cuenta_credito_codigo": regla.get("cuenta_haber_codigo"),
            "cuenta_credito_nombre": regla.get("cuenta_haber_nombre"),
            "tipo_monto" : regla.get("tipo_monto")
        })
    else:
        return jsonify({'error': 'Regla no encontrada'}), 404




@accounting_bp.route('/usuarios/actualizar/<int:id_usuario>', methods=['POST'])
def actualizar_usu(id_usuario):
    id_rol = request.form.get('id_rol')
    usua = request.form.get('usua')
    contra = request.form.get('contrasena')
    estado_usuario = request.form.get('estado')

    resultado = actualizar_usuario(id_usuario, id_rol, usua, contra, estado_usuario)
    print("Resultado de la actualización:", resultado)  
    if "error" in resultado:
        return jsonify(resultado), 400

    return jsonify(resultado), 200


@accounting_bp.route('/usuarios/agregar', methods=['POST'])
def agregar_usu():
    datos = request.get_json()
    id_rol = datos.get('id_rol')
    usua = datos.get('usua')
    contra = datos.get('contra')
    estado_usuario = datos.get('estado_usuario')

    # Verifica que los datos no sean nulos
    if not id_rol or not usua or not contra or not estado_usuario:
        return jsonify({"message": "Bad Request. Please fill all fields."}), 400

    resultado = agregar_usuario(id_rol, usua, contra, estado_usuario)

    # Verifica si hubo un error y devuelve un mensaje apropiado
    if "error" in resultado:
        return jsonify({"code": 0, "message": resultado["error"]}), 400

    return jsonify({"code": 1, "message": "Usuario añadido"})


@accounting_bp.route('/usuarios/eliminar/<int:usuario_id>', methods=['POST'])
def eliminar_usu(usuario_id):
    eliminar_usuario(usuario_id)
    return redirect(url_for('contable.usuarios'))

@accounting_bp.route('/cuentas/eliminar/<int:cuenta_id>', methods=['POST'])
def eliminar_cuenta(cuenta_id):
    eliminar_cuenta(cuenta_id)
    return redirect(url_for('contable.cuentas'))

@accounting_bp.route('/reglas/eliminar/<int:regla_id>', methods=['POST'])
def eliminar_regla(regla_id):
    eliminar_regla_bd(regla_id)  # Llama a la función separada
    return redirect(url_for('contable.reglas'))

@accounting_bp.route('/reportes/ldpdf')
@jwt_required()
def ldpf():
    return render_template('contable/reportes/pdf_ld.html')


from openpyxl import load_workbook
from openpyxl.styles import Border, Side, Font, Alignment
from openpyxl.styles import numbers
    
@accounting_bp.route('/exportar_libro_diario_excel', methods=['GET'])
@jwt_required()
def exportar_libro_diario_excel():
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', 'L,D.xlsx')
    
    if not os.path.exists(template_path):
        return "La plantilla de Excel no se encontró.", 404
    
    output = BytesIO()
    
    workbook = load_workbook(template_path)
    worksheet = workbook.active
    
    # Obtener la fecha actual
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')
    
    # Llenar las celdas específicas con los datos necesarios
    worksheet['B3'] = mes_anio_actual
    worksheet['B4'] = '20610588981'
    worksheet['B5'] = 'Tormenta'
    
    # Definir la fila inicial para insertar los datos en la tabla
    start_row = 11

    asientos, _ = obtener_asientos_agrupados_excel()
    numero_correlativo = 1

    total_debe = 0
    total_haber = 0

    # Crear un borde negro
    thin_border = Border(
        left=Side(style='thin', color='000000'),
        right=Side(style='thin', color='000000'),
        top=Side(style='thin', color='000000'),
        bottom=Side(style='thin', color='000000')
    )

    # Crear un estilo de fuente sin negrita
    normal_font = Font(bold=False)

    # Estilos de alineación
    left_alignment = Alignment(horizontal='left', vertical='center')
    right_alignment = Alignment(horizontal='right', vertical='center')
    center_alignment = Alignment(horizontal='center', vertical='center')

    # Insertar los datos en la tabla, fila por fila
    current_row = start_row
    for id_asiento, asiento in asientos.items():
        for detalle in asiento['detalles']:
            worksheet[f'A{current_row}'].number_format = numbers.FORMAT_TEXT
            worksheet[f'A{current_row}'] = str(numero_correlativo)
            worksheet[f'B{current_row}'] = asiento['fecha_asiento'].strftime('%d/%m/%Y')
            worksheet[f'C{current_row}'] = asiento['glosa']
            
            # Determinar el valor para la columna D
            if 'venta' in asiento['glosa'].lower() or 'ingreso' in asiento['glosa'].lower():
                worksheet[f'D{current_row}'] = 14
            elif 'compra' in asiento['glosa'].lower():
                worksheet[f'D{current_row}'] = 8
            elif 'pago' in asiento['glosa'].lower():
                worksheet[f'D{current_row}'] = 1
            else:
                worksheet[f'D{current_row}'] = ''
            
            worksheet[f'F{current_row}'] = asiento['num_comprobante']
            worksheet[f'G{current_row}'] = detalle['codigo_cuenta']
            worksheet[f'H{current_row}'] = detalle['nombre_cuenta']
            worksheet[f'I{current_row}'] = detalle['debe'] if detalle['debe'] != 0 else None
            worksheet[f'J{current_row}'] = detalle['haber'] if detalle['haber'] != 0 else None

            # Aplicar formato de número con dos decimales a las columnas "Debe" y "Haber"
            worksheet[f'I{current_row}'].number_format = '#,##0.00'
            worksheet[f'J{current_row}'].number_format = '#,##0.00'

            # Aplicar estilo a todas las celdas
            for col in ['A', 'B', 'C', 'D', 'F', 'G', 'H', 'I', 'J']:
                cell = worksheet[f'{col}{current_row}']
                cell.border = thin_border
                cell.font = normal_font

            # Alineación específica para columnas
            worksheet[f'A{current_row}'].alignment = center_alignment
            worksheet[f'B{current_row}'].alignment = left_alignment
            worksheet[f'C{current_row}'].alignment = left_alignment
            worksheet[f'D{current_row}'].alignment = center_alignment
            worksheet[f'F{current_row}'].alignment = left_alignment
            worksheet[f'G{current_row}'].alignment = center_alignment
            worksheet[f'H{current_row}'].alignment = left_alignment
            worksheet[f'I{current_row}'].alignment = right_alignment
            worksheet[f'J{current_row}'].alignment = right_alignment
            
            total_debe += detalle['debe']
            total_haber += detalle['haber']

            current_row += 1
        numero_correlativo += 1
    
    # Combinar las celdas de la fila del total
    total_row = current_row
    worksheet.merge_cells(f'A{total_row}:H{total_row}')
    worksheet[f'A{total_row}'] = "Total"
    worksheet[f'A{total_row}'].alignment = Alignment(horizontal='right')
    worksheet[f'A{total_row}'].border = thin_border

    worksheet[f'I{total_row}'] = total_debe
    worksheet[f'J{total_row}'] = total_haber

    # Aplicar formato de número con dos decimales a los totales
    worksheet[f'I{total_row}'].number_format = '#,##0.00'
    worksheet[f'J{total_row}'].number_format = '#,##0.00'

    # Alinear a la derecha los totales de Debe y Haber
    worksheet[f'I{total_row}'].alignment = right_alignment
    worksheet[f'J{total_row}'].alignment = right_alignment
    
    for col in ['A', 'I', 'J']:
        cell = worksheet[f'{col}{total_row}']
        cell.border = thin_border
        cell.font = normal_font

    # Asegurar que todas las columnas tengan un ancho adecuado
    column_widths = {'A': 40, 'B': 15, 'C': 65, 'D': 10, 'F': 20, 'G': 15, 'H': 40, 'I': 15, 'J': 15}
    for column, width in column_widths.items():
        worksheet.column_dimensions[column].width = width

    workbook.save(output)
    output.seek(0)

    return send_file(output, download_name="libro_diario.xlsx", as_attachment=True)


@accounting_bp.route('/exportar_libro_mayor_excel', methods=['GET'])
@jwt_required()
def exportar_libro_mayor_excel():
    import openpyxl
    import os
    from flask import current_app, send_file
    from io import BytesIO
    from datetime import datetime

    # Ruta de la plantilla
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', '234_formato51.xlsx')
    
    if not os.path.exists(template_path):
        return "La plantilla de Excel no se encontró.", 404
    
    # Obtener datos del libro mayor con glosa agrupados por fecha
    libro_mayor = obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica()

    archivos_generados = []
    
    # Obtener la fecha actual para el período
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')

    for codigo_cuenta, detalles in libro_mayor.items():
        output = BytesIO()
        
        # Cargar el archivo de plantilla
        workbook = openpyxl.load_workbook(template_path)
        worksheet = workbook.active
        
        # Llenar las celdas específicas con los datos necesarios
        worksheet['B3'] = mes_anio_actual  # Coloca el período en la celda derecha de 'PERÍODO:'
        worksheet['B4'] = '20610588981'    # Coloca el RUC
        worksheet['B5'] = 'Tormenta'       # Coloca la razón social
        worksheet['B6'] = codigo_cuenta    # Coloca el código de la cuenta
        
        # Insertar los detalles en la tabla, fila por fila
        start_row = 11
        current_row = start_row
        
        # Definir el estilo de fuente
        font = openpyxl.styles.Font(size=10, bold=False)
        
        for detalle in detalles:
            worksheet[f'A{current_row}'] = detalle['fecha_asiento'].strftime('%d/%m/%Y')
            worksheet[f'A{current_row}'].font = font
            
            worksheet[f'C{current_row}'] = detalle['glosa']
            worksheet[f'C{current_row}'].font = font
            
            saldo_debe = detalle['total_debe']
            saldo_haber = detalle['total_haber']

            worksheet[f'D{current_row}'] = saldo_debe if saldo_debe > 0 else None
            worksheet[f'D{current_row}'].number_format = '0.00#################'
            worksheet[f'D{current_row}'].font = font

            worksheet[f'E{current_row}'] = saldo_haber if saldo_haber > 0 else None
            worksheet[f'E{current_row}'].number_format = '0.00#################'
            worksheet[f'E{current_row}'].font = font

            current_row += 1

            # Añadir el total al final de la tabla
            worksheet[f'C{current_row}'] = "Total"
            worksheet[f'C{current_row}'].font = openpyxl.styles.Font(size=10, bold=True)

            # Sumar las columnas D (Deudor) y E (Acreedor)
            total_debe_formula = f'=SUM(D{start_row}:D{current_row - 1})'
            total_haber_formula = f'=SUM(E{start_row}:E{current_row - 1})'

            worksheet[f'D{current_row}'] = total_debe_formula
            worksheet[f'D{current_row}'].number_format = '0.00'
            worksheet[f'D{current_row}'].font = openpyxl.styles.Font(size=10, bold=True)

            worksheet[f'E{current_row}'] = total_haber_formula
            worksheet[f'E{current_row}'].number_format = '0.00'
            worksheet[f'E{current_row}'].font = openpyxl.styles.Font(size=10, bold=True)

        
        # Guardar el archivo modificado en un buffer de memoria
        workbook.save(output)
        output.seek(0)

        # Preparar el archivo para descarga
        archivos_generados.append({
            'filename': f"libro_mayor_{codigo_cuenta}.xlsx",
            'content': output.getvalue()
        })

    # Enviar todos los archivos generados
    if len(archivos_generados) == 1:
        # Si solo se genera un archivo, se devuelve directamente
        return send_file(BytesIO(archivos_generados[0]['content']), download_name=archivos_generados[0]['filename'], as_attachment=True)
    else:
        # Si hay múltiples archivos, se podría comprimir y enviar en un archivo ZIP
        import zipfile
        zip_output = BytesIO()
        with zipfile.ZipFile(zip_output, 'w') as zf:
            for archivo in archivos_generados:
                zf.writestr(archivo['filename'], archivo['content'])
        zip_output.seek(0)
        return send_file(zip_output, download_name="libro_mayor.zip", as_attachment=True)

@accounting_bp.route('/exportar_libro_diario_pdf', methods=['GET'])
@jwt_required()
def exportar_libro_diario_pdf():
    from fpdf import FPDF
    from flask import send_file
    from datetime import datetime
    from io import BytesIO

    # Crear un objeto FPDF en orientación horizontal
    pdf = FPDF(orientation='L', unit='mm', format='A4')
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    
    # Encabezado
    pdf.set_font("Arial", style='B', size=14)
    pdf.cell(0, 10, 'Libro Diario', ln=True, align='C')
    pdf.set_font("Arial", size=12)
    pdf.cell(0, 10, f'Período: {datetime.now().strftime("%m/%Y")}', ln=True, align='C')
    pdf.cell(0, 10, 'RUC: 20610588981', ln=True, align='C')
    pdf.cell(0, 10, 'Razón Social: Tormenta', ln=True, align='C')

    pdf.ln(10)  # Espacio vertical

    # Encabezados de la tabla
    pdf.set_font("Arial", style='B', size=10)
    pdf.cell(20, 10, 'N°', border=1, align='C')
    pdf.cell(30, 10, 'Fecha', border=1, align='C')
    pdf.cell(100, 10, 'Glosa', border=1, align='C')  # Aumentar el ancho de la columna Glosa
    pdf.cell(30, 10, 'Documento', border=1, align='C')
    pdf.cell(35, 10, 'Debe', border=1, align='C')
    pdf.cell(35, 10, 'Haber', border=1, align='C')
    pdf.ln(10)

    # Datos de los asientos
    asientos, _ = obtener_asientos_agrupados()
    numero_correlativo = 1
    total_debe = 0
    total_haber = 0

    pdf.set_font("Arial", size=10)
    for id_asiento, asiento in asientos.items():
        for detalle in asiento['detalles']:
            pdf.cell(20, 10, str(numero_correlativo), border=1, align='C')
            pdf.cell(30, 10, asiento['fecha_asiento'].strftime('%d/%m/%Y'), border=1, align='C')
            
            # Reducir el tamaño de la fuente para la glosa
            pdf.set_font("Arial", size=8)
            pdf.cell(100, 10, asiento['glosa'], border=1)
            pdf.set_font("Arial", size=10)  # Restaurar el tamaño de la fuente
            
            pdf.cell(30, 10, asiento['num_comprobante'], border=1, align='C')
            pdf.cell(35, 10, f"{detalle['debe']:.2f}" if detalle['debe'] != 0 else '', border=1, align='R')
            pdf.cell(35, 10, f"{detalle['haber']:.2f}" if detalle['haber'] != 0 else '', border=1, align='R')
            pdf.ln(10)
            
            total_debe += detalle['debe']
            total_haber += detalle['haber']
            numero_correlativo += 1

    # Totales
    pdf.set_font("Arial", style='B', size=10)
    pdf.cell(180, 10, 'Total', border=1, align='R')
    pdf.cell(35, 10, f"{total_debe:.2f}", border=1, align='R')
    pdf.cell(35, 10, f"{total_haber:.2f}", border=1, align='R')

    # Guardar el archivo PDF en un buffer de memoria
    output = BytesIO()
    pdf.output(dest='S').encode('latin1')  # Generar el contenido del PDF como bytes
    output.write(pdf.output(dest='S').encode('latin1'))
    output.seek(0)

    return send_file(output, download_name="libro_diario.pdf", as_attachment=True)


@accounting_bp.route('/exportar_libro_mayor_pdf', methods=['GET'])
@jwt_required()
def exportar_libro_mayor_pdf():
    # Obtener datos del libro mayor con glosa agrupados por fecha
    libro_mayor = obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica()

    # Obtener la fecha actual para el período
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')

    pdf_files = []

    for codigo_cuenta, detalles in libro_mayor.items():
        pdf = FPDF(orientation='L')
        pdf.add_page()

        # Configurar la fuente
        pdf.set_font("Arial", size=10)

        # Título
        pdf.set_font("Arial", style='B', size=14)
        pdf.cell(0, 10, "FORMATO 6.1: \"LIBRO MAYOR\"", ln=True, align='C')

        # Información del período, RUC, razón social y cuenta
        pdf.set_font("Arial", size=10)
        pdf.cell(40, 10, f"PERÍODO: {mes_anio_actual}", ln=True)
        pdf.cell(40, 10, "RUC: 20610588981", ln=True)
        pdf.cell(40, 10, "APELLIDOS Y NOMBRE: Tormenta", ln=True)
        pdf.cell(40, 10, f"CODIGO Y/O DENOMINACIÓN: {codigo_cuenta}", ln=True)

        # Encabezado de tabla
        pdf.set_font("Arial", style='B', size=10)
        pdf.cell(60, 10, "FECHA DE LA OPERACIÓN", border=1)
        pdf.cell(100, 10, "DESCRIPCIÓN O GLOSA", border=1)
        pdf.cell(50, 10, "DEUDOR", border=1, align='R')
        pdf.cell(50, 10, "ACREEDOR", border=1, align='R')
        pdf.ln()

        # Detalles del libro mayor
        total_debe = 0
        total_haber = 0

        pdf.set_font("Arial", size=10)
        for detalle in detalles:
            fecha = detalle['fecha_asiento'].strftime('%d/%m/%Y')
            glosa = detalle['glosa']
            debe = detalle['total_debe']
            haber = detalle['total_haber']

            pdf.cell(60, 10, fecha, border=1)
            pdf.cell(100, 10, glosa, border=1)
            pdf.cell(50, 10, f"{debe:.2f}", border=1, align='R')
            pdf.cell(50, 10, f"{haber:.2f}", border=1, align='R')
            pdf.ln()

            total_debe += debe
            total_haber += haber

        # Total al final de la tabla
        pdf.set_font("Arial", style='B', size=10)
        pdf.cell(160, 10, "Total", border=1, align='R')
        pdf.cell(50, 10, f"{total_debe:.2f}", border=1, align='R')
        pdf.cell(50, 10, f"{total_haber:.2f}", border=1, align='R')
        pdf.ln()

        # Guardar el PDF en memoria
        output = BytesIO()
        output.write(pdf.output(dest='S').encode('latin1'))
        output.seek(0)

        pdf_files.append({
            'filename': f"libro_mayor_{codigo_cuenta}.pdf",
            'content': output.getvalue()
        })

    # Enviar todos los archivos generados
    if len(pdf_files) == 1:
        return send_file(BytesIO(pdf_files[0]['content']), download_name=pdf_files[0]['filename'], as_attachment=True)
    else:
        import zipfile
        zip_output = BytesIO()
        with zipfile.ZipFile(zip_output, 'w') as zf:
            for archivo in pdf_files:
                zf.writestr(archivo['filename'], archivo['content'])
        zip_output.seek(0)
        return send_file(zip_output, download_name="libro_mayor.zip", as_attachment=True)
    
@accounting_bp.route('/exportar_registro_ventas_excel', methods=['GET'])
@jwt_required()
def exportar_registro_ventas_excel():
    from io import BytesIO
    import openpyxl
    from flask import send_file, current_app
    from datetime import datetime
    import os

    # Path to the Excel template
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', 'Registro_Ventas.xlsx')
    
    if not os.path.exists(template_path):
        return "The Excel template was not found.", 404
    
    output = BytesIO()
    
    # Load the template workbook
    workbook = openpyxl.load_workbook(template_path)
    worksheet = workbook.active
    
    # Set the current period and company info
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')
    worksheet['B3'] = mes_anio_actual  # Period
    worksheet['B4'] = '20610588981'    # RUC
    worksheet['B5'] = 'Tormenta'       # Company name

    # Fetch the purchase records
    registros_compras, totales = obtener_registro_ventas()
    print(registros_compras)
    # Define the starting row for data
    start_row = 11
    current_row = start_row

    for registro in registros_compras:
        worksheet[f'A{current_row}'] = registro["numero_correlativo"] #numero correlativo
        worksheet[f'B{current_row}'] = registro["fecha"].strftime('%d/%m/%Y')  #fecha de emision
        worksheet[f'C{current_row}'] = registro["fechaV"].strftime('%d/%m/%Y') #fecha de vencimiento
        if str(registro["num_comprobante"])[0] == "F":
            worksheet[f'D{current_row}'] = '01'  # tipo
        elif str(registro["num_comprobante"])[0] =="B":
            worksheet[f'D{current_row}'] = '03' # tipo
        else:
            worksheet[f'D{current_row}'] = '07' # tipo

        comprobante = registro["num_comprobante"]

        serie = comprobante.split("-")[0][1:]
        numero = comprobante.split("-")[1]

        worksheet[f'E{current_row}'] = serie  # la serie
        worksheet[f'F{current_row}'] = numero # el número

        if len(str(registro["documento_cliente"])) == 8:
            worksheet[f'G{current_row}'] = '1' 
        else:
            worksheet[f'G{current_row}'] = '6' #tipo
        worksheet[f'H{current_row}'] = registro["documento_cliente"] #numero de dni o ruc
        worksheet[f'I{current_row}'] = registro["nombre_cliente"] #nombres o razon social
        worksheet[f'J{current_row}'] = ''# valor facturado de la exportacion
        worksheet[f'K{current_row}'] = registro["importe"] #importe
        worksheet[f'L{current_row}'] = ''
        worksheet[f'M{current_row}'] = ''
        worksheet[f'N{current_row}'] = ''
        worksheet[f'O{current_row}'] = registro["igv"]  # IGV
        worksheet[f'P{current_row}'] = ''
        worksheet[f'Q{current_row}'] = registro["total"]  
        worksheet[f'R{current_row}'] = ''
        worksheet[f'S{current_row}'] = ''
        worksheet[f'T{current_row}'] = ''
        worksheet[f'U{current_row}'] = ''
        worksheet[f'V{current_row}'] = ''
        current_row += 1

    # Adding totals row at the end
    total_row = current_row
    worksheet.merge_cells(f'H{total_row}:J{total_row}') 
    worksheet[f'H{total_row}'] = 'Totales'
    worksheet[f'K{total_row}'] = totales["total_importe"]
    worksheet[f'O{total_row}'] = totales["total_igv"]
    worksheet[f'Q{total_row}'] = totales["total_general"]

    # Save the updated workbook to a buffer
    workbook.save(output)
    output.seek(0)

    return send_file(output, download_name="registro_ventas.xlsx", as_attachment=True)

@accounting_bp.route('/exportar_registro_ventas_pdf', methods=['GET'])
@jwt_required()
def exportar_registro_ventas_pdf():
    from fpdf import FPDF
    from flask import send_file
    from datetime import datetime
    from io import BytesIO

    # Crear un objeto FPDF en orientación horizontal
    pdf = FPDF(orientation='L', unit='mm', format='A4')
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    
    # Encabezado
    pdf.set_font("Arial", style='B', size=14)
    pdf.cell(0, 10, 'Registro de Ventas', ln=True, align='C')
    pdf.set_font("Arial", size=12)
    pdf.cell(0, 10, f'Período: {datetime.now().strftime("%m/%Y")}', ln=True, align='C')
    pdf.cell(0, 10, 'RUC: 20610588981', ln=True, align='C')
    pdf.cell(0, 10, 'Razón Social: Tormenta', ln=True, align='C')

    pdf.ln(10)  # Espacio vertical

    # Encabezados de la tabla
    pdf.set_font("Arial", style='B', size=9)
    headers = [
        ('N°', 10), ('F. Emisión', 23), ('F. Vencimiento', 25), 
        ('Tipo', 10), ('Serie', 13), ('Número', 20), ('Tipo Doc.', 15), 
        ('N° Doc', 25), ('Nombre Cliente', 70), 
        ('Importe', 20), ('IGV', 20), ('Total', 20)
    ]
    for header, width in headers:
        pdf.cell(width, 10, header, border=1, align='C')
    pdf.ln(10)

    # Obtener registros de ventas
    registros_ventas, totales = obtener_registro_ventas()
    
    pdf.set_font("Arial", size=9)
    for registro in registros_ventas:
        pdf.cell(10, 10, str(registro["numero_correlativo"]), border=1, align='C')
        pdf.cell(23, 10, registro["fecha"].strftime('%d/%m/%Y'), border=1, align='C')
        pdf.cell(25, 10, registro["fechaV"].strftime('%d/%m/%Y'), border=1, align='C')
        
        tipo_documento = '01' if registro["num_comprobante"][0] == "F" else '03' if registro["num_comprobante"][0] == "B" else '07'
        pdf.cell(10, 10, tipo_documento, border=1, align='C')

        
        num_comprobante = registro["num_comprobante"]
        serie = num_comprobante.split("-")[0][1:]  #Serie
        numero = num_comprobante.split("-")[1]      # Numero
        
        pdf.cell(13, 10, serie, border=1, align='C')   # Celda para la serie
        pdf.cell(20, 10, numero, border=1, align='C')  # Celda para el número
        
        # Tipo de documento del cliente
        tipo_doc_cliente = '1' if len(str(registro["documento_cliente"])) == 8 else '6'
        pdf.cell(15, 10, tipo_doc_cliente, border=1, align='C')
        
        pdf.cell(25, 10, str(registro["documento_cliente"]), border=1, align='C')
        pdf.cell(70, 10, registro["nombre_cliente"], border=1)
        pdf.cell(20, 10, f"{registro['importe']:.2f}", border=1, align='R')
        pdf.cell(20, 10, f"{registro['igv']:.2f}", border=1, align='R')
        pdf.cell(20, 10, f"{registro['total']:.2f}", border=1, align='R')
        pdf.ln(10)

    # Totales
    pdf.set_font("Arial", style='B', size=10)
    pdf.cell(211, 10, 'Totales', border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_importe']:.2f}", border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_igv']:.2f}", border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_general']:.2f}", border=1, align='R')

    # Guardar el archivo PDF en un buffer de memoria
    output = BytesIO()
    pdf.output(dest='S').encode('latin1')
    output.write(pdf.output(dest='S').encode('latin1'))
    output.seek(0)

    return send_file(output, download_name="registro_ventas.pdf", as_attachment=True)


@accounting_bp.route('/exportar_registro_compras_excel', methods=['GET'])
@jwt_required()
def exportar_registro_compras_excel():
    from io import BytesIO
    import openpyxl
    from flask import send_file, current_app
    from datetime import datetime
    import os

    # Ruta de la plantilla de Excel
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', 'Registro_Compras.xlsx')
    
    if not os.path.exists(template_path):
        return "La plantilla de Excel no fue encontrada.", 404
    
    output = BytesIO()
    
    # Cargar el libro de trabajo de la plantilla
    workbook = openpyxl.load_workbook(template_path)
    worksheet = workbook.active
    
    # Configurar el periodo actual y la información de la empresa
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')
    worksheet['B3'] = mes_anio_actual  # Periodo
    worksheet['B4'] = '20610588981'    # RUC
    worksheet['B5'] = 'Tormenta'       # Nombre de la empresa

    # Obtener los registros de compras
    registros_compras, totales = obtener_registro_compras()
    
    # Definir la fila inicial para los datos
    start_row = 14
    current_row = start_row

    for registro in registros_compras:
        worksheet[f'A{current_row}'] = registro["numero_correlativo"] # Número correlativo
        worksheet[f'B{current_row}'] = registro["fecha"].strftime('%d/%m/%Y')  # Fecha de emisión
        worksheet[f'C{current_row}'] = registro["fechaV"].strftime('%d/%m/%Y') # Fecha de vencimiento

        # Lógica para tipo de comprobante basado en el número
        if str(registro["num_comprobante"])[0] == "F":
            worksheet[f'D{current_row}'] = '01'  # Tipo
        elif str(registro["num_comprobante"])[0] == "B":
            worksheet[f'D{current_row}'] = '03'  # Tipo
        else:
            worksheet[f'D{current_row}'] = '07'  # Tipo

        # Dividir el número de comprobante en serie y número
        comprobante = registro["num_comprobante"]
        serie = comprobante.split("-")[0][1:]
        numero = comprobante.split("-")[1]

        worksheet[f'E{current_row}'] = serie  # Serie
        worksheet[f'F{current_row}'] = ''
        worksheet[f'G{current_row}'] = numero # Número

        # Tipo de documento del proveedor basado en el número de documento
        if len(str(registro["documento_cliente"])) == 8:
            worksheet[f'H{current_row}'] = '1' 
        else:
            worksheet[f'H{current_row}'] = '6'  # Tipo
        worksheet[f'I{current_row}'] = registro["documento_cliente"]  # Número de documento
        worksheet[f'J{current_row}'] = registro["nombre_cliente"]     # Razón social
        worksheet[f'K{current_row}'] = registro["importe"]           # Importe
        worksheet[f'L{current_row}'] = registro["igv"]
        worksheet[f'M{current_row}'] = ''
        worksheet[f'N{current_row}'] = ''  # Base imponible exonerada
        worksheet[f'O{current_row}'] = ''  # Base imponible inafecta
        worksheet[f'P{current_row}'] = ''  # Otros conceptos
                     # IGV
        worksheet[f'Q{current_row}'] = ''  # Impuesto ISC (si aplica)
        worksheet[f'R{current_row}'] = ''           # Total
        worksheet[f'S{current_row}'] = ''  # Valor de adquisición no gravada
        worksheet[f'T{current_row}'] = registro["total"]
        
        current_row += 1

    # Agregar la fila de totales al final
    total_row = current_row
    worksheet.merge_cells(f'H{total_row}:J{total_row}') 
    worksheet[f'H{total_row}'] = 'Totales'
    worksheet[f'K{total_row}'] = totales["total_importe"]
    worksheet[f'L{total_row}'] = totales["total_igv"]
    worksheet[f'T{total_row}'] = totales["total_general"]

    # Guardar el libro actualizado en el buffer
    workbook.save(output)
    output.seek(0)

    return send_file(output, download_name="registro_compras.xlsx", as_attachment=True)

@accounting_bp.route('/exportar_registro_compras_pdf', methods=['GET'])
@jwt_required()
def exportar_registro_compras_pdf():
    from fpdf import FPDF
    from flask import send_file
    from datetime import datetime
    from io import BytesIO

    # Crear un objeto FPDF en orientación horizontal
    pdf = FPDF(orientation='L', unit='mm', format='A4')
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    
    # Encabezado
    pdf.set_font("Arial", style='B', size=14)
    pdf.cell(0, 10, 'Registro de Compras', ln=True, align='C')
    pdf.set_font("Arial", size=12)
    pdf.cell(0, 10, f'Período: {datetime.now().strftime("%m/%Y")}', ln=True, align='C')
    pdf.cell(0, 10, 'RUC: 20610588981', ln=True, align='C')
    pdf.cell(0, 10, 'Razón Social: Tormenta', ln=True, align='C')

    pdf.ln(10)  # Espacio vertical

    # Encabezados de la tabla
    pdf.set_font("Arial", style='B', size=9)
    headers = [
        ('N°', 10), ('F. Emisión', 23), ('F. Vencimiento', 25), 
        ('Tipo', 10), ('Serie', 13), ('Número', 20), ('Tipo Doc.', 15), 
        ('N° Doc', 25), ('Razón Social', 70), 
        ('Importe', 20), ('IGV', 20), ('Total', 20)
    ]
    for header, width in headers:
        pdf.cell(width, 10, header, border=1, align='C')
    pdf.ln(10)

    # Obtener registros de compras
    registros_compras, totales = obtener_registro_compras()
    
    pdf.set_font("Arial", size=9)
    for registro in registros_compras:
        pdf.cell(10, 10, str(registro["numero_correlativo"]), border=1, align='C')
        pdf.cell(23, 10, registro["fecha"].strftime('%d/%m/%Y'), border=1, align='C')
        pdf.cell(25, 10, registro["fechaV"].strftime('%d/%m/%Y'), border=1, align='C')
        
        # Determinar el tipo de comprobante
        tipo_documento = '01' if registro["num_comprobante"][0] == "F" else '03' if registro["num_comprobante"][0] == "B" else '07'
        pdf.cell(10, 10, tipo_documento, border=1, align='C')

        # Serie y número del comprobante
        num_comprobante = registro["num_comprobante"]
        serie = num_comprobante.split("-")[0][1:]  # Serie
        numero = num_comprobante.split("-")[1]      # Número
        
        pdf.cell(13, 10, serie, border=1, align='C')   # Celda para la serie
        pdf.cell(20, 10, numero, border=1, align='C')  # Celda para el número

        # Tipo de documento del cliente
        tipo_doc_cliente = '1' if len(str(registro["documento_cliente"])) == 8 else '6'
        pdf.cell(15, 10, tipo_doc_cliente, border=1, align='C')
        
        pdf.cell(25, 10, str(registro["documento_cliente"]), border=1, align='C')
        pdf.cell(70, 10, registro["nombre_cliente"], border=1)
        pdf.cell(20, 10, f"{registro['importe']:.2f}", border=1, align='R')
        pdf.cell(20, 10, f"{registro['igv']:.2f}", border=1, align='R')
        pdf.cell(20, 10, f"{registro['total']:.2f}", border=1, align='R')
        pdf.ln(10)

    # Totales
    pdf.set_font("Arial", style='B', size=10)
    pdf.cell(211, 10, 'Totales', border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_importe']:.2f}", border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_igv']:.2f}", border=1, align='R')
    pdf.cell(20, 10, f"{totales['total_general']:.2f}", border=1, align='R')

    # Guardar el archivo PDF en un buffer de memoria
    output = BytesIO()
    pdf.output(dest='S').encode('latin1')
    output.write(pdf.output(dest='S').encode('latin1'))
    output.seek(0)

    return send_file(output, download_name="registro_compras.pdf", as_attachment=True)


@accounting_bp.route('/exportar_libro_caja_excel', methods=['GET'])
def exportar_libro_caja_excel():
    # Define la ruta de la plantilla de Excel
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', 'libro_caja.xlsx')
    
    # Verifica si la plantilla existe
    if not os.path.exists(template_path):
        return "La plantilla de Excel no se encontró.", 404
    
    output = BytesIO()
    workbook = load_workbook(template_path)
    worksheet = workbook.active
    
    # Obtener la fecha actual y formatearla
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')
    
    # Llenar las celdas con los datos de encabezado
    worksheet['B3'] = mes_anio_actual
    worksheet['B4'] = '20610588981'  # Ejemplo de RUC
    worksheet['B5'] = 'Tormenta'  # Nombre de la empresa
    
    # Define la fila inicial para los datos (ajustado para evitar filas extra)
    start_row = 9  # Cambiado a la fila 9 para evitar la fila adicional
    lista_libro_caja, total_caja = obtener_libro_caja()

    # Borde delgado para las celdas
    thin_border = Border(
        left=Side(style='thin', color='000000'),
        right=Side(style='thin', color='000000'),
        top=Side(style='thin', color='000000'),
        bottom=Side(style='thin', color='000000')
    )

    # Estilo de fuente y alineación
    normal_font = Font(bold=False)
    right_alignment = Alignment(horizontal='right', vertical='center')
    left_alignment = Alignment(horizontal='left', vertical='center')
    center_alignment = Alignment(horizontal='center', vertical='center')

    # Variable para el número correlativo
    numero_correlativo = 1

    # Itera sobre los datos y llénalos en el Excel
    current_row = start_row
    for row in lista_libro_caja:
        worksheet[f'A{current_row}'] = numero_correlativo
        worksheet[f'B{current_row}'] = row['fecha']
        worksheet[f'C{current_row}'] = row['glosa']
        worksheet[f'D{current_row}'] = row['cod_cuenta']
        worksheet[f'E{current_row}'] = row['nombre_cuenta']
        worksheet[f'F{current_row}'] = row['debe']
        worksheet[f'G{current_row}'] = row['haber']

        # Aplica bordes y alineación
        for col in ['A', 'B', 'C', 'D', 'E', 'F', 'G']:
            cell = worksheet[f'{col}{current_row}']
            cell.border = thin_border
            cell.font = normal_font

        # Alineación específica para columnas
        worksheet[f'A{current_row}'].alignment = center_alignment
        worksheet[f'B{current_row}'].alignment = center_alignment
        worksheet[f'C{current_row}'].alignment = left_alignment
        worksheet[f'D{current_row}'].alignment = center_alignment
        worksheet[f'E{current_row}'].alignment = left_alignment
        worksheet[f'F{current_row}'].alignment = right_alignment
        worksheet[f'G{current_row}'].alignment = right_alignment

        # Incrementa el número correlativo y la fila actual
        numero_correlativo += 1
        current_row += 1

    # Agrega los totales en la última fila
    total_row = current_row
    worksheet.merge_cells(f'A{total_row}:E{total_row}')
    worksheet[f'A{total_row}'] = "Total"
    worksheet[f'F{total_row}'] = total_caja['debe']
    worksheet[f'G{total_row}'] = total_caja['haber']

    # Aplica formato y bordes a los totales
    for col in ['A', 'F', 'G']:
        cell = worksheet[f'{col}{total_row}']
        cell.border = thin_border
        cell.alignment = right_alignment

    # Asegura el ancho de las columnas para mejor visibilidad
    column_widths = {'A': 38, 'B': 15, 'C': 60, 'D': 15, 'E': 30, 'F': 15, 'G': 15}
    for column, width in column_widths.items():
        worksheet.column_dimensions[column].width = width

    # Guarda el archivo en el buffer y lo envía
    workbook.save(output)
    output.seek(0)
    
    return send_file(output, download_name="libro_caja.xlsx", as_attachment=True)