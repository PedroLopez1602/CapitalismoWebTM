package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class manejador_cardImg {
	public cardImg cardImg_1;
	
	private String user;
	private String password;
	private String puerto;
	private String database;
	public String error;
	
	public manejador_cardImg(){
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void GetCardImg(String pid) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_cardImg(" + pid + ")");
			if (rs.next()) {
				//el parametro es el index de la columna
				cardImg_1 = new cardImg(rs.getBlob(1));
				cardImg_1.imgData(cardImg_1.image1.getBytes(1,(int)cardImg_1.image1.length()));
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
