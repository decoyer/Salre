package com.salre.main.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// 메시지 브로커 설정
		config.enableSimpleBroker("/queue" , "/topic"); // 클라이언트가 메시지를 받을 주소
		config.setApplicationDestinationPrefixes("/app"); // 클라이언트가 메시지를 보낼 주소
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// STOMP 엔드포인트 등록
        registry.addEndpoint("/chat-websocket") // chatMain.jsp > connectWebSocket()에서 사용
                .setAllowedOrigins("http://192.168.0.*:8070/") // CORS 허용
//                .setAllowedOrigins("*") // CORS 허용
                .withSockJS(); // SockJS 지원
	}

}
