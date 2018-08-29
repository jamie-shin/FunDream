package dao;

import java.util.List;

import model.Project;

public interface IProjectDao {
	
	public List<Project> selectAllProjects();

}
