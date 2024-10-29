from flask import request, redirect, url_for, flash, session, jsonify, render_template, send_file
from app.models.contable_models import obtener_usuario_por_nombre, verificar_contraseña, obtener_asientos_agrupados,obtener_reglas, obtener_cuentas, obtener_usuarios, obtener_total_cuentas, eliminar_cuenta, eliminar_regla_bd, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta, actualizar_reglas, obtener_cuentas_excel
from . import accounting_bp# routes.py
import pandas as pd
import io
from openpyxl.utils import get_column_letter
from openpyxl.styles import Font, Alignment, PatternFill


@accounting_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Consulta el usuario por nombre
        user = obtener_usuario_por_nombre(username)

        # Verifica si el usuario existe y la contraseña es correcta
        if user and verificar_contraseña(user, password):
            session['user_id'] = user['id_usuario']
            return redirect(url_for('inicio'))  # Redirige a la ruta /inicio

    return render_template('contable/login.html')

@accounting_bp.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('contable.login'))

@accounting_bp.route('/reportes', methods=['GET'])
def reportes():
    asientos = obtener_asientos_agrupados()
    return render_template('contable/reportes/reportes.html', asientos=asientos)

@accounting_bp.route('/cuentas', methods=['GET'])
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

@accounting_bp.route('/reglas', methods=['GET'])
def reglas():
    reglas = obtener_reglas()
    return render_template('contable/reglas/reglas.html', reglas=reglas)

@accounting_bp.route('/usuarios', methods = ['GET'])
def usuarios():
    usuarios = obtener_usuarios()
    return render_template('contable/usuarios/usuarios.html', usuarios=usuarios)

@accounting_bp.route('/cuentas/eliminar/<int:cuenta_id>', methods=['POST'])
def eliminar_cuenta(cuenta_id):
    eliminar_cuenta(cuenta_id)
    return redirect(url_for('contable.cuentas'))

@accounting_bp.route('/reglas/eliminar/<int:regla_id>', methods=['POST'])
def eliminar_regla(regla_id):
    eliminar_regla_bd(regla_id)  # Llama a la función separada
    return redirect(url_for('contable.reglas'))

@accounting_bp.route('/reglas/editar/<int:regla_id>', methods=['POST'])
def editar_regla(regla_id):
    nombre_regla = request.form['nombre_regla']
    tipo_transaccion = request.form['tipo_transaccion']
    cuenta_debe = request.form['cuenta_debe']
    cuenta_haber = request.form['cuenta_haber']
    estado_regla = request.form['estado']

    actualizar_reglas(regla_id, nombre_regla, tipo_transaccion, cuenta_debe, cuenta_haber, estado_regla)
    
    return redirect(url_for('contable.reglas'))
