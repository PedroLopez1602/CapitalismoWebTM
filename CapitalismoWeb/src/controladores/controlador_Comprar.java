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

import modelos.compra;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 16,  // 1 MB
        maxFileSize         = 1024 * 1024 * 16, // 16 MB
        maxRequestSize      = 1024 * 1024 * 16 * 4, // 16 MB
        location            = "C:\\Users\\Pedro Lopez\\Desktop"
)

@WebServlet("/controlador_Comprar")
public class controlador_Comprar extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String num_rows = request.getParameter("num_rows");
		String usuario_id = request.getParameter("usuario_id");
		String metodo_pago = request.getParameter("metodo_pago");
		Integer total=0;
		
		PrintWriter writer = response.getWriter();
		List<String> list = new ArrayList<String>();
		
		String parametro = "body_row_00td_1";
		int i= 0; int j = 1;
		
		while(i < Integer.parseInt(num_rows)) {
			parametro = "body_row_0" + i + "td_" + j;
			
			if(request.getParameter(parametro) != null) {
				j++;
				while(j < 5) {
					parametro = "body_row_0" + i + "td_" + j;
					list.add(request.getParameter(parametro));
					j++;
				}
			}
			j = 1;
			i++;
		}
		
	
		i=2;
		
		try {
			while(i < list.size()) {
				
				total = total + (Integer.parseInt(list.get(i)) * Integer.parseInt(list.get(i-1)));
				i++;
				i++;
				i++;
			}
		}catch(NumberFormatException e) {
			writer.println(e.toString());
		}
		
		//writer.println(total); 
		boolean resultado;
		int k = 0;
		while(k < list.size()) {
			/*writer.println(usuario_id);
			writer.println(list.get(k));
			writer.println( list.get(k+2));
			writer.println(list.get(k+1));
			writer.println(total.toString());
			writer.println(metodo_pago);*/
			
			compra objeto = new compra();
			resultado = objeto.nuevaCompra(usuario_id, list.get(k), list.get(k+2), list.get(k+1), total.toString(), metodo_pago);
			
			if(resultado) {
				writer.println("exito");
			}else {
				writer.println("fracaso");
			}
			k++;
			k++;
			k++;
		}	
		response.sendRedirect("Menu_info.jsp");
	}
}
