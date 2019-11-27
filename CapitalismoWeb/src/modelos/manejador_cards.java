package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class manejador_cards {
	public card card_1;
	public List<card> cards;
	
	private String user;
	private String password;
	private String puerto;
	private String database;
	public String error;
	
	public manejador_cards(){
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public void GetCards() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		cards = new ArrayList<card>();

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_cards()");
			while (rs.next()) {
				//el parametro es el index de la columna
				card_1 = new card(rs.getString(1), rs.getString(2), rs.getString(3), rs.getBlob(4));
				card_1.imgData(card_1.image1.getBytes(1,(int)card_1.image1.length()));
				
				cards.add(card_1);
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
