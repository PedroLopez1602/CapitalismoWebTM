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
	    	$('#formulario').append("<input type='hidden' name='id' value='" + id + "'>");
	    	
	        var v_ajax = $.get("controlador_GetProducto2?id=" + id, function(responseText){
	        	resultado = responseText.split("%");
	        	//alert(resultado);
	        	
	        	$("#titulo").val(resultado[0]);
	        	$("#descripcion").val(resultado[1]);
	        	$("#unidades").val(resultado[2]);
	        	
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
	
	<script>
	var resultado2;
	
	    $(document).ready(function() {
	    	//cargar los datos desde la database
	        var v_ajax = $.post("controlador_obtenerCategorias", function(responseText){
	        	resultado2 = responseText.split("%");
	        	var i = 0;
	        	while(i < resultado2.length){
	        		$("#categorias").append("<option value='" + resultado2[i] + "'>" + resultado2[i] + "</option>");
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
	        	while(i < resultado2.length){
	        		$(selector).append("<option value='" + resultado2[i] + "'>" + resultado2[i] + "</option>");
	        		i++;
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
        <form id ="formulario" action="controlador_ModificarArticulo" method="post" enctype="multipart/form-data">
          <br>
          <input class="form-control" id="titulo" type="text" name="titulo" value="" placeholder="Nombre del Articulo" required>
          <br>
          <div id="calificacion">

          </div>
          <textarea id = "descripcion" class="form-control" name="descripcion" rows="8" cols="40" placeholder="Aqui va la descripcion" required></textarea>
 
          <h5>Disponible: <input class="form-control" name="unidades" id="unidades" type="text"> unidades</h5>
          
          <div>
			<input type="file" name="img_1" value=""> <input type="checkbox" name="img_1_check" value="check">
	        <input type="file" name="img_2" value=""> <input type="checkbox" name="img_2_check" value="check">
	        <input type="file" name="img_3" value=""> <input type="checkbox" name="img_3_check" value="check">
	        <input type="file" name="video" value=""> <input type="checkbox" name="video_check" value="check">
          </div>
          
          <h6 id="categoria">Categorias: categoria_1, categoria_2</h6>
          
          
          <div id="division_categorias">
	          <select class="form-control" name="categoria_1" id="categorias">
	            
	          </select>
          </div>
          <button class="btn btn-primary btn-block" type="button" name="button" id="addCategoria">Añadir categoria</button>
          <h4><input type="checkbox" name="video_check" value="check">Eliminar categorias anteriores</h4>
          
          <br>
          <button type="submit" name="button" class="btn btn-primary btn-block">Modificar</button>
          </form>
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