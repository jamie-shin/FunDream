package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.Category;
import model.Member;
import model.Project;
import model.Reward;
import model.Story_Member;
import service.CategoryService;
import service.MemberService;
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
	
	@RequestMapping("MAIN.do") // 메인화면 요청
	public ModelAndView MAIN() {
		ModelAndView mav = new ModelAndView();
		//최신 프로젝트 3개
		List<Project> newlist = projectService.getNewProject();
		for(int i=0;i<3;i++) {
			int status = newlist.get(i).getP_status();
			int target = newlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			newlist.get(i).setPer(per);
		}
		mav.addObject("newlist", newlist);
		//마감임박 프로젝트 3개
		List<Project> endlist = projectService.getEndProject();
		for(int i=0;i<3;i++) {
			int status = endlist.get(i).getP_status();
			int target = endlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			endlist.get(i).setPer(per);
		}
		mav.addObject("endlist", endlist);
		//목표 달성 완료 프로젝트 3개
		List<Project> successlist = projectService.getSuccessProject();
		for(int i=0;i<3;i++) {
			int status = successlist.get(i).getP_status(); 
			int target = successlist.get(i).getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			successlist.get(i).setPer(per);
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
			public @ResponseBody String JBU_UPDATE(HttpServletRequest request /*,int p_index, int m_id, int ct_index, String p_name, String p_mainImg, int p_type, int p_target, String p_startdate, String p_enddate, boolean p_age*/) throws UnsupportedEncodingException {
				
				// 파일 업로드 부분
				request.setCharacterEncoding("UTF-8");
				String realFolder = "";
				String filename1 = "";
				int maxSize = 1024 * 1024 * 5;
				String savefile = "img";
				ServletContext scontext = request.getServletContext();
				realFolder = scontext.getRealPath(savefile);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, "UTF-8",
							new DefaultFileRenamePolicy());
					String p_index_str = multi.getParameter("p_index");
					int p_index = Integer.parseInt(p_index_str);
					String m_id_str = multi.getParameter("m_id");
					int m_id = 0;
					if(m_id_str!=null) {
						m_id =Integer.parseInt(m_id_str);
					}
					String ct_index_str = multi.getParameter("ct_index");
					int ct_index = Integer.parseInt(ct_index_str);
					String p_name = multi.getParameter("p_name");
					String p_type_str =multi.getParameter("p_type");
					int p_type = 0;
					if(p_type_str!=null) {
						p_type =Integer.parseInt(p_type_str);
					}
					String p_target_str =multi.getParameter("p_target");
					System.out.println("p_target_str : " + p_target_str);
					int p_target = 0;
					if(p_target_str!=null) {
						p_target=Integer.parseInt(p_target_str);
					}
					System.out.println("p_target : " + p_target);
					String p_startdate =multi.getParameter("p_startdate");
					String p_enddate =multi.getParameter("p_enddate");
					String p_age_str =multi.getParameter("p_age");
					Enumeration<?> files = multi.getFileNames();
					String file1 = (String) files.nextElement();
					filename1 = multi.getFilesystemName(file1);
					String fullpath = realFolder + "\\" + filename1;
					String applicationPath = request.getServletContext().getRealPath("img");
					String path = "img/" + filename1;
					// 목표금액 만원단위를 원단위로 변경
					int target = p_target * 10000;

					System.out.println("realFolder : "+realFolder);
					System.out.println("인덱스 : "+p_index);
					System.out.println("아이디: "+m_id);
					System.out.println("카테고리: "+ct_index);
					System.out.println("프로젝트명: "+p_name);
					System.out.println("프로젝트타입: "+p_type);
					System.out.println("목표금액: "+p_target);
					//System.out.println("시작일: "+ sdf.parse(p_startdate));
					//System.out.println("종료일: "+ sdf.parse(p_enddate));
					System.out.println("시작일: "+ p_startdate);
					System.out.println("종료일: "+ p_enddate);
					
					Project project = projectService.getOneProject(p_index);
					System.out.println("DB 프로젝트 : " + project);
					System.out.println("DB 카테고리 인덱스 : " + project.getCt_index());
					project.setCt_index(ct_index);
					project.setP_name(p_name);
					if(filename1 != null) {
						System.out.println("이미지 파일 : " + filename1);
						String s = filename1.replace(".", ",");
						String[] f = s.split(",");
						if (f[f.length - 1].equalsIgnoreCase("jpg") || f[f.length - 1].equalsIgnoreCase("png") || f[f.length - 1].equalsIgnoreCase("jpeg")) {
							project.setP_mainimg(path);
						} else {// 형식이 올바르지 않을경우 경고창 이후 history.go(-1)
							/*url = "redirect:alert1.do";*/
						}
					}
					
					project.setP_type(p_type);
					project.setP_target(target);
					if(p_startdate!=null) {
						project.setP_startdate(Timestamp.valueOf(p_startdate + " 00:00:00"));
					}
					if(p_enddate!=null) {
						project.setP_enddate(Timestamp.valueOf(p_enddate + " 00:00:00"));
					}
					// 미성년자 가능
					if(p_age_str == null) {
						project.setP_age(1);
					}
					// 미성년자 불가능
					if(p_age_str != null) {
						if(p_age_str.equals("on")){
							project.setP_age(2);
						}
					}
					int result = projectService.updateBasicInfo(project);
					if(result == 1) {
						return "success";
					}
					else {
						return "fail";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
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
						System.out.println("삽입 result : " + result);
						String story_Member_nick = URLEncoder.encode(member.getM_nick(), "UTF-8");
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
		
		// 신규 프로젝트 생성 후 해당 프로젝트 정보 수정(스토리)
//		@RequestMapping("")
		public void saveStory() {
			
		}
		
		// 신규 프로젝트 생성 후 해당 프로젝트 정보 수정(리워드)
//		@RequestMapping("")
		public void saveReward() {
			
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
		public @ResponseBody String JRI_INSERT(HttpServletRequest req/*, String p_index, String r_name, String r_price, String ct_index, String r_contents, String r_start, String r_option, String r_del, String r_amt*/) throws UnsupportedEncodingException {
			
			// 파일 업로드 부분
			req.setCharacterEncoding("UTF-8");
			String realFolder = "";
			String filename1 = "";
			int maxSize = 1024 * 1024 * 5;
			String savefile = "img";
			ServletContext scontext = req.getServletContext();
			realFolder = scontext.getRealPath(savefile);
			System.out.println("realFolder : " + realFolder);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				MultipartRequest multi = new MultipartRequest(req, realFolder, maxSize, "UTF-8",
						new DefaultFileRenamePolicy());
				String p_index_str = multi.getParameter("p_index");
				int p_index = Integer.parseInt(p_index_str);
				System.out.println("인덱스 : "+p_index);
				String r_name = multi.getParameter("r_name");
				String r_price_str = multi.getParameter("r_price");
				int r_price = Integer.parseInt(r_price_str);
				String ct_index_str = multi.getParameter("ct_index");
				int ct_index = Integer.parseInt(ct_index_str);
				String r_contents = multi.getParameter("r_contents");
				String delyear = multi.getParameter("delyear");
				String delmonth = multi.getParameter("delmonth");
				String delday = multi.getParameter("delday");
				String r_start = delyear+"-"+delmonth+"-"+delday;
				String r_option = multi.getParameter("r_option");
				String r_del_str = multi.getParameter("r_del");
				System.out.println("r_start : "+ r_start);
				int r_del=0;
				if(r_del_str!="0") {
					r_del = Integer.parseInt(r_del_str);
				}
				else {
					r_del=0;
				}
				String r_amt_str = multi.getParameter("r_amt");
				int r_amt=0;
				if(r_amt_str!=null) {
					r_amt = Integer.parseInt(r_amt_str);
				}
				else {
					r_amt =0;
				}
				
				Enumeration<?> files = multi.getFileNames();
				String file1 = (String) files.nextElement();
				filename1 = multi.getFilesystemName(file1);
				String fullpath = realFolder + "\\" + filename1;
				String applicationPath = req.getServletContext().getRealPath("img");
				String path = "img/" + filename1;
				
				
				Reward reward = new Reward();
				
				reward.setP_index(p_index);
				reward.setM_id(memberService.selectOneMemberByEmail((String)req.getSession().getAttribute("m_email")).getM_id());
				reward.setR_name(r_name);
				reward.setR_price(r_price);
				if(filename1 != null) {
					System.out.println("이미지 파일 : " + filename1);
					String s = filename1.replace(".", ",");
					String[] f = s.split(",");
					if (f[f.length - 1].equalsIgnoreCase("jpg") || f[f.length - 1].equalsIgnoreCase("png") || f[f.length - 1].equalsIgnoreCase("jpeg")) {
						reward.setR_img(path);
					} else {// 형식이 올바르지 않을경우 경고창 이후 history.go(-1)
						/*url = "redirect:alert1.do";*/
					}
				}
				reward.setCt_index(ct_index);
				reward.setR_contents(r_contents);
				reward.setR_start(Timestamp.valueOf(r_start + " 00:00:00"));
				reward.setR_option(r_option);
				reward.setR_del(r_del);
				reward.setR_amt(r_amt);
				int result = rewardService.addOneReward(reward);
				System.out.println("결과 : " + result + " / " + reward);
				if(result == 1) {
					String r_index = Integer.toString(reward.getR_index());
					return r_index;
				}
				else {
					return "0";
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return "0";
			
			//reward.setP_index(Integer.parseInt(p_index));
			//reward.setM_id(memberService.selectOneMemberByEmail((String)req.getSession().getAttribute("m_email")).getM_id());
			//reward.setR_name(r_name);
			//reward.setR_price(Integer.parseInt(r_price));
			//reward.setR_img("img/user.png");
			//reward.setCt_index(Integer.parseInt(ct_index));
			//reward.setR_contents(r_contents);
			//reward.setR_start(Timestamp.valueOf(r_start + " 00:00:00"));
			//reward.setR_option(r_option);
			//reward.setR_del(Integer.parseInt(r_del));
			//reward.setR_amt(Integer.parseInt(r_amt));
			/*int result = rewardService.addOneReward(reward);
			System.out.println("결과 : " + result + " / " + reward);
			if(result == 1) {
				String r_index = Integer.toString(reward.getR_index());
				return r_index;
			}
			else {
				return "0";
			}*/
		}
		
		// 리워드 삭제
		@RequestMapping("JRD_DELETE.do")
		public @ResponseBody String JRD_DELETE(String r_index) {
			int result = rewardService.deleteOneReward(Integer.parseInt(r_index));
			if(result == 1) {
				return "success";
			}
			else {
				return "fail";
			}
		}
		
		// 프로젝트 상세보기
		@RequestMapping("JPS_DETAIL.do")
		public ModelAndView JPS_DETAIL(int p_index,@RequestParam(value="m_id", required=false) String id) {
			System.out.println("id : "+id);
			ModelAndView mav = new ModelAndView();
			Project project = projectService.getOneProject(p_index);
			
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
			//들어오는사람이 누구인지
			mav.addObject("type", type);
			//프로젝트정보
			mav.addObject("project", project);
			//제작자 정보
			mav.addObject("m", m);
			mav.setViewName("JPS_DETAIL");
			return mav;
		}
		// 프로젝트 리스트 첫 화면 요청(최신순)
		@RequestMapping("JJS_FORM.do")
		public ModelAndView projectList(@RequestParam(required=false)String keyword, HttpSession session) {
			ModelAndView mav = new ModelAndView();
			List<Project> projectlist= null;
			List<Category> categoryList=categoryService.getCategoryListByType(1);
			if(keyword ==null) {
				projectlist = projectService.selectProject_accept();
				
			}
			else {
				session.setAttribute("keyword", keyword);
				projectlist =  projectService.selectProjectByKeyword(keyword);
			}
			for(int i=0;i<projectlist.size();i++) {
				int status = projectlist.get(i).getP_status();
				int target = projectlist.get(i).getP_target();
				double per2 = (double)status/(double)target*100;
				double per = Double.parseDouble(String.format("%.2f",per2));
				projectlist.get(i).setPer(per);
			}
			mav.addObject("list", projectlist);
			mav.addObject("cList", categoryList);
			mav.setViewName("JJS_FORM");
			return mav; 
		}
		
		// 프로젝트 리스트에서 더보기 클릭 시
		@RequestMapping(value="more.do",  method=RequestMethod.POST)		
		public @ResponseBody Map more(int num){
//			String number = (String)map.get("num");
//			int num = Integer.parseInt(number);
			System.out.println("num : "+ num);
			List<Project> p_list = projectService.selectProject_more(num);
			for(int i=0;i<p_list.size();i++) {
				int status = p_list.get(i).getP_status();
				int target = p_list.get(i).getP_target();
				double per2 = (double)status/(double)target*100;
				double per = Double.parseDouble(String.format("%.2f",per2));
				p_list.get(i).setPer(per);
			}
			/*for(int i=0;i< p_list.size();i++) {
				System.out.println(p_list.get(i));
			}*/
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
		
			ModelAndView mav = new ModelAndView();
			mav.addObject("myProjectList", projectList);
			mav.setViewName("MJE_FORM");
			return mav;
		}
		
		// 내 프로젝트 관리 화면 요청
		@RequestMapping("MJE_FORM.do")
		public void MJE_FORM() {}
		
		
		
		
		
		
		

}
