package model;

import java.sql.Timestamp;

public class Comment {
	private int c_index;
	private int p_index;
	private int m_id;
	private Timestamp c_writedate;
	private String c_contents;
	private int c_status;
	private String c_report;
	private String c_re_con;
	private Timestamp c_re_writedate;
	private String m_nick;
	
	
	
	
	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	
	public Comment() {
		// TODO Auto-generated constructor stub
	}
	
	public int getC_index() {
		return c_index;
	}
	public void setC_index(int c_index) {
		this.c_index = c_index;
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
	public Timestamp getC_writedate() {
		return c_writedate;
	}
	public void setC_writedate(Timestamp c_writedate) {
		this.c_writedate = c_writedate;
	}
	public String getC_contents() {
		return c_contents;
	}
	public void setC_contents(String c_contents) {
		this.c_contents = c_contents;
	}

	public int getC_status() {
		return c_status;
	}
	public void setC_status(int c_status) {
		this.c_status = c_status;
	}
	public String getC_report() {
		return c_report;
	}
	public void setC_report(String c_report) {
		this.c_report = c_report;
	}
	public String getC_re_con() {
		return c_re_con;
	}
	public void setC_re_con(String c_re_con) {
		this.c_re_con = c_re_con;
	}
	

	public Timestamp getC_re_writedate() {
		return c_re_writedate;
	}

	public void setC_re_writedate(Timestamp c_re_writedate) {
		this.c_re_writedate = c_re_writedate;
	}

	@Override
	public String toString() {
		return "Comment [c_index=" + c_index + ", p_index=" + p_index + ", m_id=" + m_id + ", c_writedate="
				+ c_writedate + ", c_contents=" + c_contents + ", c_status=" + c_status + ", c_report=" + c_report
				+ ", c_re_con=" + c_re_con + ", c_re_writedate=" + c_re_writedate + ", m_nick=" + m_nick + "]";
	}

	public Comment(int c_index, int p_index, int m_id, Timestamp c_writedate, String c_contents, int c_status,
			String c_report, String c_re_con, Timestamp c_re_writedate, String m_nick) {
		super();
		this.c_index = c_index;
		this.p_index = p_index;
		this.m_id = m_id;
		this.c_writedate = c_writedate;
		this.c_contents = c_contents;
		this.c_status = c_status;
		this.c_report = c_report;
		this.c_re_con = c_re_con;
		this.c_re_writedate = c_re_writedate;
		this.m_nick = m_nick;
	}

	
}
