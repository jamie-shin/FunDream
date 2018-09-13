package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Project;

public interface IProjectDao {
	
	public List<Project> selectAllProjects();
	//최신순
	public List<Project> selectNewProject();
	//마감임박
	public List<Project> selectEndProject();
	//목표 달성 완료
	public List<Project> selectSuccessProject();
	
	
	public int insertProject(Project project);
	public Project selectOneProjectByIndex(int p_index);
	public int updateBasicInfo(Project project);
	public List<Project> selectProjectsById(int m_id);
	public int updatePolicy(Project project);
	
	public List<Project> selectProject_more(HashMap<String, Object> params);
	
	public List<Project> selectProjectsByCategory(int ct_index);
	public List<Project> selectProjectsByApproval(int p_approval);
	public List<Project> selectProjectsByProgress(int progress);
	public List<Project> selectProjectsByCalculate(HashMap<String, Object> selectMap);
	public int updateApproval(Map<String, Object> changeMap);
	
}
