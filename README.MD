

# Variables de entorno (Para acceder a la base de datos)
FLASK_ENV=development
DATABASE_HOST=localhost
DATABASE_PORT=3306
SECRET_KEY=tormentasecreto
DATABASE_USER=root
DATABASE_PASSWORD=tucontraseña
DATABASE_NAME=db_tormenta


# Creas el venv
py -m venv venv

# Accedes
 
venv\Scripts\activate

# Instalar dependencias (Iran aumentando)

 pip install -r requirements.txt

# Ejecutar aplicacion (dentro del venv)
flask run --debug
