package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.Producto;


@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,
        maxFileSize         = 1024 * 1024 * 16,
        maxRequestSize      = 1024 * 1024 * 16 * 4,
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_AdminTable")
public class controlador_AdminTable extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String text = null;
		Producto objeto = new Producto();
		
		try {
			
			objeto.Articulos_en_borrador();
			int i=0;
			
			if(i < objeto.lista_productos.size()) {
				text = objeto.lista_productos_id.get(i).toString();
				text += "%";
				text += objeto.lista_productos.get(i);
				i++;
				if(i < objeto.lista_productos.size()) {
					text += "%";
				}				
			}
			while(i < objeto.lista_productos.size()) {
				text += objeto.lista_productos_id.get(i).toString();
				text += "%";
				text += objeto.lista_productos.get(i);
				i++;
				if(i < objeto.lista_productos.size()) {
					text += "%";
				}	
			}
			
		}catch(Exception e) {
			text = e.toString();
		}
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		htmlRespone = text;
		writer.println(htmlRespone); 
		
		/*response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(text);*/    // Write response body.
	}

}
