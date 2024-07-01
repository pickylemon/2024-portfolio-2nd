package com.portfolio.www.chat.dto;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class ChatRoomDto {
	@NotEmpty
	private String category;
	@NotEmpty(message="채팅방 이름은 필수입니다.")
	@Size(min = 1, max = 20)
	private String roomNm;
	private Integer chatroomSeq; // <selectKey로 채우기>
	private Integer roomManager;
//	private String managerNm;
	private String managerId;
	private Integer memberSeq;
	private String memberId;
	private Integer memberCnt;
	private LocalDateTime regDtm;
	private LocalDateTime delDtm;
	private String chatroomUrl;
	
	public void setChatRoom(int memberSeq) {
		setRoomManager(memberSeq);
		setMemberSeq(memberSeq);
		setChatroomUrl(UUID.randomUUID().toString());
		memberCnt = 1;
	}
}
