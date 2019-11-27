use CapitalismoWebDB;

DROP PROCEDURE SP_USUARIO;
DELIMITER //
CREATE PROCEDURE SP_USUARIO(IN Param1 VARCHAR(1), IN pUsuario_Id INT, IN pNombre VARCHAR(32), IN pApellido VARCHAR(32), IN pCorreo_electronico VARCHAR(32), IN pNombre_de_usuario VARCHAR(32), IN pContraseña VARCHAR(32), IN pTelefono VARCHAR(32), IN pDireccion VARCHAR(32), IN pAvatar mediumblob)
BEGIN
	DECLARE var_activo boolean;
    DECLARE respuesta varchar(64);

	CASE Param1
		WHEN "A" THEN 
			select usuario_unico(pCorreo_electronico,pNombre_de_usuario) into respuesta;
            IF respuesta = 'daijobu' THEN
				INSERT INTO usuario 
				(Nombre, Apellido, Correo_electronico, Nombre_de_usuario, Contraseña, Telefono, Direccion, Avatar) 
				VALUES 
				(pNombre, pApellido, pCorreo_electronico, pNombre_de_usuario, pContraseña, pTelefono, pDireccion, pAvatar); 
			ELSE
				SELECT respuesta;
            END IF;
            
            
        WHEN "B" THEN 
			select activo INTO var_activo from usuario where Usuario_Id = pUsuario_Id;
			IF var_activo = 1 THEN 
				UPDATE usuario SET activo = 0 WHERE Usuario_Id = pUsuario_Id;
			ELSE
				UPDATE usuario SET activo = 1 WHERE Usuario_Id = pUsuario_Id;
			END IF;
			
        WHEN "C" THEN UPDATE usuario
			SET Nombre = pNombre, Apellido = pApellido, Correo_electronico = pCorreo_electronico, Nombre_de_usuario = pNombre_de_usuario,
            Contraseña = pContraseña, Telefono = pTelefono, Direccion = pDireccion, Avatar = pAvatar
            WHERE Usuario_Id = pUsuario_Id;
            
		WHEN "S" THEN
			SELECT Usuario_Id, Nombre, Apellido, Correo_electronico, Nombre_de_usuario, Contraseña, Telefono, Direccion, Avatar, activo
            FROM usuario WHERE Usuario_Id = pUsuario_Id;
            
		WHEN "R" THEN
			SELECT Usuario_Id, Nombre, Apellido, Correo_electronico, Nombre_de_usuario, Contraseña, Telefono, Direccion, Avatar, activo
            FROM usuario;
        END CASE;
END //
DELIMITER ;

CALL SP_USUARIO('A', NULL, 'Pedro', 'Lopez', 'pedro_lopez1602@hotmail.com', 'PedroLopez1602', 'password', '8116204330', 'Miguel Dominguez 2204', null);
CALL SP_USUARIO('B', 1, 'Pedro', 'Lopez', 'pedro_lopez1602@hotmail.com', 'PedroLopez1602', 'password', '8116204330', 'Miguel Dominguez 2204', null);
CALL SP_USUARIO('C', 1, 'Luis Pedro', 'Lopez Perez', 'pedro_lopez1602@hotmail.com', 'PedroLopez1602', 'password', '8116204330', 'Miguel Dominguez 2204 B', null);
CALL SP_USUARIO('S', 1, null, null, null, null, null, null, null, null);
CALL SP_USUARIO('R', 1, null, null, null, null, null, null, null, null);


DROP PROCEDURE SP_ARTICULO;
DELIMITER //
CREATE PROCEDURE SP_ARTICULO(IN Param1 VARCHAR(1), IN pArticulo_Id INT, IN pNombre VARCHAR(32), IN pDescripción VARCHAR(512), IN pUnidades INT, IN pImagen_1 mediumblob, IN pImagen_2 mediumblob, IN pImagen_3 mediumblob, IN pVideo mediumblob, IN pCalificacion INT, pBorrador boolean)
BEGIN
	
	CASE Param1
		WHEN "A" THEN INSERT INTO Articulo 
			(Nombre, Descripción, Unidades, Imagen_1, Imagen_2, Imagen_3, Video, Calificacion, Borrador) 
			VALUES 
			(pNombre, pDescripción, pUnidades, pImagen_1, pImagen_2, pImagen_3, pVideo, pCalificacion, 1); 
            
        WHEN "B" THEN 
			DELETE FROM usuario_califica_articulo WHERE Articulo_Id = pArticulo_Id;
			DELETE FROM Articulo_Organiza_Categoria WHERE Articulo_Id = pArticulo_Id;
			DELETE FROM Articulo WHERE Articulo_Id = pArticulo_Id;
            
        WHEN "C" THEN UPDATE Articulo
			SET Nombre = pNombre, Descripción = pDescripción, Unidades = pUnidades, Imagen_1 = pImagen_1, Imagen_2 = pImagen_2, Imagen_3 = pImagen_3, Video = pVideo, Calificacion = pCalificacion, Borrador = pBorrador
            WHERE Articulo_Id = pArticulo_Id;
            
		WHEN "S" THEN
			SELECT Articulo_Id, Nombre, Descripción, Unidades, Imagen_1, Imagen_2, Imagen_3, Video, Calificacion, Borrador
            FROM Articulo WHERE Articulo_Id = pArticulo_Id;
            
		WHEN "R" THEN
			SELECT Articulo_Id, Nombre, Descripción, Unidades, Imagen_1, Imagen_2, Imagen_3, Video, Calificacion, Borrador
            FROM Articulo;
        END CASE;
