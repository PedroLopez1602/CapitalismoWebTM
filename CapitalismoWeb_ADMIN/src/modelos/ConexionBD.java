package modelos;
import java.sql.*;
import java.io.FileInputStream;

public class ConexionBD {

String user;
String password;
String puerto;
String database;
public String error;

	public ConexionBD() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "test";
	}

	public void subirImagen(String url) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			FileInputStream is = new FileInputStream(url);
			PreparedStatement st = connection.prepareStatement("insert into tabla values(null,?,?)");
			st.setString(1, "nombre");	
			st.setBlob(2, is);
			st.execute();
			is.close();
			st.close();
			
		} catch (Exception e) {
			error = e.toString();
		}
	}
}
