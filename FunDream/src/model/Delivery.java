package model;

public class Delivery {
	private int f_index;
	private String v_name;
	private String v_phone;
	private String v_add;
	private String v_msg;
	
	public Delivery() {
		// TODO Auto-generated constructor stub
	}
	
	public Delivery(int f_index, String v_name, String v_phone, String v_add, String v_msg) {
		
		this.f_index = f_index;
		this.v_name = v_name;
		this.v_phone = v_phone;
		this.v_add = v_add;
		this.v_msg = v_msg;
	}
	
	public int getF_index() {
		return f_index;
	}
	public void setF_index(int f_index) {
		this.f_index = f_index;
	}
	public String getV_name() {
		return v_name;
	}
	public void setV_name(String v_name) {
		this.v_name = v_name;
	}
	public String getV_phone() {
		return v_phone;
	}
	public void setV_phone(String v_phone) {
		this.v_phone = v_phone;
	}
	public String getV_add() {
		return v_add;
	}
	public void setV_add(String v_add) {
		this.v_add = v_add;
	}
	public String getV_msg() {
		return v_msg;
	}
	public void setV_msg(String v_msg) {
		this.v_msg = v_msg;
	}
	@Override
	public String toString() {
		return "Delivery [f_index=" + f_index + ", v_name=" + v_name + ", v_phone=" + v_phone + ", v_add=" + v_add
				+ ", v_msg=" + v_msg + "]";
	}
}
