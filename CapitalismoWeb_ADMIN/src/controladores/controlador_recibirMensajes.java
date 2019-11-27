package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.mensaje;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_recibirMensajes")
public class controlador_recibirMensajes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("usuario_id");
		String articulo = request.getParameter("articulo_id");
		
		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		
		try {
			mensaje objeto = new mensaje();
			objeto.GetConversacion(usuario, articulo);
			objeto.ReceiveMensaje(objeto.conversacion_id);
			int i=0;
			while(i < objeto.lista_mensajes.size()) {
				htmlRespone += objeto.lista_mensajes.get(i);
				htmlRespone += "%";
				htmlRespone += objeto.lista_enviadoporcliente.get(i);
				i++;
				if(i < objeto.lista_mensajes.size()) {
					htmlRespone += "%";
				}
			}
			
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		
		writer.println(htmlRespone); 
	}

}
