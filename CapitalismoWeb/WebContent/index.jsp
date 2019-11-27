<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

    <link rel="icon" type="image/png" href="imagenes/General/favicon.png" sizes="32x32">
    <title>CapitalismoWeb&trade; | inicio</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/popper.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="estilo.css">
    <script type="text/javascript" src="scriptIndex.js"></script>
    
    <script>
    
    var resultado;
    
	    $(document).ready(function() {
	        var v_ajax = $.post("controlador_indexcards", function(responseText){
	        	resultado = responseText.split("%");
	        	if(resultado[1] != null){
	        		var i = 0;
		        	var cat = 0;
		        	var car = 0;
		        	var num_categorias = 4;
		        	var num_cards = 5;
		        	var num_campos = 3;
		        	while(cat < num_categorias){
		        		while(car < num_cards){
		        			if(resultado[i] != null ){
		    	        		$("#categoria_" + cat + "_card_" + car + "_imagen").attr("src","controlador_indexcardsImg?id=" + resultado[i]);
		    	        		$("#categoria_" + cat + "_card_" + car + "_articulo").attr("href","producto.jsp?id=" + resultado[i]);
		    	        		$("#categoria_" + cat + "_card_" + car + "_articulo").text("Ver articulo");
		    	        		i++;
		    	        		$("#categoria_" + cat + "_card_" + car + "_nombre").text(resultado[i]);
		    	        		$("#categoria_" + cat + "_card_" + car + "_descripcion").text("");
		    	        		i++;
		    	        		//$("#categoria_" + cat + "_card_" + car + "_descripcion").text(resultado[2]);
		    	        		i++;
		        			}
		        			car++;
		        		}
		        		cat++;
		        	}
	        	}
	        	
	        	
	        	
	        })
	        .fail(function(){
	        	alert("ocurrio un error");
	        });
	    });
	</script>

</head>
<body>

	<!-- NavBar -->
	<%@include file="navbar.jsp" %>


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Aviso Importante</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p class="text-justify">Esta pagina es un proyecto escolar por lo que todos los articulos aqui representados no estan exhibidos con el proposito de venderlos si no para mostrar las competencias aprendidas
            </p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">cerrar</button>
          </div>
        </div>
      </div>
    </div>

    <div class="container">

      <!--carousel-->
      <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">

          <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
              <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="imagenes/carrusel/imagen_default.png" class="d-block w-100" alt="..." id="carrusel_img_1">
                <div class="carousel-caption d-none d-md-block">
                  <h5 id="carrusel_titulo_1">First slide label</h5>
                  <p id="carrusel_desc_1">Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="imagenes/carrusel/imagen_default.png" class="d-block w-100" alt="..." id="carrusel_img_2">
                <div class="carousel-caption d-none d-md-block">
                  <h5 id="carrusel_titulo_2">Second slide label</h5>
                  <p id="carrusel_desc_2">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                </div>
              </div>
              <div class="carousel-item">
                <img src="imagenes/carrusel/imagen_default.png" class="d-block w-100" alt="..." id="carrusel_img_3">
                <div class="carousel-caption d-none d-md-block">
                  <h5 id="carrusel_titulo_3">Third slide label</h5>
                  <p id="carrusel_desc_3">Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                </div>
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
            <br>
          </div>

        </div>
      </div>

      <!--cards-->
      
      <%for(int j=0; j != 4; j++){%>
      
      <div class="row">

        <div class="col-12 d-flex justify-content-center ">
          <h1>Categoria <%=j %></h1>
        </div>

        <div class="col-1 d-flex align-items-center">
          <a href="#" class="btn btn-primary">ver mas</a>
        </div>
        
        <%for(int i=0; i != 5; i++) {
        	String imagen = "categoria_" + j + "_card_" + i + "_imagen";;
        	String nombre = "categoria_" + j + "_card_" + i + "_nombre";
        	String desc = "categoria_" + j + "_card_" + i + "_descripcion";
        	String articulo = "categoria_" + j + "_card_" + i + "_articulo";;
        %>

        <div class="col-2">
          <div class="card">
            <img src="imagenes/cards/img_1.JPG" id="<%=imagen%>"  class="card-img-top " alt="...">
            <div class="card-body">
              <h5 class="card-title" id="<%=nombre%>">Card title <span class="badge badge-secondary">New</span> </h5>
              <p class="card-text" id="<%=desc%>">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
              <a href="#" id="<%=articulo %>" class="btn btn-primary">Go somewhere</a>
            </div>
          </div>
        </div>

        <% } %>

        <div class="col-1 d-flex align-items-center">
          <a href="#" class="btn btn-primary">ver mas</a>
        </div>

      </div>
      
      <%} %>

    </div>

    <div class="container-fluid footer">
      <div class="row">
        <div class="col-12 d-flex justify-content-center">
          <h1>CapitalismoWeb S.A. de C.V.</h1>
        </div>
        <div class="col-12 d-flex justify-content-center">
          <a href="legal.html">Acuerdo de terminos y condiciones de uso</a>
        </div>
        <div class="col-12 d-flex justify-content-center">
          <a href="#"><img class="logo" src="imagenes/logos/facebook.png" alt=""></a>
          <a href="#"><img class="logo" src="imagenes/logos/twitter.jpg" alt=""></a>
          <a href="#"><img class="logo" src="imagenes/logos/tiktok.jpg" alt=""></a>
        </div>


      </div>
    </div>

</body>
</html>