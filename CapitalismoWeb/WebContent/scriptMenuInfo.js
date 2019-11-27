$( document ).ready(function() {

  $('#selector_menu').change(function(){

    $("#encabezado").remove();
    $("#head_row").remove();

    $("#body_row_01").remove();

    $("#extradata_label").remove();
    $("#extradata_select").remove();
    $("#extradata_btn").remove();

    if($('#selector_menu').val() == 1){
      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">Lista de deseados</th>');
      $('#head_row').append('<th id="th_1">Articulo</th>');
      $('#head_row').append('<th id="th_2">Nombre del articulo</th>');
      $('#head_row').append('<th id="th_3">conversacion</th>');
      $('#head_row').append('<th id="th_4">Eliminar</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1"><button> Articulo </button></td>');
      $('#body_row_01').append('<td id="td_2">articulo ?</td>');
      $('#body_row_01').append('<td id="td_3"><button> Conversacion </button></td>');
      $('#body_row_01').append('<td id="td_4"><button> Eliminar </button></td>');
    }

    if($('#selector_menu').val() == 2){

      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">Carrito</th>');
      $('#head_row').append('<th id="th_1">Seleccionado</th>');
      $('#head_row').append('<th id="th_2">Nombre del articulo</th>');
      $('#head_row').append('<th id="th_3">Cantidad</th>');
      $('#head_row').append('<th id="th_4">Precio acordado</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1"> <input type="checkbox" name="seleccion" value="Articulo"></td>');
      $('#body_row_01').append('<td id="td_2">Nombre</td>');
      $('#body_row_01').append('<td id="td_3"> <input type="number" name="cantidad" min="0" value="0"> </td>');
      $('#body_row_01').append('<td id="td_4">$0.00</td>');

      $('#extradata').append('<label id="extradata_label">total $0</label>');
      $('#extradata').append('<select id="extradata_select"> <option value="paypal">Paypal</option> <option value="credito">credito</option> <option value="debito">debito</option> </select> ');
      $('#extradata').append('<button id="extradata_btn"> comprar </button>');

    }

    if($('#selector_menu').val() == 3){

      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">compras</th>');
      $('#head_row').append('<th id="th_1">Nombre del articulo</th>');
      $('#head_row').append('<th id="th_2">cantidad</th>');
      $('#head_row').append('<th id="th_3">fecha de compra</th>');
      $('#head_row').append('<th id="th_4">total</th>');
      $('#head_row').append('<th id="th_5">Metodo de pago</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1">articulo ?</td>');
      $('#body_row_01').append('<td id="td_2">0</td>');
      $('#body_row_01').append('<td id="td_3">01/Enero/2000 a las 00:00</td>');
      $('#body_row_01').append('<td id="td_4">$0.00</td>');
      $('#body_row_01').append('<td id="td_5">Paypal</td>');
    }

  });
});
