package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelos.admin;

@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024 * 1,  // 1 MB
        maxFileSize         = 1024 * 1024 * 10, // 10 MB
        maxRequestSize      = 1024 * 1024 * 15, // 15 MB
        location            = "C:\\"
)
@WebServlet("/controlador_index")
public class controlador_index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		String error = "";
		admin A = new admin();
		PrintWriter writer = response.getWriter();
		String htmlRespone = "";
		String R = "";
		try {
			R = A.login(user, pass);
			if(R.equals("1")){
				response.sendRedirect("inicio.jsp");
			}else {
				htmlRespone = "<h1>" + "Credenciales invalidas" + "</h1>";
			}
		}catch(Exception e){
			error = e.toString();
			htmlRespone = "<h1>" + error + "</h1>";
		}
		
		writer.println(htmlRespone);	    
	}

}
