package model;

public class Card_Info {
	private int f_index;
	private int cd_index;
	private int cd_num;
	private String cd_valid;
	private int cd_cvc;
	private String cd_cardname;
	
	public Card_Info() {
		// TODO Auto-generated constructor stub
	}

	public int getF_index() {
		return f_index;
	}

	public void setF_index(int f_index) {
		this.f_index = f_index;
	}

	public int getCd_index() {
		return cd_index;
	}

	public void setCd_index(int cd_index) {
		this.cd_index = cd_index;
	}

	public int getCd_num() {
		return cd_num;
	}

	public void setCd_num(int cd_num) {
		this.cd_num = cd_num;
	}

	public String getCd_valid() {
		return cd_valid;
	}

	public void setCd_valid(String cd_valid) {
		this.cd_valid = cd_valid;
	}

	public int getCd_cvc() {
		return cd_cvc;
	}

	public void setCd_cvc(int cd_cvc) {
		this.cd_cvc = cd_cvc;
	}

	public String getCd_cardname() {
		return cd_cardname;
	}

	public void setCd_cardname(String cd_cardname) {
		this.cd_cardname = cd_cardname;
	}

	@Override
	public String toString() {
		return "Card_Info [f_index=" + f_index + ", cd_index=" + cd_index + ", cd_num=" + cd_num + ", cd_valid="
				+ cd_valid + ", cd_cvc=" + cd_cvc + ", cd_cardname=" + cd_cardname + "]";
	}

	public Card_Info(int f_index, int cd_index, int cd_num, String cd_valid, int cd_cvc, String cd_cardname) {
		this.f_index = f_index;
		this.cd_index = cd_index;
		this.cd_num = cd_num;
		this.cd_valid = cd_valid;
		this.cd_cvc = cd_cvc;
		this.cd_cardname = cd_cardname;
	}

	
	
	
}
