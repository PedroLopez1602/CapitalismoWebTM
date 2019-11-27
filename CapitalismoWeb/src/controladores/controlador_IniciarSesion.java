package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import modelos.Usuario;


@WebServlet("/controlador_IniciarSesion")
public class controlador_IniciarSesion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String usuario = request.getParameter("username_email");
		String password = request.getParameter("password");
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		
		try {
			Usuario objeto = new Usuario();
			objeto.Revisar_credendiales(usuario, password);
			
			if(objeto.crendenciales.equals("ninguna cuenta que coincida con estas credenciales")) {
				response.sendRedirect("Usuario.jsp");
				htmlRespone = "<h1>error</h1>";
			}else {
				objeto.GetUsuario2(usuario, password);
				HttpSession misession= request.getSession(true);
				misession.setAttribute("CW_username", objeto.username);
				misession.setAttribute("CW_avatar",objeto.usuario_id);
				htmlRespone = objeto.crendenciales;
				response.sendRedirect("index.jsp");
			}
			
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		writer.println(htmlRespone); 
	}

}