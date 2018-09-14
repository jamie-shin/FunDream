package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.Bank_Info;
import model.Card_Info;
import model.Delivery;
import model.Fund;
import model.Fund_Detail;
import model.Member;
import model.Project;
import model.Reward;
import service.Bank_InfoService;
import service.Card_InfoService;
import service.DeliveryService;
import service.FundService;
import service.Fund_DetailService;
import service.MemberService;
import service.ProjectService;
import service.RewardService;

@Controller
public class FundController {
	
	@Autowired
	private ProjectService projectservice;
	
	@Autowired
	private RewardService rewardservice;
	
	@Autowired
	private FundService fundservice;
	
	@Autowired
	private Fund_DetailService fdservice;
	
	@Autowired
	private DeliveryService deliveryservice;
	
	@Autowired
	private Bank_InfoService biservice;
	
	@Autowired
	private Card_InfoService ciservice;
	
	@Autowired
	private MemberService memberservice;
	
	//후원하기 버튼 누를시
	@RequestMapping("JFI_FORM.do")
	public ModelAndView JFI_FORM(@RequestParam int p_index){
		ModelAndView mav = new ModelAndView();
		//프로젝트 정보
		Project p = projectservice.getOneProject(p_index);
		//리워드 정보
		List<Reward> r_list = rewardservice.getRewardsByProject(p_index);
		Map<String, Object> map = new HashMap<String,Object>();
		for(int i=0;i<r_list.size();i++) {
			if(r_list.get(i).getR_del()!=0) {
				map.put("del", "yes");
				break;
			}
			else {
				map.put("del", "no");
			}
		}
		mav.addObject("map", map);
		mav.addObject("project", p);
		mav.addObject("r_list", r_list);
		mav.setViewName("JFI_FORM"); 
		return mav;
	}
	//후원하기
	@RequestMapping(value="JFE_SUPPORT.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> JFE_SUPPORT(@RequestBody Map<String, Object> map) {
		//fund 테이블에 들어갈 정보 받아와서 DB생성
		String m_id_str = (String) map.get("m_id");
		String p_index_str = (String) map.get("p_index");
		String f_price_str = (String) map.get("f_price");
		String f_payment_str = (String) map.get("f_payment");
		
		int m_id= Integer.parseInt(m_id_str);
		int p_index= Integer.parseInt(p_index_str);
		int f_price= Integer.parseInt(f_price_str);
		int f_payment= Integer.parseInt(f_payment_str);
		
		Fund fund = new Fund();
		fund.setM_id(m_id);
		fund.setP_index(p_index);
		fund.setF_price(f_price);
		fund.setF_payment(f_payment);
		
		fundservice.insertFund(fund);
		
		int f_index= fund.getF_index();

		//fund_detail 테이블에 들어갈 정보 받아와서 DB생성
		Fund_Detail fd = new Fund_Detail();
		for(int i=0;i<10;i++) {
			//String fd_amt_str = (String)map.get("fd_amt"+i);
			if((String)map.get("fd_amt"+i)!=null) {
				String r_index_str = (String)map.get("r_index"+i);
				int r_index = Integer.parseInt(r_index_str);
				String fd_amt_str = (String)map.get("fd_amt"+i);
				int fd_amt = Integer.parseInt(fd_amt_str);
				String fd_r_option = (String)map.get("fd_r_option"+i);
				
				fd.setF_index(f_index);
				fd.setR_index(r_index);
				fd.setFd_amt(fd_amt);
				fd.setFd_r_option(fd_r_option);
		
				fdservice.insertFund(fd);
			}
		}
		
		//delivery 테이블에 들어갈 정보 받아와서 DB생성
		Delivery delivery = new Delivery();
		if(map.get("v_name")!=null) {
			
			String v_name=(String) map.get("v_name");
			String v_phone=(String) map.get("v_phone");
			String v_add=(String) map.get("v_add");
			String v_postnum=(String) map.get("v_postnum");
			String v_msg=null;
			if((String) map.get("v_msg")!=null) {
				v_msg=(String) map.get("v_msg");
			}
			
			delivery.setF_index(f_index);
			delivery.setV_name(v_name);
			delivery.setV_phone(v_phone);
			delivery.setV_add(v_add);
			delivery.setV_msg(v_msg);
			delivery.setM_id(m_id);
			delivery.setP_index(p_index);
			delivery.setV_postnum(v_postnum);
			
			deliveryservice.insertDelivery(delivery);
		}
		
		
		//bank_info 테이블에 들어갈 정보 받아와서 DB생성
		Bank_Info bi = new Bank_Info();
		
		String b_owner=null;
		String b_account=null;
		String b_bankname=null;
		if(f_payment==1) {
			b_owner=(String) map.get("b_owner");
			b_account=(String) map.get("b_account");
			b_bankname=(String) map.get("b_bankname");
			
			bi.setF_index(f_index);
			bi.setB_owner(b_owner);
			bi.setB_account(b_account);
			bi.setB_bankname(b_bankname);
			
			biservice.insertBank_Info(bi);
			
			int b_index= bi.getB_index();
			System.out.println("b_index : "+b_index);
			fund.setB_index(b_index);
			
		}
		
		//card_info 테이블에 들어갈 정보 받아와서 DB생성
		Card_Info ci = new Card_Info();
		
		String cd_num_str=null;
		String cd_valid =null;
		String cd_cvc_str = null;
		String cd_cardname =null;
		int cd_num=0;
		int cd_cvc = 0;
		if(f_payment==2) {
			cd_num_str=(String) map.get("cd_num");
			cd_cvc_str=(String) map.get("cd_cvc");
			cd_valid=(String) map.get("cd_valid");
			cd_cardname=(String) map.get("cd_cardname");
			cd_num=Integer.parseInt(cd_num_str);
			cd_cvc=Integer.parseInt(cd_cvc_str);
			
			ci.setF_index(f_index);
			ci.setCd_num(cd_num);
			ci.setCd_valid(cd_valid);
			ci.setCd_cvc(cd_cvc);
			ci.setCd_cardname(cd_cardname);
			
			ciservice.insertCard_Info(ci);
			
			int cd_index=ci.getCd_index();
			System.out.println("cd_index : "+cd_index);
			fund.setCd_index(cd_index);
		}
		fundservice.updateFund(fund);
		
		Project p = projectservice.getOneProject(p_index);
		int p_status = fundservice.updateP_status(p_index);
		p.setP_status(p_status);
		projectservice.update_P_status(p);
		
		Map<String, Object> re = new HashMap<String,Object>();
		re.put("code", "MS_MYFUND.do");
		return re;
	}
	
