package model;

import java.sql.Timestamp;

public class Notice {
	private int n_index;
	private int p_index;
	private String n_title;
	private Timestamp n_writedate;
	private String n_contents;
	private String n_image;
	
	public Notice() {
		// TODO Auto-generated constructor stub
	}
	
	public Notice(int n_index, int p_index, String n_title, Timestamp n_writedate, String n_contents, String n_image) {
		this.n_index = n_index;
		this.p_index = p_index;
		this.n_title = n_title;
		this.n_writedate = n_writedate;
		this.n_contents = n_contents;
		this.n_image = n_image;
	}
	
	public int getN_index() {
		return n_index;
	}
	public void setN_index(int n_index) {
		this.n_index = n_index;
	}
	public int getP_index() {
		return p_index;
	}
	public void setP_index(int p_index) {
		this.p_index = p_index;
	}
	public String getn_title() {
		return n_title;
	}
	public void setn_title(String n_title) {
		this.n_title = n_title;
	}
	public Timestamp getN_writedate() {
		return n_writedate;
	}
	public void setN_writedate(Timestamp n_writedate) {
		this.n_writedate = n_writedate;
	}
	public String getN_contents() {
		return n_contents;
	}
	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}
	public String getN_image() {
		return n_image;
	}
	public void setN_image(String n_image) {
		this.n_image = n_image;
	}
	
	@Override
	public String toString() {
		return "Notice [n_index=" + n_index + ", p_index=" + p_index + ", n_title=" + n_title + ", n_writedate="
				+ n_writedate + ", n_contents=" + n_contents + ", n_image=" + n_image + "]";
	}
}
