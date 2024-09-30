from app import db

class Usuario(db.Model):
    __tablename__ = 'usuario'

    id_usuario = db.Column(db.Integer, primary_key=True, autoincrement=True)
    id_rol = db.Column(db.Integer, nullable=False)
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
