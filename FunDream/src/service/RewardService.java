package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.IRewardDao;

@Service
public class RewardService {
	
	@Autowired
	private IRewardDao rewardDao;

}
