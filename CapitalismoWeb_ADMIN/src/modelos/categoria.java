package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class categoria {
	//variables de conexion
	private String user;
	private String password;
	private String puerto;
	private String database;
	
	public String [] categorias = null;
	public String error;
	public int sizeCategorias;
	public String Categoria_Name;

	public categoria() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void GetCategorias() {
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String opcion = "Z";

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_Categoria('" + opcion + "', null, null)");
			if (rs.next()) {
				sizeCategorias = rs.getInt(1);
				if(sizeCategorias > 0) {
					categorias = new String[sizeCategorias];
				}
			} else {
				error = "Error inesperado ocurrio";
			}
			
			rs.close();
			rs = stmt.executeQuery("CALL SP_Categoria(" + "'S'" + ", null, null)");
			int i=0;
			while (rs.next()) {
				categorias[i] = rs.getString("A_Categoria");
				i++;
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
	
	public boolean AddCategoria(String pCategoria_Name) {
		Categoria_Name = pCategoria_Name;
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_Categoria('A', '" + Categoria_Name + "', null)";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}

	public boolean DelCategoria(String pCategoria_Name) {
		Categoria_Name = pCategoria_Name;
				
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_Categoria('B', '" + Categoria_Name + "', null);";
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
