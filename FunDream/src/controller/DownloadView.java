package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//첨부파일을 다운로드 받기위한 뷰

public class DownloadView extends AbstractView {
	
	private File file;
	
	public DownloadView(File file) {
		// TODO Auto-generated constructor stub
		setContentType("application/download; utf-8");
		this.file = file;
	}	
	
	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> arg0, 
			HttpServletRequest request, 
			HttpServletResponse response)throws Exception {
		
		//응답객체에 컨텐츠 타입과 길이 설정
		response.setContentType(getContentType());
		response.setContentLength((int)file.length());
		
		//브라우저가 IE인지 판별
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
 		
		String filename = null;
		if(ie) {
			filename = URLEncoder.encode(file.getName(), "utf-8");
		}
		else {
			filename = new String(file.getName().getBytes("utf-8"));
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(fis != null) try {
				fis.close();
			}catch(Exception e) {
				
			}
		}
		
		out.flush();
		
	}

}














