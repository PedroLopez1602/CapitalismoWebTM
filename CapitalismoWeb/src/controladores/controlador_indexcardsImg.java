package controladores;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.manejador_cardImg;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_indexcardsImg")
public class controlador_indexcardsImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		try {
			manejador_cardImg objeto = new manejador_cardImg();
			objeto.GetCardImg(id);
			
			if(objeto.cardImg_1.imgData1 != null) {
				response.setContentType("image/jpg");
				OutputStream o = response.getOutputStream();
				o.write(objeto.cardImg_1.imgData1);
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
