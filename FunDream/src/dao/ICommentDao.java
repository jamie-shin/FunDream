package dao;

import java.util.HashMap;
import java.util.List;

import model.Comment;

public interface ICommentDao {

	public void insertComment(HashMap<String, Object> comment);
	public List<Comment> selectCommentByProject(int p_index);
	public void insertReply(HashMap<String, Object> reply);
	public void updateComment(HashMap<String, Object> updatedComment);
	public void updateCommentforDelete(int c_index);
	public void deleteReply(int c_index);
	public void updateReply(HashMap<String, Object> updatedReply);
	public Comment selectOneCommentByIndex(int c_index);
	
}
