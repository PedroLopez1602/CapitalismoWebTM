package controladores;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelos.manejador_cards;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_indexcards")
public class controlador_indexcards extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		
		try {
			manejador_cards objeto = new manejador_cards();
			objeto.GetCards();
			
			if(objeto.error == null) {
				int i=0;
				while(i < objeto.cards.size()) {
					htmlRespone += objeto.cards.get(i).articulo_id + "%" + objeto.cards.get(i).nombre + "%" + objeto.cards.get(i).descripcion;
					i++;
					if(i < objeto.cards.size()) {
						htmlRespone += "%";
					}
				}
			}else {
				htmlRespone = objeto.error;
			} 
		}catch(Exception e) {
			htmlRespone = e.toString();
		}
		writer.println(htmlRespone); 
	}

}
