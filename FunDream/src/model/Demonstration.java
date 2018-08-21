package model;

import java.sql.Timestamp;

public class Demonstration {
	private int d_index;
	private int p_index;
	private int d_authority;
	private String d_url;
	private Timestamp d_createdate;
	private Timestamp d_starttime;
	private Timestamp d_endtime;
	private String d_docu;
	private int d_approval;
	private String d_chat;
	
	public Demonstration() {
		// TODO Auto-generated constructor stub
	}

	public Demonstration(int d_index, int p_index, int d_authority, String d_url, Timestamp d_createdate,
			Timestamp d_starttime, Timestamp d_endtime, String d_docu, int d_approval, String d_chat) {
		
		this.d_index = d_index;
		this.p_index = p_index;
		this.d_authority = d_authority;
		this.d_url = d_url;
		this.d_createdate = d_createdate;
		this.d_starttime = d_starttime;
		this.d_endtime = d_endtime;
		this.d_docu = d_docu;
		this.d_approval = d_approval;
		this.d_chat = d_chat;
	}
	
	public int getD_index() {
		return d_index;
	}
	public void setD_index(int d_index) {
		this.d_index = d_index;
	}
	public int getP_index() {
		return p_index;
	}
	public void setP_index(int p_index) {
		this.p_index = p_index;
	}
	public int getD_authority() {
		return d_authority;
	}
	public void setD_authority(int d_authority) {
		this.d_authority = d_authority;
	}
	public String getD_url() {
		return d_url;
	}
	public void setD_url(String d_url) {
		this.d_url = d_url;
	}
	public Timestamp getD_createdate() {
		return d_createdate;
	}
	public void setD_createdate(Timestamp d_createdate) {
		this.d_createdate = d_createdate;
	}
	public Timestamp getD_starttime() {
		return d_starttime;
	}
	public void setD_starttime(Timestamp d_starttime) {
		this.d_starttime = d_starttime;
	}
	public Timestamp getD_endtime() {
		return d_endtime;
	}
	public void setD_endtime(Timestamp d_endtime) {
		this.d_endtime = d_endtime;
	}
	public String getD_docu() {
		return d_docu;
	}
	public void setD_docu(String d_docu) {
		this.d_docu = d_docu;
	}
	public int getD_approval() {
		return d_approval;
	}
	public void setD_approval(int d_approval) {
		this.d_approval = d_approval;
	}
	public String getD_chat() {
		return d_chat;
	}
	public void setD_chat(String d_chat) {
		this.d_chat = d_chat;
	}
	@Override
	public String toString() {
		return "Demonstration [d_index=" + d_index + ", p_index=" + p_index + ", d_authority=" + d_authority
				+ ", d_url=" + d_url + ", d_createdate=" + d_createdate + ", d_starttime=" + d_starttime
				+ ", d_endtime=" + d_endtime + ", d_docu=" + d_docu + ", d_approval=" + d_approval + ", d_chat="
				+ d_chat + "]";
	}
}
