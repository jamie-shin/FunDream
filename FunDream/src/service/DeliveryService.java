package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IDeliveryDao;
import model.Delivery;

@Service
public class DeliveryService {
	
	@Autowired
	private IDeliveryDao deliveryDao;
	
	public int insertDelivery(Delivery delivery) {
		return deliveryDao.insertDelivery(delivery);
	}
	
	public Delivery selectOneDeliveryByF_index(int f_index) {
		return deliveryDao.selectOneDeliveryByF_index(f_index);
	}
	
	public void deleteOneDeliveryByF_index(int f_index) {
		deliveryDao.deleteOneDeliveryByF_index(f_index);
	}
}
