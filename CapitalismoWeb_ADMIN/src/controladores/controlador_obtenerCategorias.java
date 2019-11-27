package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.categoria;

@WebServlet("/controlador_obtenerCategorias")
public class controlador_obtenerCategorias extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String text = "";
		
		try {
		categoria objeto = new categoria();
		objeto.GetCategorias();
		if(objeto.sizeCategorias > 0) {
			text = objeto.categorias[0];

			int i=1;
			while(i != objeto.sizeCategorias) {
				text += "%";
				text += objeto.categorias[i];
				i++;
			}
		}
		}catch(Exception e) {
			text = "error en servlet";
		}
		response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(text);    // Write response body.
	}

}
