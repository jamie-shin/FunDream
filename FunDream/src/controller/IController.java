package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.Category;
import model.Project;
import service.CategoryService;
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

}
