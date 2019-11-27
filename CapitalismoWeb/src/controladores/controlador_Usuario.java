package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import modelos.Usuario;


@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_Usuario")
public class controlador_Usuario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String correo = request.getParameter("correo");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String telefono = request.getParameter("telefono");
		String direccion = request.getParameter("direccion");
		Part avatar = request.getPart("avatar");
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		
		try {
			Usuario objeto = new Usuario();
			objeto.Revisar_disponibilidad(correo, username);
			
			if(objeto.disponibilidad.equals("daijobu")) {
				boolean resultado = objeto.nuevoUsuario(nombre, apellido, correo, username, password, telefono, direccion, avatar);
				if(resultado) {
					htmlRespone = "operacion exitosa";
				}else {
					htmlRespone = objeto.error;
				}
			}else {
				htmlRespone = objeto.disponibilidad;
			}
			
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		writer.println(htmlRespone); 
	}

}
