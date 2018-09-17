package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Fund;

public interface IFundDao {
	
	public int insertFund(Fund fund);
	public void updateFund(Fund fund);
	public List<Fund> selectAllFundByM_id(int m_id);
	public Fund checkFund(Map<String, Object> param);
	public Fund selectOneFindByF_index(int f_index);
	public void deleteOneFundByF_index(int f_index);
	public int fundcount(int p_index);
	public void update_cancel(int f_index);
	public String updateP_status(int p_index);
	
	public int fund_pop(int p_index);
	public String total_fund(int p_index);
	
	public List<HashMap<String, Object>>  fund_list(int p_index);
	
	public List<Fund> selectAllFundByP_index(int p_index);
}
