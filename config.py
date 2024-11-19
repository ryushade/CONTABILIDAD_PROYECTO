import os
from dotenv import load_dotenv
from pathlib import Path

# Ruta base del proyecto
basedir = Path(__file__).resolve().parent

# Cargar variables de entorno
load_dotenv(basedir / '.env')

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'clave_secreta_por_defecto')
    DATABASE_HOST = os.getenv('DATABASE_HOST', 'localhost')
    DATABASE_PORT = os.getenv('DATABASE_PORT', '3306')
    DATABASE_USER = os.getenv('DATABASE_USER', 'root')
    DATABASE_PASSWORD = os.getenv('DATABASE_PASSWORD', 'Anghelo17')
    DATABASE_NAME = os.getenv('DATABASE_NAME', 'db_tormenta')
    
    # Configuración de JWT
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'jwt_clave_secreta_por_defecto')
    JWT_TOKEN_LOCATION = ["cookies"]
    JWT_COOKIE_SECURE = False
    JWT_ACCESS_COOKIE_PATH = '/'
    JWT_COOKIE_CSRF_PROTECT = True
    JWT_ACCESS_TOKEN_EXPIRES = int(os.getenv('JWT_ACCESS_TOKEN_EXPIRES', 3600))
    JWT_CSRF_IN_FORM = True  # Allow CSRF token in form data
    JWT_COOKIE_CSRF_PROTECT = False

    # Configuración de la carpeta de subidas
    UPLOAD_FOLDER = os.path.join(basedir, 'app/static', 'fotos_perfil')
    
    @property
    def DATABASE_URI(self):
        return f"mysql+pymysql://{self.DATABASE_USER}:{self.DATABASE_PASSWORD}@{self.DATABASE_HOST}:{self.DATABASE_PORT}/{self.DATABASE_NAME}"
