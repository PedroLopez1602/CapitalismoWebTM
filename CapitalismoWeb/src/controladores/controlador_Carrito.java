package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.carrito;

@WebServlet("/controlador_Carrito")
public class controlador_Carrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("usuario_id");
		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		
		try {
			carrito objeto = new carrito();
			objeto.GetCarrito(usuario);
			
			int i=0;
			while(i < objeto.articulo.size()) {
				htmlRespone += objeto.articulo.get(i);
				htmlRespone += "%";
				htmlRespone += objeto.oferta.get(i);
				i++;
				if(i < objeto.articulo.size()) {
					htmlRespone += "%";
				}
			}
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		
		writer.println(htmlRespone); 
	}

}
