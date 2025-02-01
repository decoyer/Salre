package com.salre.main.chat;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ChatDTO {
	
	private Integer chat_id; // 채팅 상세 번호
	private Integer chatRoom_id; // 채팅방 번호
//	private Integer contract_id; // 거래 번호
	private Integer user_id; // 회원 번호
	private String sender; // 보낸 사람
	private String chat_content; // 채팅 내용
	private Timestamp send_time; // 보낸 시간
	private Boolean is_check; // 확인 여부

}
