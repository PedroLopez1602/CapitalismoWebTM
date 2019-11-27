package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.compra;

@WebServlet("/controlador_VerCompras")
public class controlador_VerCompras extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario_id = request.getParameter("usuario_id");
		
		compra objeto = new compra();
		objeto.buscarCompras(usuario_id);
		PrintWriter writer = response.getWriter();
		String htmlRespone="";
		
		int index = 0;
		while(index < objeto.lista_cantidad.size()) {
			htmlRespone += objeto.lista_nombre.get(index);
			htmlRespone += "%";
			htmlRespone += objeto.lista_metodopago.get(index);
			htmlRespone += "%";
			htmlRespone += objeto.lista_fecha.get(index);
			htmlRespone += "%";
			htmlRespone += objeto.lista_precioUnitario.get(index);
			htmlRespone += "%";
			htmlRespone += objeto.lista_cantidad.get(index);
			index++;
			if(index < objeto.lista_cantidad.size()) {
				htmlRespone += "%";
			}
		}
		writer.println(htmlRespone);
	}
}
