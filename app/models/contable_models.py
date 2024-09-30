from app import db

class Rol(db.Model):
    __tablename__ = 'rol'
    
    id_rol = db.Column(db.Integer, primary_key=True)
    nom_rol = db.Column(db.String(20), nullable=False)
    estado_rol = db.Column(db.Boolean, nullable=False)

    # Relación con usuarios
    usuarios = db.relationship('Usuario', backref='rol', lazy=True)

class Usuario(db.Model):
    __tablename__ = 'usuario'

    id_usuario = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_rol = db.Column(db.Integer, db.ForeignKey('rol.id_rol'), nullable=False)  # Clave foránea aquí
    usua = db.Column(db.String(10), unique=True, nullable=False)
    contra = db.Column(db.String(10), nullable=False)
    estado_usuario = db.Column(db.Boolean, nullable=False)
    
    def __init__(self, usua, contra, id_rol, estado_usuario=True):
        self.usua = usua
        self.contra = contra
        self.id_rol = id_rol
        self.estado_usuario = estado_usuario

    def verify_password(self, password):
        return self.contra == password
