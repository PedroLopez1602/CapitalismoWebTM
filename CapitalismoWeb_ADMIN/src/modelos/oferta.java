package modelos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class oferta {
	//variables de conexion
		private String user;
		private String password;
		private String puerto;
		private String database;
		
		public String conversacion_id;
		public String contenido;
		public String error;
		
		public String oferta_id;
		public String cantidad;
		public String aceptado;
		public String enviadoPorCliene;
		
		public oferta() {
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

		public boolean SendOferta(String pcontenido, String pconversacion_id) {
			contenido = pcontenido;
			conversacion_id = pconversacion_id;
			
			try {
				//creamos la conexion
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
				
				//insertamos los datos en mysql
				String query = "CALL SP_oferta('A', NULL, " + pcontenido + ", " + conversacion_id + ", 0)";
				PreparedStatement st = connection.prepareStatement(query);
				st.execute();
				st.close();
				return true;
				
			} catch (Exception e) {
				error = e.toString();
				return false;
			}
		}
		
		public void ReceiveOferta(String pconversacion_id) {
			conversacion_id = pconversacion_id;
			
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			try {
			
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
				stmt = con.createStatement();
				rs = stmt.executeQuery("CALL SP_oferta('S', NULL, 100, " + conversacion_id + ", 0)");
				while (rs.next()) {
					//el parametro es el index de la columna
					oferta_id = rs.getString(1);
					cantidad = rs.getString(2);
					aceptado = rs.getString(3);
					enviadoPorCliene = rs.getString(4);
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

		private void getOfertaId() {
			
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;
			
			try {
			
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
				stmt = con.createStatement();
				rs = stmt.executeQuery("CALL SP_oferta('S', null, null, " + conversacion_id + ", null)");
				if (rs.next()) {
					//el parametro es el index de la columna
					oferta_id = rs.getString(1);
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
		
		public boolean AceptarOferta() {
			
			getOfertaId();
			
			try {
				//creamos la conexion
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
				
				//insertamos los datos en mysql
				String query = "CALL SP_oferta('C', " + oferta_id + ", null, null, null);";
				PreparedStatement st = connection.prepareStatement(query);
				st.execute();
				st.close();
				return true;
				
			} catch (Exception e) {
				error = e.toString();
				return false;
			}
		}
		
		public boolean AceptarOferta2() {
			
			getOfertaId();
			
			try {
				//creamos la conexion
				Class.forName("com.mysql.jdbc.Driver");
				Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
				
				//insertamos los datos en mysql
				String query = "CALL SP_oferta('V', " + oferta_id + ", null, null, null);";
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