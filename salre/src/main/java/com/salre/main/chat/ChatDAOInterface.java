package com.salre.main.chat;

import java.util.HashMap;
import java.util.List;

import com.salre.main.product.ProductDTO;

public interface ChatDAOInterface {
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 정보 조회(user_id, product_id)
	public List<ChatRoomDTO> selectByUserId(ChatRoomDTO chatRoomDTO);
	
	// 채팅방 정보 조회(user_id)
	public List<ChatRoomDTO> getChatRoomInfo(Integer user_id);
	
	// 채팅방 정보 조회(chatRoom_id)
	public ChatRoomDTO selectByChatRoomId(Integer chatRoom_id);
	
	// 이전 채팅 내용 불러오기
	public List<ChatDTO> selectPreChat(Integer chatRoom_id);
	
	// 보낸 메시지 DB에 저장
	public void insertSendMessage(ChatDTO messageContent);
	
	// 채팅 읽음 여부 업데이트(0 => 1)
	public void updateIsCheck(HashMap<String, Integer> map);
	
	// 매물 정보 가져오기
	public List<ProductDTO> getProductByUserId(Integer user_id);

}
