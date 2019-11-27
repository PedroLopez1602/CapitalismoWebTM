package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class compra {
	//variables de conexion
	private String user;
	private String password;
	private String puerto;
	private String database;
	public String error;
	
	public List<String> lista_nombre;
	public List<String> lista_metodopago;
	public List<String> lista_fecha;
	public List<String> lista_precioUnitario;
	public List<String> lista_cantidad;
	
	public compra() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public boolean nuevaCompra(String usuario_id, String nombre_articulo, String poferta, String cantidad, String total, String MetodoDePago) {
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "call SP_compra('A', " + usuario_id + ", GetArticulo_Id('" + nombre_articulo +"'), "+poferta+", "+cantidad+", "+total+", '"+MetodoDePago+"');";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public void buscarCompras(String usuario_id) {
		
		lista_nombre = new ArrayList<String>();
		lista_metodopago = new ArrayList<String>();
		lista_fecha = new ArrayList<String>();
		lista_precioUnitario = new ArrayList<String>();
		lista_cantidad = new ArrayList<String>();
		
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("call SP_compra('S', " + usuario_id + ", NULL, NULL, NULL, NULL, NULL)");
			while (rs.next()) {
				//el parametro es el index de la columna
				lista_nombre.add(rs.getString(1));	
				lista_metodopago.add(rs.getString(2));
				lista_fecha.add(rs.getString(3));
				lista_precioUnitario.add(rs.getString(4));
				lista_cantidad.add(rs.getString(5));
				
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
