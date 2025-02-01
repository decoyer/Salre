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
public class ChatRoomDTO {
	
	private Integer chatRoom_id; // 채팅방 번호
//	private Integer contract_id; // 거래 번호
	private Integer user_id; // 회원 번호
	private Integer product_id; // 매물 번호
	private String room_name; // 채팅방 이름
	private Timestamp created_at; // 채팅방 생성일시
	private Timestamp updated_at; // 채팅방 수정일시
	private String chat_content; // 채팅방 마지막 내용
	private Timestamp send_time; // 채팅방 마지막 내용을 보낸 일시
	private Integer is_checkFalseCnt; // 읽지 않은 채팅 갯수

}
