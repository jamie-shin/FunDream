package model;

import java.sql.Timestamp;

public class Reward {
	private int r_index;
    private int p_index;
    private int m_id;
    private int r_price;
    private String r_name;
    private String r_img;
    private String r_contents;
    private int ct_index;
    private Timestamp r_start;
    private String r_option;
    private int r_del;
    private int r_amt;
    private String r_policy;
    
    public Reward() {
		// TODO Auto-generated constructor stub
	}
    
    public Reward(int r_index, int p_index, int m_id, int r_price, String r_name, String r_img, String r_contents, int ct_index, Timestamp r_start, String r_option, int r_del, int r_amt, String r_policy) {
		this.r_index = r_index;
		this.p_index = p_index;
		this.m_id = m_id;
		this.r_price = r_price;
		this.r_name = r_name;
		this.r_img = r_img;
		this.r_contents = r_contents;
		this.ct_index = ct_index;
		this.r_start = r_start;
		this.r_option = r_option;
		this.r_del = r_del;
		this.r_amt = r_amt;
		this.r_policy = r_policy;
	}

	public int getR_index() {
		return r_index;
	}

	public void setR_index(int r_index) {
		this.r_index = r_index;
	}

	public int getP_index() {
		return p_index;
	}

	public void setP_index(int p_index) {
		this.p_index = p_index;
	}

	public int getM_id() {
		return m_id;
	}

	public void setM_id(int m_id) {
		this.m_id = m_id;
	}

	public int getR_price() {
		return r_price;
	}

	public void setR_price(int r_price) {
		this.r_price = r_price;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	public String getR_img() {
		return r_img;
	}

	public void setR_img(String r_img) {
		this.r_img = r_img;
	}

	public String getR_contents() {
		return r_contents;
	}

	public void setR_contents(String r_contents) {
		this.r_contents = r_contents;
	}

	public int getCt_index() {
		return ct_index;
	}

	public void setCt_index(int ct_index) {
		this.ct_index = ct_index;
	}

	public Timestamp getR_start() {
		return r_start;
	}

	public void setR_start(Timestamp r_start) {
		this.r_start = r_start;
	}

	public String getR_option() {
		return r_option;
	}

	public void setR_option(String r_option) {
		this.r_option = r_option;
	}

	public int getR_del() {
		return r_del;
	}

	public void setR_del(int r_del) {
		this.r_del = r_del;
	}

	public int getR_amt() {
		return r_amt;
	}

	public void setR_amt(int r_amt) {
		this.r_amt = r_amt;
	}

	public String getR_policy() {
		return r_policy;
	}

	public void setR_policy(String r_policy) {
		this.r_policy = r_policy;
	}
    
	@Override
	public String toString() {
		return "Reward [r_index=" + r_index + ", p_index=" + p_index + ", m_id=" + m_id + ", r_price=" + r_price
				+ ", r_name=" + r_name + ", r_img=" + r_img + ", r_contents=" + r_contents + ", ct_index=" + ct_index
				+ ", r_start=" + r_start + ", r_option=" + r_option + ", r_del=" + r_del + ", r_amt=" + r_amt
				+ ", r_policy=" + r_policy + "]";
	}
}
