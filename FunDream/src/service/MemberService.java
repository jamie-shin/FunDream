package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		if(member!=null) {
			memberDao.insertMember(member);
			return 1;
		}
		return 2;
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
		if(member !=null) {
			memberDao.updateMember(member);
			return 1;
		}
		return 2;
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
		if (m_pwd_check.equals(member.getM_pwd())) return 1;
		else return 2;
	}

	public void MUU_MODIFY(Member m) {
		// TODO Auto-generated method stub
		System.out.println(m);
		memberDao.updateMember(m);
		//md.updateMember(m);
	}

	public void MUU_LEAVE(String m_email) {
		// TODO Auto-generated method stub
		memberDao.updateMemberForLeave(m_email);
	}
	
	public Member selectOneMemberById(int m_id) {
		return memberDao.selectOneMemberById(m_id);
	}
}