END //
DELIMITER ;

CALL SP_ARTICULO('A', NULL, "Hyrule Warriors WiiU", "Genero: Muso, Plataforma: WiiU, Saga: The legend of Zelda, Warriors", 10, null, null, null, null, 100, 0);
CALL SP_ARTICULO('B', 1, "Hyrule Warriors WiiU", "Genero: Muso, Plataforma: WiiU, Saga: The legend of Zelda, Warriors", 10, null, null, null, null, 100, 0);
CALL SP_ARTICULO('C', 2, "Hyrule Warriors", "Genero: Muso, Plataforma: WiiU, Switch, Nintendo 3DS, Saga: The legend of Zelda, Warriors", 10, null, null, null, null, 100, 0);
CALL SP_ARTICULO('S', 3, null, null, null, null, null, null, null, null, null);
CALL SP_ARTICULO('R', 2, "Hyrule Warriors WiiU", "Genero: Muso, Plataforma: WiiU, Saga: The legend of Zelda, Warriors", 10, null, null, null, null, 100, 0);
select * from Articulo; 

DROP FUNCTION GetArticulo_Id;
DELIMITER //
CREATE FUNCTION GetArticulo_Id (pNombre VARCHAR(32))
RETURNS INT
BEGIN
	DECLARE MyID INT;
    SELECT Articulo_Id INTO MyID FROM Articulo WHERE Nombre = pNombre;
    RETURN MyID;
END //
DELIMITER ;
SELECT GetArticulo_Id("Hyrule Warriors"); 

DROP FUNCTION GetUsuario_Id;
DELIMITER //
CREATE FUNCTION GetUsuario_Id (pUsername_email VARCHAR(32), pContraseña VARCHAR(32))
RETURNS INT
BEGIN
	DECLARE MyID INT;
    SELECT Usuario_Id INTO MyID FROM Usuario WHERE Nombre_de_usuario = pUsername_email AND Contraseña = pContraseña limit 1;
    IF MyID IS NULL THEN 
		SELECT Usuario_Id INTO MyID FROM Usuario WHERE Correo_electronico = pUsername_email AND Contraseña = pContraseña limit 1;
    END IF;
    RETURN MyID;
END //
DELIMITER ;



SELECT GetUsuario_Id("PedroLopez1602", "MitsurugiRyu42"); 
SELECT GetUsuario_Id("pedro_lopez1602@hotmail.com", "password"); 

SELECT * FROM Usuario;

/*ejemplo de trigger*/
DELIMITER //
CREATE TRIGGER registro AFTER UPDATE ON SALARIOS
FOR EACH ROW
BEGIN
	INSERT INTO BITACORA_SALARIOS (ID_SALARIO, N_EMP, SALARIO, FECHA, USUARIO)
	VALUES (OLD. ID_SALARIO, OLD.N_EMP, OLD.SALARIO, NOW(), CURRENT_USER());
END;
DELIMITER ;

/*--------------------------------------------------------------------------------------------------------------------*/
INSERT INTO Administrador VALUES (null, "admin", "admin"); 
SELECT Username A_name, Contraseña A_pass FROM Administrador WHERE Administrador_Id = 1;
CREATE VIEW v_administrador AS SELECT Username A_name, Contraseña A_pass FROM Administrador WHERE Administrador_Id = 1;
SELECT A_name, A_pass FROM v_administrador;
DROP FUNCTION login_Admin;
DELIMITER //
CREATE FUNCTION login_Admin (pUsuario VARCHAR(32), pContraseña VARCHAR(32))
RETURNS INT
BEGIN
	DECLARE returnValue INT;
    SELECT COUNT(A_name) into returnValue FROM v_administrador WHERE A_name = pUsuario AND A_pass = pContraseña;
    RETURN returnValue;
END //
DELIMITER ;
SELECT login_Admin("admin","admin") as resultado;

DROP PROCEDURE SP_ADMIN;
DELIMITER //
CREATE PROCEDURE SP_ADMIN(IN P_USER VARCHAR(32), IN P_PASS VARCHAR(32))
BEGIN
	SELECT login_Admin(P_USER,P_PASS) as resultado;
