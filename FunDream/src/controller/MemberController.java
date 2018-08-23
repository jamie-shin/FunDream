package controller;

import java.util.Properties;

import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class MemberController {

	private final String send_email = "FunDream2018@gmail.com";
	private final String send_email_pw = "1q2w3e4r`";

	@RequestMapping("MIE_LOGINFORM.do")//메뉴바에서 로그인버튼 눌렀을떄
	public String MIE_LOGINFORM() {
		return "MIE_LOGINFORM";        
	}
	
	@RequestMapping("MSE_JOINFORM.do")//회원가입창 요청
	public String MSE_JOINFORM() {
		return "MSE_JOINFORM";
	}
	

	@RequestMapping("MSE_SENDC.do")//이메일 인증 버튼
	public void MSE_SENDC(@RequestParam("m_email")String m_email) {
		System.out.println(m_email);
		String code="aaaa";
	    
	    Properties props = new Properties();
	    props.setProperty("mail.transport.protocol", "smtp");
	    props.setProperty("mail.host", "smtp.gmail.com");
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.port", "465");
	    props.put("mail.smtp.socketFactory.port", "465");
	    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    props.put("mail.smtp.socketFactory,fallback", "false");
	    props.setProperty("mail.smtp.quitwait", "false");
	    
	    Authenticator auth = new Authenticator() {
	       protected PasswordAuthentication getPasswordAuthentication() {
	          return new PasswordAuthentication(send_email, send_email_pw);
	       }
	    };
	    
	    Session session = Session.getDefaultInstance(props, auth);
	    
	    MimeMessage message = new MimeMessage(session);
	    try {
			message.setSender(new InternetAddress(send_email));
	    message.setSubject("FunDream 사이트 회원가입 인증코드");
	    message.setRecipient(Message.RecipientType.TO, new InternetAddress(m_email));
	    
	    Multipart mp = new MimeMultipart();
	    MimeBodyPart mbp1 = new MimeBodyPart();
	    mbp1.setText("CODE : " + code);
	    mp.addBodyPart(mbp1);
	    
	    MailcapCommandMap mc = (MailcapCommandMap)CommandMap.getDefaultCommandMap();
	    mc.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
	    mc.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
	    mc.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
	    mc.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
	    mc.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
	    CommandMap.setDefaultCommandMap(mc);
	    
	    message.setContent(mp);
	    Transport.send(message);
	    
	    } catch (MessagingException e) {
	    	// TODO Auto-generated catch block
	    	e.printStackTrace();
	    }
	    
	 
	}
	
	@RequestMapping("MSI_JOIN.do") //회원가입완료 버튼
	public void MSI_JOIN() {
		
	}
	
	@RequestMapping("MIS_LOGIN.do")//로그인창에서 로그인버튼
	public void MIS_LOGIN() {
		
	}
	
	@RequestMapping("MOE.do")//메뉴바에서 로그아웃버튼
	public void MOE() {
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("MSE_SETPWFORM.do")//비밀번호 찾기화면 요청
	public void MSE_SETPW() {
		
	}
	
	@RequestMapping("MSE_SETPW.do")//비밀번호 찾기(이메일인증 코드 확인)
	public void MSE_CODE() {
		
	}
	
	@RequestMapping("MSS_SETPW.do")//DB접속해서 맞는지 확인
	public void MSS_SETPW() {
		
	}
	
	@RequestMapping("MSU_SETPW.do")//새비밀번호 설정
	public void MSU_SETPW() {
		
	}
	
	
}
