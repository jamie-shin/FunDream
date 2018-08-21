package dao;

import java.util.List;

import model.Member;

public interface IMemberDao {
	
	public int insertMember(Member member);
	public List<Member> selectAllMember();
	public Member selectOneMemberById(int m_id);
	public Member selectOneMemberByEmail(String m_email);
	public int updateMember(Member member);
	public int deleteMember(int m_id);

}
