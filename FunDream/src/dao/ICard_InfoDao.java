package dao;

import model.Card_Info;

public interface ICard_InfoDao {
	
	public int insertCard_info(Card_Info card_info);
	public Card_Info selectOneCard_infoByF_index(int f_index);
	public void deleteOneCard_infoByF_index(int f_index);
}
