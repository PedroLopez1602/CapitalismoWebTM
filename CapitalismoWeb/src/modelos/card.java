package modelos;

import java.sql.Blob;

public class card {
	public String articulo_id;
	public String nombre;
	public String descripcion;
	Blob image1 = null;
	public byte[ ] imgData1;

	public card(String pid, String pname, String pdesc, Blob pimg) {
		articulo_id = pid;
		nombre = pname;
		descripcion = pdesc;
		image1 = pimg;
	}
	
	public void imgData(byte[] pimgData) {
		imgData1 = pimgData;
	}
}
