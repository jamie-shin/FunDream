package service;

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
}
