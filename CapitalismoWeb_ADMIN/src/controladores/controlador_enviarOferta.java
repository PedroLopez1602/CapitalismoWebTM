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
@WebServlet("/controlador_enviarOferta")
public class controlador_enviarOferta extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oferta = request.getParameter("oferta");
		String usuario = request.getParameter("usuario_id");
		String articulo = request.getParameter("articulo_id");
		
		PrintWriter writer = response.getWriter();
		String htmlRespone = oferta + "%" + usuario + "%" + articulo + "%";
		
		oferta objeto = new oferta();
		objeto.GetConversacion(usuario, articulo);
		
		htmlRespone += objeto.conversacion_id;
		
		try {
			boolean respuesta = objeto.SendOferta(oferta, objeto.conversacion_id);
			if(respuesta) {
				htmlRespone = "";
				response.sendRedirect("Presupuestos.jsp?articulo_id=" + articulo + "&usuario_id=" + usuario);
			}else {
				htmlRespone = "Ocurrio un problema al momento de mandar el mensaje";
			}
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		writer.println(htmlRespone); 
	}
}

