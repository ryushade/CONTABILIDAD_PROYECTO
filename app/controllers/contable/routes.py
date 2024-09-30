from flask import request, redirect, url_for, flash, session, jsonify, render_template
from app.models.contable_models import Usuario
from . import accounting_bp
from app import db

@accounting_bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Consulta el usuario por nombre
        user = Usuario.query.filter_by(usua=username).first()

        # Verifica si el usuario existe y la contraseña es correcta
        if user and user.verify_password(password):
            session['user_id'] = user.id_usuario
            flash('Login exitoso', 'success')
            return redirect(url_for('transaccional.index'))

    return render_template('contable/login.html')  


@accounting_bp.route('/' , methods=['GET']) 
def index():
    return render_template('contable/index.html')
    

@accounting_bp.route('/logout')
def logout():
    session.pop('user_id', None)
    flash('Logout exitoso', 'success')
    return redirect(url_for('contable.login'))
