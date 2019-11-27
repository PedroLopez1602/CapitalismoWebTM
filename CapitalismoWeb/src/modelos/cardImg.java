package modelos;

import java.sql.Blob;

public class cardImg {
	Blob image1 = null;
	public byte[ ] imgData1;

	public cardImg(Blob pimg) {
		image1 = pimg;
	}
	
	public void imgData(byte[] pimgData) {
		imgData1 = pimgData;
	}
}