END //
DELIMITER ;
CALL SP_ADMIN("admin", "admin");
/*-----------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------------------------------------------------*/
SELECT Nombre FROM Categoria;
INSERT INTO Categoria VALUES (null, "los mas vendidos"); 
INSERT INTO Categoria VALUES (null, "los más vistos");
INSERT INTO Categoria VALUES (null, "los más buscados");
INSERT INTO Categoria VALUES (null, "los mejor calificados");
DROP VIEW v_categoria;
CREATE VIEW v_categoria AS SELECT Nombre A_Categoria, Categoria_Id A_index FROM Categoria;
SELECT A_Categoria, A_index FROM v_categoria;
DROP PROCEDURE SP_Categoria;
DELIMITER //
CREATE PROCEDURE SP_Categoria(IN P_Option varchar(1), IN P_categoria VARCHAR(32), IN P_id INT)
BEGIN
	DECLARE var_id int;
	CASE P_Option
		WHEN 'A' THEN INSERT INTO v_categoria VALUES (P_categoria, null); 
		WHEN 'B' THEN 
			SELECT A_index INTO var_id FROM v_categoria WHERE A_Categoria = P_categoria;
			DELETE FROM Articulo_Organiza_Categoria WHERE Categoria_Id = var_id;
			DELETE FROM v_categoria WHERE A_index = var_id;
		WHEN 'C' THEN UPDATE v_categoria SET A_Categoria = P_categoria WHERE A_index=P_id;  
        WHEN 'S' THEN SELECT A_Categoria, A_index FROM v_categoria;
        WHEN 'Z' THEN SELECT size_Categories() as resultado;
	END CASE;
END //
DELIMITER ;
CALL SP_Categoria("Z", null, null);
CALL SP_Categoria("S", null, null);
CALL SP_Categoria("A", "categoria_prueba", null);
CALL SP_Categoria("B", "categoria_prueba", null);
select * from Articulo_Organiza_Categoria;
UPDATE Articulo_Organiza_Categoria set Categoria_Id = 2 where Articulo_Organiza_Categoria_Id = 1; 
CALL SP_CategoriaProducto('A', 4, 1);
CALL SP_Categoria("C", "test", 7);
truncate table Articulo_Organiza_Categoria
truncate table Categoria;



DROP FUNCTION size_Categories;
DELIMITER //
CREATE FUNCTION size_Categories ()
RETURNS INT
BEGIN
	DECLARE returnValue INT;
    SELECT COUNT(A_Categoria) into returnValue FROM v_categoria;
    RETURN returnValue;
END //
DELIMITER ;
SELECT size_Categories() as resultado;
select * from Categoria;
/*-----------------------------------------------------------------------------------------------------------------------*/

/*
Para cambiar el valor de max_allowed_packet y innodb_log_file_size
se debe abrir xampp en la seccion mysql oprimir config y seleccionar
my.ini buscar las variables en el archivo texto, max_allowed_packet
aparece 2 veces y innodb_log_file_size aparece una vez
*/


/*--------------------------------------------------------------------------------------------------------------------------*/
DROP VIEW v_producto;
CREATE VIEW v_producto AS SELECT Articulo_Id A_index, Nombre A_nombre, Descripción A_Description, Unidades A_unidades,
Imagen_1 A_img1, Imagen_2 A_img2, Imagen_3 A_img3, Video A_video, Calificacion A_calificacion, Borrador A_borrador FROM Articulo;
SELECT A_index, A_nombre, A_Description, A_unidades, A_img1, A_img2, A_img3, A_video, A_calificacion, A_borrador FROM v_producto;

DROP FUNCTION size_Productos;
DELIMITER //
CREATE FUNCTION size_Productos ()
RETURNS INT
BEGIN
	DECLARE returnValue INT;
    SELECT COUNT(A_index) into returnValue FROM v_producto;
    RETURN returnValue;
END //
DELIMITER ;
SELECT size_Productos() as resultado;


update Articulo set Calificacion = 80 where Articulo_Id = 3;

/*----------------------------------------------------------------------------------------------------------------------*/
DROP VIEW v_productocategoria;
CREATE VIEW v_productocategoria AS select Articulo_Organiza_Categoria_Id AOC_id, Articulo_Id A_id, Categoria_Id C_id from Articulo_Organiza_Categoria;
select Articulo_Organiza_Categoria_Id AOC_id, Articulo_Id A_id, Categoria_Id C_id from Articulo_Organiza_Categoria;
select * from v_productocategoria;

DROP PROCEDURE SP_CategoriaProducto;
DELIMITER //
CREATE PROCEDURE SP_CategoriaProducto(IN p_option varchar(1), IN p_productoid int, IN p_categoriaid int)
BEGIN
	CASE p_option
		WHEN 'A' THEN INSERT INTO v_productocategoria VALUES (null, p_productoid, p_categoriaid); 
        WHEN 'B' THEN 
			DELETE FROM v_productocategoria WHERE A_id = p_productoid;
        WHEN 'S' THEN SELECT AOC_id, A_id, C_id FROM v_productocategoria;
        WHEN 'P' THEN SELECT AOC_id, A_id, C_id FROM v_productocategoria where A_id = p_productoid;
        WHEN 'C' THEN SELECT AOC_id, A_id, C_id FROM v_productocategoria where C_id = p_categoriaid;
	END CASE;
END //
DELIMITER ;
CALL SP_CategoriaProducto('A', null, 1);
CALL SP_CategoriaProducto('B', 4, null);
select * from Articulo_Organiza_Categoria
select * from Articulo

update Articulo set Borrador = 1 where Articulo_Id = 7

DROP FUNCTION GetCategoria_Id;
DELIMITER //
CREATE FUNCTION GetCategoria_Id (pNombre VARCHAR(32))
RETURNS INT
BEGIN
	DECLARE MyID INT;
    SELECT A_index INTO MyID FROM v_categoria WHERE A_Categoria = pNombre;
    RETURN MyID;
