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
    DATABASE_PASSWORD = os.getenv('DATABASE_PASSWORD', '123456')
    DATABASE_NAME = os.getenv('DATABASE_NAME', 'db_tormenta')
    
    # Configuración de JWT
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'jwt_clave_secreta_por_defecto')  # Clave para JWT
    JWT_TOKEN_LOCATION = ["cookies"]  # Usar cookies para almacenar el token
    JWT_COOKIE_SECURE = True  # Usa True si estás en un entorno de producción con HTTPS
    JWT_ACCESS_COOKIE_PATH = '/'  # Rutas que podrán acceder a la cookie
    JWT_COOKIE_CSRF_PROTECT = True  # Habilitar protección CSRF en cookies
    JWT_ACCESS_TOKEN_EXPIRES = int(os.getenv('JWT_ACCESS_TOKEN_EXPIRES', 3600))  # Expiración en segundos del token

    @property
    def DATABASE_URI(self):
        return f"mysql+pymysql://{self.DATABASE_USER}:{self.DATABASE_PASSWORD}@{self.DATABASE_HOST}:{self.DATABASE_PORT}/{self.DATABASE_NAME}"
