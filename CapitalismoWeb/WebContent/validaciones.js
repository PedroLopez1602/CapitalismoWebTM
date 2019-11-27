function validacion(){
  var nombre_form = "registrousuario";
  var nombre_password = "password";
  var nombre_usuario = "username";
  var nombre_confirm = "confirm";

  var caracteres_minimos_password = 8;
  var caracteres_minimos_usuario = 6;

  var mensaje_error_1 = "cantidad de caracteres insuficiente en contraseña";
  var mensaje_error_2 = "debe haber al menos una mayuscula en su contraseña";
  var mensaje_error_3 = "debe haber al menos una minuscula en su contraseña";
  var mensaje_error_4 = "debe haber al menos un numero en su contraseña";
  var mensaje_error_5 = "cantidad de caracteres insuficiente en usuario";
  var mensaje_error_6 = "contraseñas no coinciden"

  var usuario = document.forms[nombre_form][nombre_usuario].value;
  var password = document.forms[nombre_form][nombre_password].value;
  var confirmar = document.forms[nombre_form][nombre_confirm].value;

  //contar los caracteres
  if(password.length < caracteres_minimos_password){
    alert(mensaje_error_1);
    return false;
  }

  //contener al menos una mayuscula
  if(password === password.toLowerCase()){
    alert(mensaje_error_2);
    return false;
  }

  //contener al menos una minuscula
  if(password === password.toUpperCase()){
    alert(mensaje_error_3);
    return false
  }

  //contener al menos un numero
  var aux = String(password);
  var bandera = false;
  var i = 0;
  while(i < aux.length){
    if(!isNaN(aux.charAt(i))){
      bandera = true;
    }
    i++;
  }
  if(!bandera){
    alert(mensaje_error_4);
    return false;
  }

//contar caracteres
  if(usuario.length < caracteres_minimos_usuario){
    alert(mensaje_error_5);
    return false;
  }

//que coincidan la contraseña y su confirmacion
  if(password != confirmar){
    alert(mensaje_error_6);
    return false;
  }


  return true;
}
