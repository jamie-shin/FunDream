package dao;

import java.util.List;

import model.Reward;

public interface IRewardDao {
	
	public List<Reward> selectAllRewards();
	public int insertReward(Reward reward);
	public int deleteReward(int r_index);
	public List<Reward> selectRewardsByProject(int p_index);
	public Reward selectOneRewardByIndex(int r_index);
	public int updateOneReward(Reward reward);

}