END //
DELIMITER ;

SELECT GetArticulo_Id('Death Stranding'); 
SELECT GetCategoria_Id('los mas vendidos'); 
CALL SP_CategoriaProducto('P', GetArticulo_Id('Death Stranding'), GetCategoria_Id('los mas vendidos'));

select * from Articulo_Organiza_Categoria;
select * from Categoria;
select * from Articulo;
/*----------------------------------------------------------------------------------------------------------------------*/

DROP VIEW v_productocategoria2;
CREATE VIEW v_productocategoria2 AS 
SELECT Articulo.Nombre articulo, Articulo.Articulo_Id index_A, Categoria.Nombre categoria, Categoria.Categoria_Id index_C FROM Categoria 
JOIN Articulo_Organiza_Categoria ON Categoria.Categoria_Id = Articulo_Organiza_Categoria.Categoria_Id
JOIN Articulo ON Articulo_Organiza_Categoria.Articulo_Id = Articulo.Articulo_Id;

Select * from v_productocategoria2 WHERE index_A = 8;

DROP PROCEDURE SP_CategoriaProducto2;
DELIMITER //
CREATE PROCEDURE SP_CategoriaProducto2(IN p_productoid int)
BEGIN
	Select categoria from v_productocategoria2 WHERE index_A = p_productoid;
END //
DELIMITER ;
CALL SP_CategoriaProducto2(8);

DROP FUNCTION size_productocategoria2;
DELIMITER //
CREATE FUNCTION size_productocategoria2 (p_productoid int)
RETURNS INT
BEGIN
	DECLARE size INT;
    Select count(categoria) INTO size from v_productocategoria2 WHERE index_A = p_productoid;
    RETURN size;
END //
DELIMITER ;

select size_productocategoria2(8);

DROP PROCEDURE SP_size_productocategoria2;
DELIMITER //
CREATE PROCEDURE SP_size_productocategoria2(IN p_productoid int)
BEGIN
	select size_productocategoria2(p_productoid);
END //
DELIMITER ;

CALL SP_size_productocategoria2(8);
CALL SP_CategoriaProducto2(8);


select * from Articulo_Organiza_Categoria;
truncate table Articulo_Organiza_Categoria;

select * from Articulo;
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE Articulo;
SET FOREIGN_KEY_CHECKS=1;
DESCRIBE Articulo


select * from v_usuario;
TRUNCATE TABLE Usuario;



/*--------------------------------------------------------------------------------------------------------------------------*/
DROP VIEW v_usuario;
CREATE VIEW v_usuario AS 
SELECT Usuario_Id A_id, Nombre A_nombre, Apellido A_apellido, Correo_electronico A_email, Nombre_de_usuario A_user, Contraseña A_pass, Telefono A_tel, Direccion A_addres, Avatar FROM Usuario;
DROP FUNCTION usuario_unico;
DELIMITER //
CREATE FUNCTION usuario_unico(p_email varchar(32), p_username varchar(32))
RETURNS varchar(64)
BEGIN
	DECLARE respuesta varchar(64);
    DECLARE cuenta int;
    set respuesta = "daijobu";
    Select count(A_user) into cuenta from v_usuario WHERE A_user = p_username;
    IF cuenta > 0 THEN set respuesta = "este nombre de usuario no se encuentra disponible"; END IF;
    SET cuenta = 0;
    Select count(A_email) into cuenta from v_usuario WHERE A_email = p_email;
    IF cuenta > 0 THEN set respuesta = "este correo electronico ya se encuentra en uso"; END IF;
    RETURN respuesta;
END //
DELIMITER ;
select usuario_unico('pedro_lopezsdsdd1602@hotmail.com','PedroLopsez1602');

DROP PROCEDURE SP_usuario_unico;
DELIMITER //
CREATE PROCEDURE SP_usuario_unico(IN p_email varchar(32), IN p_user varchar(32))
BEGIN
	select usuario_unico(p_email, p_user);
END //
DELIMITER ;
CALL SP_usuario_unico('pedro_lopezlogin_Usuario`capitalismowebdb`.`login_Usuario`1602@hotmail.com','PedroLopez1602');

DROP FUNCTION login_Usuario;
DELIMITER //
CREATE FUNCTION login_Usuario(p_user varchar(32), p_password varchar(32))
RETURNS varchar(64)
BEGIN
	DECLARE respuesta varchar(64);
    DECLARE cuenta int;
    set respuesta = "ninguna cuenta que coincida con estas credenciales";
    
    Select count(A_user) into cuenta from v_usuario WHERE A_user = p_user AND A_pass = p_password;
    IF cuenta > 0 THEN set respuesta = "username y password coinciden"; 
    ELSE
		SET cuenta = 0;
		Select count(A_email) into cuenta from v_usuario WHERE A_email = p_user AND A_pass = p_password;
		IF cuenta > 0 THEN set respuesta = "email y password coinciden"; END IF; 
    END IF;
    RETURN respuesta;
