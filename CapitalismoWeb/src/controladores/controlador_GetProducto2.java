package controladores;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.Producto;

@WebServlet("/controlador_GetProducto2")
public class controlador_GetProducto2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String text = null;
		
		try {
			if(true) {
				Producto objeto = new Producto();
				objeto.GetProducto(Integer.parseInt(id));
				text = objeto.titulo;
				text += "%";
				text += objeto.descr;
				text += "%";
				text += objeto.unidades;
				text += "%";
				text += objeto.calificacion;
				text += "%";
				text += objeto.borrador;
				try {
					objeto.GetCategoria(Integer.parseInt(id));
					if(objeto.sizeCategorias != 0) {
						text += "%";
						text += objeto.sizeCategorias;
						int i=0;
						while(i < objeto.sizeCategorias) {
							text += "%";
							text += objeto.categorias[i];
							i++;
						}
					}
				}catch(Exception e) {
					text += e.toString();
				}
				
				
			}
			}catch(Exception e) {
				text = e.toString();
			}
			response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(text);
	}
}
