package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IRewardDao;
import model.Reward;

@Service
public class RewardService {
	
	@Autowired
	private IRewardDao rewardDao;
	
	public List<Reward> getAllRewards(){
		return rewardDao.selectAllRewards();
	}

	public int addOneReward(Reward reward) {
		return rewardDao.insertReward(reward);
	}
	
	public int deleteOneReward(int r_index) {
		return rewardDao.deleteReward(r_index);
	}

	public List<Reward> getRewardsByProject(int p_index) {
		// TODO Auto-generated method stub
		return rewardDao.selectRewardsByProject(p_index);
	}

}
