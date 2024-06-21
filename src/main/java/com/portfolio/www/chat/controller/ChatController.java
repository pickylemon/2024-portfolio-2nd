package com.portfolio.www.chat.controller;

import java.util.List;

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
import com.portfolio.www.chat.dto.ChatDto;
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
	
	@GetMapping("/chatRoomList.do")
	public String ChatPage() {
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
	@GetMapping("/{chatroomSeq}/{memberSeq}/chatRoom.do")
	public String enterChatRoom(@PathVariable("chatroomSeq") Integer chatroomSeq,
								@PathVariable("memberSeq") Integer memberSeq, Model model) {
		
		ChatRoomDto chatRoomDto = chatService.getChatRoomInfo(chatroomSeq);
		log.info("\n >>>>>> chatRoomDto={}", chatRoomDto);
		List<String> memberList = chatService.getMemberList(chatroomSeq);
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
	public ChatDto message(@DestinationVariable("chatroomSeq") Integer chatroomSeq, ChatDto chatDto) {
		log.info("chatroomSeq = {}", chatroomSeq);		
		log.info(">>>>>chatDto={}", chatDto);
		
		MemberDto member = chatService.getMember(chatDto.getMemberSeq());	
		String memberNm = member.getMemberNm();
		
		if(chatDto.getMsgType() == ChatMessageEnum.ENTER) { //입장의 경우
			chatDto.setMsg(member.getMemberNm() + "님이 채팅방에 들어왔습니다. 환영해주세요");
		} else if (chatDto.getMsgType() == ChatMessageEnum.LEAVE) { //퇴장의 경우
			//chatDetail에 update
			chatDto.setMsg(member.getMemberNm() + "님이 퇴장하셨습니다");
		} else { //일반 채팅의 경우
			//chatDetail에 insert
			chatDto.setMsg(member.getMemberNm() +" : " + chatDto.getMsg());
		}
		
		return chatDto;
	}

}
