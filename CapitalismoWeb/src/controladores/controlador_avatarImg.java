package controladores;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.Usuario;

/**
 * Servlet implementation class controlador_avatarImg
 */
@WebServlet("/controlador_avatarImg")
public class controlador_avatarImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String indice = "1";
	
		try {
			Usuario objeto = new Usuario();
			objeto.GetUsuario(id);
			
			if(objeto.getImgData(Integer.parseInt(indice)) != null) {
				response.setContentType("image/jpg");
				OutputStream o = response.getOutputStream();
				o.write(objeto.getImgData(Integer.parseInt(indice)));
				o.flush();
				o.close();	
			}
			else {
				PrintWriter writer = response.getWriter();
				String htmlRespone;
				htmlRespone = "woopsi doopsi no encontramos ninguna imagen asociada a este id de producto meperd0nas¿";
				writer.println(htmlRespone);
			}
		}catch(Exception e) {
			PrintWriter writer = response.getWriter();
			String htmlRespone;
			htmlRespone = e.toString();
			writer.println(htmlRespone);
		}
	}

	

}
