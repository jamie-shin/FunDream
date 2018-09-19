package dao;

import java.util.List;

import model.Admin_Notice;

public interface IAdmin_NoticeDao {
	
	public int insertAdmin_Notice(Admin_Notice admin_Notice);
	public int updateAdmin_Notice(Admin_Notice admin_Notice);
	public int deleteAdmin_Notice(int an_index);
	public List<Admin_Notice> selectAllAdmin_Notices();
	public Admin_Notice selectOneAdmin_Notice(int an_index);

}
