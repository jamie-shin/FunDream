package model;

import java.sql.Timestamp;

public class Project {
	private int p_index;
    private int m_id;
    private int p_approval;
    private int ct_index;
    private String p_name;
    private Timestamp p_createdate;
    private Timestamp p_startdate;
    private Timestamp p_enddate;
    private int p_target;
    private int p_status;
    private String p_s_link;
    private String p_contents;
    private String p_mainimg;
    private int p_age;
    private int p_calculate;
    private int p_type;
    private double per;
    
    public double getPer() {
		return per;
	}

	public void setPer(double per) {
		this.per = per;
	}

	public Project() {
		// TODO Auto-generated constructor stub
	}

	public Project(int p_index, int m_id, int p_approval, int ct_index, String p_name, Timestamp p_createdate, Timestamp p_startdate, Timestamp p_enddate, int p_target, int p_status, String p_s_link, String p_contents, String p_mainimg, int p_age, int p_calculate, int p_type) {
		this.p_index = p_index;
		this.m_id = m_id;
		this.p_approval = p_approval;
		this.ct_index = ct_index;
		this.p_name = p_name;
		this.p_createdate = p_createdate;
		this.p_startdate = p_startdate;
		this.p_enddate = p_enddate;
		this.p_target = p_target;
		this.p_status = p_status;
		this.p_s_link = p_s_link;
		this.p_contents = p_contents;
		this.p_mainimg = p_mainimg;
		this.p_age = p_age;
		this.p_calculate = p_calculate;
		this.p_type = p_type;
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

	public int getP_approval() {
		return p_approval;
	}

	public void setP_approval(int p_approval) {
		this.p_approval = p_approval;
	}

	public int getCt_index() {
		return ct_index;
	}

	public void setCt_index(int ct_index) {
		this.ct_index = ct_index;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public Timestamp getP_createdate() {
		return p_createdate;
	}

	public void setP_createdate(Timestamp p_createdate) {
		this.p_createdate = p_createdate;
	}

	public Timestamp getP_startdate() {
		return p_startdate;
	}

	public void setP_startdate(Timestamp p_startdate) {
		this.p_startdate = p_startdate;
	}

	public Timestamp getP_enddate() {
		return p_enddate;
	}

	public void setP_enddate(Timestamp p_enddate) {
		this.p_enddate = p_enddate;
	}

	public int getP_target() {
		return p_target;
	}

	public void setP_target(int p_target) {
		this.p_target = p_target;
	}

	public int getP_status() {
		return p_status;
	}

	public void setP_status(int p_status) {
		this.p_status = p_status;
	}

	public String getP_s_link() {
		return p_s_link;
	}

	public void setP_s_link(String p_s_link) {
		this.p_s_link = p_s_link;
	}

	public String getP_contents() {
		return p_contents;
	}

	public void setP_contents(String p_contents) {
		this.p_contents = p_contents;
	}

	public String getP_mainimg() {
		return p_mainimg;
	}

	public void setP_mainimg(String p_mainimg) {
		this.p_mainimg = p_mainimg;
	}

	public int getP_age() {
		return p_age;
	}

	public void setP_age(int p_age) {
		this.p_age = p_age;
	}

	public int getP_calculate() {
		return p_calculate;
	}

	public void setP_calculate(int p_calculate) {
		this.p_calculate = p_calculate;
	}

	public int getP_type() {
		return p_type;
	}

	public void setP_type(int p_type) {
		this.p_type = p_type;
	}

	@Override
	public String toString() {
		return "Project [p_index=" + p_index + ", m_id=" + m_id + ", p_approval=" + p_approval + ", ct_index="
				+ ct_index + ", p_name=" + p_name + ", p_createdate=" + p_createdate + ", p_startdate=" + p_startdate
				+ ", p_enddate=" + p_enddate + ", p_target=" + p_target + ", p_status=" + p_status + ", p_s_link="
				+ p_s_link + ", p_contents=" + p_contents + ", p_mainimg=" + p_mainimg + ", p_age=" + p_age
				+ ", p_calculate=" + p_calculate + ", p_type=" + p_type + ", per=" + per + "]";
	}
}
