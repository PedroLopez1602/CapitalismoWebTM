package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import modelos.Producto;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)


@WebServlet("/controlador_Nuevo_Producto")
public class controlador_Nuevo_Producto extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part filePart_1 = request.getPart("img_1");
		Part filePart_2 = request.getPart("img_2");
		Part filePart_3 = request.getPart("img_3");
		Part filePart_video = request.getPart("video");
		String titulo = request.getParameter("titulo");
		String descripcion = request.getParameter("descripcion");
		String unidades = request.getParameter("unidades");
		
		//para recibir una cantidad n de categorias
		List <String> lista_categorias = new ArrayList<String>();
		String categoria = "categoria_";
		int index = 1;
		String parametro = categoria + index;
		while(request.getParameter(parametro) != null) {
			
			lista_categorias.add(request.getParameter(parametro));
			
			index++;
			parametro = categoria + index;
		}
		
		Producto objeto = new Producto();
		boolean resultado = objeto.nuevoProducto(titulo, descripcion, unidades, filePart_1, filePart_2,filePart_3, filePart_video);
		
		int i=0;
		while(i<lista_categorias.size()) {
			objeto.setCategoria(titulo, lista_categorias.get(i));
			i++;
		}
		
		PrintWriter writer = response.getWriter();
		String htmlRespone;
		if(resultado) {
			htmlRespone = "operacion exitosa";
			response.sendRedirect("inicio.jsp");
		}else {
			htmlRespone = objeto.error;
		}
		
		writer.println(htmlRespone);	     
	}

}
