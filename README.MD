

# Variables de entorno (Para acceder a la base de datos)
SECRET_KEY=tormentasecreto
SQLALCHEMY_DATABASE_URI=mysql+pymysql://tu_usuario:tu_contraseña@localhost/db_tormenta
FLASK_ENV=development
FLASK_DEBUG=1




# Creas el venv
py -m venv venv

# Accedes
 
venv\Scripts\activate

# Instalar dependencias (Iran aumentando)

 pip install -r requirements.txt

# Ejecutar aplicacion (dentro del venv)
flask run --debug
