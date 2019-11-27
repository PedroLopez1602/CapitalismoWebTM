package controladores;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.modelo_test;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15, // 15 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)


@WebServlet("/controlador_testbajada")
public class controlador_testbajada extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//obtenemos la informacion del form del jsp
		String titulo = request.getParameter("titulo");
		
		//obtenemos los datos de nuestro modelo
		modelo_test objeto = new modelo_test();
		objeto.DownloadData(titulo);
		
		//desplegamos la informacion
		response.setContentType("image/jpg");
		OutputStream o = response.getOutputStream();
		o.write(objeto.imgData);
		o.flush();
		o.close();
	}

}
