<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form method="get" action="controlador_GetProducto">
	<input type="number" name="id">
	<input type="number" name="indice_imagen">
	<input type="submit">
	
	 <video width="320" height="240" controls>
	  <source src="controlador_GetProducto?id=3&indice_imagen=4" type="video/mp4">
	Your browser does not support the video tag.    
	</video> 
	
	<img src="controlador_GetProducto?id=3&indice_imagen=1">
	<img src="controlador_GetProducto?id=3&indice_imagen=2">
	<img src="controlador_GetProducto?id=3&indice_imagen=3">
</form>

</body>
</html>