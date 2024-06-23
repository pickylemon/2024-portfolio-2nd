package com.portfolio.www.chat.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.portfolio.www.auth.dto.MemberDto;
import com.portfolio.www.chat.dto.ChatDetailDto;
import com.portfolio.www.chat.dto.ChatForm;
import com.portfolio.www.chat.dto.ChatRoomDto;
import com.portfolio.www.chat.message.ChatMessageEnum;
import com.portfolio.www.chat.service.ChatService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
	
@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatController {
	private final ChatService chatService;	
	
	
	
	//모든 채팅방 목록을 조회 후 카테고리 별로 나누어 모델에 담기
	@GetMapping("/chatRoomList.do")
	public String ChatPage(Model model) {
		
		List<ChatRoomDto> chatRoomList = chatService.getAllChatRoomList();
		Map<String, List<ChatRoomDto>> chatRoomMap = chatRoomList.stream()
																.collect(Collectors.groupingBy
																		(ChatRoomDto::getCategory));
		model.addAttribute("chatRoomMap", chatRoomMap);
		log.info(">>>>>>chatRoomMap={}", chatRoomMap);
		
		return "chat/chatRoomList";
	}
	

//	@PostMapping("/chatRoomList.do")
//	public String makeChatRoom(@ModelAttribute @Validated ChatRoomDto chatRoomDto, 
//															BindingResult result,
//															HttpSession session) {
	
	//TODO REST는 서블릿과 구분하기 (dispatcher Servlet 따로 두기)
	@PostMapping("/chatRoomList.do")
	@ResponseBody
	public ResponseEntity<ChatRoomDto> makeChatRoom(@RequestBody ChatRoomDto chatRoomDto, 
																	HttpSession session) {
		
		log.info("before chatRoomForm={}", chatRoomDto);
		
//		if(result.hasErrors()) {
//			result.getAllErrors().forEach(System.out::println);
//			return "/chat/chatRoomList";
//		}
		
		int memberSeq = (int)session.getAttribute("memberSeq");
		
		//기타 chatRoom정보를 set
		chatRoomDto.setChatRoom(memberSeq);
		
		//채팅방을 새로 만든다.
		//채팅방 이름에 unique 제약조건 걸어두었음. 예외처리 필요(사용자에게 inform)
		int code = chatService.makeChatRoom(chatRoomDto);
		log.info("after chatRoomForm={}", chatRoomDto);
		if(code == 1) {
			return ResponseEntity.ok().body(chatRoomDto);
		} else {
			return ResponseEntity.badRequest().body(null);
		}		
	}
	
	//채팅 팝업창으로 연결됨
	//새로 채팅방을 만들거나, 채팅방 목록에서 클릭해서 들어온 경우
	@GetMapping("/{chatroomSeq}/{memberSeq}/chatRoom.do")
	public String enterChatRoom(@PathVariable("chatroomSeq") Integer chatroomSeq,
								@PathVariable("memberSeq") Integer memberSeq, Model model) {
		
		//1. 채팅방의 memberCnt가 10명 미만일 때만 입장 가능
		//2. 한 채팅방에 한 유저가 퇴장 없이는 두 번 입장할 수 없어야함. (ex. 다른 브라우저로 접근 등)
		ChatRoomDto chatRoomDto = chatService.getChatRoomInfo(chatroomSeq);
		log.info("\n >>>>>> chatRoomDto={}", chatRoomDto);
		List<String> memberList = chatService.getMemberList(chatroomSeq);
		log.info("canEnter?={}",canEnter(chatRoomDto, memberSeq));
		if(!canEnter(chatRoomDto, memberSeq)) {
			log.info("can't enter");
			//채팅방 입장 불가 메시지 같이 넘기기
			return "redirect:/chatRoomList.do";
		}

//		MemberDto memberDto = chatService.getMember(memberSeq);
		model.addAttribute("memberList", memberList);
		model.addAttribute("chatRoomDto", chatRoomDto);
		model.addAttribute("memberSeq", memberSeq);
//		model.addAttribute("memberDto", memberDto);
		//채팅방 이름과 멤버 목록을 가지고 이동.
		return "chat/chatRoom";
	}
	
	//MessageMapping에서 쓸 수 있는 argument는 정해져있다. 다른 controller의 argument처럼 
	//pathVariable을 쓴다든가 이런거 못함.
	@MessageMapping("/groupchat/{chatroomSeq}") //
	@SendTo("/topic/message/{chatroomSeq}") //MessageBroker
	public ChatForm message(@DestinationVariable("chatroomSeq") Integer chatroomSeq, ChatForm chatForm) {
		log.info("chatroomSeq = {}", chatroomSeq);		
		log.info(">>>>>chatDto={}", chatForm);
		
		MemberDto member = chatService.getMember(chatForm.getMemberSeq());	
		String memberNm = member.getMemberNm();
		
		if(chatForm.getMsgType() == ChatMessageEnum.ENTER) { //입장의 경우
			chatForm.setMessage(member.getMemberNm() + "님이 채팅방에 들어왔습니다. 환영해주세요");
		} else if (chatForm.getMsgType() == ChatMessageEnum.LEAVE) { //퇴장의 경우
			//chatDetail에 update
			chatService.updateMemberStatus(chatForm);
			chatForm.setMessage(member.getMemberNm() + "님이 퇴장하셨습니다");
		} else { //일반 채팅의 경우
			ChatDetailDto chatDetailDto = ChatDetailDto.create(chatForm);
			log.info(">>>>>chatDetailDto={}", chatDetailDto);
			chatService.saveMsg(chatDetailDto);
			chatForm.setMessage(member.getMemberNm() +" : " + chatForm.getMessage());
		}
		
		return chatForm;
	}
	
	
	
	//채팅방에 입장할 수 있는지 유효성 검사
	private boolean canEnter(ChatRoomDto chatRoomDto, Integer memberSeq) {
		//인원이 다 찼는지
		if(chatRoomDto.getMemberCnt() >= 10) {
			return false;
		}
		//인원이 여유가 있어도, 이미 채팅방 안에 있는 멤버인지
		if(chatService.isAlreadyParticipating(memberSeq, chatRoomDto.getChatroomSeq())) {
			return false;
		}
		return true;		
	}
}
