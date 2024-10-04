from flask import Flask, redirect, url_for, session
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
    app.register_blueprint(transactional_bp, url_prefix='/inicio')

    from app.controllers.contable import accounting_bp
    app.register_blueprint(accounting_bp, url_prefix='/contable')

    @app.context_processor
    def inject_user():
        from app.models.contable_models import Usuario
        user_id = session.get('user_id')
        
        user = Usuario.query.get(user_id) if user_id else None
        # Debug: Verificar si el usuario y su rol están presentes
        if user:
            print(f"Usuario: {user.usua}, Rol: {user.rol.nom_rol}")
        else:
            print("No se encontró usuario en la sesión.")
        
        return dict(user=user)

    
    @app.route('/')
    def index():
        return redirect(url_for('contable.login'))

   
        
    return app
