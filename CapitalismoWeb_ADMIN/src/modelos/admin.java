package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class admin {

	private String user;
	private String password;
	private String puerto;
	private String database;
	private Connection con;
	private Statement stmt;
	private ResultSet rs;
	public String bandera;
	
	public admin() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public String login(String puser, String ppass) {
		
		String valorRetorno = "0";
		con = null;
		stmt = null;
		rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			bandera = "CALL SP_ADMIN('" + puser + "','" + ppass + "')";
			rs = stmt.executeQuery("CALL SP_ADMIN('" + puser + "','" + ppass + "')");
			if (rs.next()) {
				
				valorRetorno = rs.getString(1);
				bandera = valorRetorno;
				
			}	
		} catch (Exception e) {
			System.out.println(e.getMessage());
			bandera = e.toString();
		} finally {
			try {
				//rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return valorRetorno;
	}
}
