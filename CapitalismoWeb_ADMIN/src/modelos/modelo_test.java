package modelos;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.Part;

public class modelo_test {
	
	private String user;
	private String password;
	private String puerto;
	private String database;
	
	private Part imagen;
	private String nombre;
	
	public byte[ ] imgData;
	
	public modelo_test(Part p_imagen, String p_nombre) {
		imagen = p_imagen;
		nombre = p_nombre;
		
		user = "root";
		password = "";
		puerto = "3307";
		database = "test";
	}
	
	public modelo_test() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "test";
	}
	
	public boolean UploadData() {
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			PreparedStatement st = connection.prepareStatement("insert into tabla values(null,?,?)");
			InputStream inputStream = imagen.getInputStream();
			st.setString(1, nombre);	
			st.setBlob(2, inputStream);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			return false;
		}
	}
	
	public void DownloadData(String ptitulo) {
		Blob image = null;
		Connection con = null;
		
		Statement stmt = null;
		ResultSet rs = null;

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("select image from tabla where id = " + ptitulo);
			if (rs.next()) {
				image = rs.getBlob(1);
				imgData = image.getBytes(1,(int)image.length());
			} else {
				System.out.println("Display Blob Example");
				System.out.println("image not found for given id>");
				return;
			}
			
			
		} catch (Exception e) {
			System.out.println("Unable To Display image");
			System.out.println("Image Display Error=" + e.getMessage());
			return;
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
