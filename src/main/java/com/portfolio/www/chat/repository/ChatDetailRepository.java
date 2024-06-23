package com.portfolio.www.chat.repository;

import java.util.List;

import com.portfolio.www.chat.dto.ChatDetailDto;
import com.portfolio.www.chat.dto.ChatForm;

public interface ChatDetailRepository {
	
	//채팅 메시지 저장
	public int save(ChatDetailDto chatDetailDto);
	
	//채팅 메시지 읽기
	public List<ChatDetailDto> get();
	
	//채팅 메시지 업데이트 (유저 나갔을 때 chatStatus를 N으로 업데이트)
	public int update();
	
	//현재 채팅방 MemberList 가져오기
	public List<String> getMemberNmList(Integer chatroomSeq);
	
	public List<Integer> getMemberSeqList(Integer chatroomSeq);
	
	//채팅방을 나간 멤버 상태 update하기(insert)
	public int updateStatus(ChatForm chatForm);
	
}
