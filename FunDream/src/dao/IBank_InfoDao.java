package dao;

import model.Bank_Info;

public interface IBank_InfoDao {
	
	public int insertBank_info(Bank_Info bank_info);
	public Bank_Info selectOneBank_infoByF_index(int f_index);
	public void deleteOneBank_infoByF_index(int f_index);
	public Bank_Info selectOneBankByProject(int p_index);
	
}
