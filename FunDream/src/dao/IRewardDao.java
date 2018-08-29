package dao;

import java.util.List;

import model.Reward;

public interface IRewardDao {
	
	public List<Reward> selectAllRewards();

}
