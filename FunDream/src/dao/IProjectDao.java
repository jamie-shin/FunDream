package dao;

import java.util.List;

import model.Project;

public interface IProjectDao {
	
	public List<Project> selectAllProjects();
	//최신순
	public List<Project> selectNewProject();
	//마감임박
	public List<Project> selectEndProject();
	//목표 달성 완료
	public List<Project> selectSuccessProject();
}
