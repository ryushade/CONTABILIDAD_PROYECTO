from flask import Blueprint

transactional_bp = Blueprint('transaccional', __name__, template_folder='templates')

from . import routes
