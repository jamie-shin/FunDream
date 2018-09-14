package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IFundDao;
import model.Fund;

@Service
public class FundService {
	
	@Autowired
	private IFundDao fundDao;
	
	public int insertFund(Fund fund) {
		return fundDao.insertFund(fund);
	}
	
	public void updateFund(Fund fund) {
		fundDao.updateFund(fund);
	}
	
	public List<Fund> selectAllFundByM_id(int m_id){
		return fundDao.selectAllFundByM_id(m_id);
	}
	
	public Fund checkFund(int m_id,int p_index) {
		Map<String, Object> param = new HashMap<String,Object>();
		param.put("m_id", m_id);
		param.put("p_index", p_index);
		return fundDao.checkFund(param);
	}
	
	public Fund selectOneFindByF_index(int f_index) {
		return fundDao.selectOneFindByF_index(f_index);
	}
	
	public void deleteOneFundByF_index(int f_index) {
		fundDao.deleteOneFundByF_index(f_index);
	}
	
	public int fundcount(int p_index) {
		return fundDao.fundcount(p_index);
	}
	
	public void update_cancel(int f_index) {
		fundDao.update_cancel(f_index);
	}
	
	public int updateP_status(int p_index) {
		String p_status_str = fundDao.updateP_status(p_index);
		int p_status=0;
		if(p_status_str!=null) {
			p_status=Integer.parseInt(p_status_str);
		}
		if(p_status==0) {
			return 0;
		}
		return p_status;
	}
}
