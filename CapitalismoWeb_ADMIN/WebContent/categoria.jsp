<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Categorias</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src="scriptAdminTable.js"></script>
    
    <script>
    
    //cargar categorias
    var resultado;
    
    $(document).ready(function() {
    	//cargar los datos desde la database
        var v_ajax = $.post("controlador_obtenerCategorias", function(responseText){
        	//alert(responseText);
        	if(responseText != ""){
        		resultado = responseText.split("%");
            	//alert(resultado);
            	var i = 0;
            	while(i < resultado.length){
            		$("#categorias_existentes").append("<option value='" + resultado[i] + "'>" + resultado[i] + "</option>");
            		i++;
            	}
        	}else{
        		alert("no hay categorias registradas");
        	}
        })
        .fail(function(){
        	alert("ocurrio un error");
        });
    });
	    
	    
	</script>

  </head>
  <body>

    <%@include file="navbar.jsp" %>

    <div class="container">
      <div class="row">
        <div class="col-12">
          <br>
          <form action="controlador_CategoriaEliminar" method="post" enctype="multipart/form-data">
	          <select class="form-control" name="categorias" id="categorias_existentes">
	            
	          </select>
	          <button class="btn btn-primary btn-block" type="submit" name="button">Eliminar</button>
          </form>
          <br>
		  
		  <form action="controlador_CategoriaAgregar" method="post" enctype="multipart/form-data">
          	<input class="form-control" type="text" name="nuevaCategoria" placeholder="agregar categoria"><br>
          	<button class="btn btn-primary btn-block" type="submit" name="button">Agregar</button>
		  </form>

        </div>
      </div>
    </div>

  </body>
</html>
