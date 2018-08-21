package model;

import java.util.Date;

public class Member {
	private int m_id;
    private String m_email;
    private String m_pwd;
    private String m_name;
    private String m_img;
    private String m_nick;
    private String m_phone;
    private int m_gender;
    private Date m_birth;
    private int m_manager;
    private int m_valid;

    public Member() {
		// TODO Auto-generated constructor stub
	}
    
	public Member(int m_id, String m_email, String m_pwd, String m_name, String m_img, String m_nick, String m_phone, int m_gender, Date m_birth, int m_manager, int m_valid) {
		this.m_id = m_id;
		this.m_email = m_email;
		this.m_pwd = m_pwd;
		this.m_name = m_name;
		this.m_img = m_img;
		this.m_nick = m_nick;
		this.m_phone = m_phone;
		this.m_gender = m_gender;
		this.m_birth = m_birth;
		this.m_manager = m_manager;
		this.m_valid = m_valid;
	}

	public int getM_id() {
		return m_id;
	}

	public void setM_id(int m_id) {
		this.m_id = m_id;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public String getM_pwd() {
		return m_pwd;
	}

	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_img() {
		return m_img;
	}

	public void setM_img(String m_img) {
		this.m_img = m_img;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getM_phone() {
		return m_phone;
	}

	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}

	public int getM_gender() {
		return m_gender;
	}

	public void setM_gender(int m_gender) {
		this.m_gender = m_gender;
	}

	public Date getM_birth() {
		return m_birth;
	}

	public void setM_birth(Date m_birth) {
		this.m_birth = m_birth;
	}

	public int getM_manager() {
		return m_manager;
	}

	public void setM_manager(int m_manager) {
		this.m_manager = m_manager;
	}

	public int getM_valid() {
		return m_valid;
	}

	public void setM_valid(int m_valid) {
		this.m_valid = m_valid;
	}

	@Override
	public String toString() {
		return "Member [m_id=" + m_id + ", m_email=" + m_email + ", m_pwd=" + m_pwd + ", m_name=" + m_name
				+ ", m_img=" + m_img + ", m_nick=" + m_nick + ", m_phone=" + m_phone + ", m_gender=" + m_gender
				+ ", m_birth=" + m_birth + ", m_manager=" + m_manager + ", m_valid=" + m_valid + "]";
	}
}