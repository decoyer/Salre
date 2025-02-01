package com.salre.main.chat;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.salre.main.product.ProductDTO;

@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDAO;
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoomService(ChatRoomDTO chatRoomDTO) {
		return chatDAO.checkDupChatRoom(chatRoomDTO);
	}

	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO) {
		chatDAO.createChatRoom(chatRoomDTO);
	}

	// 채팅방 정보 조회(user_id, product_id)
	public List<ChatRoomDTO> selectByUserIdService(ChatRoomDTO chatRoomDTO) {
		return chatDAO.selectByUserId(chatRoomDTO);
	}
	
	// 채팅방 정보 조회(user_id)
	public List<ChatRoomDTO> getChatRoomInfoService(Integer user_id) {
		return chatDAO.getChatRoomInfo(user_id);
	}

	// 채팅방 정보 조회(chatRoom_id)
	public ChatRoomDTO selectByChatRoomIdService(Integer chatRoom_id) {
		return chatDAO.selectByChatRoomId(chatRoom_id);
	}
	
	// 이전 채팅 내용 불러오기
	public List<ChatDTO> selectPreChatService(Integer chatRoom_id) {
		return chatDAO.selectPreChat(chatRoom_id);
	}

	// 보낸 메시지 DB에 저장
	public void insertSendMessageService(ChatDTO messageContent) {
		chatDAO.insertSendMessage(messageContent);
	}

	// 채팅 읽음 여부 업데이트(0 => 1)
	public void updateIsCheckService(HashMap<String, Integer> map) {
		chatDAO.updateIsCheck(map);
	}

	// 매물 정보 가져오기
	public List<ProductDTO> getProductByUserId(Integer user_id) {
		return chatDAO.getProductByUserId(user_id);
	}

}
