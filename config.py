import os
from dotenv import load_dotenv
from pathlib import Path

# Ruta base del proyecto
basedir = Path(__file__).resolve().parent

# Cargar variables de entorno
load_dotenv(basedir / '.env')

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'clave_secreta_por_defecto')
    SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
