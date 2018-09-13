package dao;

import java.util.HashMap;
import java.util.List;

import model.Member;

public interface IMemberDao {
	
	public int insertMember(Member member);
	public List<Member> selectAllMember();
	public Member selectOneMemberById(int m_id);
	public Member selectOneMemberByEmail(String m_email);
	public int updateMember(Member member);
	public int deleteMember(int m_id);
	public String shaPwd(String m_pwd);
	public void updateMemberForLeave(String m_email);
	public List<Member> selectMembersByManager(HashMap<String, Object> searchMap);
	public List<Member> selectMembersByValid(HashMap<String, Object> searchMap);
	public List<Member> selectMembersByKeyword(HashMap<String, Object> searchMap);

}
