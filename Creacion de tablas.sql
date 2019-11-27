create database CapitalismoWebDB;
use CapitalismoWebDB;

CREATE TABLE Administrador (
Administrador_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Username VARCHAR(32) NOT NULL,
Contraseña VARCHAR(32) NOT NULL
);

CREATE TABLE Usuario (
Usuario_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(32) NOT NULL,
Apellido VARCHAR(32) NOT NULL,
Correo_electronico VARCHAR(32) NOT NULL,
Nombre_de_usuario VARCHAR(32) NOT NULL,
Contraseña VARCHAR(32) NOT NULL,
Telefono VARCHAR(32) NOT NULL,
Direccion VARCHAR(32) NOT NULL,
Avatar mediumblob
);
ALTER TABLE Usuario ADD COLUMN activo BOOLEAN default 1;

CREATE TABLE Administrador_Conversa_Usuario (
Administrador_Conversa_Usuario_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Administrador_Id INT UNSIGNED,
Usuario_Id INT UNSIGNED,
FOREIGN KEY (Administrador_Id) REFERENCES Administrador(Administrador_Id),
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id)
);
ALTER TABLE Administrador_Conversa_Usuario ADD COLUMN Articulo_Id INT UNSIGNED;

CREATE TABLE Mensaje (
Mensaje_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Contenido VARCHAR(255) NOT NULL,
Administrador_Conversa_Usuario_Id INT UNSIGNED,
FOREIGN KEY (Administrador_Conversa_Usuario_Id) REFERENCES Administrador_Conversa_Usuario(Administrador_Conversa_Usuario_Id)
);
ALTER TABLE Mensaje add column enviadoPorCliente int;

drop table Articulo;
CREATE TABLE Articulo (
Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(32) NOT NULL,
Descripción VARCHAR(512) NOT NULL,
Unidades INT,
Imagen_1 mediumblob,
Imagen_2 mediumblob,
Imagen_3 mediumblob,
Video mediumblob,
Calificacion INT,
Borrador boolean
);

ALTER TABLE Articulo DROP COLUMN Descripción;
ALTER TABLE Articulo ADD Descripción varchar(512) NOT NULL;

CREATE TABLE Oferta (
Oferta_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Cantidad INT NOT NULL,
Aceptado BOOLEAN,
Administrador_Conversa_Usuario_Id INT UNSIGNED,
FOREIGN KEY (Administrador_Conversa_Usuario_Id) REFERENCES Administrador_Conversa_Usuario(Administrador_Conversa_Usuario_Id)
);
ALTER TABLE Oferta add column enviadoPorCliente int;

CREATE TABLE Categoria (
Categoria_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(32) NOT NULL
);

CREATE TABLE Elemento_Del_Carrusel (
Elemento_Del_Carrusel_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Nombre VARCHAR(32) NOT NULL,
Descripcion VARCHAR(255) NOT NULL,
Imagen mediumblob,
Articulo_Id INT UNSIGNED,
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Metodo_De_Pago (
Metodo_De_Pago_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Total DECIMAL(10,2),
Metodo_De_Pago VARCHAR(32) NOT NULL
);

CREATE TABLE Envio (
Envio_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Metodo_de_envio VARCHAR(32) NOT NULL,
estatus VARCHAR(32) NOT NULL,
costo DECIMAL(10,2),
Metodo_De_Pago_Id INT UNSIGNED,
FOREIGN KEY (Metodo_De_Pago_Id) REFERENCES Metodo_De_Pago(Metodo_De_Pago_Id)
);

CREATE TABLE Usuario_Compra_Articulo (
Usuario_Compra_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
Metodo_De_Pago_Id INT UNSIGNED,
Fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
Aceptado boolean,
Oferta_Id INT UNSIGNED,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id),
FOREIGN KEY (Metodo_De_Pago_Id) REFERENCES Metodo_De_Pago(Metodo_De_Pago_Id),
FOREIGN KEY (Oferta_Id) REFERENCES Oferta(Oferta_Id)
);
ALTER TABLE Usuario_Compra_Articulo ADD COLUMN Cantidad int;

CREATE TABLE Usuario_Comenta_Articulo (
Usuario_Comenta_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
comentario VARCHAR(255) NOT NULL,
Fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Usuario_Califica_Articulo (
Usuario_Califica_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
Calificacion INT,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Usuario_Agrega_A_Deseados_A_Articulo (
Usuario_Agrega_A_Deseados_A_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Usuario_Visita_Articulo (
Usuario_Visita_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Usuario_Busca_Articulo (
Usuario_Busca_Articulo_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Usuario_Id INT UNSIGNED,
Articulo_Id INT UNSIGNED,
FOREIGN KEY (Usuario_Id) REFERENCES Usuario(Usuario_Id),
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id)
);

CREATE TABLE Articulo_Organiza_Categoria (
Articulo_Organiza_Categoria_Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Articulo_Id INT UNSIGNED,
Categoria_Id INT UNSIGNED,
FOREIGN KEY (Articulo_Id) REFERENCES Articulo(Articulo_Id),
FOREIGN KEY (Categoria_Id) REFERENCES Categoria(Categoria_Id)
);


select * from articulo;