	//내가 후원한 목록
	@RequestMapping("MS_MYFUND.do")
	public ModelAndView MS_MYFUND(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		int m_id = (int)req.getSession().getAttribute("m_id");
		List<Fund> f_list = fundservice.selectAllFundByM_id(m_id);
		
		List<List<Object>> test=new ArrayList<List<Object>>();
		
		for(Fund f:f_list) {
			List<Object> list=new ArrayList<Object>();
			Project p = projectservice.getOneProject(f.getP_index());
			int status = p.getP_status();
			int target = p.getP_target();
			double per2 = (double)status/(double)target*100;
			double per = Double.parseDouble(String.format("%.2f",per2));
			p.setPer(per);
			list.add(f);
			list.add(p);
			test.add(list);
		}
		
		mav.addObject("test", test);
		
		Member m = memberservice.selectOneMemberById(m_id);
		mav.addObject("m", m);
		mav.setViewName("MS_MYFUND");
		return mav;
	}
	
	//내가 후원한 프로젝트인지 확인
	@RequestMapping(value="checkFund.do",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkFund(@RequestBody Map<String, Object> map) {
		String m_id_str = (String) map.get("m_id");
		String p_index_str = (String) map.get("p_index");
		int m_id = Integer.parseInt(m_id_str);
		int p_index= Integer.parseInt(p_index_str);
		Map<String, Object> re = new HashMap<String,Object>();
		if(fundservice.checkFund(m_id, p_index)!=null) {
			System.out.println("나와라 얍");
			re.put("msg","unable");
		}
		else {
			re.put("msg","able");
		}
		
		return re;
	}
	//내가 후원한 프로젝트 상세보기
	@RequestMapping("MS_MYFUNDDETAIL.do")
	public ModelAndView MS_MYFUNDDETAIL(int f_index) {
		ModelAndView mav = new ModelAndView();
		//펀드 정보
		Fund fund = fundservice.selectOneFindByF_index(f_index);
		mav.addObject("fund", fund);
		//펀드디테일 정보
		List<Fund_Detail> fd_list = fdservice.selectAllFund_DetailByF_index(f_index);
		//후원한 리워드에 대한 정보
		List<List<Object>> test = new ArrayList<List<Object>>();
		for(Fund_Detail fd : fd_list) {
			List<Object> list = new ArrayList<Object>();
			Reward r = rewardservice.getOneRewardByIndex(fd.getR_index());
			list.add(fd);
			list.add(r);
			test.add(list);
		}
		mav.addObject("test", test);
		
		//배송정보
		Delivery delivery = deliveryservice.selectOneDeliveryByF_index(f_index);
		mav.addObject("delivery", delivery);
		//결제 정보
		int f_payment = fund.getF_payment();
		if(f_payment==1) {
			Bank_Info bi = biservice.selectOneBank_infoByF_index(f_index);
			mav.addObject("bank", bi);
		}
		else if(f_payment==2) {
			Card_Info ci = ciservice.selectOneCard_infoByF_index(f_index);
			mav.addObject("card", ci);
		}
		int p_index = fund.getP_index();
		mav.addObject("p_index", p_index);
		
		Project p = projectservice.getOneProject(p_index);
		String p_name = p.getP_name();
		mav.addObject("p_name", p_name);
		
		mav.setViewName("MS_MYFUNDDETAIL");
		return mav;
	}
	
	@RequestMapping("MD_MYFUND.do")
	public String MD_MYFUND(int f_index) {
		//biservice.deleteOneBank_infoByF_index(f_index);
		//ciservice.deleteOneCard_infoByF_index(f_index);
		//deliveryservice.deleteOneDeliveryByF_index(f_index);
		//fdservice.deleteOneFund_DetailByF_index(f_index);
		//fundservice.deleteOneFundByF_index(f_index);
		fundservice.update_cancel(f_index);
		
		Fund f = fundservice.selectOneFindByF_index(f_index);
		int p_index = f.getP_index();
		Project p = projectservice.getOneProject(p_index);
		int p_status = fundservice.updateP_status(p_index);
		p.setP_status(p_status);
		projectservice.update_P_status(p);
		
		return "redirect:MS_MYFUND.do";
	}
	
	
}
