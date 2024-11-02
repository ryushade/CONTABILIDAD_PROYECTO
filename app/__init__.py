from flask import Flask, redirect, url_for, session, render_template
from config import Config
from flask_jwt_extended import JWTManager
from flask_jwt_extended import JWTManager, jwt_required, get_jwt_identity
from app.models.contable_models import obtener_usuario_por_id

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    jwt = JWTManager(app)

    # Registrar Blueprints
    from app.controllers.transaccional import transactional_bp
    app.register_blueprint(transactional_bp, url_prefix='/transaccional')

    from app.controllers.contable import accounting_bp
    app.register_blueprint(accounting_bp, url_prefix='/contable')

    # Context Processor para inyectar el usuario
    @app.context_processor
    def inject_user():
        try:
            user_id = get_jwt_identity()
            user = obtener_usuario_por_id(user_id) if user_id else None
        except:
            user = None
        return dict(user=user)

    @app.route('/')
    def index():
        return redirect(url_for('contable.login'))

    @app.route('/inicio')
    @jwt_required()  # Protección con JWT en la ruta de inicio
    def inicio():
        return render_template('index.html')    

    return app