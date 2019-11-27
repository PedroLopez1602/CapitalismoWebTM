package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.Producto;

/**
 * Servlet implementation class controlador_publicarArticulo
 */
@WebServlet("/controlador_publicarArticulo")
public class controlador_publicarArticulo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		Producto objeto = new Producto();
		boolean resultado = objeto.Publicar_Articulo(Integer.parseInt(id));
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		if(resultado) {
			htmlRespone = "operacion exitosa";
			response.sendRedirect("inicio.jsp");
		}else {
			htmlRespone = "operacion fallida";
		}
		writer.println(htmlRespone);
	}

}
