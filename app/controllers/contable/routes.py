from flask import request, redirect, url_for, flash, session, jsonify, render_template, send_file
from flask_jwt_extended import jwt_required, create_access_token, set_access_cookies, unset_jwt_cookies, get_jwt_identity, verify_jwt_in_request
from app.models.contable_models import obtener_roles, obtener_usuario_por_nombre, agregar_usuario, actualizar_usuario, eliminar_usuario, verificar_contraseña, obtener_asientos_agrupados,obtener_reglas, obtener_cuentas, obtener_usuarios, obtener_total_cuentas, eliminar_cuenta, eliminar_regla_bd, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta, actualizar_reglas, obtener_cuentas_excel, obtener_libro_mayor_agrupado_por_fecha
from . import accounting_bp
import pandas as pd
import io
from openpyxl.utils import get_column_letter
from openpyxl.styles import Font, Alignment, PatternFill


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
            response = redirect(url_for('inicio'))
            set_access_cookies(response, access_token)  # Guardar el token en una cookie segura
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
def reportes():
    asientos, totales = obtener_asientos_agrupados()
    libro_mayor_data, total_debe, total_haber = obtener_libro_mayor_agrupado_por_fecha()
    return render_template('contable/reportes/reportes.html', asientos=asientos, totales=totales, libro_mayor=libro_mayor_data, total_debe=total_debe, total_haber=total_haber)

@accounting_bp.route('/cuentas', methods=['GET'])
@jwt_required()
def cuentas():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 50, type=int)
    tipo_cuenta = request.args.get('tipo_cuenta')
    naturaleza = request.args.get('naturaleza')

    cuentas = obtener_cuentas(page, per_page, tipo_cuenta=tipo_cuenta, naturaleza=naturaleza)
    total_cuentas = obtener_total_cuentas(tipo_cuenta=tipo_cuenta, naturaleza=naturaleza)
    total_pages = (total_cuentas + per_page - 1) // per_page

    return render_template(
        'contable/cuentas/cuentas.html',
        cuentas=cuentas,
        page=page,
        total_pages=total_pages,
        per_page=per_page,
        total_results=total_cuentas,
        tipo_cuenta=tipo_cuenta,
        naturaleza=naturaleza,
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

@accounting_bp.route('/exportar_pdf', methods=['GET'])

@accounting_bp.route('/cuentas/obtener/<int:cuenta_id>', methods=['GET'])
@jwt_required()
def obtener_cuenta(cuenta_id):
    cuenta = obtener_cuenta_por_id(cuenta_id)
    if cuenta:
        return jsonify(cuenta)
    else:
        return jsonify({'error': 'Cuenta no encontrada'}), 404

@accounting_bp.route('/cuentas/editar/<int:cuenta_id>', methods=['POST'])
@jwt_required()
def editar_cuenta(cuenta_id):
    codigo_cuenta = request.form['codigo_cuenta']
    nombre_cuenta = request.form['nombre_cuenta']
    naturaleza = request.form['naturaleza']
    estado_cuenta = request.form['estado_cuenta']

    actualizar_cuenta(cuenta_id, codigo_cuenta, nombre_cuenta, naturaleza, estado_cuenta)

    return redirect(url_for('contable.cuentas'))

@accounting_bp.route('/reglas', methods=['GET'])
@jwt_required()
def reglas():
    reglas = obtener_reglas()
    return render_template('contable/reglas/reglas.html', reglas=reglas)

@accounting_bp.route('/usuarios', methods = ['GET'])
@jwt_required()
def usuarios():
    usuarios = obtener_usuarios()
    roles = obtener_roles()
    return render_template('contable/usuarios/usuarios.html', usuarios=usuarios, roles=roles)

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
@jwt_required()
def eliminar_cuenta(cuenta_id):
    eliminar_cuenta(cuenta_id)
    return redirect(url_for('contable.cuentas'))

@accounting_bp.route('/reglas/eliminar/<int:regla_id>', methods=['POST'])
@jwt_required()
def eliminar_regla(regla_id):
    eliminar_regla_bd(regla_id)  # Llama a la función separada
    return redirect(url_for('contable.reglas'))

@accounting_bp.route('/reglas/editar/<int:regla_id>', methods=['POST'])
@jwt_required()
def editar_regla(regla_id):
    nombre_regla = request.form['nombre_regla']
    tipo_transaccion = request.form['tipo_transaccion']
    cuenta_debe = request.form['cuenta_debe']
    cuenta_haber = request.form['cuenta_haber']
    estado_regla = request.form['estado']

    actualizar_reglas(regla_id, nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado_regla)
    
    return redirect(url_for('contable.reglas'))

@accounting_bp.route('/reportes/ldpdf')
@jwt_required()
def ldpf():
    return render_template('contable/reportes/pdf_ld.html')