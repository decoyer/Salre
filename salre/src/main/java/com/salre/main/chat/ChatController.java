package com.salre.main.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;
import com.salre.main.login.UserService;
import com.salre.main.product.ProductDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	UserService userService;
	
	@Autowired
    private SimpMessagingTemplate simpMessagingTemplate;
	
	// 채팅 메인 화면
	@GetMapping("/main.do")
	public String main(HttpServletRequest request, Model model) {
		// 로그인 정보(세션) 가져오기
		HttpSession session = request.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
		
		Integer user_id = userDTO.getUser_id(); // 회원 번호
		
		// 매물 정보 가져오기
		List<ProductDTO> productDTOList = chatService.getProductByUserId(user_id);
		log.info("productDTOList : " + productDTOList);
		
		List<ChatRoomDTO> chatRoomDTOList = new ArrayList<>();
		if (!productDTOList.isEmpty()) {
			for (ProductDTO productDTO : productDTOList) {
				Integer product_id = productDTO.getProduct_id(); // 매물 번호
				
				ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder().user_id(user_id)
															   .product_id(product_id).build();
				
				// 채팅방 정보 조회(user_id, product_id)
				List<ChatRoomDTO> result = chatService.selectByUserIdService(chatRoomDTO);
				
				if (result != null) {
					chatRoomDTOList.addAll(result);
					
					chatRoomDTOList = chatRoomDTOList.stream()
						    .collect(Collectors.toMap(
						        chatRoom -> chatRoom.getRoom_name(), // 중복을 판단할 키
						        chatRoom -> chatRoom,                // 값
						        (existing, replacement) -> existing  // 중복 발생 시 기존 값을 유지
						    ))
						    .values() // Map의 값만 가져오기
						    .stream()
						    .collect(Collectors.toList());
				}
			}
		} else {
			// 채팅방 정보 조회(user_id)
			chatRoomDTOList = chatService.getChatRoomInfoService(user_id);
		}
		log.info("chatRoomDTOList : " + chatRoomDTOList);
		Set<ChatRoomDTO> chatRoomDTOSet = new HashSet<>(chatRoomDTOList);
		log.info("chatRoomDTOSet : " + chatRoomDTOSet);
		
		model.addAttribute("chatRoomDTOList", chatRoomDTOList);
		model.addAttribute("loggedInUser", userDTO);
		
		return "chat/chatMain";
	}
	
	// 채팅방 생성
	@PostMapping("/createChatRoom.do")
	public String createChatRoom(HttpServletRequest request,
			@RequestParam("product_id") String product_id,
			@RequestParam("product_user_id") String product_user_id,
			@RequestParam("product_name") String product_name, Model model) {
		// 로그인 정보(세션) 가져오기
		HttpSession session = request.getSession();
		UserDTO userDTO = (UserDTO) session.getAttribute("loggedInUser");
		
		Integer user_id = userDTO.getUser_id();
		String user_name = userDTO.getUser_name();
		
		// 매물 정보 받아오기(product/detail.jsp에서)
		Integer productId = Integer.parseInt(product_id); // 매물 번호
		Integer productUserId = Integer.parseInt(product_user_id); // 매물 등록한 사람의 user_id
		
		UserDTO userDTO2 = userService.getUserById(productUserId);
		String product_user_name = userDTO2.getUser_name(); // 매물 등록한 사람의 이름
		
		String room_name = "<b>" + product_name + "</b><br>임차인: " + user_name + "<br>임대인: " + product_user_name;
		
		ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder().user_id(user_id)
													   .room_name(room_name)
													   .product_id(productId).build();
		
		// 채팅방 생성 시 중복 확인
		int result = chatService.checkDupChatRoomService(chatRoomDTO);
		if (result != 1) { // 중복되는 채팅방이 없으면 채팅방 생성
			chatService.createChatRoom(chatRoomDTO);
		}
		
		return "redirect:/chat/main.do";
	}
	
	// 채팅방 입장
	@GetMapping("/enterChatRoom")
	public String enterChatRoom(Integer chatRoom_id, Model model) {
		// 채팅방 정보 조회(chatRoom_id)
		ChatRoomDTO chatRoomDTO = chatService.selectByChatRoomIdService(chatRoom_id);
		
		model.addAttribute("chatRoomDTO", chatRoomDTO);
		
		return "chat/chatRoom";
	}
	
	// 이전 채팅 내용 불러오기
	@ResponseBody
	@GetMapping("/getPreviousChat")
	public List<ChatDTO> getPreviousChat(Integer chatRoom_id) {
		List<ChatDTO> chatDTOList = chatService.selectPreChatService(chatRoom_id);
		
		return chatDTOList;
	}
	
	// 채팅 읽음 여부 업데이트(0 => 1)
	@ResponseBody
	@GetMapping("/updateIsCheck")
	public void updateIsCheck(Integer chatRoom_id, Integer user_id) {
		HashMap<String, Integer> map = new HashMap<>();
		
		map.put("chatRoom_id", chatRoom_id);
		map.put("user_id", user_id);
		
		chatService.updateIsCheckService(map);
	}
	
	// 채팅방 입장 알림
	@MessageMapping("/addUser")
//	@SendTo("topic/chatRoom")
	public void addUser(ChatDTO message) {
		// addUser가 우선 순위로 먼저 처리
		message.setChat_content(message.getSender() + " 님이 입장했습니다.");
        log.info("[chat_content] : " + message.getChat_content());
        
        simpMessagingTemplate.convertAndSend("/topic/chatRoom/" + message.getChatRoom_id(), message);
        
//        return message;
	}
	
	// 채팅방 내에서 메시지 전송
	@MessageMapping("/sendMessage") // 클라이언트가 "/app/sendMessage"로 보낸 메시지를 처리
//    @SendTo("/topic/chatRoom") // "/topic/chatRoom"를 구독 중인 클라이언트에게 메시지를 브로드캐스트
    public void sendMessage(ChatDTO message) {
        log.info("[Received message] : " + message);

        simpMessagingTemplate.convertAndSend("/topic/chatRoom/" + message.getChatRoom_id(), message);
        
        // 보낸 메시지 DB에 저장
        chatService.insertSendMessageService(message);
        
//        return message;
    }
	
}
