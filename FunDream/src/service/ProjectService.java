package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IProjectDao;

@Service
public class ProjectService {
	
	@Autowired
	private IProjectDao projectDao;

}
