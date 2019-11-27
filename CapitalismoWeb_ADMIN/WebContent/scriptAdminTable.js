
function scriptAdminTable(){
	$("#encabezado").remove();
    $("#head_row").remove();

    $("#body_row_01").remove();

    $("#extradata_label").remove();
    $("#extradata_select").remove();
    $("#extradata_btn").remove();

    if($('#selector_menu').val() == 1){
      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">ventas realizadas</th>');

      $('#head_row').append('<th id="th_1">ID</th>');
      $('#head_row').append('<th id="th_2">Usuario</th>');
      $('#head_row').append('<th id="th_3">Articulo</th>');
      $('#head_row').append('<th id="th_4">Precio</th>');
      $('#head_row').append('<th id="th_5">pago aceptado</th>');
      $('#head_row').append('<th id="th_6">metodo de envio</th>');
      $('#head_row').append('<th id="th_7">estatus</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1">#0</td>');
      $('#body_row_01').append('<td id="td_2">Usuario</td>');
      $('#body_row_01').append('<td id="td_3">Articulo_1</td>');
      $('#body_row_01').append('<td id="td_4">$0.00</td>');
      $('#body_row_01').append('<td id="td_5">Si</td>');
      $('#body_row_01').append('<td id="td_6">Estafeta</td>');
      $('#body_row_01').append('<td id="td_7">Entregado</td>');

    }

    if($('#selector_menu').val() == 2){

      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">Productos en venta</th>');

      $('#head_row').append('<th id="th_1">link</th>');
      $('#head_row').append('<th id="th_2">Nombre del articulo</th>');
      $('#head_row').append('<th id="th_3">vistas</th>');
      $('#head_row').append('<th id="th_4">busquedas</th>');
      $('#head_row').append('<th id="th_5">compras</th>');
      $('#head_row').append('<th id="th_6">en listas de deseados</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1"><button>articulo</button></td>');
      $('#body_row_01').append('<td id="td_2">Articulo_1</td>');
      $('#body_row_01').append('<td id="td_3">0</td>');
      $('#body_row_01').append('<td id="td_4">0</td>');
      $('#body_row_01').append('<td id="td_5">0</td>');
      $('#body_row_01').append('<td id="td_6">0</td>');

    }

    if($('#selector_menu').val() == 3){

      $('#head_table').append('<tr id="head_encabezado"></tr><tr id="head_row"></tr>');

      $('#head_encabezado').append('<th id="encabezado">borrador</th>');
      $('#head_row').append('<th id="th_1">Link</th>');
      $('#head_row').append('<th id="th_2">Nombre del articulo</th>');
      $('#head_row').append('<th id="th_3">Editar</th>');
      $('#head_row').append('<th id="th_4">Eliminar</th>');

      $('#body_table').append('<tr id="body_row_01"></tr>');

      $('#body_row_01').append('<td id="td_1"><button>articulo</button></td>');
      $('#body_row_01').append('<td id="td_2">Articulo_1</td>');
      $('#body_row_01').append('<td id="td_3"><button>Editar</button></td>');
      $('#body_row_01').append('<td id="td_4"><button>Eliminar</button></td>');

    }
	
}