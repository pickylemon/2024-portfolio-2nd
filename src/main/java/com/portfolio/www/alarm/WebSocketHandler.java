package com.portfolio.www.alarm;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.portfolio.www.alarm.dto.AlarmDto;
import com.portfolio.www.alarm.service.AlarmService;
import com.portfolio.www.auth.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

//QUESTION WebSocketHandler는 누가 호출하는거지....?
//STOMP 사용시 Controller와 그냥 WebSocket 사용시 WebSocketHandler가 같은 역할인가?
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
	private final ObjectMapper objectMapper = new ObjectMapper();
	private final AlarmService alarmService;
	
	//memberSeq와 WebSocketSession을 entry
	private Map<Integer, WebSocketSession> sessionMap = new HashMap<>();
	
	@Autowired
	WebSocketHandler(AlarmService alarmService){
		log.info("websocketHandler init");
		this.alarmService = alarmService;
	}

	//세션이 시작되면 SessionMap에 해당 session을 저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("afterConnectionEstablished");
		Map<String, Object> attributesMap = session.getAttributes();
		//attributesMap.keySet().forEach(System.out::println);
		sessionMap.put((Integer)attributesMap.get("memberSeq"), session);


	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// TODO Auto-generated method stub
		log.info("session={}", session);
		log.info("message={}", message);
		log.info("message.class={}", message.getClass());
		//class org.springframework.web.socket.TextMessage
		
		AlarmDto alarmDto = objectMapper.readValue((String)message.getPayload(), AlarmDto.class);
		log.info("alarmDto={}", alarmDto);
		
		WebSocketSession writerSession = sessionMap.get(alarmDto.getWriterSeq());
		MemberDto commenter = alarmService.getMember(alarmDto.getCommenterSeq());
		
		String url = "http://localhost:8080/pf/forum/notice/readPage.do?boardSeq="
				+alarmDto.getBoardSeq()+"&boardTypeSeq="
				+alarmDto.getBoardTypeSeq();
		
		String msg = "<a href='"+url+"'>작성하신 게시글 " + alarmDto.getBoardSeq() + "번에 "
				   + commenter.getMemberNm() + "님의 댓글이 달렸습니다.</a>";
		

		writerSession.sendMessage(new TextMessage(msg));
	}
	

	//세션 종료시 해당 세션을 Map에서 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> attributesMap = session.getAttributes();
		sessionMap.remove(attributesMap.get("memberSeq"));
	}
	
	

}
