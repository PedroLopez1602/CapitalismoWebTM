package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class comentario {
	//variables de conexion
	private String user;
	private String password;
	private String puerto;
	private String database;
	public String error;
	
	public List<String> lista_id;
	public List<String> lista_usuario;
	public List<String> lista_comentario;
	public List<String> lista_fecha;
	
	public comentario() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void ReceiveComentarios(String particuloid) {
		
		lista_id = new ArrayList<String>();
		lista_usuario = new ArrayList<String>();
		lista_comentario = new ArrayList<String>();
		lista_fecha = new ArrayList<String>();
		
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("call SP_comentario('S', null, " + particuloid + ", null)");
			while (rs.next()) {
				//el parametro es el index de la columna
				lista_id.add(rs.getString(1));
				lista_usuario.add(rs.getString(2));
				lista_comentario.add(rs.getString(3));
				lista_fecha.add(rs.getString(4));
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
	
	public boolean SendComentarios(String pusuarioid, String particuloid, String pcomentario) {
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "call SP_comentario('A', " + pusuarioid + ", " + particuloid + ", '"+pcomentario+"')";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
}
