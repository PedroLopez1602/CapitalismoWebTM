package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.oferta;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_AceptarOferta")
public class controlador_AceptarOferta extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("usuario_id");
		String articulo = request.getParameter("articulo_id");
		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		try {
			oferta objeto = new oferta();
			objeto.GetConversacion(usuario, articulo);
			objeto.AceptarOferta2();
			htmlRespone = objeto.oferta_id + " " + objeto.conversacion_id;
			response.sendRedirect("Presupuestos.jsp?articulo_id=" + articulo + "&usuario_id=" + usuario);
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		writer.println(htmlRespone); 
	}

}
