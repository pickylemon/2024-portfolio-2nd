package com.portfolio.www.chat.dto;

import java.time.LocalDateTime;

import com.portfolio.www.chat.message.ChatMessageEnum;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChatDetailDto {
	private Integer messageSeq;
	private Integer chatroomSeq;
	private Integer memberSeq;
	private String chatStatus;
	private ChatMessageEnum messageType;
	private String message;
	private LocalDateTime regDtm;
	
	public static ChatDetailDto create(ChatForm chatDto) {
		ChatDetailDto dto = new ChatDetailDto();
		dto.setChatroomSeq(chatDto.getChatroomSeq());
		dto.setMemberSeq(chatDto.getMemberSeq());
		dto.setMessage(chatDto.getMessage());
		dto.setMessageType(chatDto.getMessageType());
		return dto;
	}
}
