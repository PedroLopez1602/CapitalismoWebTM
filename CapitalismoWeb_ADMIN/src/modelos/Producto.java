package modelos;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

public class Producto {
	//variables de conexion
	private String user;
	private String password;
	private String puerto;
	private String database;
	
	public String [] productos = null;
	public String error;
	public int sizeProductos;
	
	public String titulo;
	public String descr;
	public String unidades;
	private Part imagen_1;
	private Part imagen_2;
	private Part imagen_3;
	private Part video;
	
	public int producto_id;
	Blob image1 = null;
	public byte[ ] imgData1;
	Blob image2 = null;
	public byte[ ] imgData2;
	Blob image3 = null;
	public byte[ ] imgData3;
	Blob download_video = null;
	public byte[ ] videoData;
	
	public String calificacion;
	public String borrador;
	
	public int sizeCategorias;
	public String [] categorias = null;
	
	public List<String> lista_productos;
	public List<Integer> lista_productos_id;
	
 	public Producto() {
		user = "root";
		password = "";
		puerto = "3307";
		database = "CapitalismoWebDB";
	}
	
	public boolean nuevoProducto(String p_titulo, String p_descr, String p_unidades, Part p_imagen1, Part p_imagen2, Part p_imagen3, Part p_video) {
		titulo = p_titulo;
		descr = p_descr;
		unidades = p_unidades;
		imagen_1 = p_imagen1;
		imagen_2 = p_imagen2;
		imagen_3 = p_imagen3;
		video = p_video;
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_ARTICULO('A', NULL, '" + titulo + "', '" + descr + "', "+ unidades +", ?, ?, ?, ?, 100, 0)";
			PreparedStatement st = connection.prepareStatement(query);
			InputStream inputStream_1 = imagen_1.getInputStream();
			InputStream inputStream_2 = imagen_2.getInputStream();
			InputStream inputStream_3 = imagen_3.getInputStream();
			InputStream inputStream_video = video.getInputStream();	
			st.setBlob(1, inputStream_1);
			st.setBlob(2, inputStream_2);
			st.setBlob(3, inputStream_3);
			st.setBlob(4, inputStream_video);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public void GetProducto(int id) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String opcion = "S";

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_ARTICULO('" + opcion + "', " + id + ", null, null, null, null, null, null, null, null, null)");
			if (rs.next()) {
				//el parametro es el index de la columna
				producto_id = rs.getInt(1);
				titulo = rs.getString(2);
				descr = rs.getString(3);
				unidades = rs.getString(4);
				image1 = rs.getBlob(5); 
				imgData1 = image1.getBytes(1,(int)image1.length());
				image2 = rs.getBlob(6); 
				imgData2 = image2.getBytes(1,(int)image2.length());
				image3 = rs.getBlob(7); 
				imgData3 = image3.getBytes(1,(int)image3.length());
				download_video = rs.getBlob(8); 
				videoData = download_video.getBytes(1,(int)download_video.length());
				calificacion = rs.getString(9);
				borrador = rs.getString(10);
				
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
		  case 2:
			return imgData2;
		  case 3:
			return imgData3;
		  case 4:
			return videoData;
		  default:
		    return null;
		  
		}
	}
	
	public boolean setCategoria(String p_titulo, String p_categoria) {
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_CategoriaProducto('A', GetArticulo_Id('" + p_titulo + "'), GetCategoria_Id('" + p_categoria +"'))";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public boolean unsetCategoria(String p_titulo) {
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_CategoriaProducto('B', GetArticulo_Id('" + p_titulo + "'), null)";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}

	public void GetCategoria(int id) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		sizeCategorias = 0;

		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_size_productocategoria2(" + id + ")");
			if (rs.next()) {
				//el parametro es el index de la columna
				sizeCategorias = rs.getInt(1);
				categorias = new String[sizeCategorias];
			} else {
				error = "Error inesperado ocurrio";
			}
			rs.close();
			rs = stmt.executeQuery("CALL SP_CategoriaProducto2(" + id + ")");
			int i=0;
			while (rs.next()) {
				categorias[i] = rs.getString(1);
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
	
	public void Articulos_en_borrador() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		lista_productos = new ArrayList<String>();
		lista_productos_id = new ArrayList<Integer>();
		
		try {
		
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			stmt = con.createStatement();
			rs = stmt.executeQuery("CALL SP_listaBorrador()");
			while (rs.next()) {
				//el parametro es el index de la columna
				lista_productos_id.add(rs.getInt(1));
				lista_productos.add(rs.getString(2));
				
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
	
	public boolean Publicar_Articulo(int pid) {
		producto_id = pid;
				
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_publicar(" + producto_id + ")";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}

	public boolean Eliminar_Articulo(int pid) {
		producto_id = pid;
				
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_ARTICULO('B', " + producto_id + ", null, null, null, null, null, null, null, null, null)";
			PreparedStatement st = connection.prepareStatement(query);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
	
	public boolean modificarProducto(String p_id, String p_titulo, String p_descr, String p_unidades, Part p_imagen1, Part p_imagen2, Part p_imagen3, Part p_video) {
		titulo = p_titulo;
		descr = p_descr;
		unidades = p_unidades;
		imagen_1 = p_imagen1;
		imagen_2 = p_imagen2;
		imagen_3 = p_imagen3;
		video = p_video;
		
		try {
			//creamos la conexion
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:"+puerto+"/"+database+"?useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", user, password);
			
			//insertamos los datos en mysql
			String query = "CALL SP_ARTICULO('C', " + p_id + ", '" + titulo + "', '" + descr + "', "+ unidades +", ?, ?, ?, ?, 100, 1)";
			PreparedStatement st = connection.prepareStatement(query);
			InputStream inputStream_1 = imagen_1.getInputStream();
			InputStream inputStream_2 = imagen_2.getInputStream();
			InputStream inputStream_3 = imagen_3.getInputStream();
			InputStream inputStream_video = video.getInputStream();	
			st.setBlob(1, inputStream_1);
			st.setBlob(2, inputStream_2);
			st.setBlob(3, inputStream_3);
			st.setBlob(4, inputStream_video);
			st.execute();
			st.close();
			return true;
			
		} catch (Exception e) {
			error = e.toString();
			return false;
		}
	}
}
