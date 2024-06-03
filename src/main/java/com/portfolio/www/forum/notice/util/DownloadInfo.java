package com.portfolio.www.forum.notice.util;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.portfolio.www.forum.notice.dto.BoardAttachDto;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 파일 다운로드 시 fileDownloadView로 전달되는 객체
 */

@Getter
@Setter(value = AccessLevel.PRIVATE)
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class DownloadInfo {
	private File downloadFile;
	private String orgFileNm;
	private boolean isCompressedFile;
	
	/**
	 * 개별 파일 다운로드시
	 * @param boardAttachDto
	 * @param isCompressedFile
	 */
	public DownloadInfo(BoardAttachDto boardAttachDto, boolean isCompressedFile) {
		this.downloadFile = new File(boardAttachDto.getSavePath());
		this.orgFileNm = boardAttachDto.getOrgFileNm();
		this.isCompressedFile = isCompressedFile;
	}
	
	/**
	 * zip파일 다운로드시.
	 */
	public static DownloadInfo ZipDownloadInfo(File file) {
		DownloadInfo zipInfo = new DownloadInfo();
		zipInfo.setDownloadFile(file);
		zipInfo.setCompressedFile(true);
		zipInfo.setOrgFileNm(LocalDateTime.now().format(DateTimeFormatter.ISO_DATE)+".zip");
		
		return zipInfo;
	}
	
	public boolean isCompressedFile() {
		return this.isCompressedFile;
	}
	
}
