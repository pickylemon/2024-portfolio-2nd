package com.portfolio.www.forum.notice.dto;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString	
public class BoardAttachDto {
	 private int attachSeq;
	 private int boardSeq;
	 private int boardTypeSeq;
	 private String orgFileNm;
	 private String savePath;
	 private String chngFileNm;
	 private long fileSize;
	 private String fileType;
	 private String accessUri;
	 private String regDtm;
	 private int downloadCnt;
	 
	 
	 public static BoardAttachDto makeBoardAttachDto(MultipartFile mf, File destFile,
			 						BoardSaveDto boardSaveDto) {
		 BoardAttachDto attachDto = new BoardAttachDto();
		 attachDto.setOrgFileNm(mf.getOriginalFilename());
		 attachDto.setChngFileNm(destFile.getName());
    	 attachDto.setFileType(mf.getContentType());
		 attachDto.setFileSize(mf.getSize());
		 attachDto.setSavePath(destFile.getAbsolutePath());
		 attachDto.setBoardSeq(boardSaveDto.getBoardSeq());
		 attachDto.setBoardTypeSeq(boardSaveDto.getBoardTypeSeq());
		 
		 return attachDto;
	 }
}