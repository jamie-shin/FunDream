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

}
