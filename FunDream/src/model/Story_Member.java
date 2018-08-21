package model;

public class Story_Member {
	private int p_index;
	private int m_id;
	
	public Story_Member(int p_index, int m_id) {
		this.p_index = p_index;
		this.m_id = m_id;
	}
	public Story_Member() {
		// TODO Auto-generated constructor stub
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
	
	@Override
	public String toString() {
		return "Story_Member [p_index=" + p_index + ", m_id=" + m_id + "]";
	}
}
