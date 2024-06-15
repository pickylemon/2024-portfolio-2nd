package com.portfolio.www.alarm;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.portfolio.www.alarm.service.AlarmService;

import lombok.extern.slf4j.Slf4j;

//QUESTION WebSocketHandler는 누가 호출하는거지....?
//STOMP 사용시 Controller와 그냥 WebSocket 사용시 WebSocketHandler가 같은 역할인가?
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
	private final AlarmService alarmService;
	private Map<String, WebSocketSession> sessionMap = new HashMap<>();
	
	@Autowired
	WebSocketHandler(AlarmService alarmService){
		log.info("websocketHandler init");
		this.alarmService = alarmService;
	}

	//세션이 시작되면 SessionMap에 해당 session을 저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		Map<String, Object> attributesMap = session.getAttributes();
		String memberId = alarmService.getMemberId((int)attributesMap.get("memberSeq"));
		sessionMap.put(memberId, session);
		

	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		// TODO Auto-generated method stub
		log.info("session={}", session);
		log.info("message={}", message);
	}
	

	//세션 종료시 해당 세션을 Map에서 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> attributesMap = session.getAttributes();
		String memberId = alarmService.getMemberId((int)attributesMap.get("memberSeq"));
		sessionMap.remove(memberId);
	}
	
	

}
