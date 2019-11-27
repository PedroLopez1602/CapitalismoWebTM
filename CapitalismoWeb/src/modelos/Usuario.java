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

public class Usuario {
	private String user;
	private String password;
	private String puerto;
	private String database;
	
	public String nombre;
	public String apellido; 
	public String correo; 
	public String username; 
	public String userpassword;
	public String telefono; 
	public String direccion; 
	public Part avatar;
	public String usuario_id;
	
	public String error;
	public String disponibilidad;
	public String crendenciales;
	
	Blob image1 = null;
	public byte[ ] imgData1;
	
	public Usuario(){
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public boolean nuevoUsuario(String pnombre, String papellido, String pcorreo, String pusername, String ppassword, String ptelefono, String pdireccion, Part pavatar) {
		nombre = pnombre;
		apellido = papellido;
		correo = pcorreo;
		username = pusername;
		userpassword = ppassword;
		telefono = ptelefono;
		direccion = pdireccion;
		avatar = pavatar;
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_USUARIO('A', NULL, '" + nombre +"', '" + apellido + "', '" + correo + "', '" + username + "', '" + userpassword + "', '" + telefono + "', '" + direccion +"', ?)";
			PreparedStatement st = connection.prepareStatement(query);
			InputStream inputStream_1 = avatar.getInputStream();
			st.setBlob(1, inputStream_1);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public void Revisar_disponibilidad(String pcorreo, String pusername) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		correo = pcorreo;
		username = pusername;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_usuario_unico('" + correo + "','" + username + "')");
			if (rs.next()) {
				//el parametro es el index de la columna
				disponibilidad = rs.getString(1);
			} else {
				error = "Error inesperado ocurrio";
			}
		} catch (Exception e) {
			error = e.toString();
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				error = e.toString();
			}
		}
	}

	public void Revisar_credendiales(String puser, String ppassword) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_login_Usuario('" + puser + "','" + ppassword + "')");
			if (rs.next()) {
				//el parametro es el index de la columna
				crendenciales = rs.getString(1);
			} else {
				error = "Error inesperado ocurrio";
			}
		} catch (Exception e) {
			error = e.toString();
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				error = e.toString();
			}
		}
	}

	public void GetUsuario(String pid) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_avatarusuario(" + pid + ")");
			if (rs.next()) {
				//el parametro es el index de la columna
				image1 = rs.getBlob(1); 
				imgData1 = image1.getBytes(1,(int)image1.length());
			} else {
				error = "Error inesperado ocurrio";
			}
		} catch (Exception e) {
			error = e.toString();
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				error = e.toString();
			}
		}
	}

	public byte[] getImgData(int index) {
		switch (index) {
		  case 1:
		    return imgData1;
		  
		  default:
		    return null;
		  
		}
	}

	public void GetUsuario2(String puser, String ppass) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_getUsuario('" +puser + "', '" + ppass + "')");
			if (rs.next()) {
				//el parametro es el index de la columna
				usuario_id = rs.getString(1);
				username = rs.getString(2);
			} else {
				error = "Error inesperado ocurrio";
			}
		} catch (Exception e) {
			error = e.toString();
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				error = e.toString();
			}
		}
	}
	
}
