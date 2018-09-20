package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IBank_InfoDao;
import model.Bank_Info;

@Service
public class Bank_InfoService {
	
	@Autowired
	private IBank_InfoDao biDao;
	
	public int insertBank_Info(Bank_Info bi) {
		return biDao.insertBank_info(bi);
	}
	
	public Bank_Info selectOneBank_infoByF_index(int f_index) {
		return biDao.selectOneBank_infoByF_index(f_index);
	}
	
	public void deleteOneBank_infoByF_index(int f_index) {
		biDao.deleteOneBank_infoByF_index(f_index);
	}
	
	public Bank_Info selectBankByProject(int p_index) {
		// TODO Auto-generated method stub
		return biDao.selectOneBankByProject(p_index);
	}
	
}
