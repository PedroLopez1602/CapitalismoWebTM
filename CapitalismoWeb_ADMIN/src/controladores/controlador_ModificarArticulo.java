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



@WebServlet("/controlador_ModificarArticulo")
public class controlador_ModificarArticulo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		String htmlRespone;


		//los check regresan null si no estan activos
		String id = request.getParameter("id");
		String titulo = request.getParameter("titulo");
		String descripcion = request.getParameter("descripcion");
		String unidades = request.getParameter("unidades");
		String checkImg1 = request.getParameter("img_1_check");
		Part filePart_1;
		if(checkImg1 != null) {
			filePart_1 = request.getPart("img_1");
		}else {
			filePart_1 = null;
		}
		String checkImg2 = request.getParameter("img_2_check");
		Part filePart_2;
		if(checkImg2 != null) {
			filePart_2 = request.getPart("img_2");
		}else {
			filePart_2 = null;
		}
		String checkImg3 = request.getParameter("img_3_check");
		Part filePart_3;
		if(checkImg3 != null) {
			filePart_3 = request.getPart("img_3");
		}else {
			filePart_3 = null;
		}
		String checkvideo = request.getParameter("video_check");
		Part video;
		if(checkvideo != null) {
			video = request.getPart("video");
		}else {
			video = null;
		}
		
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
		boolean respuesta = objeto.modificarProducto(id, titulo, descripcion, unidades, filePart_1, filePart_2,filePart_3, video);
		objeto.unsetCategoria(titulo);
		int i=0;
		while(i<lista_categorias.size()) {
			objeto.setCategoria(titulo, lista_categorias.get(i));
			i++;
		}
		if(respuesta) {
			htmlRespone = "operacion exitosa";
			response.sendRedirect("inicio.jsp");
		}else {
			htmlRespone = objeto.error;
		}
		writer.println(htmlRespone);
		
		//Part filePart_1 = request.getPart("img_1");
		//Part filePart_2 = request.getPart("img_2");
		//Part filePart_3 = request.getPart("img_3");
		//Part filePart_video = request.getPart("video");
		
		
		
	}

}
