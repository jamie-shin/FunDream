package service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IMemberDao;
import model.Member;

@Service
public class MemberService {
	@Autowired
	private IMemberDao memberDao;

	public Member selectOneMemberByEmail(String inputEmail) {
		// TODO Auto-generated method stub
		Member member = memberDao.selectOneMemberByEmail(inputEmail);
		if(member == null) {
			return null;  // 존재하지 않는 이메일
		}
		else {
			return member;  // DB에 존재하는 이메일
		}
	}

	public int insertMember(Member member, String type, MultipartFile file) {
		// TODO Auto-generated method stub
		String path = "C:/Temp/FunDream/"+type+"/";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs(); //해당경로에 디렉토리가 없으면 생성
		String fileName = file.getOriginalFilename();
		File attachFile = new File(path + fileName);
		
		try {
			file.transferTo(attachFile);  //파일 복사
			member.setM_img(fileName);
			System.out.println(path+fileName);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return memberDao.insertMember(member);
	}
	
	public Member selectOneMemberByEmail2(String inputEmail,String name) {
		Member member = memberDao.selectOneMemberByEmail(inputEmail);
		if(member != null && member.getM_name().trim().equals(name.trim())) {
			return member;
		}
		else return null;
	}

	public int updateMember(Member member) {
		// TODO Auto-generated method stub
		return memberDao.updateMember(member);
	}
	
	public int MIS_LOGIN(String m_email, String m_pwd) {
        // TODO Auto-generated method stub
        Member member = memberDao.selectOneMemberByEmail(m_email);
        System.out.println(member);
        String m_pwd_input = memberDao.shaPwd(m_pwd);
        //System.out.println("입력된 pw: "+m_pwd_input);
         
        if(member==null) {
            return 1; //이메일이 없을 때
        } else { //이메일이 있을 때
        	if(member.getM_valid()==2) {
        		return 5; //탈퇴자
        	}
        	if(member.getM_valid()==3) {
        		return 6; //이용정지자
        	}
            if(member.getM_pwd().equals(m_pwd_input)) {
                if(member.getM_manager()==1) return 2; //이메일 비밀번호 일치 & 관리자
                else return 4; //이메일 비밀번호 일치 & 일반회원
            }else return 3; //이메일 비밀번호 불일치
        } 
    }

	public int MUS_CHECKPW(String m_pwd_input, String m_email) {
		// TODO Auto-generated method stub
		Member member = memberDao.selectOneMemberByEmail(m_email);
		String m_pwd_check = memberDao.shaPwd(m_pwd_input);
		System.out.println("정보수정 비밀번호 : " + m_pwd_check);
		System.out.println("정보수정 비밀번호 확인 : " + member.getM_pwd());
		if (m_pwd_check.equals(member.getM_pwd())) return 1;
		else return 2;
	}

	public void MUU_LEAVE(String m_email) {
		// TODO Auto-generated method stub
		memberDao.updateMemberForLeave(m_email);
	}
	
	public Member selectOneMemberById(int m_id) {
		return memberDao.selectOneMemberById(m_id);
	}
	

	public List<Member> getAllMembers() {
		// TODO Auto-generated method stub
		return memberDao.selectAllMember();
	}

	public List<Member> getMembersByManager(HashMap<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return memberDao.selectMembersByManager(searchMap);
	}

	public List<Member> getMembersByValid(HashMap<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return memberDao.selectMembersByValid(searchMap);
	}

	public List<Member> getMembersByKeyword(HashMap<String, Object> searchMap) {
		// TODO Auto-generated method stub
		return memberDao.selectMembersByKeyword(searchMap);
	}

	public int updatePassword(Member member) {
		return memberDao.updatePassword(member);
	}
	
	public File getAttachFile(int m_id, String type) {
		// TODO Auto-generated method stub
		Member member = memberDao.selectOneMemberById(m_id); //번호에 해당하는 게시물 정보 가져오기
		String fileName = member.getM_img();  //DB안에 있는 파일 정보
		String path = "C:/Temp/FunDream/member/";
		return new File(path+fileName);
	}
	
}
