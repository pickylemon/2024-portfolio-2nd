package com.portfolio.www.chat.dto;

import com.portfolio.www.chat.message.ChatMessageEnum;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatForm {
	private Integer chatroomSeq;
	private Integer memberSeq;
	private String memberId;
	private ChatMessageEnum messageType;
	private String message;
	
	public ChatForm(Integer memberSeq, String memberId, ChatMessageEnum messageType) {
		this.memberSeq = memberSeq;
		this.memberId = memberId;
		this.messageType = messageType;
	}

}
