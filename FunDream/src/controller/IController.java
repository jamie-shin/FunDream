package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import model.Admin_Notice;
import model.Bank_Info;
import model.Category;
import model.Comment;
import model.Member;
import model.Project;
import service.Admin_NoticeService;
import service.Bank_InfoService;
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
	
	@Autowired
	private Bank_InfoService bank_InfoService;
	
	@Autowired
	private Admin_NoticeService admin_NoticeService;
	
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
		System.out.println(projectList);
		if(projectList.size() == 0 || projectList == null || projectList.isEmpty()) {  // 해당 카테고리 인덱스로 조회한 프로젝트가 있을 때
			int result = categoryService.deleteOneCategory(ct_index);
			System.out.println("수정 결과 : " + result);
			if(result == 1) return "true";
			return "false";
		}
		else {
			System.out.println("프로젝트가 있다고??");
			for(Project p : projectList) {
				System.out.println(p);
			}
			return "disabled";
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
		Member member = new Member();
		member.setM_id(m_id);
		member.setM_manager(m_manager);
		
		int result = memberService.updateByManager(member);
		if(result == 1) {
			return memberService.selectOneMemberById(m_id).getM_manager();
		}
		return 0;
	}
	
	// 관리자 - 회원 유형 변경
	@RequestMapping("IMU_SLEEP.do")
	public @ResponseBody int IMU_SLEEP(int m_valid, int m_id) {
		Member member = new Member();
		member.setM_id(m_id);
		member.setM_valid(m_valid);
		
		int result = memberService.updateByManager(member);
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
	
	// 관리자 - 프로젝트 정산 화면 요청
	@RequestMapping("IJE_FORM.do")
	public ModelAndView IJE_FORM(String p_index_str) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("project", projectService.getOneProject(Integer.parseInt(p_index_str)));
		mav.setViewName("IJE_FORM");
		return mav;
	}
	
	// 관리자 - 프로젝트 정산 요청
	@RequestMapping("IJU_APPLY.do")
	public @ResponseBody String IJU_APPLY(int p_index, int p_calculate, String bankname, String bankaccount, String bankowner) {
		Bank_Info bank = new Bank_Info();
		bank.setP_index(p_index);
		String b_bankname = "";
		switch(bankname) {
		case "1":
			b_bankname = "신한은행";
			break;
		case "2":
			b_bankname = "국민은행";
			break;
		case "3": 
			b_bankname = "우리은행";
			break;
		}
		bank.setB_bankname(b_bankname);
		bank.setB_account(bankaccount);
		bank.setB_owner(bankowner);
		System.out.println(bank);
		int b_result = bank_InfoService.insertBank_Info(bank);
		
		Map<String, Object> changeMap = new HashMap<>();
		changeMap.put("p_index", p_index);
		changeMap.put("p_calculate", p_calculate);
		int p_result = projectService.updateCalculate(changeMap);
		
		if(b_result == 1 && p_result == 1) return "success";
		return "fail";
	}
	
	
	// 관리자 - 공지사항 목록
	@RequestMapping("INS_NOTICELIST.do")
	public ModelAndView INS_NOTICELIST() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("adNoticeList", admin_NoticeService.selectAllAdmin_Notices());
		mav.setViewName("INS_NOTICELIST");
		return mav;
	}
	
	// 관리자 - 공지사항 등록 화면 요청
	@RequestMapping("INE_WRITEFORM.do")
	public void INE_WRITEFORM() {}

	// 관리자 - 공지사항 등록
	@RequestMapping(value="INI_WRITENOTICE.do", method=RequestMethod.POST)
	public @ResponseBody int INI_WRITENOTICE(HttpServletRequest req, String an_title, String an_contents) {
		Admin_Notice admin_Notice = new Admin_Notice();
		System.out.println("제목 : " + an_title);
		System.out.println("내용 : " + an_contents);
		admin_Notice.setAn_title(an_title);
		admin_Notice.setAn_contents(an_contents);
		int result = admin_NoticeService.insertAdmin_Notice(admin_Notice);
		// 등록 성공 시 인덱스 리턴
		if(result == 1) return admin_Notice.getAn_index();
		return 0;
	}
	
	// 관리자 - 공지사항 상세보기
	@RequestMapping("INS_NOTICEDETAIL.do")
	public ModelAndView INS_NOTICEDETAIL(int an_index) {
		ModelAndView mav = new ModelAndView();
		Admin_Notice ad = admin_NoticeService.selectOneAdmin_Notice(an_index);
		mav.addObject("ad", ad);
		mav.addObject("adNoticeList", admin_NoticeService.selectAllAdmin_Notices().subList(0, 2));
		mav.setViewName("INS_NOTICEDETAIL");
		return mav;
	}
	
	// 관리자 - 공지사항 수정 화면 요청
	@RequestMapping("INS_UPDATEFORM.do")
	public ModelAndView INS_UPDATEFORM(int an_index) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("admin_Notice", admin_NoticeService.selectOneAdmin_Notice(an_index));
		mav.setViewName("INS_UPDATEFORM");
		return mav;
	}
	
	// 관리자 - 공지사항 수정
	@RequestMapping("INU_UPDATENOTICE.do")
	public @ResponseBody String INU_UPDATENOTICE(HttpServletRequest req) {
		Admin_Notice admin_Notice = new Admin_Notice();
		
		int result = admin_NoticeService.updateAdmin_Notice(admin_Notice);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 관리자 - 공지사항 삭제
	@RequestMapping("IND_DELETENOTICE.do")
	public @ResponseBody String IND_DELETENOTICE(int an_index) {
		int result = admin_NoticeService.deleteAdmin_Notice(an_index);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 서머노트 이미지 업로드
	@RequestMapping("uploadImage.do")
	public void uploadImage(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {
		int m_id = (Integer)request.getSession().getAttribute("m_id");
		response.setContentType("text/html;charset=utf-8");
		
		// 어디에서 이미지가 업로드 되는지에 따라 저장...(관리자 공지사항, 제작자 공지사항, 프로젝트 스토리)
		String type = null;
		if(request.getParameter("type") == null) {
			type = request.getParameter("type");
		}
		
		PrintWriter out = response.getWriter();
		
		// 업로드할 폴더 경로
		String realFolder = request.getSession().getServletContext().getRealPath("profileUpload");
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = realFolder + "\\" + m_id + "\\" + type  + "\\" + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		out.println("profileUpload/"+m_id+"/"+type+"/"+str_filename);
		out.close();
	}
	
}
