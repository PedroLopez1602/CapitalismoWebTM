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

import modelos.modelo_test;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15, // 15 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_test")
public class controlador_test extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public controlador_test() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Part filePart = request.getPart("image");
		String titulo = request.getParameter("titulo");
		modelo_test objeto = new modelo_test(filePart, titulo);
		boolean resultado = objeto.UploadData();
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		
		if(resultado) {
			htmlRespone = "<h1>" + "Operacion exitosa" + "</h1>";
		}else {
			htmlRespone = "<h1>" + "Operacion fallida" + "</h1>";
		}
		writer.println(htmlRespone);    
		
	}

}
