package dao;

import java.util.HashMap;
import java.util.List;

import model.Notice;

public interface INoticeDao {

	public List<Notice> selectNoticeByProject(int p_index);

	public void insertNotice(HashMap<String, Object> notice);

	public void deleteNotice(int n_index);

}
