<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <a class="navbar-brand" href="index.jsp"> <img src="imagenes/General/Logo.svg" widht="32px" height="32px" alt=""> CapitalismoWeb&trade;</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="Usuario.jsp">Identificarse</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Mi Cuenta
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="Menu_info.jsp">Lista de deseados</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="Menu_Presupuestos.jsp">Presupuestos</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="Menu_info.jsp">Carrito</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="Menu_info.jsp">Mis Compras</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="Menu_MisDatos.jsp">Mis Datos</a>
            </div>
          </li>
          <li class="nav-item">
          <%HttpSession misession = (HttpSession) request.getSession(); 
          String username_del_usuario = (String)misession.getAttribute("CW_username"); 
          if(username_del_usuario == null){username_del_usuario = "";}
          String avatar_del_usuario = "controlador_avatarImg?id=";
          String indice_avatar_del_usuario = (String)misession.getAttribute("CW_avatar"); 
          if(indice_avatar_del_usuario != null){ avatar_del_usuario+=indice_avatar_del_usuario; }else{avatar_del_usuario = "";}
          
          %>
          
            <a class="nav-link" href="Menu_MisDatos.jsp"><img src="<%=avatar_del_usuario%>" id="avatar" alt=""> <label><%=username_del_usuario%></label> </a>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="search" placeholder="Desea buscar algo?" aria-label="Search">
          <a href="ResultadoDeBusqueda.jsp" class="btn btn-primary">Buscar</a>
          <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                buscar por
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <div class="dropdown-item">
                  <input type="radio" name="tipo_de_busqueda" value="nombre"> nombre
                </div>
                <div class="dropdown-divider"></div>
                <div class="dropdown-item">
                  <input type="radio" name="tipo_de_busqueda" value="categoria"> descripción
                </div>
                <div class="dropdown-divider"></div>
                <div class="dropdown-item">
                  <select class="custom-select" id="inputGroupSelect03" >
                    <option selected>Categoria</option>
                    <option value="1">Lo más visto</option>
                    <option value="2">Lo más buscado</option>
                    <option value="3">Lo más vendido</option>
                    <option value="4">Lo mejor calificado</option>
                  </select>
                </div>
              </div>
            </li>
          </ul>
          <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                busqueda por fechas
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <div class="dropdown-item">
                  desde <br>
                  <input type="date" name="" value="">
                </div>
                <div class="dropdown-divider"></div>
                <div class="dropdown-item">
                  hasta <br>
                  <input type="date" name="" value="">
                </div>

              </div>
            </li>
          </ul>
        </form>
      </div>
    </nav>