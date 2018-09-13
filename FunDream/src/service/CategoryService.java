package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ICategoryDao;
import model.Category;

@Service
public class CategoryService {

	@Autowired
	private ICategoryDao categoryDao;
	
	public List<Category> getCategoryListByType(int ct_type){
		return categoryDao.selectCategoriesByType(ct_type);
	}
	
	public List<Category> getAllCategoryList(){
		return categoryDao.selectAllCategories();
	}
	
	public int deleteOneCategory(int ct_index) {
		return categoryDao.deleteOneCategory(ct_index);
	}

	public int updateOneCategory(Category category) {
		return categoryDao.updateOneCategory(category);
	}
	
	public int insertCategory(Category category) {
		return categoryDao.insertCategory(category);
	}
	
}
