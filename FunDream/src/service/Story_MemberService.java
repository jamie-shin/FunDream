package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IStory_MemberDao;
import model.Story_Member;

@Service
public class Story_MemberService {
	
	@Autowired
	private IStory_MemberDao story_MemberDao;
	
	public int addOneStoryMember(Story_Member story_Member) {
		System.out.println("스토리 멤버 저장 완료!");
		return story_MemberDao.insertStoryMember(story_Member);
	}
	
	public int deleteOneStoryMember(Story_Member story_Member) {
		System.out.println("스토리 멤버 삭제 완료!");
		return story_MemberDao.deleteStoryMember(story_Member);
	}

	public Story_Member getOneStoryMemberByEmail(Story_Member story_Member) {
		System.out.println("스토리 멤버 찾기 : " + story_Member);
		return story_MemberDao.selectOneStoryMemberByEmail(story_Member);
	}

	public List<Story_Member> getStoryMembersByProject(int p_index) {
		// TODO Auto-generated method stub
		return story_MemberDao.selectStoryMembersByProject(p_index);
	}

}
