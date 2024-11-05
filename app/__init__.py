from flask import Flask, redirect, url_for, session, render_template, jsonify
from config import Config
from flask_jwt_extended import JWTManager, jwt_required, get_jwt_identity, create_access_token, set_access_cookies, unset_jwt_cookies
from app.models.contable_models import obtener_usuario_por_id

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    jwt = JWTManager(app)

    @jwt.unauthorized_loader
    def unauthorized_callback(callback):
        # Redirige al usuario a la página de inicio de sesión con un parámetro en la URL
        return redirect(url_for('contable.login', login_required=1))

    @jwt.expired_token_loader
    def expired_token_callback(jwt_header, jwt_payload):
        return redirect(url_for('contable.login'))
    
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
            
            # Construye la URL completa para la foto de perfil si existe
            if user and user.get('foto'):
                user['foto'] = url_for('static', filename=f'img/{user["foto"].replace("/static/img/", "")}')
            return dict(user=user)
            
        except Exception as e:
            # Log the error for debugging
            app.logger.error(f"Error in inject_user: {str(e)}")
            return dict(user=None)


    @app.route('/')
    def index():
        return redirect(url_for('contable.login'))

    @app.route('/inicio')
    @jwt_required()  # Protección con JWT en la ruta de inicio
    def inicio():
        return render_template('index.html')    

    return app