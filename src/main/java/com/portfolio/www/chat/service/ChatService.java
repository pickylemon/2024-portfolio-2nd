package com.portfolio.www.chat.service;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.auth.repository.MemberRepository;
import com.portfolio.www.chat.dto.ChatDetailDto;
import com.portfolio.www.chat.dto.ChatForm;
import com.portfolio.www.chat.dto.ChatRoomDto;
import com.portfolio.www.chat.message.ChatMessageEnum;
import com.portfolio.www.chat.repository.ChatDetailRepository;
import com.portfolio.www.chat.repository.ChatRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
	
	public List<ChatRoomDto> getAllChatRoomList(){
		return chatRepository.getAll();
	}
	
	//해당 채팅방에 대한 정보 조회
	public ChatRoomDto getChatRoomInfo(Integer chatroomSeq) {
		return chatRepository.get(chatroomSeq);
	}
	
	//해당 채팅방의 현재 참여 멤버 구하기
	public List<String> getMemberList(Integer chatroomSeq) {
		return chatDetailRepository.getMemberIdList(chatroomSeq);
	}
	
	//이미 채팅에 참여중인 멤버인지
	public boolean isAlreadyParticipating(Integer memberSeq, Integer chatroomSeq) {
		
		List<Integer> memberList = chatDetailRepository.getMemberSeqList(chatroomSeq);
		log.info(">>>>>>>memberList= {}", memberList);
		log.info(">>>>>>memberSeq={}", memberSeq);
		
		return memberList.stream().anyMatch(i -> i.equals(memberSeq));
	}
	
	//해당 memberSeq의 회원 구하기
	public MemberDto getMember(Integer memberSeq) {
		return memberRepository.findBySeq(memberSeq);
	}

	
	//채팅방을 나간 member에 대해 status update
	public int updateMemberStatus(ChatForm chatDto) {
		return chatDetailRepository.updateStatus(chatDto);
	}
	
	public void updateMemberStatus(Integer memberSeq) {
		List<ChatForm> chatrooms = chatDetailRepository.getChatroomsByMemberSeq(memberSeq);
		log.info("현재 참여중인 채팅방 목록 : " + chatrooms);
		for(ChatForm form : chatrooms) {
			form.setMessageType(ChatMessageEnum.LEAVE);
			chatDetailRepository.updateStatus(form);
		}
	}
	
	
	
	
	//채팅 메시지 저장
	public int saveMsg(ChatDetailDto chatDetailDto) {
		return chatDetailRepository.save(chatDetailDto);
	}
	

}
