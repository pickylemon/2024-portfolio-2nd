package com.portfolio.www.chat.dto;

import com.portfolio.www.chat.message.ChatMessageEnum;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatDto {
	private Integer chatroomSeq;
	private Integer memberSeq;
	private ChatMessageEnum msgType;
	private String msg;

}
