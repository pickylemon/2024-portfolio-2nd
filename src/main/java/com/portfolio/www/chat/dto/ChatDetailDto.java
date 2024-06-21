package com.portfolio.www.chat.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ChatDetailDto {
	private Integer messageSeq;
	private Integer chatroomSeq;
	private Integer memberSeq;
	private String chatStatus;
	private String message;
	private LocalDateTime regDtm;
}
