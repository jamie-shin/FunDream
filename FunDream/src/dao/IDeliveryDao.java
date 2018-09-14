package dao;

import model.Delivery;

public interface IDeliveryDao {
	
	public int insertDelivery(Delivery delivery);
	public Delivery selectOneDeliveryByF_index(int f_index);
	public void deleteOneDeliveryByF_index(int f_index);
}