END //
DELIMITER ;
select login_Usuario('pedro_lopez1602@hotmail.com','MitsurugiRyu42');
select login_Usuario('PedroLopez1602','MitsurugiRyu42');
select login_Usuario('pedro_lopez1602@hotmail.com','incorrecta');

DROP PROCEDURE SP_login_Usuario;
DELIMITER //
CREATE PROCEDURE SP_login_Usuario(IN p_email varchar(32), IN p_user varchar(32))
BEGIN
	select login_Usuario(p_email, p_user);
END //
DELIMITER ;
CALL SP_login_Usuario('PedroLopez1602','MitsurugiRyu42');


DROP PROCEDURE SP_listaBorrador;
DELIMITER //
CREATE PROCEDURE SP_listaBorrador()
BEGIN
	select A_index, A_nombre From v_producto where A_borrador = 1;
END //
DELIMITER ;
CALL SP_listaBorrador();

select * from Articulo
update Articulo set Borrador = 1 where Articulo_Id = 2




/*-----------------------------------------------------------------------------------------------------------------------------*/
DROP TRIGGER calificacionArticulo;
DELIMITER //
CREATE TRIGGER calificacionArticulo AFTER INSERT ON Usuario_Califica_Articulo
FOR EACH ROW
BEGIN
	/*este trigger se encargara de asignar una calificacion a un articulo*/
    DECLARE promedio int;
    SELECT AVG(Usuario_Califica_Articulo.Calificacion) into promedio FROM Usuario_Califica_Articulo 
    JOIN Articulo ON Usuario_Califica_Articulo.Articulo_Id = Articulo.Articulo_Id WHERE Usuario_Califica_Articulo.Articulo_Id = NEW.Articulo_Id;
    
    UPDATE Articulo SET Calificacion = promedio WHERE Articulo_Id = NEW.Articulo_Id;

END //
DELIMITER ;
INSERT INTO Usuario_Califica_Articulo VALUES (NULL, 1, 1, 100); 

DROP TRIGGER compraArticulo;
DELIMITER //
CREATE TRIGGER compraArticulo AFTER INSERT ON Usuario_Compra_Articulo
FOR EACH ROW
BEGIN
	/*este trigger se encargara de restar una unidad a un articulo*/
    DECLARE unidades_anterior int;
    DECLARE unidades_nuevo int;
    SELECT Unidades into unidades_anterior FROM Articulo 
    WHERE Articulo_Id = NEW.Articulo_Id;
    
    set unidades_nuevo = unidades_anterior - 1;
    
    UPDATE Articulo SET Unidades = unidades_nuevo WHERE Articulo_Id = NEW.Articulo_Id;
END //
DELIMITER ;
INSERT INTO Usuario_Compra_Articulo VALUES (NULL, 1, 1, null, null, 1, null); 



DROP TRIGGER desactivarArticulo;
DELIMITER //
CREATE TRIGGER desactivarArticulo BEFORE INSERT ON Usuario_Compra_Articulo
FOR EACH ROW
BEGIN
	/*este trigger se encargara de restar una unidad a un articulo*/
    DECLARE unidades_articulo int;
    SELECT Unidades INTO unidades_articulo FROM Articulo WHERE Articulo_Id = NEW.Articulo_Id;
    IF unidades_articulo = 1 THEN
		UPDATE Articulo SET Borrador = 1 WHERE Articulo_Id = NEW.Articulo_Id;
	END IF;
END //
DELIMITER ;

INSERT INTO Usuario_Compra_Articulo VALUES (NULL, 1, 1, null, null, 1, null); 
select * from Articulo;
Update Articulo set Unidades = 2 where Articulo_Id = 1;

select * from Usuario








/*-------------------------------------------------------------------------------------------------------------------------*/
DROP PROCEDURE SP_publicar;
DELIMITER //
CREATE PROCEDURE SP_publicar(IN pid int)
BEGIN
	update v_producto set A_borrador = 0 where A_index = pid;
END //
DELIMITER ;
CALL SP_publicar(1);

update v_producto set A_borrador = 1 where A_index = 1;
select * from Articulo

CALL SP_ARTICULO('A', NULL, "asdasd", "asdas", 10, null, null, null, null, 100, 0);
CALL SP_ARTICULO('B', 4, null, null, null, null, null, null, null, null, null);
Update Articulo set Borrador = 1 where Articulo_Id = 4;

DROP PROCEDURE SP_avatarusuario;
DELIMITER //
CREATE PROCEDURE SP_avatarusuario(IN pid int)
BEGIN
	SELECT Avatar FROM v_usuario where A_id = pid;
END //
DELIMITER ;
CALL SP_avatarusuario(1);

DROP PROCEDURE SP_getUsuario;
DELIMITER //
CREATE PROCEDURE SP_getUsuario(in puser VARCHAR(32), in ppass VARCHAR(32))
BEGIN
	SELECT GetUsuario_Id(puser, ppass), A_user FROM v_usuario where A_id = GetUsuario_Id(puser, ppass); 
END //
DELIMITER ;
CALL SP_getUsuario("PedroLopez1602", "MitsurugiRyu42");
CALL SP_getUsuario("pedro_lopez1602@hotmail.com", "MitsurugiRyu42");
select * from v_usuario;
/*________________________________________________________________________________________________________________________________*/

