package dao;

import java.util.List;

import model.Favorite;

public interface IFavoriteDao {
	
	public int insertFavorite(Favorite favorite);
	public int deleteFavorite(int fv_index);
	public List<Favorite> selectFavoritesById(int m_id);
	public Favorite selectOneFavoriteByIdProject(Favorite favorite);
	
}
