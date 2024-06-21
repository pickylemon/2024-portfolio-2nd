package com.portfolio.www.chat.service;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberRepository;
import com.portfolio.www.chat.dto.ChatRoomDto;
import com.portfolio.www.chat.repository.ChatDetailRepository;
import com.portfolio.www.chat.repository.ChatRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatService {
	private final ChatRepository chatRepository;
	private final ChatDetailRepository chatDetailRepository;
	private final MemberRepository memberRepository;
	
	//채팅방 만들기
	public int makeChatRoom(ChatRoomDto chatRoomForm) {	
		int code = -1;
		try {
			code = chatRepository.save(chatRoomForm);	
		} catch(DuplicateKeyException e ) {
			code = -2;
		}catch (DataAccessException e) {
			e.printStackTrace();
		}
		return code;
	}
	
	//해당 채팅방에 대한 정보 조회
	public ChatRoomDto getChatRoomInfo(Integer chatroomSeq) {
		return chatRepository.get(chatroomSeq);
	}
	
	//해당 채팅방의 현재 참여 멤버 구하기
	public List<String> getMemberList(Integer chatroomSeq) {
		return chatDetailRepository.getMemberList(chatroomSeq);
	}
	
	//해당 memberSeq의 회원 구하기
	public MemberDto getMember(Integer memberSeq) {
		return memberRepository.findBySeq(memberSeq);
	}

}