DROP VIEW v_cards;
CREATE VIEW v_cards AS 
SELECT Articulo_Id A_index, Nombre A_nombre, Descripción A_desc, Imagen_1 A_img FROM Articulo WHERE Borrador = 0;

DROP PROCEDURE SP_cards;
DELIMITER //
CREATE PROCEDURE SP_cards()
BEGIN
	SELECT A_index, A_nombre, A_desc, A_img FROM v_cards;
END //
DELIMITER ;
CALL SP_cards();

DROP PROCEDURE SP_cardImg;
DELIMITER //
CREATE PROCEDURE SP_cardImg(IN pid int)
BEGIN
	SELECT A_img FROM v_cards WHERE A_index = pid;
END //
DELIMITER ;
CALL SP_cardImg(1);

select * from Articulo_Organiza_Categoria;
truncate Articulo_Organiza_Categoria;
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM Articulo WHERE Articulo_Id = pArticulo_Id;
select * from Articulo;
truncate Articulo;
select * from Categoria;
select * from Articulo_Organiza_Categoria;
select * from usuario_califica_articulo;
truncate usuario_califica_articulo;
truncate Categoria;

/*_______________________________________________________________________________________________________________________________*/
DROP PROCEDURE SP_Administrador_Conversa_Usuario;
DELIMITER //
CREATE PROCEDURE SP_Administrador_Conversa_Usuario(IN p_option varchar(1), IN pUsuarioid int, IN pArticuloid INT)
BEGIN    
    CASE p_option 
    WHEN 'S' THEN SELECT Administrador_Conversa_Usuario_Id FROM Administrador_Conversa_Usuario WHERE Usuario_Id = pUsuarioid AND Articulo_Id = pArticuloid;
    WHEN 'A' THEN INSERT INTO Administrador_Conversa_Usuario VALUES (null, 1, pUsuarioid, pArticuloid);
    END CASE;
END //
DELIMITER ;
CALL SP_Administrador_Conversa_Usuario('A', 1, 1);
CALL SP_Administrador_Conversa_Usuario('S', 1, 1);
select * from Administrador_Conversa_Usuario;

SELECT Administrador_Conversa_Usuario_Id FROM Administrador_Conversa_Usuario WHERE Usuario_Id = 1 AND Articulo_Id = 1;

DROP PROCEDURE SP_mensaje;
DELIMITER //
CREATE PROCEDURE SP_mensaje(IN p_option varchar(1), IN pContenido VARCHAR(255), IN pAdministrador_Conversa_Usuario_Id INT, in penviadoPorCliente int)
BEGIN
	CASE p_option
    WHEN 'A' THEN 
		INSERT INTO Mensaje VALUES (null, pContenido, pAdministrador_Conversa_Usuario_Id, penviadoPorCliente);
    WHEN 'S' THEN
		SELECT Contenido, enviadoPorCliente FROM Mensaje WHERE Administrador_Conversa_Usuario_Id = pAdministrador_Conversa_Usuario_Id;
	END CASE;
END //
DELIMITER ;
CALL SP_mensaje('S', 'hola mundo', 1, 0);

select * from Mensaje;
CALL SP_mensaje('A', 'soi el administrador k kiere xd', 4, 0);
delete from Mensaje where Mensaje_Id = 3;
truncate table Mensaje;


DROP PROCEDURE SP_oferta;
DELIMITER //
CREATE PROCEDURE SP_oferta(IN p_option varchar(1), IN pOferta_Id INT, IN pContenido INT, IN pAdministrador_Conversa_Usuario_Id INT, in penviadoPorCliente int)
BEGIN
	CASE p_option
    WHEN 'A' THEN 
		INSERT INTO Oferta VALUES (null, pContenido, false, pAdministrador_Conversa_Usuario_Id, penviadoPorCliente);
	WHEN 'C' THEN
		UPDATE Oferta SET Aceptado = 1 WHERE Oferta_Id = pOferta_Id;
	WHEN 'V' THEN
		UPDATE Oferta SET enviadoPorCliente = 0 WHERE Oferta_Id = pOferta_Id;
    WHEN 'S' THEN
		SELECT Oferta_Id, Cantidad, Aceptado, enviadoPorCliente, Administrador_Conversa_Usuario_Id FROM Oferta WHERE Administrador_Conversa_Usuario_Id = pAdministrador_Conversa_Usuario_Id order by Oferta_Id DESC LIMIT 1;
	END CASE;
END //
DELIMITER ;

CALL SP_oferta('A', null, 680, 4, 0);
CALL SP_oferta('C', 7, null, null, null);
CALL SP_oferta('S', null, null, 4, null);


SELECT * FROM OFERTA;


