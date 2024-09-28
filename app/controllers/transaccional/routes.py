from flask import render_template
from . import transactional_bp

@transactional_bp.route('/')
def index():
    return render_template('transaccional/index.html')
