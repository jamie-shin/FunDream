package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.Category;
import model.Comment;
import model.Delivery;
import model.Fund;
import model.Fund_Detail;
import model.Member;
import model.Notice;
import model.PhotoVo;
import model.Project;
import model.Reward;
import model.Story_Member;
import service.CategoryService;
import service.CommentService;
import service.DeliveryService;
import service.FundService;
import service.Fund_DetailService;
import service.MemberService;
import service.NoticeService;
import service.ProjectService;
import service.RewardService;
import service.Story_MemberService;

@Controller
public class ProjectController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private RewardService rewardService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private Story_MemberService story_MemberService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private FundService fundService;
	
	@Autowired
	private Fund_DetailService fdservice;
	
	@Autowired
	private DeliveryService deliveryService;
	
	@Autowired
	private NoticeService noticeService;
	
	int gap=0;
	Date today = new Date();
	Date end = new Date();
	String t = null;
	String e= null;
	
	@RequestMapping("MAIN.do") // 메인화면 요청
	public ModelAndView MAIN(HttpSession session) {
		session.removeAttribute("keyword");
		ModelAndView mav = new ModelAndView();

		//최신 프로젝트 3개
		List<Project> newlist = projectService.getNewProject();
		for(int i=0;i<3;i++) {
			int p_status = fundService.updateP_status(newlist.get(i).getP_index());
			newlist.get(i).setP_status(p_status);
			int status = newlist.get(i).getP_status();
			int target = newlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			t = new SimpleDateFormat("yyyyMMddHHmm").format(today);
			end = newlist.get(i).getP_enddate();
			e = new SimpleDateFormat("yyyyMMddHHmm").format(end);
			int count = fundService.fundcount(newlist.get(i).getP_index());
			newlist.get(i).setP_count(count);
			
			long e_int = Long.parseLong(e);
			long t_int = Long.parseLong(t);
			
			gap = (int)(e_int - t_int);

			newlist.get(i).setPer(per);
			newlist.get(i).setGap(gap);
		}
		mav.addObject("newlist", newlist);
		//마감임박 프로젝트 3개
		List<Project> endlist = projectService.getEndProject();
		for(int i=0;i<3;i++) {
			int p_status = fundService.updateP_status(endlist.get(i).getP_index());
			endlist.get(i).setP_status(p_status);
			int status = endlist.get(i).getP_status();
			int target = endlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			t = new SimpleDateFormat("yyyyMMddHHmm").format(today);
			end = endlist.get(i).getP_enddate();
			e = new SimpleDateFormat("yyyyMMddHHmm").format(end);
			
			long e_int = Long.parseLong(e);
			long t_int = Long.parseLong(t);
			
			gap = (int)(e_int - t_int);
			int count = fundService.fundcount(endlist.get(i).getP_index());
			endlist.get(i).setP_count(count);

			endlist.get(i).setPer(per);
			endlist.get(i).setGap(gap);
		}
		mav.addObject("endlist", endlist);
		//목표 달성 완료 프로젝트 3개
		List<Project> successlist = projectService.getSuccessProject();
		for(int i=0;i<3;i++) {
			int p_status = fundService.updateP_status(successlist.get(i).getP_index());
			successlist.get(i).setP_status(p_status);
			int status = successlist.get(i).getP_status(); 
			int target = successlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			t = new SimpleDateFormat("yyyyMMddHHmm").format(today);
			end = successlist.get(i).getP_enddate();
			e = new SimpleDateFormat("yyyyMMddHHmm").format(end);
			
			long e_int = Long.parseLong(e);
			long t_int = Long.parseLong(t);
			
			gap = (int)(e_int - t_int);
			int count = fundService.fundcount(successlist.get(i).getP_index());
			successlist.get(i).setP_count(count);

			successlist.get(i).setPer(per);
			successlist.get(i).setGap(gap);
		}
		mav.addObject("successlist", successlist);
		
		mav.setViewName("MAIN");
		return mav;
	}
	
	// 신규 프로젝트 생성 버튼 클릭 시 해당 아이디로 작성중인 프로젝트가 있는지 확인
	@RequestMapping(value="JJS.do", produces="application/json")
	public @ResponseBody String JJS(String m_email, String NewProjectBtn) {
		System.out.println(m_email);
		Member member = memberService.selectOneMemberByEmail(m_email);
		int m_id = member.getM_id();
		List<Project> projectList = projectService.getIngProjectById(m_id);
		if(projectList == null) {
			System.out.println("신규 프로젝트 버튼 클릭 : 진행중인 프로젝트 없음!");
			return "false";  // 작성 중(승인 요청 전)인 프로젝트가 없을 때
		}
		else {
			System.out.println("신규 프로젝트 버튼 클릭 : 진행중인 프로젝트 있음!");
			return "true";  // 작성 중(승인 요청 전)인 프로젝트가 있을 때
		}
		
	}
	
	// 신규 프로젝트 생성(회원아이디, 프로젝트 인덱스)
	@RequestMapping("JJI.do")
	public String JJI(HttpServletRequest req) {
		// 신규 프로젝트 버튼 클릭 여부
		String m_email = (String)req.getSession().getAttribute("m_email");  // 세션에서 이메일 가져오기
		int m_id = memberService.selectOneMemberByEmail(m_email).getM_id();  // 회원 아이디 가져오기
		Project project = new Project();  // 새로운 프로젝트 객체 생성
		project.setM_id(m_id);  // 생성된 프로젝트 객체에 회원 아이디 저장
		projectService.insertProject(project);  // 회원 아이디만 저장된 프로젝트 객체로 DB에 데이터 생성
		int p_index = project.getP_index();  // DB에서 프로젝트 데이터 생성 시 가져온 인덱스 값 가져오기
		System.out.println("=============신규프로젝트 생성 버튼 클릭===============");
		System.out.println("로그인한 아이디 : " + m_id);
		System.out.println("새로운 프로젝트 인덱스 : " + p_index);
		System.out.println("생성한 프로젝트 : " + projectService.getOneProject(p_index));
		return "redirect:JJI_FORM.do?p_index="+p_index;
	}
	
	// 프로젝트 수정 화면 요청(프로젝트 인덱스만 존재하는 신규 프로젝트)
	@RequestMapping("JJI_FORM.do")
	public ModelAndView JJI_FORM(HttpServletRequest req, String p_index) {
		ModelAndView mav = new ModelAndView();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("들어왔지 p_index : " + p_index);
		String m_email = (String)req.getSession().getAttribute("m_email");  // 세션에서 이메일 가져오기
		Member member = memberService.selectOneMemberByEmail(m_email);  // 세션에서 가져온 이메일로 회원 정보 가져오기
		String m_phone = member.getM_phone();  // 회원 연락처 가져오기
		int m_id = member.getM_id();  // 회원 아이디 가져오기
		mav.addObject("m_id", m_id);
		mav.addObject("m_email", m_email);
		mav.addObject("m_phone", m_phone);
		mav.addObject("p_index", p_index);
		Project project = projectService.getOneProject(Integer.parseInt(p_index));
		if(project.getP_name() != "" && project.getP_name() != null) {
			project.setP_target((Integer)(project.getP_target()/10000));
			String policy = project.getP_policy();
			if(policy != null && policy.contains("<br/>")) {
				policy = policy.replace("<br/>", "\n");
			}
			project.setP_policy(policy);		
			System.out.println("프로젝트명 : " + project.getP_name());
			System.out.println("목표금액 : " + project.getP_target());
			mav.addObject("project", project);
			mav.addObject("sdate", sdf.format(project.getP_startdate()));
			mav.addObject("edate", sdf.format(project.getP_enddate()));
			
			// 해당 프로젝트의 리워드 리스트 
			List<Reward> rewardList = rewardService.getRewardsByProject(project.getP_index());
			if(rewardList.size() > 0) {
				mav.addObject("rewardList", rewardList);
			}
			
			// 해당 프로젝트의 스토리멤버 리스트
			List<Story_Member> storyMemberList = story_MemberService.getStoryMembersByProject(Integer.parseInt(p_index));
			if(storyMemberList.size() > 0) {
				List<Member> smList = new ArrayList<>();
				for(Story_Member sm : storyMemberList) {
					Member m = memberService.selectOneMemberById(sm.getM_id());
					smList.add(m);
				}
				mav.addObject("smList", smList);
			}
		}
		mav.addObject("pCategoryList", categoryService.getCategoryListByType(1));
		mav.addObject("rCategoryList", categoryService.getCategoryListByType(2));
		mav.setViewName("JJI_FORM");
		return mav;
	}
	
	// 신규 프로젝트 생성 후 해당 프로젝트 정보 수정(기본정보)
	@RequestMapping(value="JBU_UPDATE.do", method=RequestMethod.POST)
	public @ResponseBody String JBU_UPDATE(HttpServletRequest request, @RequestParam("p_mainImg") MultipartFile file) {
		
		int p_index = Integer.parseInt(request.getParameter("p_index"));
		String type = request.getParameter("type");
		int m_id = (Integer)(request.getSession().getAttribute("m_id"));
		int ct_index = Integer.parseInt(request.getParameter("ct_index"));
		String p_name = request.getParameter("p_name");
		int p_type = Integer.parseInt(request.getParameter("p_type"));
		int p_target = Integer.parseInt(request.getParameter("p_target"));
		String p_startdate = request.getParameter("p_startdate");
		String p_enddate = request.getParameter("p_enddate");
		String p_age_str = request.getParameter("p_age");
	
		System.out.println("인덱스 : "+p_index);
		System.out.println("아이디: "+m_id);
		System.out.println("카테고리: "+ct_index);
		System.out.println("프로젝트명: "+p_name);
		System.out.println("프로젝트타입: "+p_type);
		System.out.println("목표금액: "+p_target);
		System.out.println("시작일: "+ p_startdate);
		System.out.println("종료일: "+ p_enddate);
		System.out.println("나이제한: "+p_age_str);
		
		Project project = projectService.getOneProject(p_index);
		project.setM_id(m_id);
		project.setCt_index(ct_index);
		project.setP_name(p_name);
		project.setP_type(p_type);
		project.setP_target(p_target);
		project.setP_startdate(Timestamp.valueOf(p_startdate + " 00:00:00"));
		project.setP_enddate(Timestamp.valueOf(p_enddate + " 00:00:00"));
		if(p_age_str != null && p_age_str.equals("on")) {
			project.setP_age(2);
		}
		else {
			project.setP_age(1);
		}
		
		int result = projectService.updateBasicInfo(project, type, file,request);
		if(result == 1) return "success";
		return "fail";
	}
	
	// 스토리 멤버 검색 및 삽입
	@RequestMapping(value="JSI.do", produces="application/text;charset=UTF-8")
	public @ResponseBody String JSI(HttpServletRequest req, HttpServletResponse resp, int p_index, String email) throws UnsupportedEncodingException {
		System.out.println(email);
		if(email != "") {
			Story_Member db_story_member = story_MemberService.getOneStoryMemberByEmail(new Story_Member(p_index, memberService.selectOneMemberByEmail(email).getM_id()));
			Member member = memberService.selectOneMemberByEmail(email);
			if(member != null && db_story_member == null) {
				System.out.println(member);
				Story_Member story_Member = new Story_Member(p_index, member.getM_id());
				int result = story_MemberService.addOneStoryMember(story_Member);
				if(result == 1) {
					System.out.println("스토리 멤버 닉네임 : " + member.getM_nick());
					return member.getM_nick();
				}
			}
			else if(db_story_member != null) {
				return "exist";
			}
		}
		return "null";
	}
	
	// 스토리 멤버 삭제 
	@RequestMapping("JSD.do") 
	public @ResponseBody String JSD(int p_index, String email) {
		System.out.println("p_index : " + p_index);
		Story_Member story_Member = new Story_Member(p_index, memberService.selectOneMemberByEmail(email).getM_id());
		int result = story_MemberService.deleteOneStoryMember(story_Member);
		System.out.println("삭제 result : " + result);
		if(result == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}

	// 신규 프로젝트 생성 후 해당 프로젝트 정보 수정(정책확인)
	@RequestMapping("JPU_UPDATE.do")
	public @ResponseBody String JPU_UPDATE(int p_index, String p_policy) {
		Project project = projectService.getOneProject(p_index);
		project.setP_policy(p_policy);
		int result = projectService.updatePolicy(project);
		if(result == 1) {
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	// 리워드 삽입
	@RequestMapping(value="JRI_INSERT.do", method=RequestMethod.POST)
	public @ResponseBody String JRI_INSERT(HttpServletRequest request, @RequestParam("r_img") MultipartFile file) {
		
		String type = "reward";
		Reward reward = new Reward();
		
		String p_index_str = request.getParameter("p_index");
		int p_index = Integer.parseInt(p_index_str);
		System.out.println("인덱스 : "+p_index);
		reward.setP_index(p_index);
		
		reward.setM_id(memberService.selectOneMemberByEmail((String)request.getSession().getAttribute("m_email")).getM_id());
		
		String r_name = request.getParameter("r_name");
		reward.setR_name(r_name);
		
		int r_price = Integer.parseInt(request.getParameter("r_price"));
		reward.setR_price(r_price);
		
		String ct_index_str = request.getParameter("ct_index");
		int ct_index = Integer.parseInt(ct_index_str);
		reward.setCt_index(ct_index);
		
		String r_contents = request.getParameter("r_contents");
		reward.setR_contents(r_contents);
		
		String delyear = request.getParameter("delyear");
		String delmonth = request.getParameter("delmonth");
		String delday = request.getParameter("delday");
		String r_start = delyear+"-"+delmonth+"-"+delday;
		System.out.println("r_start : "+ r_start);
		reward.setR_start(Timestamp.valueOf(r_start + " 00:00:00"));
		
		reward.setR_option(request.getParameter("r_option"));

		try {
			int r_del = Integer.parseInt(request.getParameter("r_del"));
			reward.setR_del(r_del);
		}catch (Exception e) {
			reward.setR_del(0);
		}
		
		try {
			int r_amt = Integer.parseInt(request.getParameter("r_amt"));
			reward.setR_amt(r_amt);
		}catch (Exception e) {
			reward.setR_amt(-1);
		}
		
		int result = rewardService.addOneReward(reward, type, file,request);
		System.out.println("결과 : " + result + " / " + reward);
		
		if(result == 1) return Integer.toString(reward.getR_index());
		return "0";
	}
	
	// 리워드 삭제
	@RequestMapping("JRD_DELETE.do")
	public @ResponseBody String JRD_DELETE(String r_index) {
		if(r_index != null || r_index != "") {
			System.out.println(r_index);
			int result = rewardService.deleteOneReward(Integer.parseInt(r_index));
			
			if(result == 1) {
				return "success";
			}
			else {
				return "fail";
			}
		}
		
		else if (r_index ==null || r_index =="") {
			return "noIndex";
		}
		else return "";
		
	}
	
	// 리워드 수정
	@RequestMapping(value="JRU_MODIFIED.do", method=RequestMethod.POST)
	public @ResponseBody String JRU_MODIFIED(HttpServletRequest request, @RequestParam("r_img") MultipartFile file) throws UnsupportedEncodingException {
		System.out.println("리워드 수정 요청 실행중....");
		
		String type = "reward";
		request.setCharacterEncoding("UTF-8");
			
		int r_index = Integer.parseInt(request.getParameter("r_index"));
		// DB에 저장된 리워드 가져오기
		Reward reward = rewardService.getOneRewardByIndex(r_index);
		
		if(!request.getParameter("r_name").isEmpty()) {
			String r_name = request.getParameter("r_name");
			reward.setR_name(r_name);
		}
		
		if(!request.getParameter("r_price").isEmpty()) {
			int r_price = Integer.parseInt(request.getParameter("r_price"));
			reward.setR_price(r_price);
		}
		
		if(!request.getParameter("r_contents").isEmpty()) {
			String r_contents = request.getParameter("r_contents");
			reward.setR_contents(r_contents);
		}
		
		if(!request.getParameter("ct_index").isEmpty()) {
			int ct_index = Integer.parseInt(request.getParameter("ct_index"));
			reward.setCt_index(ct_index);
		}
		
		if(!request.getParameter("delyear").isEmpty() && !request.getParameter("delmonth").isEmpty() && !request.getParameter("delday").isEmpty()) {
			String r_start = request.getParameter("delyear")+"-"+request.getParameter("delmonth")+"-"+request.getParameter("delday");
			reward.setR_start(Timestamp.valueOf(r_start + " 00:00:00"));
			System.out.println("r_start : "+ r_start);
		}
		
		if(!request.getParameter("r_option").isEmpty()) {
			String r_option = request.getParameter("r_option");
			reward.setR_option(r_option);
		}
		
		try {
			int r_del = Integer.parseInt(request.getParameter("r_del"));
			reward.setR_del(r_del);
		}catch (Exception e) {
			reward.setR_del(reward.getR_del());
		}

		try {
			int r_amt = Integer.parseInt(request.getParameter("r_amt"));
			reward.setR_amt(r_amt);
		}catch (Exception e) {
			reward.setR_amt(reward.getR_amt());
		}
		
		System.out.println("업데이트 전 : " + reward);
		int result = rewardService.updateOneReward(reward, type, file);
		
		if(result == 1) {
			System.out.println("리워드 수정 성공 " + reward);
			return "success";
		}
		else {
			System.out.println("리워드 수정 실패 " + reward);
			return "fail";
		}
	}
	
	// 프로젝트 상세보기
	@RequestMapping("JPS_DETAIL.do")
	public ModelAndView JPS_DETAIL(@RequestParam(required=false, defaultValue="0") int p_index, @RequestParam(required=false) String p_index_str,/*@RequestParam(value="m_id", required=false) String id*/ HttpServletRequest req) {

		if(p_index_str != null && p_index == 0) {
			p_index = Integer.parseInt(p_index_str);
		}
		
		String id= null;
		int id_int = 0;
		try {
			id_int = (Integer)req.getSession().getAttribute("m_id");
			id = Integer.toString(id_int);
		} catch (Exception e) {
			System.out.println("아이디 문자열 변환 불가(숫자가 아닌듯...)");
		}
		
		System.out.println("id : "+id);
		ModelAndView mav = new ModelAndView();
		Project project = projectService.getOneProject(p_index);
		List<Reward> reward = rewardService.getRewardsByProject(p_index);
		System.out.println("리워드정뵈:"+reward);
		
		for(int i=0;i<reward.size();i++) {
			int fd_amt=0;
			int limit =0;
			int r_amt=0;
			List<Fund_Detail> fd_list = fdservice.selectFDByR_index(reward.get(i).getR_index());
			r_amt= reward.get(i).getR_amt();
			for(int j=0;j<fd_list.size();j++) {
				if(r_amt!=0) {
					fd_amt+=fd_list.get(j).getFd_amt();
				}
			}
			limit=r_amt-fd_amt;
			reward.get(i).setR_amt(limit);
		}
		
		//댓글 불러오기
		List<Comment> comment = commentService.selectCommentByProject(p_index);
		String m_name =null;
		String m_nick = null;
		for(int i=0; i<comment.size() ;i++) {
			int m_id = comment.get(i).getM_id();
			Member member = memberService.selectOneMemberById(m_id);
			m_name = member.getM_name();
			m_nick = member.getM_nick();
			if (m_nick == null) {
				comment.get(i).setM_nick(m_name);
			}
			else if(m_nick !=null) {
				comment.get(i).setM_nick(m_nick);
			}
		}
		
		//공지사항 가져오기
		List<Notice> notice = noticeService.selectNoticeByProject(p_index);
		System.out.println("공지사항목록:"+notice);

		//퍼센트 구하기
		int status = project.getP_status(); 
		int target = project.getP_target();
		double per2 = (double)status/(double)target*100;
		double per = Double.parseDouble(String.format("%.2f",per2));
		project.setPer(per);
		
		//제작자 정보
		int m_idproducer = project.getM_id();
		Member m = memberService.selectOneMemberById(m_idproducer);
		
		//제작자 : producer , 관리자 : manager , 일반회원 : normal , 비회원 : none
		String type ="";
		//비회원이 아니면(회원이면)
		if(id !=null) {
			int m_id = Integer.parseInt(id);
			Member member=memberService.selectOneMemberById(m_id);
			//관리자가 아닐때
			if(member.getM_manager()==2) {
				//제작자일때
				if(project.getM_id()==member.getM_id()) {
					type="producer";
				}
				//제작자가 아닌 일반 회원일때
				else {
					type="normal";
				}
			}
			//관리자일때
			else {
				type="manager";
			}
		}
		//비회원이면
		else {
			type = "none";
		}
		mav.addObject("notice", notice);
		//리워드 정보
		mav.addObject("reward", reward);
		//댓글정보
		mav.addObject("commentList", comment);
		
		//들어오는사람이 누구인지
		mav.addObject("type", type);
		//프로젝트정보
		mav.addObject("project", project);
		//제작자 정보
		mav.addObject("m", m);
		//후원자 목록
		
		//후원한 총원
		int fund_pop = fundService.fund_pop(p_index);
		//후원한 총금액
		int total_fund = fundService.total_fund(p_index);
		
		List<Fund> f_list = fundService.selectAllFundByP_index(p_index);
		
		List<List<Object>> test = new ArrayList<List<Object>>();
		for(Fund f : f_list) {
			List<Object> list = new ArrayList<Object>();
			Member member = memberService.selectOneMemberById(f.getM_id());
			Delivery d = deliveryService.selectOneDeliveryByF_index(f.getF_index());
			List<Fund_Detail> fd_list= fdservice.selectAllFund_DetailByF_index(f.getF_index());
			list.add(member);
			list.add(f);
			list.add(d);
			list.add(fd_list);
			test.add(list);
		}
		
		mav.addObject("fund_pop", fund_pop);
		mav.addObject("total_fund", total_fund);
		mav.addObject("test", test);
		
		//그래프
		//리워드 별 데이터
		// 리워드 reward
		List<Fund> r_fund = fundService.selectAllFundByP_index(p_index);
		List<Fund_Detail> r_fund_detail = new ArrayList<>();
		
		for(int i = 0; i < r_fund.size(); i++) {
			List<Fund_Detail> result_fd = fdservice.selectAllFund_DetailByF_index(r_fund.get(i).getF_index());
			for(int j = 0; j < result_fd.size(); j++) {
				r_fund_detail.add(result_fd.get(j));
			}
		}
		
		System.out.println("============= 펀드 디데일 리스트 시작 ===============");
		for(Fund_Detail f : r_fund_detail) {
			System.out.println(f);
		}
		System.out.println("============= 펀드 디데일 리스트 끝  ===============");
		
		List<Fund_Detail> final_result = new ArrayList<>();
		for(int i = 0; i < reward.size(); i++) {
			Fund_Detail fd = new Fund_Detail();
			int sum_amt = 0;
			int rindex = reward.get(i).getR_index();
			for(int j = 0; j < r_fund_detail.size(); j++) {
				if(r_fund_detail.get(j).getR_index() == rindex) {
					sum_amt += r_fund_detail.get(j).getFd_amt();
				}
			}
			fd.setR_index(rindex);
			fd.setR_name(reward.get(i).getR_name());
			fd.setFd_amt(sum_amt);
			final_result.add(fd);
		}
		
		System.out.println("======== 리워드별 합계 =======");
		for(Fund_Detail fd : final_result) {
			System.out.println(fd);
		}
		System.out.println("======== 리워드별 합계 끝 =======");
		
		mav.addObject("fd_sum", final_result);
		
		//성별데이터
		int F_num = 0;
		int M_num = 0;
		int sum =0;
		double f_per=0;
		double m_per=0;
		for(Fund ff : r_fund) {
			Member mm = memberService.selectOneMemberById(ff.getM_id());
			if(mm.getM_gender()==1) {
				//System.out.println("M : "+mm);
				M_num+=1;
			}
			else if(mm.getM_gender()==2) {
				//System.out.println("F : "+mm);
				F_num+=1;
			}
		}
		sum = F_num + M_num;
		double F_per=0;
		if(F_num!=0) {
			f_per = (double)(F_num) / (double)(sum) * 100;
			F_per = Double.parseDouble(String.format("%.1f",f_per));
		}
		double M_per=0;
		if(M_num!=0) {
			m_per = (double)(M_num) / (double)(sum) * 100;
			M_per = Double.parseDouble(String.format("%.1f",m_per));
		}
		if(m_per==0.0) {
			f_per=100;
		}
		if(f_per==0.0) {
			m_per=100;
		}
		
		HashMap<String, Object> param = new HashMap<String,Object>();
		param.put("f_per", F_per);
		param.put("m_per", M_per);
		System.out.println("param : "+ param);
		mav.addObject("param_per", param);
		mav.setViewName("JPS_DETAIL");
		return mav;
	}
	
	//댓글 등록
	@RequestMapping(value="JCI_COMMENT.do", method=RequestMethod.POST)
	public @ResponseBody void JCI_COMMENT(String m_id, String p_index, String contents) {
		System.out.println("아이디: "+m_id);
		System.out.println("프로젝트:"+p_index);
		System.out.println("댓글:" + contents);
		commentService.insertComment(m_id, p_index, contents);
	}
	
	//댓글 수정
	@RequestMapping(value="JCU_COMMENT.do", method=RequestMethod.POST)
	public @ResponseBody void JCU_COMMENT(String contents, int c_index) {
		System.out.println("수정내용: " +contents);
		System.out.println("댓글번호: "+ c_index);
		commentService.updateComment(c_index, contents);
	}
	//댓글 삭제
	@RequestMapping(value="JCD_COMMENT.do", method=RequestMethod.POST)
	public @ResponseBody void JCD_COMMENT(int c_index) {
		System.out.println("댓글번호: "+ c_index);
		commentService.updateCommentforDelete(c_index);
	}
	
	//댓글의 답글 등록
	@RequestMapping(value="JCI_REPLY.do", method=RequestMethod.POST)
	public @ResponseBody int JCI_REPLY(String c_re_con, int c_index) {
		System.out.println("controller: "+c_index+","+c_re_con);
		
		commentService.insertReply(c_re_con, c_index);
		
		return 1;
	}
	
	//댓글의 답글 삭제
	@RequestMapping(value="JCD_REPLY.do", method=RequestMethod.POST)
	public @ResponseBody void JCD_REPLY(int c_index) {
		System.out.println("삭제할거:"+c_index);
		
		commentService.deleteReply(c_index);
	}
	
	//댓글의 답글 수정
	@RequestMapping(value="JCU_REPLY.do", method=RequestMethod.POST)
	public @ResponseBody void JCU_REPLY(int c_index, String c_re_con) {
		System.out.println("수정할거: "+c_index+","+c_re_con);
		
		commentService.updateReply(c_index, c_re_con);
	}
	
	
	//댓글 신고창
	@RequestMapping(value="JCE_REPORTFORM.do", method=RequestMethod.GET)
	public ModelAndView JCE_REPORTFORM(int c_index, int p_index) {
		ModelAndView mav = new ModelAndView();
		System.out.println("신고할거:"+c_index);
		System.out.println("p:"+p_index);
		String title = projectService.getOneProject(p_index).getP_name();
		
		mav.addObject("title", title);
		mav.setViewName("JCE_REPORTFORM");
		return mav;
	}
	
	@RequestMapping(value="JCE_REPORT.do", method=RequestMethod.POST)
	public @ResponseBody void JCE_REPORT(int c_index, String c_report) {
		System.out.println("신고할거:"+c_index);
		System.out.println("내용:"+c_report);
		
		commentService.updateCommentforReport(c_index, c_report);
	}
	
	
	//summernote부분시작
	@RequestMapping("JNE_NOTICEFORM2.do")
	public void JNE_NOTICEFORM2() {}
	
    
    @RequestMapping("JNU_NOTICEFORM2.do")
	public ModelAndView JNU_NOTICEFORM2(String n_index_str){
		System.out.println(n_index_str);
		int n_index = Integer.parseInt(n_index_str);
		Notice n = noticeService.selectOneNotice(n_index);
		System.out.println(n);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("notice", n);
		mav.setViewName("JNE_NOTICEFORM2");
		return mav;
	}
	
	//프로젝트 공지사항 등록
	@RequestMapping(value="JNE_NOTICE.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> JNE_NOTICE(@RequestBody Map<String, Object> map) {
		
		String p_index_str = (String)map.get("p_index");
		int p_index = Integer.parseInt(p_index_str);
		String n_title = (String)map.get("n_title");
		String n_contents = (String)map.get("n_contents");
		/*String con = n_contents.replace("<img", "<img style=\"max-width: 100%\"");*/
		noticeService.insertNotice(p_index, n_title, n_contents);
		
		Map<String, Object> re = new HashMap<String,Object>();
		re.put("msg", "제발");
		return re;
	}

	//프로젝트 공지사항 수정
	@RequestMapping(value="JNU_NOTICE.do", method=RequestMethod.POST)
	public @ResponseBody void JNU_NOTICE(@RequestBody Map<String, Object> map) {
		
		String n_index_str = (String)map.get("n_index");
		int n_index = Integer.parseInt(n_index_str);
		String n_title = (String)map.get("n_title");
		String n_contents = (String)map.get("n_contents");
		String con = n_contents.replace("<img", "<img style=\"max-width: 100%\"");
		noticeService.updateNotice(n_index, n_title, con);
	}
	
	
	//단일파일업로드
    @RequestMapping("photoUpload.do")
    public String photoUpload(HttpServletRequest request, PhotoVo vo){
        String callback = vo.getCallback();
        String callback_func = vo.getCallback_func();
        String file_result = "";
        try {
            if(vo.getFiledata() != null && vo.getFiledata().getOriginalFilename() != null && !vo.getFiledata().getOriginalFilename().equals("")){
                //파일이 존재하면
                String original_name = vo.getFiledata().getOriginalFilename();
                String ext = original_name.substring(original_name.lastIndexOf(".")+1);
                //파일 기본경로
                String defaultPath = request.getSession().getServletContext().getRealPath("img");
                //파일 기본경로 _ 상세경로
                String path = defaultPath + File.separator;
                File file = new File(path);
                //디렉토리 존재하지 않을경우 디렉토리 생성
                if(!file.exists()) {
                    file.mkdirs();
                }
                //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
                String realname = UUID.randomUUID().toString() + "." + ext;
            ///////////////// 서버에 파일쓰기 /////////////////
                vo.getFiledata().transferTo(new File(path+realname));
                file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=../img/"+realname;
            } else {
                file_result += "&errstr=error";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:" + callback + "?callback_func="+callback_func+file_result;
    }
    //공지사항 삭제
	@RequestMapping("JND_NOTICE.do")
	public @ResponseBody void JND_NOTICE(String n_index_str) {
		System.out.println(n_index_str);
		int n_index = Integer.parseInt(n_index_str);
		noticeService.deleteNotice(n_index);
	}
    
	
	
	// 프로젝트 리스트 첫 화면 요청(최신순)
	@RequestMapping("JJS_FORM.do")
	public ModelAndView projectList(@RequestParam(required=false)String keyword, HttpSession session, @RequestParam(required=false) String ct_index,
			@RequestParam String sort, @RequestParam(defaultValue="0") int num, @RequestParam(required=false) String option) throws ParseException {
		
		ModelAndView mav = new ModelAndView();
		List<Project> projectlist= null;
		List<Category> categoryList=categoryService.getCategoryListByType(1);

		int ct_int=0;
		
		if(ct_index != null) {
			ct_int = Integer.parseInt(ct_index);
		}
		if(keyword ==null) {
			projectlist = projectService.selectProject_more(0, keyword, ct_int, sort, option);
			System.out.println("controller <키워드: 없음>");
			if(ct_int != 0) {
				System.out.println("controller <카테고리: "+ ct_int +">");
				projectlist = projectService.selectProject_more(0, keyword, ct_int, sort, option);
			}
		}
	
		else if(keyword !=null && ct_int ==0) {
			System.out.println("controller <키워드: "+ keyword +">");
			System.out.println("controller <카테고리: >"+ct_int);
			projectlist =  projectService.selectProject_more(0, keyword, ct_int, sort, option);
		
		}
		else if(keyword != null && ct_int != 0) {
			System.out.println("controller <카테고리: "+ ct_int +">");
			projectlist = projectService.selectProject_more(0, keyword, ct_int, sort, option);
		}
		
		
		if(projectlist !=null) {
			for(int i=0;i<projectlist.size();i++) {
				int status = projectlist.get(i).getP_status();
				int target = projectlist.get(i).getP_target();
				double per2 = (double)status/(double)target*100;
				double per = Double.parseDouble(String.format("%.2f",per2));
				t = new SimpleDateFormat("yyyyMMddHHmm").format(today);
				end = projectlist.get(i).getP_enddate();
				e = new SimpleDateFormat("yyyyMMddHHmm").format(end);
				
				long e_int = Long.parseLong(e);
				long t_int = Long.parseLong(t);
				
				gap = (int)(e_int - t_int);
				int count = fundService.fundcount(projectlist.get(i).getP_index());
				projectlist.get(i).setP_count(count);
				projectlist.get(i).setPer(per);
				projectlist.get(i).setGap(gap);
			}
		}
		mav.addObject("list", projectlist);
		mav.addObject("cList", categoryList);
		mav.setViewName("JJS_FORM");
		return mav; 
	}
	
	// 프로젝트 리스트에서 더보기 클릭 시
	@RequestMapping(value="more.do",  method=RequestMethod.POST)		
	public @ResponseBody Map more(String num1,@RequestParam(required=false)String keyword,@RequestParam(required=false)String sort,
			@RequestParam(required=false)String ct_index1, @RequestParam String option){
	
		int num = Integer.parseInt(num1);
		int ct_index=0;
		if(ct_index1!="") {
			ct_index=Integer.parseInt(ct_index1);
		}
		if(keyword.equals("null")) {
			keyword="";
		}
		System.out.println("option : "+option);
		System.out.println("num : "+ num);
		System.out.println("keyword :" + keyword);
		System.out.println("ct_index :" + ct_index);
		System.out.println("sort: "+ sort);
		System.out.println("-------------------------");
		
		List<Project> p_list = projectService.selectProject_more(num,keyword,ct_index,sort,option);

		for(int i=0;i<p_list.size();i++) {
			int status = p_list.get(i).getP_status();
			int target = p_list.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			t = new SimpleDateFormat("yyyyMMddHHmm").format(today);
			end = p_list.get(i).getP_enddate();
			e = new SimpleDateFormat("yyyyMMddHHmm").format(end);
			
			long e_int = Long.parseLong(e);
			long t_int = Long.parseLong(t);
			
			gap = (int)(e_int - t_int);
			int count = fundService.fundcount(p_list.get(i).getP_index());
			p_list.get(i).setP_count(count);
			p_list.get(i).setPer(per);
			p_list.get(i).setGap(gap);
		}
			
		for(Project p: p_list){
			System.out.println(p.getP_enddate());
		}
		
		Map<String, Object> plist = new HashMap<String, Object>();
		plist.put("p_list", p_list);
		if(p_list.size()/9!=1) {
			plist.put("code","empty");
		}
		
		return plist;
	}
	
	
	// 내 프로젝트 관리 화면에 필요한 해당 아이디로 만든 프로젝트 조회
	@RequestMapping("MJS.do")
	public ModelAndView MJS(HttpServletRequest req) {
		int m_id = (Integer)req.getSession().getAttribute("m_id");
		List<Project> projectList = projectService.getProjectById(m_id);
		
		for(int i=0;i<projectList.size();i++) {
			int p_status = fundService.updateP_status(projectList.get(i).getP_index());
			projectList.get(i).setP_status(p_status);
			int status = projectList.get(i).getP_status();
			int target = projectList.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			
			if (target ==0) {
				per=0;
			}
			projectList.get(i).setPer(per);
			

		}
		System.out.println();
	
		ModelAndView mav = new ModelAndView();
		mav.addObject("producer", memberService.selectOneMemberById(m_id));
		mav.addObject("myProjectList", projectList);
		mav.setViewName("MJE_FORM");
		return mav;
	}
	
	// 내 프로젝트 관리 화면 요청
	@RequestMapping("MJE_FORM.do")
	public void MJE_FORM() {}
	
	// 프로젝트 승인 요청
	@RequestMapping("JJU.do")
	public @ResponseBody String JJU(int p_index, int p_approval) {
		System.out.println("승인 요청까지 옴..." + p_index);
		Map<String, Object> changeMap = new HashMap<>();
		changeMap.put("p_index", p_index);
		changeMap.put("p_approval", p_approval);
		
		int result = projectService.updateApproval(changeMap);
		if(result == 1) return "success";
		return "fail";
	}
	
	@RequestMapping("downloadP.do")
	public View downloadP(String p_index_str) {
		//해당게시물의 파일정보를 이용해서 파일을 가져옴	
		int p_index = Integer.parseInt(p_index_str);
		String type = "project";
		File attachFile = projectService.getAttachFile(p_index, type);
		//커스텀 뷰인 DownloadView를 이용해서 전달
		View view = new DownloadView(attachFile);
		return view;
	}
	
	@RequestMapping("downloadR.do")
	public View downloadR(String r_index_str) {
		//해당게시물의 파일정보를 이용해서 파일을 가져옴	
		int r_index = Integer.parseInt(r_index_str);
		String type = "reward";
		File attachFile = rewardService.getAttachFile(r_index, type);
		//커스텀 뷰인 DownloadView를 이용해서 전달
		View view = new DownloadView(attachFile);
		return view;
	}

	// 해당 프로젝트의 스토리 수정
	@RequestMapping("JSU_MODIFY.do")
	public @ResponseBody String JSU_MODIFY(int p_index, String p_contents, String type) {
		System.out.println("프로젝트 인덱스 : " + p_index);
		System.out.println("프로젝트 스토리 : " + p_contents);
		Project project = new Project();
		project.setP_index(p_index);
		project.setP_contents(p_contents);
		
		int result = projectService.updateStory(project);
		if(result == 1) return "success";
		return "fail";
	}

}
