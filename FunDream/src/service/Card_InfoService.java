package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ICard_InfoDao;
import model.Card_Info;

@Service
public class Card_InfoService {
	
	@Autowired
	private ICard_InfoDao ciDao;
	
	public int insertCard_Info(Card_Info ci) {
		return ciDao.insertCard_info(ci);
	}
	
	public Card_Info selectOneCard_infoByF_index(int f_index) {
		return ciDao.selectOneCard_infoByF_index(f_index);
	}
	
	public void deleteOneCard_infoByF_index(int f_index) {
		ciDao.deleteOneCard_infoByF_index(f_index);
	}
}
