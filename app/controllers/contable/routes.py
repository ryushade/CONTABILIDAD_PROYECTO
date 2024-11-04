from flask import request, redirect, url_for, flash, session, jsonify, render_template, send_file, current_app
from flask_jwt_extended import jwt_required, create_access_token, set_access_cookies, unset_jwt_cookies, get_jwt_identity, verify_jwt_in_request
from app.models.contable_models import obtener_regla_por_id, obtener_roles, obtener_usuario_por_id_2, obtener_usuario_por_nombre, agregar_usuario, actualizar_usuario, eliminar_usuario, verificar_contraseña, obtener_asientos_agrupados,obtener_reglas, obtener_cuentas, obtener_usuarios, obtener_total_cuentas, eliminar_cuenta, eliminar_regla_bd, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta, actualizar_reglas, obtener_cuentas_excel, obtener_libro_mayor_agrupado_por_fecha, obtener_libro_mayor_agrupado_por_fecha_y_glosa_unica,obtener_registro_ventas
from . import accounting_bp
import pandas as pd
import io
import os
from openpyxl.utils import get_column_letter
from openpyxl.styles import Font, Alignment, PatternFill
from datetime import datetime
import openpyxl
from fpdf import FPDF
from io import BytesIO

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
    registro_compra_data, totale = obtener_registro_ventas()
    return render_template('contable/reportes/reportes.html', asientos=asientos, totales=totales, libro_mayor=libro_mayor_data, total_debe=total_debe, total_haber=total_haber,registros_compras = registro_compra_data, totale = totale)

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
@jwt_required()
def reglas():
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=50, type=int)

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
def usuarios():
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=50, type=int)

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


@accounting_bp.route('/usuarios/obtener/<int:usuario_id>', methods=['GET'])
def obtener_usuario(usuario_id):
    usuario = obtener_usuario_por_id_2(usuario_id)
    if usuario:
        # Devuelve todos los datos necesarios del usuario en formato JSON
        return jsonify({
            "rol": usuario.get("rol"),
            "usua": usuario.get("usua"),
            "contra": usuario.get("contra"),
            "estado_usuario": usuario.get("estado_usuario")
        })
    else:
        return jsonify({'error': 'Usuario no encontrado'}), 404

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
            "cuenta_credito_nombre": regla.get("cuenta_haber_nombre")
        })
    else:
        return jsonify({'error': 'Regla no encontrada'}), 404




@accounting_bp.route('/usuarios/actualizar/<int:id_usuario>', methods=['POST'])
def actualizar_usu(id_usuario):
    id_rol = request.form['id_rol']
    usua = request.form['usua']
    contra = request.form['contra']
    estado_usuario = request.form['estado_usuario']

    resultado = actualizar_usuario(id_usuario, id_rol, usua, contra, estado_usuario)

    if "error" in resultado:
        return redirect(url_for('contable.usuarios'))
    elif resultado.get("code") == 0:
        return redirect(url_for('contable.usuarios'))

    return redirect(url_for('contable.usuarios'))


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



@accounting_bp.route('/reglas/editar/<int:regla_id>', methods=['POST'])
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

@accounting_bp.route('/exportar_libro_diario_excel', methods=['GET'])
@jwt_required()
def exportar_libro_diario_excel():
    from io import BytesIO
    import openpyxl
    from flask import send_file, current_app
    from datetime import datetime
    import os

    # Ruta de la plantilla
    template_path = os.path.join(current_app.root_path, 'templates', 'contable', 'plantillas', 'L,D.xlsx')
    
    if not os.path.exists(template_path):
        return "La plantilla de Excel no se encontró.", 404
    
    output = BytesIO()
    
    # Cargar el archivo de plantilla
    workbook = openpyxl.load_workbook(template_path)
    worksheet = workbook.active
    
    # Obtener la fecha actual
    fecha_actual = datetime.now()
    mes_anio_actual = fecha_actual.strftime('%m/%Y')
    
    # Llenar las celdas específicas con los datos necesarios
    worksheet['B3'] = mes_anio_actual  # Coloca el período en la celda derecha de 'PERÍODO:'
    worksheet['B4'] = '20610588981'    # Coloca el RUC
    worksheet['B5'] = 'Tormenta'       # Coloca la razón social
    
    # Definir la fila inicial para insertar los datos en la tabla
    start_row = 11  # Comenzar desde la fila 11 como especificaste

    # Suponiendo que obtienes los datos de una función llamada obtener_asientos_agrupados
    asientos, _ = obtener_asientos_agrupados()
    numero_correlativo = 1

    total_debe = 0
    total_haber = 0

    # Insertar los datos en la tabla, fila por fila
    current_row = start_row
    for id_asiento, asiento in asientos.items():
        for detalle in asiento['detalles']:
            worksheet[f'A{current_row}'] = numero_correlativo
            worksheet[f'B{current_row}'] = asiento['fecha_asiento'].strftime('%d/%m/%Y')
            worksheet[f'C{current_row}'] = asiento['glosa']
            worksheet[f'F{current_row}'] = asiento['num_comprobante']
            worksheet[f'G{current_row}'] = detalle['codigo_cuenta']
            worksheet[f'H{current_row}'] = detalle['nombre_cuenta']
            worksheet[f'I{current_row}'] = detalle['debe'] if detalle['debe'] != 0 else None
            worksheet[f'J{current_row}'] = detalle['haber'] if detalle['haber'] != 0 else None
            
            # Sumar los valores para el total
            total_debe += detalle['debe']
            total_haber += detalle['haber']

            current_row += 1
        numero_correlativo += 1
    
    # Combinar las celdas de la fila del total
    total_row = current_row
    worksheet.merge_cells(f'A{total_row}:H{total_row}')
    worksheet[f'A{total_row}'] = "Total"
    worksheet[f'A{total_row}'].alignment = openpyxl.styles.Alignment(horizontal='right')

    # Insertar los totales en las columnas I y J
    worksheet[f'I{total_row}'] = total_debe
    worksheet[f'J{total_row}'] = total_haber

    # Guardar el archivo modificado en un buffer de memoria
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
        worksheet[f'D{current_row}'].number_format = '0.00#################'
        worksheet[f'D{current_row}'].font = openpyxl.styles.Font(size=10, bold=True)
        
        worksheet[f'E{current_row}'] = total_haber_formula
        worksheet[f'E{current_row}'].number_format = '0.00#################'
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

    # Define the starting row for data
    start_row = 11
    current_row = start_row

    for registro in registros_compras:
        worksheet[f'A{current_row}'] = registro["numero_correlativo"] #numero correlativo
        worksheet[f'B{current_row}'] = registro["fecha"].strftime('%d/%m/%Y')  #fecha de emision
        worksheet[f'C{current_row}'] = registro["fechaV"].strftime('%d/%m/%Y') #fecha de vencimiento
        worksheet[f'D{current_row}'] = '' # tipo
        worksheet[f'E{current_row}'] = registro["num_comprobante"] #serie
        worksheet[f'F{current_row}'] = registro["num_comprobante"] #numero
        worksheet[f'G{current_row}'] = '' #tipo
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
    
    worksheet[f'K{total_row}'] = totales["total_importe"]
    worksheet[f'O{total_row}'] = totales["total_igv"]
    worksheet[f'Q{total_row}'] = totales["total_general"]

    # Save the updated workbook to a buffer
    workbook.save(output)
    output.seek(0)

    return send_file(output, download_name="registro_ventas.xlsx", as_attachment=True)
