<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Nuevo Producto</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src=""></script>
    
    <script>
    
    var resultado;
    
	    $(document).ready(function() {
	    	//cargar los datos desde la database
	        var v_ajax = $.post("controlador_obtenerCategorias", function(responseText){
	        	resultado = responseText.split("%");
	        	var i = 0;
	        	while(i < resultado.length){
	        		$("#categorias").append("<option value='" + resultado[i] + "'>" + resultado[i] + "</option>");
	        		i++;
	        	}
	        })
	        .fail(function(){
	        	alert("ocurrio un error");
	        });
	        
	        //boton para añadir otro campo de categoria
	        
	        $( "#addCategoria" ).click(function() {
	        	
	        	//alert(resultado.length);
	        	
	        	//regresa 0 si no existe y 1 si existe
	        	//if ($("#categorias").length ) {
	        	  //  alert($("#categorias").length );
	        	//}
	        		        	
		   		var nameOld = $("#categorias").attr("name");
		   		var nameNew;
		   		var nameArray = nameOld.split("_");
		   		var nameIndex = $("select").length;//nameArray[1];
		   		nameNew = nameArray[0];
		   		nameNew += "_";
		   		nameNew += nameIndex;

	        	var id = $("#categorias").attr("id");
	        	id += nameIndex;
		   		
		   		//alert(nameNew);
		   		//alert(id);
		   		$("#division_categorias").append("<select class='form-control' name='" + nameNew + "' id='" + id + "'></select>");
		   		
		   		var selector = "#" + id;
		   		
		   		var i = 0;
	        	while(i < resultado.length){
	        		$(selector).append("<option value='" + resultado[i] + "'>" + resultado[i] + "</option>");
	        		i++;
	        	}
		    });
	    });
	    
	    
	</script>
    
  </head>
<body>

	<%@include file="navbar.jsp" %>
<form action="controlador_Nuevo_Producto" method="post" enctype="multipart/form-data">
    <div class="container">
      <div class="row">
      
      
      
        <div class="col-1 d-flex align-items-center">
          <button type="button" name="button" class="btn btn-primary"><img class="card-img-top" src="imagenes/General/flecha_izq.png" alt=""></button>
        </div>
        <div class="col-6">
          <br>
          <input type="file" name="img_1" value="" required>
          <input type="file" name="img_2" value="" required>
          <input type="file" name="img_3" value="" required>
          <input type="file" name="video" value="" required>
          <img src="" class="card-img-top" alt="">
        </div>
        <div class="col-1 d-flex align-items-center">
          <button type="button" name="button" class="btn btn-primary"><img class="card-img-top" src="imagenes/General/flecha_der.png" alt=""></button>
        </div>
        <div class="col-4">
          <br>
          <input class="form-control" type="text" name="titulo" value="" placeholder="Nombre del Articulo" required>
          <br>
          <img src="imagenes/General/estrella_dorada.png" alt="">
          <img src="imagenes/General/estrella_dorada.png" alt="">
          <img src="imagenes/General/estrella_dorada.png" alt="">
          <img src="imagenes/General/estrella_dorada.png" alt="">
          <img src="imagenes/General/estrella_dorada.png" alt="">
          <textarea class="form-control" name="descripcion" rows="8" cols="40" placeholder="Aqui va la descripcion" required></textarea>
          <input class="form-control" type="text" name="unidades" value="" placeholder="Unidades disponibles" required><br>
          <div id="division_categorias">
	          <select class="form-control" name="categoria_1" id="categorias">
	            
	          </select>
          </div>
          <button class="btn btn-primary btn-block" type="button" name="button" id="addCategoria">Añadir categoria</button>
          <br>

          <button type="submit" name="button" class="btn btn-primary btn-block">Crear articulo</button>
        </div>
		
      </div>
    </div>
</form>
  </body>

</html>