package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ICommentDao;
import model.Comment;

@Service
public class CommentService {
	
	@Autowired
	private ICommentDao commentDao;

	public void insertComment(String m_id, String p_index, String contents) {
		HashMap<String, Object> comment = new HashMap<>();
		int pint = Integer.parseInt(p_index);
		int mint = Integer.parseInt(m_id);
		
		comment.put("p_index", pint);
		comment.put("m_id", mint);
		comment.put("c_contents", contents);
		System.out.println("들어갈 내용:"+comment);
		commentDao.insertComment(comment);
	}
	
	public List<Comment> selectCommentByProject(int p_index){
		return commentDao.selectCommentByProject(p_index);
	}

	public void insertReply(String c_re_con, int c_index) {
		System.out.println("service: "+c_index+","+c_re_con);
		HashMap<String, Object> reply = new HashMap<>();
		reply.put("c_re_con", c_re_con);
		reply.put("c_index", c_index);
		commentDao.insertReply(reply);
		// TODO Auto-generated method stub
		
	}

	public void updateComment(int c_index, String c_contents) {
		HashMap<String, Object> updatedComment = new HashMap<>();
		updatedComment.put("c_contents", c_contents);
		updatedComment.put("c_index", c_index);
		// TODO Auto-generated method stub
		System.out.println("service: "+c_index+","+c_contents);
		commentDao.updateComment(updatedComment);
		
	}

	public void updateCommentforDelete(int c_index) {
		// TODO Auto-generated method stub
		commentDao.updateCommentforDelete(c_index);
		
	}

	public void deleteReply(int c_index) {
		// TODO Auto-generated method stub
		commentDao.deleteReply(c_index);
		
	}

	public void updateReply(int c_index, String c_re_con) {
		// TODO Auto-generated method stub
		HashMap<String, Object> updatedReply = new HashMap<>();
		updatedReply.put("c_re_con", c_re_con);
		updatedReply.put("c_index", c_index);
		commentDao.updateReply(updatedReply);
		
	}

	public Comment getOneCommentByIndex(int c_index) {
		// TODO Auto-generated method stub
		return commentDao.selectOneCommentByIndex(c_index);
	}
}
