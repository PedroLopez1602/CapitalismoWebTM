package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.comentario;

@WebServlet("/controlador_comentario")
public class controlador_comentario extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String articulo = request.getParameter("articulo_id");
		comentario objeto = new comentario();
		objeto.ReceiveComentarios(articulo);
		
		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		
		int i = 0;
		while(i < objeto.lista_id.size()) {
			htmlRespone += objeto.lista_id.get(i);
			htmlRespone += "%";
			htmlRespone += objeto.lista_usuario.get(i);
			htmlRespone += "%";
			htmlRespone += objeto.lista_comentario.get(i);
			htmlRespone += "%";
			htmlRespone += objeto.lista_fecha.get(i);
			i++;
			if(i < objeto.lista_id.size()) {
				htmlRespone += "%";
			}
		}
		
		writer.println(htmlRespone); 
	}
}
