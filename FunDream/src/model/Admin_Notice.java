package model;

import java.sql.Timestamp;

public class Admin_Notice {
	private int an_index;
	private String an_title;
	private String an_contents;
	private Timestamp an_time;
	private String an_image;
	
	public Admin_Notice(int an_index, String an_title, String an_contents, Timestamp an_time, String an_image) {
		this.an_index = an_index;
		this.an_title = an_title;
		this.an_contents = an_contents;
		this.an_time = an_time;
		this.an_image = an_image;
	}
	
	public Admin_Notice() {
		// TODO Auto-generated constructor stub
	}

	public int getAn_index() {
		return an_index;
	}
	public void setAn_index(int an_index) {
		this.an_index = an_index;
	}
	public String getAn_title() {
		return an_title;
	}
	public void setAn_title(String an_title) {
		this.an_title = an_title;
	}
	public String getAn_contents() {
		return an_contents;
	}
	public void setAn_contents(String an_contents) {
		this.an_contents = an_contents;
	}
	public Timestamp getAn_time() {
		return an_time;
	}
	public void setAn_time(Timestamp an_time) {
		this.an_time = an_time;
	}
	public String getAn_image() {
		return an_image;
	}
	public void setAn_image(String an_image) {
		this.an_image = an_image;
	}
	@Override
	public String toString() {
		return "Admin_Notice [an_index=" + an_index + ", an_title=" + an_title + ", an_contents=" + an_contents
				+ ", an_time=" + an_time + ", an_image=" + an_image + "]";
	}
}
