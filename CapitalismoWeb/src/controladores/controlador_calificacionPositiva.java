package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.calificacion;

@WebServlet("/controlador_calificacionPositiva")
public class controlador_calificacionPositiva extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String articulo = request.getParameter("articulo_id");
		String usuario = request.getParameter("usuario_id");
		String htmlRespone;
		
		calificacion objeto = new calificacion();
		boolean resultado = objeto.MeGusta(usuario, articulo);
		if(resultado) {
			response.sendRedirect("producto.jsp?id=" + articulo);
		}else {
			htmlRespone = "ocurrio un problema";
		}
		
		PrintWriter writer = response.getWriter();
		htmlRespone = articulo + " " + usuario;
		writer.println(htmlRespone); 
		
	}
}