DROP TRIGGER TR_oferta;
DELIMITER //
CREATE TRIGGER TR_oferta AFTER INSERT ON Oferta
FOR EACH ROW
BEGIN
	/*este trigger se encargara de crear un mensaje a partir de una oferta*/
    DECLARE mensaje_oferta varchar(32);
    IF new.enviadoPorCliente = 1 THEN
    set mensaje_oferta = concat('El cliente a ofrecido $', new.Cantidad);
    INSERT INTO Mensaje VALUES (null, mensaje_oferta, new.Administrador_Conversa_Usuario_Id, new.enviadoPorCliente);
    END IF;
    
    IF new.enviadoPorCliente = 0 THEN
    set mensaje_oferta = concat('El vendedor a propuesto $', new.Cantidad);
    INSERT INTO Mensaje VALUES (null, mensaje_oferta, new.Administrador_Conversa_Usuario_Id, new.enviadoPorCliente);
    END IF;
END //
DELIMITER ;

select * from mensaje;
select * from oferta;

select concat('string ', 5);


DROP VIEW v_carritoUsuario;
CREATE VIEW v_carritoUsuario AS 
SELECT Articulo.Nombre A_Nombre, Cantidad O_precio, Usuario.Usuario_Id usuario FROM Articulo
JOIN Administrador_Conversa_Usuario ON Administrador_Conversa_Usuario.Articulo_Id = Articulo.Articulo_Id
JOIN Oferta ON Oferta.Administrador_Conversa_Usuario_Id = Administrador_Conversa_Usuario.Administrador_Conversa_Usuario_Id
JOIN Usuario ON Usuario.Usuario_Id = Administrador_Conversa_Usuario.Usuario_Id
WHERE Oferta.Aceptado = 1 AND Oferta.enviadoPorCliente = 0 order by Oferta.Oferta_Id;

update oferta set aceptado = 1 where Oferta_id = 6;
update oferta set enviadoPorCliente = 0 where Oferta_id = 6;

SELECT * from v_carritoUsuario where usuario = 1;

DROP PROCEDURE SP_CarritoUsuario;
DELIMITER //
CREATE PROCEDURE SP_CarritoUsuario(in pusuario_id int)
BEGIN
	SELECT A_Nombre, O_precio from v_carritoUsuario where usuario = pusuario_id;
END //
DELIMITER ;
CALL SP_CarritoUsuario(1);

/*___________________________________________________________________________________________________________________________*/

DROP PROCEDURE SP_compra;
DELIMITER //
CREATE PROCEDURE SP_compra(IN p_option varchar(1), IN pusuarioid int, IN particuloid int, IN poferta int, IN pcantidad int, IN ptotal decimal(10,2), IN pMetodo_De_Pago VARCHAR(32))
BEGIN
	DECLARE var_pago int;
    DECLARE var_ofertaid int;
	CASE p_option
		WHEN 'A' THEN 
			INSERT INTO Metodo_De_Pago VALUES (null, ptotal, pMetodo_De_Pago);
            SELECT Metodo_De_Pago_Id INTO var_pago FROM Metodo_De_Pago ORDER BY Metodo_De_Pago_Id DESC LIMIT 1;
            SELECT Oferta_Id INTO var_ofertaid from oferta where Cantidad = poferta order by Oferta_Id desc limit 1;
			INSERT INTO Usuario_Compra_Articulo VALUES (null, pusuarioid, particuloid, var_pago, null, 1, var_ofertaid, pcantidad);
		WHEN 'S' THEN
			select Nombre, Metodo_De_Pago, Fecha, precio_unitario, Cantidad from v_compras WHERE Usuario_Id = pusuarioid;
		END CASE;
END //
DELIMITER ;
call SP_compra('A', 1, GetArticulo_Id("Hyrule Warriors"), 1, 99, 12, 'Paypal');

call SP_compra('S', 1, NULL, NULL, NULL, NULL, NULL);
	

select Oferta_Id from oferta where Cantidad = 700 order by Oferta_Id desc limit 1;

select * from Usuario_Compra_Articulo;
truncate table Usuario_Compra_Articulo;
select * from Oferta;

drop view v_compras;
CREATE VIEW v_compras as
SELECT Usuario_Compra_Articulo.Usuario_Id, Articulo.Nombre, Metodo_De_Pago.Metodo_De_Pago, Usuario_Compra_Articulo.Fecha, Oferta.Cantidad precio_unitario, Usuario_Compra_Articulo.Cantidad
FROM Usuario_Compra_Articulo
JOIN Articulo ON Articulo.Articulo_Id = Usuario_Compra_Articulo.Articulo_Id
JOIN Metodo_De_Pago ON Metodo_De_Pago.Metodo_De_Pago_Id = Usuario_Compra_Articulo.Metodo_De_Pago_Id
JOIN Oferta ON Oferta.Oferta_Id = Usuario_Compra_Articulo.Oferta_Id;

select * from v_compras
WHERE Usuario_Compra_Articulo.Usuario_Id = 1;

select * from Usuario_Compra_Articulo;
select * from Metodo_De_Pago;
select * from Administrador_Conversa_Usuario;


select * from Usuario_Comenta_Articulo;
DROP PROCEDURE SP_comentario;
DELIMITER //
CREATE PROCEDURE SP_comentario(IN p_option varchar(1), IN pusuarioid int, IN particuloid int, IN pcomentario VARCHAR(255))
BEGIN
	CASE p_option
		WHEN 'A' THEN 
			INSERT INTO Usuario_Comenta_Articulo VALUES (null, pusuarioid, particuloid, pcomentario, null);
		WHEN 'S' THEN
			select Usuario_Comenta_Articulo_Id, Usuario.Nombre_de_usuario, comentario, fecha from Usuario_Comenta_Articulo 
            JOIN Usuario on Usuario.Usuario_Id = Usuario_Comenta_Articulo.Usuario_Id WHERE Articulo_Id = particuloid;
		END CASE;
