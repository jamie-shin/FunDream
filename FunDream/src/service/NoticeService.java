package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.INoticeDao;
import model.Notice;

@Service
public class NoticeService {
	
	@Autowired
	private INoticeDao noticeDao;
	
	public void insertNotice(int p_index, String n_title, String n_contents) {
		// TODO Auto-generated method stub
		HashMap<String, Object> notice = new HashMap<>();
		notice.put("p_index", p_index);
		notice.put("n_title", n_title);
		notice.put("n_contents", n_contents);
		System.out.println("들어갈내용:"+notice);
		noticeDao.insertNotice(notice);
	
	}
	public List<Notice> selectNoticeByProject(int p_index) {
		return noticeDao.selectNoticeByProject(p_index);
	}
	public void deleteNotice(int n_index) {
		// TODO Auto-generated method stub
		noticeDao.deleteNotice(n_index);
		
	}


}
