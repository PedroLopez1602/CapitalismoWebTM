package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.categoria;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_CategoriaAgregar")
public class controlador_CategoriaAgregar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String CategoriaNombre = request.getParameter("nuevaCategoria");
		categoria objeto = new categoria();
		boolean resultado = objeto.AddCategoria(CategoriaNombre);
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		if(resultado) {
			htmlRespone = "operacion exitosa";
			response.sendRedirect("inicio.jsp");
		}else {
			htmlRespone = objeto.error;
		}
		writer.println(htmlRespone);   
		
	}
}
