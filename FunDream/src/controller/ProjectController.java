package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

}
