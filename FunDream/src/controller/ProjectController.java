package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.Project;
import service.MemberService;
import service.ProjectService;
import service.RewardService;

@Controller
public class ProjectController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private RewardService rewardService;
	
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
}
