package service;

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
}
