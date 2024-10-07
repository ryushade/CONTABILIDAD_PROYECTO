from flask import request, redirect, url_for, flash, session, jsonify, render_template
from app.models.contable_models import obtener_usuario_por_nombre, verificar_contraseña, obtener_cuentas, obtener_total_cuentas, obtener_usuario_por_id, obtener_cuenta_por_id, actualizar_cuenta
from . import accounting_bp

# routes.py

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
            flash('Login exitoso', 'success')
            return redirect(url_for('transaccional.index'))
        else:
            flash('Usuario o contraseña incorrectos', 'danger')

    return render_template('contable/login.html')

@accounting_bp.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('Logout exitoso', 'success')
    return redirect(url_for('contable.login'))

@accounting_bp.route('/reportes')
def reportes():
    return render_template('contable/reportes/reportes.html')

@accounting_bp.route('/cuentas', methods=['GET'])
def cuentas():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 50, type=int)

    cuentas = obtener_cuentas(page, per_page)
    total_cuentas = obtener_total_cuentas()

    total_pages = (total_cuentas + per_page - 1) // per_page

    return render_template('contable/cuentas/cuentas.html', cuentas=cuentas, page=page, total_pages=total_pages, per_page=per_page, max=max, min=min)

# routes.py

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

    flash('Cuenta actualizada correctamente', 'success')
    return redirect(url_for('contable.cuentas'))
