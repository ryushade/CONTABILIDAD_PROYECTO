from flask import Flask, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from config import Config

# Inicializar extensiones
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Inicializar la base de datos
    db.init_app(app)

    # Registrar Blueprints (Controladores)
    from app.controllers.transaccional import transactional_bp
    app.register_blueprint(transactional_bp, url_prefix='/transaccional')

    from app.controllers.contable import accounting_bp
    app.register_blueprint(accounting_bp, url_prefix='/contable')

    
    @app.route('/')
    def index():
        return redirect(url_for('contable.login'))
        
    return app
