package service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.IRewardDao;
import model.Project;
import model.Reward;

@Service
public class RewardService {
	
	@Autowired
	private IRewardDao rewardDao;
	
	public List<Reward> getAllRewards(){
		return rewardDao.selectAllRewards();
	}

	public int addOneReward(Reward reward, String type, MultipartFile file) {
		
		String path = "C:/Temp/FunDream/"+type+"/";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs(); //해당경로에 디렉토리가 없으면 생성
		String fileName = file.getOriginalFilename();
		File attachFile = new File(path + fileName);
		
		try {
			//파일 복사
			file.transferTo(attachFile);
			//파일정보를 db에저장
			reward.setR_img(fileName);
			System.out.println(path+fileName);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rewardDao.insertReward(reward);
	}
	
	public int deleteOneReward(int r_index) {
		return rewardDao.deleteReward(r_index);
	}

	public List<Reward> getRewardsByProject(int p_index) {
		// TODO Auto-generated method stub
		return rewardDao.selectRewardsByProject(p_index);
	}

	public Reward getOneRewardByIndex(int r_index) {
		// TODO Auto-generated method stub
		return rewardDao.selectOneRewardByIndex(r_index);
	}

	public int updateOneReward(Reward reward, String type, MultipartFile file) {
		// TODO Auto-generated method stub
		
		String path = "C:/Temp/FunDream/"+type+"/";
		File dir = new File(path);
		if(!dir.exists()) dir.mkdirs(); //해당경로에 디렉토리가 없으면 생성
		String fileName = file.getOriginalFilename();
		File attachFile = new File(path + fileName);
		
		try {
			//파일 복사
			file.transferTo(attachFile);
			//파일정보를 db에저장
			reward.setR_img(fileName);
			System.out.println(path+fileName);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rewardDao.updateOneReward(reward);
	}
	
	public File getAttachFile(int r_index, String type) {
		// TODO Auto-generated method stub
		Reward reward = rewardDao.selectOneRewardByIndex(r_index);
		String fileName = reward.getR_img();  //DB안에 있는 파일 정보
		String path = "C:/Temp/FunDream/reward/";
		return new File(path+fileName);
	}
	
}
