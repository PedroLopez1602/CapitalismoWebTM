<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | Presupuesto</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src=""></script>
    
    <script>
    var resultado;
    
    $(document).ready(function() {
    	
    	var articulo_id = <%= request.getParameter("articulo_id") %>;
    	var usuario_id = <%= request.getParameter("usuario_id") %>;
    	
    	var controlador = "controlador_recibirOfertas?articulo_id=" + articulo_id + "&usuario_id=" + usuario_id;
    	//cargar los datos desde la database
        var v_ajax = $.get(controlador, function(responseText){
        	resultado = responseText;//.split("%");
        	//alert(resultado);
        	$("#precio_actual").text(resultado);
        })
        .fail(function(){
        	alert("ocurrio un error");
        });
    });
    </script>
    
    <script>
    var resultado2;
    
    $(document).ready(function() {
    	
    	var articulo_id = <%= request.getParameter("articulo_id") %>;
    	var usuario_id = <%= request.getParameter("usuario_id") %>;
    	var controlador = "controlador_recibirMensajes?articulo_id=" + articulo_id + "&usuario_id=" + usuario_id;
    	//cargar los datos desde la database
        var v_ajax = $.get(controlador, function(responseText){
        	resultado2 = responseText.split("%");
        	alert(resultado2);
        	var i = 0;
        	while(i < resultado2.length){
        		
        		if(resultado2[i+1] == "0"){	
        			//alert("vendedor");
        			$("#espacioMensaje").append("<div class='row'> <div class='col-6'> <br> <div class='card'> <div class='card-body'> <h5 class='card-title text-justify'> " + resultado2[i] + "</h5></div> </div> </div> <div class='col-6'></div> </div>");
        		}else{
        			$("#espacioMensaje").append("<div class='row'> <div class='col-6'></div> <div class='col-6'> <br> <div class='card'> <div class='card-body'> <h5 class='card-title text-justify'> " + resultado2[i] + "</h5></div> </div> </div> </div>");
        		}
        		i++;
        		i++;
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
        <div class="col-3">
          <div class="container">
            <div class="row">
              <div class="col-12">
                <br>

                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Articulo</h5>
                    <a href="#" class="btn btn-primary">Link</a>
                  </div>
                </div>

              </div>
              <div class="col-12">
                <br>
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Articulo</h5>
                    <a href="#" class="btn btn-primary">Link</a>
                  </div>
                </div>
              </div>
              <div class="col-12">
                <br>
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Articulo</h5>
                    <a href="#" class="btn btn-primary">Link</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-9">
          <div class="container">
          <div  id="espacioMensaje"></div>
            
            <div class="row">

              <div class="col-12">
                <br>
                
                <form action="controlador_enviarMensaje" method="post" enctype="multipart/form-data">
					<textarea class="form-control" name="mensaje" rows="8" cols="80" placeholder="Mensaje"></textarea>
					<input type="hidden" name="articulo_id" value ="<%= request.getParameter("articulo_id") %>" >
					<input type="hidden" name="usuario_id" value ="<%= request.getParameter("usuario_id") %>">
					<button class="btn btn-primary btn-block" type="submit" name="btn_mensaje">Enviar</button><br>
                </form>
                
              </div>
              </div>
              
              <form action="controlador_enviarOferta" method="post" enctype="multipart/form-data">
		             <input type="hidden" name="articulo_id" value ="<%= request.getParameter("articulo_id") %>" >
					 <input type="hidden" name="usuario_id" value ="<%= request.getParameter("usuario_id") %>">
					
					<div class="row">
		             <div class="col-6">
		               <input class="form-control" type="number" name="oferta" placeholder="Cuanto estas dispuesto a pagar?">
		             </div>
		             <div class="col-6">
		               <button class="btn btn-primary btn-block" type="submit" name="button">Adelante!</button><br>
		             </div>
		             </div>
             </form>
             
             	<div class="row">
		             <div class="col-12">
		               <label>el precio actual es de: $</label><label id="precio_actual">?</label>
		               <form action="controlador_AceptarOferta" method="post" enctype="multipart/form-data">
		               		<input type="hidden" name="articulo_id" value ="<%= request.getParameter("articulo_id") %>" >
					 		<input type="hidden" name="usuario_id" value ="<%= request.getParameter("usuario_id") %>">
		               		<button class="btn btn-primary" type="submit" name="button">¡Acepto!</button>
		               </form>
		             </div>
              </div>
              
            
          </div>
        </div>
      </div>
    </div>

  </body>
</html>