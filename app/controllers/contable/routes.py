from flask import render_template
from . import accounting_bp

@accounting_bp.route('/')
def index():
    return render_template('contable/index.html')
