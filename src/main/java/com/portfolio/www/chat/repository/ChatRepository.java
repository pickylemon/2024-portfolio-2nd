package com.portfolio.www.chat.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.portfolio.www.chat.dto.ChatRoomDto;

public interface ChatRepository {
	
	//채팅방 생성
	public int save(ChatRoomDto chatRoomDto);

	//채팅방 삭제 (삭제는 방장만 할 수 있다)
	public int delete(@Param("chatroomSeq") Integer chatroomSeq, @Param("memberSeq") Integer memberSeq);
	
	//채팅방 정보 가져오기
	public ChatRoomDto get(Integer chatroomSeq);
	
	//모든 채팅방 리스트 가져오기
	public List<ChatRoomDto> getAll();
	
	//채팅방 업데이트(멤버 in/out)
	public int update(@Param("chatroomSeq") Integer chatroomSeq);
}
