package dao;

import java.util.List;

import model.Story_Member;

public interface IStory_MemberDao {
	
	public int insertStoryMember(Story_Member story_Member);
	public int deleteStoryMember(Story_Member story_Member);
	public Story_Member selectOneStoryMemberByEmail(Story_Member story_Member);
	public List<Story_Member> selectStoryMembersByProject(int p_index);

}
