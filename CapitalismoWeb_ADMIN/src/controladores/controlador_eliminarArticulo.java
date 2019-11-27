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
 * Servlet implementation class controlador_eliminarArticulo
 */
@WebServlet("/controlador_eliminarArticulo")
public class controlador_eliminarArticulo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		Producto objeto = new Producto();
		try {
			boolean resultado = objeto.Eliminar_Articulo(Integer.parseInt(id));
		
			if(resultado) {
				htmlRespone = "operacion exitosa";
				response.sendRedirect("inicio.jsp");
			}else {
				htmlRespone = objeto.error;
			}
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		htmlRespone += "<a href='inicio.jsp'>inicio</a>";
		writer.println(htmlRespone);
	}

}
