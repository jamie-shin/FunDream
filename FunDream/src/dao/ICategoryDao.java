package dao;

import java.util.List;

import model.Category;

public interface ICategoryDao {
	
	public List<Category> selectAllCategories();
	public List<Category> selectCategoriesByType(int ct_type);
	public int deleteOneCategory(int ct_index);
	public int updateOneCategory(Category category);
	public int insertCategory(Category category);
	
}
