<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | inicio</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src="scriptAdminTable.js"></script>
    
    <script type="text/javascript">
    
    	var resultado;
    
		$( document ).ready(function() {
			var v_ajax = $.post("controlador_AdminTable", function(responseText){
	        	resultado = responseText.split("%");
	        	//alert(resultado);
	        	//resultado.length
	        	//resultado[i]
	        })
	        .fail(function(){
	        	alert("ocurrio un error en el front");
	        });
			
			
			$('#selector_menu').change(function(){
				scriptAdminTable();
				
				if($('#selector_menu').val() == 3){
					$("#encabezado").remove();
					$("#head_row").remove();
					$("#body_row_01").remove();
					$("#extradata_label").remove();
					$("#extradata_select").remove();
					$("#extradata_btn").remove();
					    
					$('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');
					
					$('#head_encabezado').append('<th id="encabezado">borrador</th>');
					$('#head_row').append('<th id="th_1">Link</th>');
					$('#head_row').append('<th id="th_2">Nombre del articulo</th>');
					$('#head_row').append('<th id="th_3">Publicar</th>');
					$('#head_row').append('<th id="th_4">Eliminar</th>');
					$('#head_row').append('<th id="th_5">Modificar</th>');
					
					var body_row = "body_row_0";
					var indice = 0;
					var row_id;
					
					while(indice < resultado.length){
						row_id = body_row + indice;
						$('#body_table').append("<tr id="+row_id+"></tr>");
						$("#"+row_id).append("<td id='td_1'><form action='producto.jsp' method='get'><button type='submit' name='id' value='" + resultado[indice] + "'>Articulo</button></form></td>");
						
						$("#"+row_id).append("<td id='td_2'>" + resultado[indice + 1] + "</td>");
						$("#"+row_id).append("<td id='td_3'><form action='controlador_publicarArticulo' method='post'><button type='submit' name='id' value='" + resultado[indice] + "'>Publicar</button></form></td>");
						$("#"+row_id).append("<td id='td_3'><form action='controlador_eliminarArticulo' method='post'><button type='submit' name='id' value='" + resultado[indice] + "'>Eliminar</button></form></td>");
						$("#"+row_id).append("<td id='td_3'><form action='modificarProducto.jsp' method='get'><button type='submit' name='id' value='" + resultado[indice] + "'>Modificar</button></form></td>");
						indice++;
						indice++;
					}
				}
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
            <div class="input-group mb-3">
              <select class="custom-select" id="selector_menu">
                <option selected>Elige una opcion</option>
                <option value="1">Ventas realizadas</option>
                <option value="2">productos en venta</option>
                <option value="3">borrador</option>
              </select>
              <div class="input-group-append">
                <label class="input-group-text" for="inputGroupSelect02">Options</label>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-12">
            <br>
            <table class="table table-striped table-dark">
              <thead id="head_table">

              </thead>
              <tbody id="body_table">

              </tbody>
            </table>
            <div id="extradata">

            </div>
          </div>
        </div>
      </div>

  </body>
</html>
