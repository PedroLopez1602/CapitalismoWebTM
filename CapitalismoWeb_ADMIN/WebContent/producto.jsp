<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Producto</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src=""></script>
    
    <script>
    
    var id = <%= request.getParameter("id") %>;
    var resultado;
    var indiceImg = 1;
    
	    $(document).ready(function() {
	    	//cargar los datos desde la database
	        var v_ajax = $.get("controlador_GetProducto2?id=" + id, function(responseText){
	        	resultado = responseText.split("%");
	        	//alert(resultado);
	        	
	        	$("#titulo").text(resultado[0]);
	        	$("#descripcion").text(resultado[1]);
	        	$("#unidades").text("Disponible: " + resultado[2] + " unidades");
	        	
        		var i;
        		var estrellas_doradas = resultado[3]/20;
        		var estrellas_grises = 5 - estrellas_doradas;
        		for (i = 0; i < estrellas_doradas; i++) {
        			$("#calificacion").append("<img src='imagenes/General/estrella_dorada.png' >");
        		} 
        		for (i = 0; i < estrellas_grises; i++) {
        			$("#calificacion").append("<img src='imagenes/General/estrella_gris.png' >");
        		} 
	        	
        		$("#imagen").attr("src", "controlador_GetProducto?id=" + id + "&indice_imagen=1");
        		
        		var num_categorias = parseInt(resultado[5]);
        		var index = 0;
        		var indice = 0;
        		var catetexto = "Categorias: ";

        		while(index < num_categorias){
        			indice = 5 + index + 1;
        			catetexto += resultado[indice];
        			index++;
					if(index < num_categorias ){
						catetexto += ", "
        			}
        		}
        		$("#categoria").text(catetexto);
        		
        		//$("#presupuesto").val(id);
        		
	        	
	        })
	        .fail(function(){
	        	alert("ocurrio un error");
	        });
	    	
	    	
	        $( "#derecho" ).click(function() {
	        	if(indiceImg == 4){
	        		indiceImg = 0;
	        	}
	        	indiceImg++;
	        	if(indiceImg == 1 || indiceImg == 2 || indiceImg == 3){
	        		$("#imagen").remove();
	        		$("#imgyvids").append("<img id='imagen' src='controlador_GetProducto?id=" + id + "&indice_imagen=" + indiceImg + "' class='card-img-top' alt='oopsi imagen no disponible'>");
	        		
	        	}
	        	if(indiceImg == 4){
	        		$("#imagen").remove();
	        		$("#imgyvids").append("<video  id='imagen' class='card-img-top' controls> <source src='controlador_GetProducto?id=" + id + "&indice_imagen=4' type='video/mp4'></video>");
	        	}
        	});
	        $( "#izquierdo" ).click(function() {
	        	if(indiceImg == 1){
	        		indiceImg = 5;
	        	}
	        	indiceImg--;
	        	if(indiceImg == 1 || indiceImg == 2 || indiceImg == 3){
	        		$("#imagen").remove();
	        		
	        		$("#imgyvids").append("<img id='imagen' src='controlador_GetProducto?id=" + id + "&indice_imagen=" + indiceImg + "' class='card-img-top' alt='oopsi imagen no disponible'>");
	        		
	        	}
	        	if(indiceImg == 4){
	        		$("#imagen").remove();
	        		$("#imgyvids").append("<video  id='imagen' class='card-img-top' controls> <source src='controlador_GetProducto?id=" + id + "&indice_imagen=4' type='video/mp4'></video>");
	        	}
        	});
	        
	    });
	    
	    
	</script>
    
  </head>
  <body>

    <%@include file="navbar.jsp" %>

    <div class="container">
      <div class="row">
        <div class="col-1 d-flex align-items-center">
          <button type="button" id="izquierdo" name="button" class="btn btn-primary"><img class="card-img-top" src="imagenes/General/flecha_izq.png" alt=""></button>
        </div>
        <div class="col-6">
          <br>
          <div id="imgyvids">
          	<img id="imagen" src="" class="card-img-top" alt="oopsi imagen no disponible">
          </div>
        </div>
        <div class="col-1 d-flex align-items-center">
          <button type="button" id="derecho" name="button" class="btn btn-primary"><img class="card-img-top" src="imagenes/General/flecha_der.png" alt=""></button>
        </div>
        <div class="col-4">
          <br>
          <h1 id="titulo"></h1>
          <br>
          <div id="calificacion">

          </div>
          <p id = "descripcion"></p>
          <h5 id="unidades"></h5>
          <h6 id="categoria">Categorias: categoria_1, categoria_2</h6>
          
          <br>
          <button type="button" name="button" class="btn btn-primary btn-block">Agregar a lista de deseados</button>
          
          
          
        </div>
        <div class="col-6">
          <br>
          <button type="button" name="button" class="btn btn-primary btn-block">Me gusta este producto <img src="imagenes/General/pulgar arriba.png" alt=""></button>
        </div>
        <div class="col-6">
          <br>
          <button type="button" name="button" class="btn btn-primary btn-block">No me gusta este producto <img src="imagenes/General/pulgar abajo.png" alt=""></button>
        </div>
        <div class="col-12">
          <textarea name="name" rows="8" cols="123"></textarea>
          <button type="button" name="button" class="btn btn-primary btn-block">dejar comentario</button>
        </div>
        <div class="col-12">
          <br>
          <h5>Usuario</h5>
          <h6>publicado el 01/Ene/1999 a las 00:00</h6>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
      </div>
    </div>

  </body>
</html>