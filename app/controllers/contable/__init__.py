from flask import Blueprint

accounting_bp = Blueprint('contable', __name__, template_folder='templates')

from . import routes
