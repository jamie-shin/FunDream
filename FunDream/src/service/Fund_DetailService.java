package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IFund_detailDao;
import model.Fund_Detail;

@Service
public class Fund_DetailService {
	
	@Autowired
	private IFund_detailDao fdDao;
	
	public int insertFund(Fund_Detail fd) {
		return fdDao.insertFund_detail(fd);
	}
	public List<Fund_Detail> selectAllFund_DetailByF_index(int f_index) {
		return fdDao.selectAllFund_DetailByF_index(f_index);
	}
	public void deleteOneFund_DetailByF_index(int f_index) {
		fdDao.deleteOneFund_DetailByF_index(f_index);
	}
	public void update_cancel(int f_index) {
		fdDao.update_cancel(f_index);
	}
	public List<Fund_Detail> selectFDByR_index(int r_index){
		return fdDao.selectFDByR_index(r_index);
	}
	
	public HashMap<String, Object> fd_amt(int r_index) {
		HashMap<String, Object> map = fdDao.fd_amt(r_index);
		
		return map;
	}
}
