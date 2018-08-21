package model;

public class Category {
	private int ct_type;
	private int ct_index;
	private String ct_name;
	
	public Category() {
		// TODO Auto-generated constructor stub
	}

	public Category(int ct_type, int ct_index, String ct_name) {
		
		this.ct_type = ct_type;
		this.ct_index = ct_index;
		this.ct_name = ct_name;
	}
	
	public int getCt_type() {
		return ct_type;
	}
	public void setCt_type(int ct_type) {
		this.ct_type = ct_type;
	}
	public int getCt_index() {
		return ct_index;
	}
	public void setCt_index(int ct_index) {
		this.ct_index = ct_index;
	}
	public String getCt_name() {
		return ct_name;
	}
	public void setCt_name(String ct_name) {
		this.ct_name = ct_name;
	}
	@Override
	public String toString() {
		return "Category [ct_type=" + ct_type + ", ct_index=" + ct_index + ", ct_name=" + ct_name + "]";
	}
}
