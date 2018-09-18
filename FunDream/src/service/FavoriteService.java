package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IFavoriteDao;
import model.Favorite;

@Service
public class FavoriteService {
	
	@Autowired
	private IFavoriteDao favoriteDao;
	
	public int insertFavorite(Favorite favorite) {
		return favoriteDao.insertFavorite(favorite);
	}
	
	public int deleteFavorite(int fv_index) {
		return favoriteDao.deleteFavorite(fv_index);
	}
	
	public List<Favorite> selectFavoritesById(int m_id){
		return favoriteDao.selectFavoritesById(m_id);
	}

}
