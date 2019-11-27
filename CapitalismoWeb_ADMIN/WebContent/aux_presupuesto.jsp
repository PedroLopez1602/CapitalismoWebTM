<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Presupuesto</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
</head>
<body>

	<%@include file="navbar.jsp" %>
	
	<div class="container">
        <div class="row">
          <div class="col-12">
            
            <form action="Presupuestos.jsp" method="get">
            	<input type="text" name="articulo_id" placeholder="articulo id">
            	<input type="text" name="usuario_id" placeholder="usuario id">
            	<input type="submit" value="ir a conversacion" >
            </form>
        
          </div>
        </div>
      </div>


</body>
</html>