package model;

public class Payment_Info {
	private String y_id;
	private String y_amount;
	private String y_apply_num;
	
	public Payment_Info(String y_id, String y_amount, String y_apply_num) {
		this.y_id = y_id;
		this.y_amount = y_amount;
		this.y_apply_num = y_apply_num;
	}
	public Payment_Info() {
		// TODO Auto-generated constructor stub
	}
	
	public String getY_id() {
		return y_id;
	}
	public void setY_id(String y_id) {
		this.y_id = y_id;
	}
	public String getY_amount() {
		return y_amount;
	}
	public void setY_amount(String y_amount) {
		this.y_amount = y_amount;
	}
	public String getY_apply_num() {
		return y_apply_num;
	}
	public void setY_apply_num(String y_apply_num) {
		this.y_apply_num = y_apply_num;
	}
	
	@Override
	public String toString() {
		return "Payment_Info [y_id=" + y_id + ", y_amount=" + y_amount + ", y_apply_num=" + y_apply_num + "]";
	}
}
