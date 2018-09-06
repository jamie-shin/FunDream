package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IProjectDao;
import model.Project;

@Service
public class ProjectService {

	@Autowired
	private IProjectDao projectDao;

	public List<Project> getAllProjects() {
		return projectDao.selectAllProjects();
	}

	// 최신 프로젝트 3개
	public List<Project> getNewProject() {
		List<Project> newlist = projectDao.selectNewProject();
		return newlist;
	}

	// 마감임박 프로젝트 3개
	public List<Project> getEndProject() {
		List<Project> endlist = projectDao.selectEndProject();
		return endlist;
	}

	// 목표 달성 완료 프로젝트 3개
	public List<Project> getSuccessProject() {
		List<Project> successlist = projectDao.selectSuccessProject();
		return successlist;
	}
	
	
	// 회원 아이디로 새로운 프로젝트 생성
		public int insertProject(Project project) {
			return projectDao.insertProject(project);
		}
		
		public Project getOneProject(int p_index) {
			// TODO Auto-generated method stub
			return projectDao.selectOneProjectByIndex(p_index);
		}
		
		// 프로젝트 기본정보 수정 
		public int updateBasicInfo(Project project) {
			// TODO Auto-generated method stub
			return projectDao.updateBasicInfo(project);
		}
		
		public List<Project> getProjectById(int m_id){
			return projectDao.selectProjectsById(m_id);
		}
		
		// 해당 아이디로 조회한 프로젝트 중 프로젝트 승인 요청 전(4)인 프로젝트 조회
		public List<Project> getIngProjectById(int m_id){
			List<Project> IngprojectList = new ArrayList<Project>();
			List<Project> projectList = getProjectById(m_id);
			if(projectList.size() > 0) {
				for(Project p : projectList) {
					if(p.getP_approval() == 4) {
						IngprojectList.add(p);
					}
				}
			}
			else {
				IngprojectList = null;
			}
			System.out.println("project : " + IngprojectList);
			return IngprojectList;
		}
		
		// 해당 아이디로 조회한 프로젝트 중 프로젝트 승인 대기 중(1)인 프로젝트 조회
		public List<Project> getWaitProjectById(int m_id){
			List<Project> projectList = projectDao.selectProjectsById(m_id);
			List<Project> IngprojectList = new ArrayList<Project>();
			for(Project p : projectList) {
				if(p.getP_approval() == 1) {
					IngprojectList.add(p);
				}
			}
			return IngprojectList;
		}
		
		// 해당 아이디로 조회한 프로젝트 중 프로젝트 승인 완료(2)인 프로젝트 조회
		public List<Project> getApproveProjectById(int m_id){
			List<Project> projectList = projectDao.selectProjectsById(m_id);
			List<Project> IngprojectList = new ArrayList<Project>();
			for(Project p : projectList) {
				if(p.getP_approval() == 2) {
					IngprojectList.add(p);
				}
			}
			return IngprojectList;
		}
		
		// 해당 아이디로 조회한 프로젝트 중 프로젝트 승인 반려(3)인 프로젝트 조회
		public List<Project> getReturnProjectById(int m_id){
			List<Project> projectList = projectDao.selectProjectsById(m_id);
			List<Project> IngprojectList = new ArrayList<Project>();
			for(Project p : projectList) {
				if(p.getP_approval() == 3) {
					IngprojectList.add(p);
				}
			}
			return IngprojectList;
		}
		
		// 프로젝트 정책확인 수정 
		public int updatePolicy(Project project) {
			// TODO Auto-generated method stub
			return projectDao.updatePolicy(project);
		}
		
		//p_approval=2인 모든 프로젝트 받아오기
		public List<Project> selectProject_accept(){
			return projectDao.selectProject_accept();
		}
		
		public List<Project> selectProject_more(int num){
			int number= num*9;
			return projectDao.selectProject_more(number);
		}
		
		//검색 
		public List<Project> selectProjectByKeywordOrCt(String keyword, String ct_index) {
			// TODO Auto-generated method stub
			System.out.println("service <키워드:"+keyword+">");
			System.out.println("service <카테고리: "+ct_index+">");
			HashMap<String, Object> params = new HashMap<>();
			params.put("keyword", keyword);
			params.put("ct_index", ct_index);
			List<Project> list = projectDao.selectProjectByKeywordOrCt(params);
			System.out.println("service 리스트 사이즈 : " + list.size());
			
			return list;
		}
		
}
