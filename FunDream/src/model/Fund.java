package model;

public class Fund {
	private int f_index;
    private int p_index;
    private int m_id;
    private int f_price;
    private int f_payment;
    private int b_index;
    private int cd_index;
    private int f_cancel;
    
	public Fund() {
		// TODO Auto-generated constructor stub
	}
    
	public Fund(int f_index, int p_index, int m_id, int f_price, int f_payment, int b_index, int cd_index, int f_cancel) {
		this.f_index = f_index;
		this.p_index = p_index;
		this.m_id = m_id;
		this.f_price = f_price;
		this.f_payment = f_payment;
		this.b_index = b_index;
		this.cd_index = cd_index;
		this.f_cancel = f_cancel;
	}

	public int getF_index() {
		return f_index;
	}

	public void setF_index(int f_index) {
		this.f_index = f_index;
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

	public int getF_price() {
		return f_price;
	}

	public void setF_price(int f_price) {
		this.f_price = f_price;
	}

	public int getF_payment() {
		return f_payment;
	}

	public void setF_payment(int f_payment) {
		this.f_payment = f_payment;
	}

	public int getB_index() {
		return b_index;
	}

	public void setB_index(int b_index) {
		this.b_index = b_index;
	}

	public int getCd_index() {
		return cd_index;
	}

	public void setCd_index(int cd_index) {
		this.cd_index = cd_index;
	}

	public int getF_cancel() {
		return f_cancel;
	}

	public void setF_cancel(int f_cancel) {
		this.f_cancel = f_cancel;
	}

	@Override
	public String toString() {
		return "Fund [f_index=" + f_index + ", p_index=" + p_index + ", m_id=" + m_id + ", f_price=" + f_price
				+ ", f_payment=" + f_payment + ", b_index=" + b_index + ", cd_index=" + cd_index + ", f_cancel="
				+ f_cancel + "]";
	}
}
