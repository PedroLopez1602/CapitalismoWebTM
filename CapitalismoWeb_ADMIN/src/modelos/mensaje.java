package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class mensaje {
	//variables de conexion
	private String user;
	private String password;
	private String puerto;
	private String database;
	
	public String conversacion_id;
	public String contenido;
	public String error;
	
	public List<String> lista_mensajes;
	public List<Integer> lista_enviadoporcliente;
	
	public mensaje() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void GetConversacion(String p_usuarioid, String p_articuloid) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_Administrador_Conversa_Usuario('S', " + p_usuarioid + ", " + p_articuloid + ")");
			if (rs.next()) {
				//el parametro es el index de la columna
				conversacion_id = rs.getString(1);
			} else {
				rs.close();
				rs = stmt.executeQuery("CALL SP_Administrador_Conversa_Usuario('A', " + p_usuarioid + ", " + p_articuloid + ")");
				rs.close();
				rs = stmt.executeQuery("CALL SP_Administrador_Conversa_Usuario('S', " + p_usuarioid + ", " + p_articuloid + ")");
				if (rs.next()) {
					//el parametro es el index de la columna
					conversacion_id = rs.getString(1);
				}
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

	public boolean SendMensaje(String pcontenido, String pconversacion_id) {
		contenido = pcontenido;
		conversacion_id = pconversacion_id;
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_mensaje('A', '" + contenido + "', '" + conversacion_id +"', 0)";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public void ReceiveMensaje(String pconversacion_id) {
		conversacion_id = pconversacion_id;
		
		lista_mensajes = new ArrayList<String>();
		lista_enviadoporcliente = new ArrayList<Integer>();
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_mensaje('S', null, " + conversacion_id + ", 0);");
			while (rs.next()) {
				//el parametro es el index de la columna
				lista_mensajes.add(rs.getString(1));
				lista_enviadoporcliente.add(rs.getInt(2));
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