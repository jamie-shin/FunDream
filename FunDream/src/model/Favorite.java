package model;

public class Favorite {
	private int fv_index;
	private int m_id;
	private int p_index;
	
	public Favorite(int fv_index, int m_id, int p_index) {
		this.fv_index = fv_index;
		this.m_id = m_id;
		this.p_index = p_index;
	}
	public Favorite() {
		// TODO Auto-generated constructor stub
	}
	
	public int getFv_index() {
		return fv_index;
	}
	public void setFv_index(int fv_index) {
		this.fv_index = fv_index;
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

	@Override
	public String toString() {
		return "Favorite [fv_index=" + fv_index + ", m_id=" + m_id + ", p_index=" + p_index + "]";
	}
}
