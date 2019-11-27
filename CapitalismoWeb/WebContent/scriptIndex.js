$( document ).ready(function() {
  $('#exampleModal').modal({
    show: false
  });

  //carrusel
  $('#carrusel_img_1').attr("src","imagenes/carrusel/imagen_1.png");
  $('#carrusel_titulo_1').text("The Legend of Zelda");
  $('#carrusel_desc_1').text("Disponible en WiiU");

  $('#carrusel_img_2').attr("src","imagenes/carrusel/imagen_2.png");
  $('#carrusel_titulo_2').text("God of War");
  $('#carrusel_desc_2').text("Disponible en PlayStation 4");

  $('#carrusel_img_3').attr("src","imagenes/carrusel/imagen_3.png");
  $('#carrusel_titulo_3').text("Halo 5");
  $('#carrusel_desc_3').text("Disponible en Xbox One");

});
