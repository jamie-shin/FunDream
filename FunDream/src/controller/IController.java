package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.Category;
import model.Comment;
import model.Member;
import model.Project;
import service.CategoryService;
import service.CommentService;
import service.FundService;
import service.Fund_DetailService;
import service.MemberService;
import service.ProjectService;
import service.RewardService;

@Controller
public class IController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private RewardService rewardService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private FundService fundservice;
	
	@Autowired
	private Fund_DetailService fdservice;
	
	// 관리자 메인 화면 요청
	@RequestMapping("IBE_MANAGER.do")
	public void IBE_MANAGER() {}
	
	// 관리자 - 카테고리 목록 화면 요청
	@RequestMapping("ICS_LIST.do")
	public ModelAndView ICS_LIST() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pCategoryList", categoryService.getCategoryListByType(1));
		mav.addObject("rCategoryList", categoryService.getCategoryListByType(2));
		mav.setViewName("ICS_LIST");
		return mav;
	}
	
	// 관리자 - 카테고리 생성
	@RequestMapping("ICI.do")
	public @ResponseBody int ICI(String ct_name, String ct_type) {
		Category category = new Category();
		category.setCt_name(ct_name);
		try {
			category.setCt_type(Integer.parseInt(ct_type));
		} catch (Exception e) {
			return -1;
		}
		int result = categoryService.insertCategory(category);
		if(result == 1) {
			return category.getCt_index();
		}
		else {
			return 0;
		}
	}
	
	// 관리자 - 카테고리 삭제
	@RequestMapping("ICD.do")
	public @ResponseBody String ICD(int ct_index) {
		System.out.println("삭제할 카테고리 인덱스 : " + ct_index);
		List<Project> projectList = projectService.getProjectsByCategory(ct_index);
		if(projectList.size() > 0 || projectList != null) {  // 해당 카테고리 인덱스로 조회한 프로젝트가 있을 때
			return "disable";
		}
		else {
			int result = categoryService.deleteOneCategory(ct_index);
			System.out.println("수정 결과 : " + result);
			if(result == 1) {
				return "true";
			}
			else {
				return "false";
			}
		}
	}
	
	// 관리자 - 카테고리명 수정
	@RequestMapping("ICU.do")
	public @ResponseBody String ICU(int ct_index, String ct_name) {
		System.out.println("수정할 카테고리 인덱스 : " + ct_index);
		Category category = new Category();
		category.setCt_index(ct_index);
		category.setCt_name(ct_name);
		int result = categoryService.updateOneCategory(category);
		System.out.println("수정 결과 : " + result);
		if(result == 1) {
			return "true";
		}
		else {
			return "false";
		}
	}

	
	// 관리자 - 회원 목록 화면 요청
	@RequestMapping("IMS_LISTFORM.do")
	public ModelAndView IMS_LISTFORM() {
		ModelAndView mav = new ModelAndView();
		List<Member> memberList = memberService.getAllMembers();
		List<Comment> reportCommentList = commentService.selectCommentsByReport(2);
		mav.addObject("memberList", memberList);
		mav.addObject("reportComment", reportCommentList);
		mav.setViewName("IMS_LISTFORM");
		return mav;
	}
	
	// 관리자 - 전체 회원 검색
	@RequestMapping("IMS_ALLMEMBERS.do")
	public @ResponseBody Map IMS_ALLMEMBERS(){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMap", memberService.getAllMembers());

		Set<String> keys = resultMap.keySet();
		for(String key : keys) {
			System.out.println(key + " : " + resultMap.get(key));
		}
		
		return resultMap;
	}
	
	// 관리자 - 회원 타입별 검색
	@RequestMapping(value="IMS_SEARCH.do", method=RequestMethod.POST)
	public @ResponseBody Map IMS_SEARCH(@RequestParam(required=false) int sc_type, @RequestParam(required=false) int sc_detail, @RequestParam(required=false) String keyword) {
		
		HashMap<String, Object> searchMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(!keyword.isEmpty()) {
			searchMap.put("keyword", keyword);
		}
		
		switch(sc_type) {
		case 0:
			resultMap.put("resultMap", memberService.getMembersByKeyword(searchMap));
			break;
		// 관리자 여부 조회
		case 1:
			switch(sc_detail) {
			case 1:  // 관리자 조회
				searchMap.put("m_manager", 1);
				resultMap.put("resultMap" ,memberService.getMembersByManager(searchMap));
				break;
			case 2:  // 일반회원 조회
				searchMap.put("m_manager", 2);
				resultMap.put("resultMap" ,memberService.getMembersByManager(searchMap));
				break;
			}
			break;
		// 활동 여부 조회
		case 2:
			switch(sc_detail) {
			case 1:  // 활동 중 회원 조회
				searchMap.put("m_valid", 1);
				resultMap.put("resultMap" ,memberService.getMembersByValid(searchMap));
				break;
			case 2:  // 탈퇴 회원 조회
				searchMap.put("m_valid", 2);
				resultMap.put("resultMap" ,memberService.getMembersByValid(searchMap));
				break;
			case 3:  // 이용 정지 회원 조회
				searchMap.put("m_valid", 3);
				resultMap.put("resultMap" ,memberService.getMembersByValid(searchMap));
				break;
			}
			break;
		}
		
		Set<String> keys = resultMap.keySet();
		for(String key : keys) {
			System.out.println(key + " : " + resultMap.get(key));
		}
		
		// 신고처리된 댓글 내역 가져오기
		List<Comment> reportCommentList = commentService.selectCommentsByReport(2);
		if(reportCommentList != null) {
			resultMap.put("reportComment", reportCommentList);
		}
		
		return resultMap;
	}
	
	// 관리자 - 회원 상세보기 화면 요청
	@RequestMapping("IMS_DETAILFORM.do")
	public ModelAndView IMS_DETAILFORM(String m_id_str) {
		int m_id = 0;
		try {
			m_id = Integer.parseInt(m_id_str);
		}
		catch (Exception e) {
			System.out.println("숫자 변환 불가");
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("member", memberService.selectOneMemberById(m_id));
		mav.addObject("projectList", projectService.getProjectById(m_id));
		mav.addObject("allProjectList", projectService.getAllProjects());
		mav.addObject("fundList", fundservice.selectAllFundByM_id(m_id));
		mav.addObject("commentList", commentService.selectCommentsById(m_id));
		mav.setViewName("IMS_DETAILFORM");
		return mav;
	}
	
	// 관리자 - 관리자 변경
	@RequestMapping("IMU_GRANT.do")
	public @ResponseBody int IMU_GRANT(int m_id, int m_manager) {
		Member member = memberService.selectOneMemberById(m_id);
		member.setM_manager(m_manager);
		
		int result = memberService.updateMember(member);
		if(result == 1) {
			return memberService.selectOneMemberById(m_id).getM_manager();
		}
		return 0;
	}
	
	// 관리자 - 회원 유형 변경
	@RequestMapping("IMU_SLEEP.do")
	public @ResponseBody int IMU_SLEEP(int m_valid, int m_id) {
		Member member = memberService.selectOneMemberById(m_id);
		member.setM_valid(m_valid);
		
		int result = memberService.updateMember(member);
		if(result == 1) {
			return memberService.selectOneMemberById(m_id).getM_valid();
		}
		return 0;
	}
	
	// 관리자 - 프로젝트 목록
	@RequestMapping("IJS_PROJECTFORM.do")
	public ModelAndView IJS_PROJECTFORM() {
		ModelAndView mav = new ModelAndView();
		// 승인 대기 중(1)
		mav.addObject("waitList", projectService.getProjectsByApproval(1));
		// 승인 완료(2) - 프로젝트 시작 전(1)
		mav.addObject("approveListBefore", projectService.getProjectsByApproval(2));
		// 승인 완료(2) - 프로젝트 진행 중(2)
		mav.addObject("approveListProgress", projectService.getProjectsByApproval(2));
		// 반려(3)
		mav.addObject("rejectList", projectService.getProjectsByApproval(3));
		
		HashMap<String, Object> selectMap1 = new HashMap<>();
		// 승인 완료(2) - 프로젝트 종료 - 정산 대기(1)
		selectMap1.put("calculate", 1);
		mav.addObject("calculateBeforeList", projectService.getProjectsByCalculate(selectMap1));
		// 승인 완료(2) - 프로젝트 종료 - 정산 완료(2)
		HashMap<String, Object> selectMap2 = new HashMap<>();
		selectMap2.put("calculate", 2);
		mav.addObject("completeList", projectService.getProjectsByCalculate(selectMap2));
		// 승인 완료(2) - 프로젝트 종료 - 모금 실패(3)
		HashMap<String, Object> selectMap3 = new HashMap<>();
		selectMap3.put("calculate", 3);
		mav.addObject("failList", projectService.getProjectsByCalculate(selectMap3));
		
		mav.setViewName("IJS_PROJECTFORM");
		return mav;
	}
	
	// 프로젝트 승인 처리
	@RequestMapping("IJU_APPROVE.do")
	public @ResponseBody String IJU_APPROVE(int p_index) {
		Map<String, Object> changeMap = new HashMap<>();
		changeMap.put("p_index", p_index);
		changeMap.put("p_approval", 2);  // 프로젝트 승인 완료로 변경(2)
		int result = projectService.updateApproval(changeMap);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 프로젝트 반려 처리
	@RequestMapping("IJU_REJECT.do")
	public @ResponseBody String IJU_REJECT(int p_index) {
		Map<String, Object> changeMap = new HashMap<>();
		changeMap.put("p_index", p_index);
		changeMap.put("p_approval", 3);  // 프로젝트 반려로 변경(3)
		int result = projectService.updateApproval(changeMap);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 프로젝트 승인/반쳐 처리 취소(승인 대기로 변경)
	@RequestMapping("IJU_CANCEL.do")
	public @ResponseBody String IJU_CANCEL(int p_index) {
		Map<String, Object> changeMap = new HashMap<>();
		changeMap.put("p_index", p_index);
		changeMap.put("p_approval", 1);  // 프로젝트 승인 대기로 변경(1)
		int result = projectService.updateApproval(changeMap);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 댓글 신고 처리
	@RequestMapping("IMU_REPORTCOMM.do")
	public @ResponseBody String IMU_REPORTCOMM(int c_index, int c_status) {
		Map<String, Object> statusMap = new HashMap<>();
		statusMap.put("c_index", c_index);
		statusMap.put("c_status", c_status);
		int result = commentService.updateCommentforStatus(statusMap);
		if(result == 1) return "success";
		return "fail";
	}
}
