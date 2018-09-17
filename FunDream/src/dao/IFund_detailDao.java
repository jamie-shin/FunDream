package dao;

import java.util.HashMap;
import java.util.List;

import model.Fund_Detail;

public interface IFund_detailDao {
	
	public int insertFund_detail(Fund_Detail fund_detail);
	public List<Fund_Detail> selectAllFund_DetailByF_index(int f_index);
	public void deleteOneFund_DetailByF_index(int f_index);
	public void update_cancel(int f_index);
	public List<Fund_Detail> selectFDByR_index(int r_index);
	
	public HashMap<String, Object> fd_amt(int r_index);
}
