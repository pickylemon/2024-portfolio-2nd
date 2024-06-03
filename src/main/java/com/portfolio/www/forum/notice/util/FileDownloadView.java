package com.portfolio.www.forum.notice.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FileDownloadView extends AbstractView{
	
	//객체 생성시에 content-type을 지정한다.
	public FileDownloadView() {
		setContentType("application/download; charset=UTF-8");
	}

	//왜 model의 타입이 Model이 아니라 Map일까? 물론 Model이 Map인건 맞지만
	//왜 매개변수의 타입이 Model이 아닌지 궁금. 
	//--> render메서드에서 model,request,response를 조합해 Map타입의 mergedModel을 반환한다.
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		DownloadInfo fileInfo = (DownloadInfo)model.get("fileInfo");
		
		//헤더 세팅이 중요하다.
		response.setContentType(getContentType());
		response.setContentLength((int)fileInfo.getDownloadFile().length());
		
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		
		String fileNm = null;
		if(ie) {
			fileNm = URLEncoder.encode(fileInfo.getOrgFileNm(), "UTF-8");
		} else {
			fileNm = new String(fileInfo.getOrgFileNm().getBytes("UTF-8"), "ISO-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+ fileNm + "\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		//파일 읽어와서 Response의 outputStream에 보내기
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
	
		fis = new FileInputStream(fileInfo.getDownloadFile());
		//FileCopyUtils.copy()에서 내부적으로 read, write, flush, close까지 다 진행됨.
		FileCopyUtils.copy(fis, out);
		
		//일괄 다운받기로 인해 만든 zip파일의 경우에는 
		//유저의 파일 다운로드가 끝나면 해당 zip파일을 삭제해야한다. 
		//즉, 일괄다운로드인지 개별 다운로드인지에 따라 파일 삭제 여부가 결정됨
		if(fileInfo.isCompressedFile()) {
			fileInfo.getDownloadFile().delete();
		}
	}	
}
