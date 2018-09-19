package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IAdmin_NoticeDao;
import model.Admin_Notice;

@Service
public class Admin_NoticeService {
	
	@Autowired
	private IAdmin_NoticeDao admin_NoticeDao;
	
	public int insertAdmin_Notice(Admin_Notice admin_Notice) {
		return admin_NoticeDao.insertAdmin_Notice(admin_Notice);
	}
	
	public int updateAdmin_Notice(Admin_Notice admin_Notice) {
		return admin_NoticeDao.updateAdmin_Notice(admin_Notice);
	}
	
	public int deleteAdmin_Notice(int an_index) {
		return admin_NoticeDao.deleteAdmin_Notice(an_index);
	}
	
	public List<Admin_Notice> selectAllAdmin_Notices(){
		return admin_NoticeDao.selectAllAdmin_Notices();
	}
	
	public Admin_Notice selectOneAdmin_Notice(int an_index) {
		return admin_NoticeDao.selectOneAdmin_Notice(an_index);
	}

}
