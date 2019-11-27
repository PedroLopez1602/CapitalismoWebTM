package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.comentario;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_comentarioEnviar")
public class controlador_comentarioEnviar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String articulo = request.getParameter("articulo_id");
		String usuario = request.getParameter("usuario_id");
		String comentario = request.getParameter("comentario");
		String htmlRespone;
		
		comentario objeto = new comentario();
		boolean resultado = objeto.SendComentarios(usuario, articulo, comentario);
		
		if(resultado) {
			htmlRespone = "exito";
			response.sendRedirect("producto.jsp?id=" + articulo);
		}else {
			htmlRespone = "fracaso";
		}
		
		PrintWriter writer = response.getWriter();
		writer.println(htmlRespone); 
		
	}

}
