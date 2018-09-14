package model;

public class Delivery {
	private int f_index;
	private int m_id;
	private int p_index;
	private String v_name;
	private String v_phone;
	private String v_add;
	private String v_msg;
	private String v_postnum;
	
	public Delivery() {
		// TODO Auto-generated constructor stub
	}

	public int getF_index() {
		return f_index;
	}

	public void setF_index(int f_index) {
		this.f_index = f_index;
	}

	public int getM_id() {
		return m_id;
	}

	public void setM_id(int m_id) {
		this.m_id = m_id;
	}

	public int getP_index() {
		return p_index;
	}

	public void setP_index(int p_index) {
		this.p_index = p_index;
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

	public String getV_postnum() {
		return v_postnum;
	}

	public void setV_postnum(String v_postnum) {
		this.v_postnum = v_postnum;
	}

	@Override
	public String toString() {
		return "Delivery [f_index=" + f_index + ", m_id=" + m_id + ", p_index=" + p_index + ", v_name=" + v_name
				+ ", v_phone=" + v_phone + ", v_add=" + v_add + ", v_msg=" + v_msg + ", v_postnum=" + v_postnum + "]";
	}

	public Delivery(int f_index, int m_id, int p_index, String v_name, String v_phone, String v_add, String v_msg,
			String v_postnum) {
		this.f_index = f_index;
		this.m_id = m_id;
		this.p_index = p_index;
		this.v_name = v_name;
		this.v_phone = v_phone;
		this.v_add = v_add;
		this.v_msg = v_msg;
		this.v_postnum = v_postnum;
	}
	
	
}
