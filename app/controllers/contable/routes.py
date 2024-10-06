from flask import request, redirect, url_for, flash, session, jsonify, render_template
from app.models.contable_models import obtener_usuario_por_nombre, verificar_contraseña, obtener_cuentas, obtener_usuario_por_id
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

@accounting_bp.route('/cuentas', methods=['GET'])
def cuentas():
    page = request.args.get('page', 1, type=int)
    per_page = request.args.get('per_page', 50, type=int)

    cuentas = obtener_cuentas(page, per_page)  

    
    total_pages = (len(cuentas) + per_page - 1) // per_page  

    
    start = (page - 1) * per_page
    end = start + per_page
    cuentas_paginadas = cuentas[start:end]

    return render_template('contable/cuentas/cuentas.html', cuentas=cuentas_paginadas, page=page, total_pages=total_pages, per_page=per_page, max=max, min=min)
