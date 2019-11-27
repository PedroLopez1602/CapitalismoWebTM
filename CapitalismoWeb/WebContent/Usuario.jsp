<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Identificate!</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src="validaciones.js"></script>
    
  </head>
  <body>

    <%@include file="navbar.jsp" %>

    <div class="container">
        <div class="row">
          <div class="col-6 d-flex align-items-center">
            <div class="container">
              <div class="row">

                <div class="col-12 d-flex justify-content-center">
                  <h1>Iniciar sesión</h1>
                </div>

                <div class="col-12">
                  <form class="" action="controlador_IniciarSesion" method="post">
                    <input class="form-control" type="text" name="username_email" value="" placeholder="usuario o correo electrónico" required> <br>
                    <input class="form-control" type="password" name="password" value="" placeholder="contraseña" required> <br>
                    <input class="btn btn-primary form-control" type="submit" name="" value="ingresar"> <br>
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="checkbox_recordar">
                      <label class="form-check-label" for="checkbox_recordar">Mantener sesión iniciada</label>
                    </div>
                  </form>
                </div>

            </div>
          </div>
          </div>
          <div class="col-6 d-flex align-items-center">
            <div class="container">
              <div class="row">

                <div class="col-12  d-flex justify-content-center">
                  <h1>Crear cuenta</h1>
                </div>

                <div class="col-12">
                  <form name="registrousuario" class="" action="controlador_Usuario" method="post" enctype="multipart/form-data" onsubmit="return validacion()">
                    <div class="form-row">
                      <div class="col-6">
                        <input class="form-control" id="form_nombre" type="text" name="nombre" value="" placeholder="nombre" required>
                      </div>
                      <div class="col-6">
                        <input class="form-control" id="form_apellido" type="text" name="apellido" value="" placeholder="apellido" required><br>
                      </div>
                      <div class="col-12">
                        <input class="form-control" id="form_email" type="email" name="correo" value="" placeholder="correo electrónico" required> <br>
                      </div>
                      <div class="col-12">
                        <input class="form-control" id="form_username" type="text" name="username" value="" placeholder="nombre de usuario" required> <br>
                      </div>
                      <div class="col-6">
                        <input class="form-control" id="form_password" type="password" name="password" value="" placeholder="contraseña" required> <br>
                      </div>
                      <div class="col-6">
                        <input class="form-control" id="form_confirm" type="password" name="confirm" value="" placeholder="confirmar contraseña" required> <br>
                      </div>
                      <div class="col-12">
                        <input class="form-control" id="form_telefono" type="text" name="telefono" value="" placeholder="telefono"> <br>
                      </div>
                      <div class="col-12">
                        <input class="form-control" id="form_direccion" type="text" name="direccion" value="" placeholder="direccion"> <br>
                      </div>
                      <div class="col-12">
                        <div class="input-group">
                          <div class="custom-file">
                            <input type="file" class="custom-file-input" id="inputGroupFile04" name="avatar" aria-describedby="inputGroupFileAddon04">
                            <label class="custom-file-label" for="inputGroupFile04">Imagen tipo avatar</label>
                          </div>
                        </div>
                        <br>
                      </div>
                      <div class="col-12">
                        <br>
                        <button type="submit" id="crear_cuenta" class="btn btn-primary form-control" name="button" id="btn_accountcreate">enviar</button>
                      </div>
                    </div>
                  </form>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>


  </body>
</html>
