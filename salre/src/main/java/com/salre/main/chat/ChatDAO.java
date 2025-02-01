package com.salre.main.chat;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salre.main.product.ProductDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ChatDAO implements ChatDAOInterface {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.salre.main.chat.";
	
	// 채팅방 생성 시 중복 확인
	public int checkDupChatRoom(ChatRoomDTO chatRoomDTO) {
		int result = sqlSession.selectOne(namespace + "checkDupChatRoom", chatRoomDTO);
		log.info("[checkDupChatRoom] result : " + result);
		
		return result;
	}

	// 채팅방 생성
	public void createChatRoom(ChatRoomDTO chatRoomDTO) {
		sqlSession.insert(namespace + "createChatRoom", chatRoomDTO);
		log.info("[createChatRoom] 성공!");
	}

	// 채팅방 정보 조회(user_id, product_id)
	public List<ChatRoomDTO> selectByUserId(ChatRoomDTO chatRoomDTO) {
		List<ChatRoomDTO> chatRoomDTOList = sqlSession.selectList(namespace + "selectByUserId", chatRoomDTO);
		log.info("[selectByUserId] chatRoomDTOList : " + chatRoomDTOList);
		
		return chatRoomDTOList;
	}
	
	// 채팅방 정보 조회(user_id)
	public List<ChatRoomDTO> getChatRoomInfo(Integer user_id) {
		List<ChatRoomDTO> chatRoomDTOList = sqlSession.selectList(namespace + "getChatRoomInfo", user_id);
		log.info("[getChatRoomInfo] chatRoomDTOList : " + chatRoomDTOList);
		
		return chatRoomDTOList;
	}

	// 채팅방 정보 조회(chatRoom_id)
	public ChatRoomDTO selectByChatRoomId(Integer chatRoom_id) {
		ChatRoomDTO chatRoomDTO = sqlSession.selectOne(namespace + "selectByChatRoomId", chatRoom_id);
		log.info("[selectByChatRoomId] chatRoomDTO : " + chatRoomDTO);
		
		return chatRoomDTO;
	}
	
	// 이전 채팅 내용 불러오기
	public List<ChatDTO> selectPreChat(Integer chatRoom_id) {
		List<ChatDTO> chatDTOList = sqlSession.selectList(namespace + "selectPreChat", chatRoom_id);
		log.info("[selectPreChat] chatDTOList : " + chatDTOList);
		
		return chatDTOList;
	}

	// 보낸 메시지 DB에 저장
	public void insertSendMessage(ChatDTO messageContent) {
		sqlSession.insert(namespace + "insertSendMessage", messageContent);
		log.info("[insertSendMessage] 성공!");
	}

	// 채팅 읽음 여부 업데이트(0 => 1)
	public void updateIsCheck(HashMap<String, Integer> map) {
		sqlSession.update(namespace + "updateIsCheck", map);
		log.info("[updateIsCheck] 성공!");
	}

	// 매물 정보 가져오기
	public List<ProductDTO> getProductByUserId(Integer user_id) {
		List<ProductDTO> productDTOList = sqlSession.selectList(namespace + "getProductByUserId", user_id);
		log.info("[getProductByUserId] productDTOList : " + productDTOList);
		
		return productDTOList;
	}

}
