package model;

public class Fund_Detail {
	private int fd_index;
	private int f_index;
	private int r_index;
	private int fd_amt;
	private String fd_r_option;
	private int fd_cancel;
	private String r_name;
	
	public Fund_Detail() {
		// TODO Auto-generated constructor stub
	}

	public int getFd_index() {
		return fd_index;
	}

	public void setFd_index(int fd_index) {
		this.fd_index = fd_index;
	}

	public int getF_index() {
		return f_index;
	}

	public void setF_index(int f_index) {
		this.f_index = f_index;
	}

	public int getR_index() {
		return r_index;
	}

	public void setR_index(int r_index) {
		this.r_index = r_index;
	}

	public int getFd_amt() {
		return fd_amt;
	}

	public void setFd_amt(int fd_amt) {
		this.fd_amt = fd_amt;
	}

	public String getFd_r_option() {
		return fd_r_option;
	}

	public void setFd_r_option(String fd_r_option) {
		this.fd_r_option = fd_r_option;
	}

	public int getFd_cancel() {
		return fd_cancel;
	}

	public void setFd_cancel(int fd_cancel) {
		this.fd_cancel = fd_cancel;
	}

	public String getR_name() {
		return r_name;
	}

	public void setR_name(String r_name) {
		this.r_name = r_name;
	}

	@Override
	public String toString() {
		return "Fund_Detail [fd_index=" + fd_index + ", f_index=" + f_index + ", r_index=" + r_index + ", fd_amt="
				+ fd_amt + ", fd_r_option=" + fd_r_option + ", fd_cancel=" + fd_cancel + ", r_name=" + r_name + "]";
	}

	public Fund_Detail(int fd_index, int f_index, int r_index, int fd_amt, String fd_r_option, int fd_cancel,
			String r_name) {
		this.fd_index = fd_index;
		this.f_index = f_index;
		this.r_index = r_index;
		this.fd_amt = fd_amt;
		this.fd_r_option = fd_r_option;
		this.fd_cancel = fd_cancel;
		this.r_name = r_name;
	}
	
	
	
}
