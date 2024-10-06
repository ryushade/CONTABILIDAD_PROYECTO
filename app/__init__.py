from flask import Flask, redirect, url_for, session
from config import Config

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Registrar Blueprints
    from app.controllers.transaccional import transactional_bp
    app.register_blueprint(transactional_bp, url_prefix='/inicio')

    from app.controllers.contable import accounting_bp
    app.register_blueprint(accounting_bp, url_prefix='/contable')

    # Context Processor
    @app.context_processor
    def inject_user():
        from app.models.contable_models import obtener_usuario_por_id
        user_id = session.get('user_id')
        user = obtener_usuario_por_id(user_id) if user_id else None

        return dict(user=user)

    @app.route('/')
    def index():
        return redirect(url_for('contable.login'))
    
    return app