END //
DELIMITER ;
call SP_comentario('A', 1, 10, 'ARA ARA');
call SP_comentario('S', null, 10, null);

/*_______________________________________________________________________________________________________________________*/

DROP PROCEDURE SP_calificar;
DELIMITER //
CREATE PROCEDURE SP_calificar(IN p_option varchar(1), IN pusuarioid int, IN particuloid int)
BEGIN
	CASE p_option
		WHEN 'B' THEN 
			INSERT INTO Usuario_Califica_Articulo VALUES (NULL, pusuarioid, particuloid, 100);
		WHEN 'M' THEN
			INSERT INTO Usuario_Califica_Articulo VALUES (NULL, pusuarioid, particuloid, 0);
		END CASE;
END //
DELIMITER ;
call SP_calificar('M', 1, 10);
SELECT * FROM Articulo;


INSERT INTO Usuario_Califica_Articulo VALUES (NULL, 1, 1, 100);

/*_______________________________________________________________________________________________________________________*/

DROP PROCEDURE SP_NoCategorias;
DELIMITER //
CREATE PROCEDURE SP_NoCategorias(IN p_option varchar(1))
BEGIN
	CASE p_option
		WHEN 'V' THEN 
			/*Categoria mas vendidos*/
			SELECT Articulo.Articulo_Id, Articulo.Nombre, count(Usuario_Compra_Articulo.Articulo_Id) ventas FROM Articulo
			LEFT JOIN Usuario_Compra_Articulo ON Usuario_Compra_Articulo.Articulo_Id=Articulo.Articulo_Id
			WHERE Borrador = 0 group by Articulo.Nombre order by ventas desc;
		WHEN 'O' THEN
			/*Categoria los mas vistos*/
			SELECT Articulo.Articulo_Id, Articulo.Nombre, count(Usuario_Visita_Articulo.Articulo_Id) visitas FROM Articulo
			LEFT JOIN Usuario_Visita_Articulo ON Usuario_Visita_Articulo.Articulo_Id=Articulo.Articulo_Id
			WHERE Borrador = 0 group by Articulo.Nombre order by visitas desc;
		WHEN 'B' THEN
			/*Categoria los mas buscados*/
			SELECT Articulo.Articulo_Id, Articulo.Nombre, count(Usuario_Busca_Articulo.Articulo_Id) busquedas FROM Articulo
			LEFT JOIN Usuario_Busca_Articulo ON Usuario_Busca_Articulo.Articulo_Id=Articulo.Articulo_Id
			WHERE Borrador = 0 group by Articulo.Nombre order by busquedas desc;
		WHEN 'C' THEN
			/*Categoria los mejor calificados*/
			SELECT Articulo_Id, Nombre, calificacion from Articulo WHERE Borrador = 0 order by calificacion desc;
		END CASE;
END //
DELIMITER ;
call SP_NoCategorias('V');
CALL SP_cards();
CALL SP_cardImg(1);



/*--------------------------------------------------------------------------------------------------------------------------*/

SELECT A_index, A_nombre, A_img1 FROM v_producto WHERE A_nombre LIKE '%%';

DROP PROCEDURE SP_Busqueda;
DELIMITER //
CREATE PROCEDURE SP_Busqueda(IN p_option varchar(1), IN p_patron varchar(32))
BEGIN
	CASE p_option
		WHEN 'N' THEN 
			SELECT A_index, A_nombre FROM v_producto WHERE A_nombre LIKE concat(concat('%', p_patron), '%');
		WHEN 'D' THEN
			SELECT A_index, A_nombre FROM v_producto WHERE A_Description LIKE concat(concat('%', p_patron), '%');
		END CASE;
END //
DELIMITER ;
call SP_Busqueda('N', 'may');
call SP_Busqueda('D', '');

select * from v_producto


select * from Administrador_Conversa_Usuario
select * from Mensaje group by Administrador_Conversa_Usuario_Id
select * from articulo

SELECT * FROM MENSAJE WHERE Administrador_Conversa_Usuario_Id=18

drop view v_conversaciones;
CREATE VIEW v_conversaciones as
select Administrador_Conversa_Usuario_Id id, Articulo.Nombre articulo, Usuario.Nombre_de_usuario usuario,
Articulo.Articulo_id, Usuario.Usuario_id
from Administrador_Conversa_Usuario JOIN Usuario On Usuario.Usuario_Id = Administrador_Conversa_Usuario.Usuario_Id
JOIN Articulo ON Articulo.Articulo_Id = Administrador_Conversa_Usuario.Articulo_Id

DROP PROCEDURE SP_conversaciones;
DELIMITER //
CREATE PROCEDURE SP_conversaciones()
BEGIN
	SELECT id, articulo, usuario, Articulo_id, Usuario_id FROM v_conversaciones;
END //
DELIMITER ;
call SP_conversaciones();
