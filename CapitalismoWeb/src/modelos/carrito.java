package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class carrito {
	
	public List<String> articulo;
	public List<String> oferta;
	
	private String user;
	private String password;
	private String puerto;
	private String database;
	public String error;

	public carrito() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void GetCarrito(String pusuario_id) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		articulo = new ArrayList<String>();
		oferta = new ArrayList<String>();
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_CarritoUsuario(" + pusuario_id + ");");
			while (rs.next()) {
				//el parametro es el index de la columna
				articulo.add(rs.getString(1));
				oferta.add(rs.getString(2));
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
