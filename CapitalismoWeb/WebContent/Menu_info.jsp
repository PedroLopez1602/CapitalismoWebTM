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
    <script type="text/javascript" src="scriptMenuInfo.js"></script>
    
    <script>
    
    var resultado;
    var resultadoCompras;
    
    	$(document).ready(function(){
    		
    		var usuario_id = $("#usuario_id").val();
    		var controlador = "controlador_Carrito?usuario_id=" + usuario_id;
    		var v_ajax = $.get(controlador, function(responseText){
    			resultado = responseText.split("%");
    			//alert(resultado.length);
    			//alert(resultado[resultado.length - 1]);
	        	//if(resultado[1] != null){}
    		});
    		
    		var v_ajax2 = $.get("controlador_VerCompras?usuario_id=" + usuario_id, function(responseText){
    			resultadoCompras = responseText.split("%");
    			//alert(resultadoCompras);
    			//alert(resultado[resultado.length - 1]);
	        	//if(resultado[1] != null){}
    		});
    		
	        	
    		
    		$('#selector_menu').change(function(){

    		    $("#encabezado").remove();
    		    $("#head_row").remove();

    		    $("#body_row_01").remove();

    		    $("#extradata_label").remove();
    		    $("#extradata_select").remove();
    		    $("#extradata_btn").remove();
    		    
    		    $("#body_table").remove();
    		    $("#head_table").remove();
    		    $("#TablaPrincipal").append("<thead id='head_table'></thead>");
    		    $("#TablaPrincipal").append("<tbody id='body_table'></tbody>");
    
    		    if($('#selector_menu').val() == 2){

    		        $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

    		        $('#head_encabezado').append('<th id="encabezado">Carrito</th>');
    		        $('#head_row').append('<th id="th_1">Seleccionado</th>');
    		        $('#head_row').append('<th id="th_2">Nombre del articulo</th>');
    		        $('#head_row').append('<th id="th_3">Cantidad</th>');
    		        $('#head_row').append('<th id="th_4">Precio acordado</th>');

    		        var i = 0;
    		        var body_row;
    		        //alert(resultado.length);
    		        while(i < resultado.length){
    		        	body_row = "body_row_0" + i;
    		        	$('#body_table').append("<tr id=" + body_row + "></tr>");
        		        $('#' + body_row).append("<td id='td_1'> <input type='checkbox' name='" + body_row + "td_1" + "' value='check'></td>");
        		        $('#' + body_row).append("<td id='td_2' >" + resultado[i] + "</td>");
        		        $('#' + body_row).append("<input type='hidden' value='" + resultado[i] + "' name='" + body_row + "td_2" + "'>");
        		        i++
        		        $('#' + body_row).append("<td id='td_3'> <input type='number' name='" + body_row + "td_3" + "' min='0' value='0'> </td>");
        		        $('#' + body_row).append("<td id='td_4' >$" + resultado[i] + "</td>");
        		        $('#' + body_row).append("<input type='hidden' value='" + resultado[i] + "' name='" + body_row + "td_4" + "'>");
    		        	i++;
    		        }
    		        
    		        var selector = "[name='body_row_08td_4']";
    		        //alert($(selector).val());
    		        var trimeado = $.trim($(selector).val());
    		        //alert(trimeado);
    		        $(selector).val(trimeado);
    		        
    		        
    		        $('#extradata').append("<input type='hidden' name='num_rows' value=" + i + ">");
    		        $('#extradata').append('<label id="extradata_label">total $0</label>');
    		        $('#extradata').append('<select id="extradata_select" name="metodo_pago"> <option value="paypal">Paypal</option> <option value="credito">credito</option> <option value="debito">debito</option> </select> ');
    		        $('#extradata').append('<button type="submit" id="extradata_btn"> comprar </button>');

    		      }
    		    
    		    if($('#selector_menu').val() == 3){

    		        $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

    		        $('#head_encabezado').append('<th id="encabezado">compras</th>');
    		        $('#head_row').append('<th id="th_1">Nombre del articulo</th>');
    		        $('#head_row').append('<th id="th_2">Metodo de pago</th>');
    		        $('#head_row').append('<th id="th_3">fecha de compra</th>');
    		        $('#head_row').append('<th id="th_4">precio unitario</th>');
    		        $('#head_row').append('<th id="th_5">cantidad</th>');

    		        $('#body_table').append('<tr id="body_row_01"></tr>');

    		        var iCompras=0;
    		        var iCompras2 = 0;
    		        var j=1;
    		        var rowCompra = "body_row_0";
    		        var rowComprai = rowCompra + j;
    		        //alert(rowComprai);
    		        //alert(resultadoCompras.length);
    		        while(iCompras2<resultadoCompras.length){
    		        	while(iCompras<5){
    		        		//alert(resultadoCompras[iCompras]);
        		        	$('#' + rowComprai).append("<td id='td_" + iCompras2 + "'>" + resultadoCompras[iCompras2] + "</td>");
        		        	iCompras2++;
        		        	iCompras ++;
        		        }
    		        	//alert(iCompras2);
    		        	//alert(resultadoCompras.length);
    		        	iCompras = 0;
    		        	j++;
    		        	rowComprai = rowCompra + j;
    		        	//alert(rowComprai);
    		        	$('#body_table').append("<tr id=" + rowComprai + "></tr>");
    		        }
    		      }
    		});
    	});
    </script>
  </head>
  <body>

    <%@include file="navbar.jsp" %>
    
    <%String usuario_id = (String)misession.getAttribute("CW_avatar"); 
	    if(usuario_id == null)
	    {
	    	usuario_id = "No ha iniciado sesion";
	    } 
	%>
	<input type="hidden" name="usuario_id" id="usuario_id" value="<%= usuario_id %>">
	
    <div class="container">
      <div class="row">
        <div class="col-12">
          <br>
          <div class="input-group mb-3">
            <select class="custom-select" id="selector_menu">
              <option selected>Elige una opcion</option>
              <option value="1">Lista de deseados</option>
              <option value="2">Carrito</option>
              <option value="3">Compras</option>
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
          <form action="controlador_Comprar" method="post" enctype="multipart/form-data">
          		<input type="hidden" name="usuario_id" value="<%=usuario_id%>">
	          <table class="table table-striped table-dark" id="TablaPrincipal">
	            <thead id="head_table">
	
	            </thead>
	            <tbody id="body_table">
	
	            </tbody>
	          </table>
	          
	            <div id="extradata">
				</div>
          </form>
          
			
        </div>
      </div>
    </div>

  </body>
</html>
