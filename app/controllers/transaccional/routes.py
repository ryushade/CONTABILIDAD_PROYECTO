from flask import render_template
from . import transactional_bp

@transactional_bp.route('/')
def index():
    return render_template('transaccional/index.html')

@transactional_bp.route('/almacen')
def almacen():
    return render_template('transaccional/almacen/almacen.html')

@transactional_bp.route('/compras')
def compras():
    return render_template('transaccional/compras/almacen.html')

