package model;

public class Bank_Info {
	private int b_index;
	private int p_index;
	private int f_index;
	private int b_type;
	private int b_b_num;
	private String b_b_owner;
	private String b_name;
	private String b_owner;
	private String b_account;
	private String b_bankname;
	
	public Bank_Info(int b_index, int p_index, int f_index, int b_type, int b_b_num, String b_b_owner, String b_name,
			String b_owner, String b_account, String b_bankname) {
		this.b_index = b_index;
		this.p_index = p_index;
		this.f_index = f_index;
		this.b_type = b_type;
		this.b_b_num = b_b_num;
		this.b_b_owner = b_b_owner;
		this.b_name = b_name;
		this.b_owner = b_owner;
		this.b_account = b_account;
		this.b_bankname = b_bankname;
	}
	
	public Bank_Info() {
		// TODO Auto-generated constructor stub
	}
	
	public int getB_index() {
		return b_index;
	}
	public void setB_index(int b_index) {
		this.b_index = b_index;
	}
	public int getP_index() {
		return p_index;
	}
	public void setP_index(int p_index) {
		this.p_index = p_index;
	}
	public int getF_index() {
		return f_index;
	}
	public void setF_index(int f_index) {
		this.f_index = f_index;
	}
	public int getB_type() {
		return b_type;
	}
	public void setB_type(int b_type) {
		this.b_type = b_type;
	}
	public int getB_b_num() {
		return b_b_num;
	}
	public void setB_b_num(int b_b_num) {
		this.b_b_num = b_b_num;
	}
	public String getB_b_owner() {
		return b_b_owner;
	}
	public void setB_b_owner(String b_b_owner) {
		this.b_b_owner = b_b_owner;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public String getB_owner() {
		return b_owner;
	}
	public void setB_owner(String b_owner) {
		this.b_owner = b_owner;
	}
	public String getB_account() {
		return b_account;
	}
	public void setB_account(String b_account) {
		this.b_account = b_account;
	}
	public String getB_bankname() {
		return b_bankname;
	}
	public void setB_bankname(String b_bankname) {
		this.b_bankname = b_bankname;
	}
	@Override
	public String toString() {
		return "Bank_Info [b_index=" + b_index + ", p_index=" + p_index + ", f_index=" + f_index + ", b_type=" + b_type
				+ ", b_b_num=" + b_b_num + ", b_b_owner=" + b_b_owner + ", b_name=" + b_name + ", b_owner=" + b_owner
				+ ", b_account=" + b_account + ", b_bankname=" + b_bankname + "]";
	}

}
