<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no, viewport-fit=cover">
<meta name="color-scheme" content="light dark">

<title>살래?</title>

<!-- Favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

<!-- Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700" rel="stylesheet">

<!-- Template CSS -->
<link class="css-lt" rel="stylesheet" href="${contextPath}/resources/bootstrap/chat/assets/css/template.bundle.css" media="(prefers-color-scheme: light)">
<link class="css-dk" rel="stylesheet" href="${contextPath}/resources/bootstrap/chat/assets/css/template.dark.bundle.css" media="(prefers-color-scheme: dark)">

<!-- Theme mode -->
<script>
    if (localStorage.getItem('color-scheme')) {
        let scheme = localStorage.getItem('color-scheme');

        const LTCSS = document.querySelectorAll('link[class=css-lt]');
        const DKCSS = document.querySelectorAll('link[class=css-dk]');

        [...LTCSS].forEach((link) => {
            link.media = (scheme === 'light') ? 'all' : 'not all';
        });

        [...DKCSS].forEach((link) => {
            link.media = (scheme === 'dark') ? 'all' : 'not all';
        });
    }
</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- SockJS, STOMP -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
</head>
<body>
	<!-- Layout -->
	<div class="layout overflow-hidden">
	    <!-- Sidebar -->
	    <aside class="sidebar bg-light">
	        <div class="tab-content h-100" role="tablist">
	            <!-- Chats -->
	            <div class="tab-pane fade h-100 show active" id="tab-content-chats" role="tabpanel">
	                <div class="d-flex flex-column h-100 position-relative">
	                    <div class="hide-scrollbar">
	
	                        <div class="container py-8">
	                            <!-- Title -->
	                            <div class="mb-8 d-flex align-items-center">
	                            	<!-- Controls -->
				                    <a href="${contextPath}" class="me-3">
				                    	<img src="${contextPath}/resources/images/favicon.ico" style="width: 30px; flex-shrink: 0">
				                    </a>
	                                <h2 class="fw-bold m-0">채팅 목록</h2>
	                                <h4 class="fw-bold m-0 ms-auto"><u>${loggedInUser.user_name}</u> 님</h4>
	                            </div>
	
	                            <!-- Chats -->
	                            <div class="card-list">
	                            	<c:choose>
	                            		<c:when test="${empty chatRoomDTOList}">
	                            			<a class="card border-0 text-reset">
		                            			<!-- Card -->
			                                    <div class="card-body">
			                                        <div class="row gx-5 justify-content-center">
			                                            <div class="col-auto">
			                                                채팅방이 없습니다.
			                                            </div>
			                                        </div>
			                                    </div>
		                                    </a>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<c:forEach items="${chatRoomDTOList}" var="chatRoom">
				                                <!-- Card -->
				                                <a href="javascript:enterChatRoom(${chatRoom.chatRoom_id});" class="card border-0 text-reset">
				                                    <div class="card-body">
				                                        <div class="row gx-5">
				                                            <div class="col-auto">
				                                                <div class="avatar">
				                                                    <img src="${contextPath}/resources/images/products/${chatRoom.product_id}.jpeg" alt="매물 사진" class="avatar-img">
				                                                </div>
				                                            </div>
				
				                                            <div class="col">
				                                                <div class="d-flex align-items-center mb-3">
				                                                    <h5 class="me-auto mb-0">${chatRoom.room_name}</h5>
				                                                    <span class="text-muted small ms-2">
				                                                    	<fmt:formatDate value="${chatRoom.send_time}" pattern="HH:mm"/>
				                                                    </span>
				                                                </div>
				
				                                                <div class="d-flex align-items-center">
				                                                    <div class="line-clamp me-auto">
				                                                    	${chatRoom.chat_content}
				                                                    </div>
				
				                                                    <c:if test="${chatRoom.is_checkFalseCnt ne 0}">
					                                                    <div class="badge badge-circle bg-warning ms-5">
					                                                        <span>${chatRoom.is_checkFalseCnt}</span>
					                                                    </div>
				                                                    </c:if>
				                                                </div>
				                                            </div>
				                                        </div>
				                                    </div><!-- .card-body -->
				                                </a>
				                                <!-- Card -->
			                                </c:forEach>
	                                	</c:otherwise>
	                                </c:choose>
	                            </div>
	                            <!-- Chats -->
	                        </div>
	
	                    </div>
	                </div>
	            </div>
	        </div>
	    </aside>
	    <!-- Sidebar -->
	
	    <!-- Chat -->
	    <main class="main is-visible" data-dropzone-area="">
	        <div class="container h-100" id="chatRoomArea">
	
	            <div class="d-flex flex-column h-100 justify-content-center text-center">
	                <div class="mb-6">
	                    <span class="icon icon-xl text-muted">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-message-square"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
	                    </span>
	                </div>
	
	                <p class="text-muted">왼쪽 목록에서 채팅방을 선택하여 <br> 대화를 시작하세요.</p>
	            </div>
	
	        </div>
	    </main>
	    <!-- Chat -->
	
	</div>
	<!-- Layout -->
	
	<!-- Scripts -->
	<script src="${contextPath}/resources/bootstrap/chat/assets/js/vendor.js"></script>
	<script src="${contextPath}/resources/bootstrap/chat/assets/js/template.js"></script>
	
	<!-- 채팅방 입장 -->
	<script type="text/javascript">
		let user_id = ${loggedInUser.user_id};
		let user_name = "${loggedInUser.user_name}";
		
		function enterChatRoom(chatRoom_id) {
			$.ajax({
				url: "${contextPath}/chat/enterChatRoom",
				type: "GET",
				data: {
					chatRoom_id: chatRoom_id
				},
				success: function(res) {
					/* $("#chatRoomArea").html(res); */
					document.getElementById("chatRoomArea").innerHTML = res;
					
					// 채팅방 입장 시 웹소켓 연결
					connectWebSocket(chatRoom_id);
					
					// 이전 채팅 내용 불러오기
					getPreviousChat(chatRoom_id);
					
					// 스크롤을 맨 아래로 이동
					scrollToBottom();
					
					// 채팅 읽음 여부 업데이트
					updateIsCheck(chatRoom_id, user_id);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
		
		let stompClient;
	    function connectWebSocket(chatRoom_id) {
	        const socket = new SockJS("${contextPath}/chat-websocket"); // WebSocketConfig에서 설정한 Endpoint
	        stompClient = Stomp.over(socket);

	        stompClient.connect({}, function (frame) {
	            console.log('Connected : ' + frame);
	            
	            const message = {
	            		chatRoom_id: chatRoom_id,
	            		sender: user_name
	            };
	            
	            // 채팅방에 누가 입장했는지 안내(message에 sender 정보를 담아서 전달)
	            stompClient.send("/app/addUser", {}, JSON.stringify(message));
	            
	            // 서버로부터 메시지를 구독(메시지 수신)
	            stompClient.subscribe('/topic/chatRoom/' + chatRoom_id, function (message) {
	            	<%--
	            	message.body
	            	{"chat_id":null,"chatRoom_id":2,"contract_id":null,"sender":"김광진","chat_content":"김광진 님이 입장했습니다.","send_time":null,"is_check":null}
	            	{"chatRoom_id":2,"sender":"김광진","chat_content":"김광진 입력","send_time":"2025-01-07T01:02:43.107Z"}
	            	--%>
	            	const messageBody = JSON.parse(message.body);
	            	
	            	if (messageBody.chat_content && messageBody.chat_content.includes("님이 입장했습니다")) {
	            		if (message.sender != user_name) { // 본인이 아닌 다른 사람이 입장했을 시
	            			showEntranceMessage(messageBody); // 사용자 입장 안내 메시지
	            		}
	            	} else {
	            		displayMessage(messageBody); // 사용자가 전송한 메시지 채팅방에 출력
	            	}
	            	
	            	// 스크롤을 맨 아래로 이동
        			scrollToBottom();
	            });
	            
	         	// Enter 키를 눌러 메시지 전송
	            document.getElementById("chatInput").addEventListener("keypress", function(event) {
	                if (event.key === "Enter" && !event.shiftKey) {  // Shift + Enter는 줄바꿈을 허용하고, Enter만 전송
	                    event.preventDefault();  // Enter 키 기본 동작 방지 (줄 바꿈 안됨)
	                    sendMessage(chatRoom_id);  // 메시지 전송 함수 호출
	                }
	            });
	        });
	    }
	    
	    // 이전 채팅 내용 불러오기
	    function getPreviousChat(chatRoom_id) {
	    	$.ajax({
	    		url: "${contextPath}/chat/getPreviousChat",
				type: "GET",
				data: {
					chatRoom_id: chatRoom_id
				},
				success: function(chatDTOList) {
					chatDTOList.forEach(chatDTO => {
						displayMessage(chatDTO);
					});
				},
				error: function(err) {
					alert(err);
				}
	    	});
	    }
	    
	 	// 채팅 읽음 여부 업데이트(0 => 1)
		function updateIsCheck(chatRoom_id, user_id) {
			$.ajax({
	    		url: "${contextPath}/chat/updateIsCheck",
				type: "GET",
				data: {
					chatRoom_id: chatRoom_id,
					user_id: user_id
				},
				success: function() {
					if (document.querySelector('.badge')) {
						// 업데이트 성공 시 <div class="badge"> 제거
						document.querySelector('.badge').remove();
					}
				},
				error: function(err) {
					alert(err);
				}
	    	});
	 	}
	    
	 	// 스크롤을 맨 아래로 이동하게 하는 함수
	 	function scrollToBottom() {
	 		const chatBodyDiv = document.querySelector('.chat-body');
	        chatBodyDiv.scrollTop = chatBodyDiv.scrollHeight;
	 	}
	    
	    // 사용자가 메시지를 전송했을 때 수행할 함수
	    function sendMessage(chatRoom_id) {
	        const input = document.getElementById("chatInput"); // chatRoom.jsp > id="chatInput"
	        const messageContent = input.value.trim();
	        
	        if (messageContent) {
	        	// 스크롤을 맨 아래로 이동
		        scrollToBottom();
	        	
	            // WebSocket/STOMP 등을 통해 서버에 메시지 전송
	            if (stompClient && stompClient.connected) {
	            	const message = {
	            			chatRoom_id: chatRoom_id,
	            			user_id: user_id,
	            			sender: user_name,
	            			chat_content: messageContent,
	            			send_time: new Date()
	            	};
	            	// ChatController의 @MessageMapping("/sendMessage")과 연결
	                stompClient.send("/app/sendMessage", {}, JSON.stringify(message));
	            }

	            // 입력 필드 비우기
	            input.value = "";
	        } else {
	        	alert("내용을 입력하세요.");
	        }
	    }
	    
	    // 채팅방에 누가 입장했는지 출력해주는 함수
	    function showEntranceMessage(message) {
	    	const chatBody = document.querySelector(".chat-body-inner > .py-6");
	    	
	    	const messageDiv = document.createElement("div");
	    	messageDiv.className = "message-divider";
	    	messageDiv.innerHTML = `
	    		<small class="text-muted">\${message.chat_content}</small>
	    	`;
	    	
	    	chatBody.appendChild(messageDiv);
	    }

	    // 사용자가 전송한 메시지를 출력해주는 함수
	    let lastDay = "";
	    function displayMessage(message) {
	        const chatBody = document.querySelector(".chat-body-inner > .py-6");
	        
	        // 메시지의 방향에 따라 클래스 설정
	        const messageDiv = document.createElement("div");
	        if (message.sender === user_name) { // message.sender가 로그인한 사람과 동일하면
	            messageDiv.className = "message message-out"; // 보내는 사람
	        } else {
	            messageDiv.className = "message"; // 상대방
	        }
	        
	     	// Timestamp 날짜 형식을 사람이 읽을 수 있는 형식으로 변환
	        const send_time = timestampToKRTime(message.send_time); // 2024-12-30 14:53
	        let dateOnly = send_time.split(' ')[0]; // 2024-12-30
	        let [year, month, day] = dateOnly.split('-'); // 문자열 분리
	        let formattedDate = `\${year}년 \${month}월 \${day}일`;
	     	let timeOnly = send_time.split(' ')[1]; // 14:53
	     	
	     	// 날짜별 대화 내용 구분을 위한 코드
	     	let divider = "";
	     	if (lastDay == "" || (formattedDate != lastDay)) {
	     		lastDay = formattedDate;
	     		divider = `
		    		<span class="text-muted">\${lastDay}</span>
	     	   `;
	     		const DividerDiv = document.createElement("div");
		     	DividerDiv.className = "message-divider";
		     	DividerDiv.innerHTML = `\${divider}`;
		     	chatBody.appendChild(DividerDiv);
	     	}
	     	
	        // 메시지 내용을 설정
	        messageDiv.innerHTML = `
	        	<div class="fw-bold">
	        		\${message.sender}
	        	</div>
	        	
	        	<div class="message-inner">
                	<div class="message-body">
                    	<div class="message-content">
				            <div class="message-text">
				            	\${escapeHtml(message.chat_content)}
				            </div>
				            <span class="small text-muted align-self-end ms-2 me-2">\${timeOnly}</span>
			            </div>
		            </div>
	            </div>
	        `;
	        
	        // 메시지를 채팅 영역에 추가
	        chatBody.appendChild(messageDiv);
	        
	        <%-- // 읽음 여부를 확인하는 뱃지(badge) 요소 생성
	     	const readCheckDiv = document.createElement("div");
	     	readCheckDiv.className = "badge badge-circle bg-warning align-self-end mb-1";
	     	readCheckDiv.innerHTML = `<span>1</span>`;
	        
	     	// 상대방 메시지에만 읽음 여부를 확인하는 뱃지(badge) 요소 추가
	     	const messageContent = messageDiv.querySelector('.message .message-content');
	        if (message.sender != user_name) {
	        	messageContent.appendChild(readCheckDiv);
	        } --%>

	     	// 스크롤을 맨 아래로 이동
	        scrollToBottom();
	    }

	    // HTML 특수문자 이스케이프 처리 (XSS 방지)
	    function escapeHtml(unsafe) {
	        return unsafe
	            .replace(/&/g, "&amp;")
	            .replace(/</g, "&lt;")
	            .replace(/>/g, "&gt;")
	            .replace(/"/g, "&quot;")
	            .replace(/'/g, "&#039;");
	    }
	    
	 	// Timestamp 날짜 형식을 사람이 읽을 수 있는 형식으로 변환
	    function timestampToKRTime(send_time) {
	        const timestamp = send_time;
	        const date = new Date(timestamp);
	        
	     	// UTC에서 9시간을 더해 한국 시간(KST)으로 변환
	        date.setHours(date.getHours() + 9);
	     	
	     	// 한국 시간으로 변환된 날짜를 원하는 형식으로 출력
	     	send_time = date.toISOString().slice(0, 16).replace("T", " "); // 예: 2024-12-30 14:53
	     	
	     	return send_time;
	    }
	 	
	 	// 채팅방 나가기
	    function exitChatRoom() {
	 		// 웹소켓 연결 해제
	    	disconnect();
	    	
	    	document.getElementById("chatRoomArea").innerHTML = "";
	    	
	    	document.getElementById("chatRoomArea").innerHTML = `
	    		<div class="d-flex flex-column h-100 justify-content-center text-center">
		            <div class="mb-6">
		                <span class="icon icon-xl text-muted">
		                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-message-square"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
		                </span>
		            </div>
	
		            <p class="text-muted">왼쪽 목록에서 채팅방을 선택하여 <br> 대화를 시작하세요.</p>
		        </div>
	    	`;
	    }
	    
	    // 채팅방 퇴장할 시 웹소켓 연결 해제
	    function disconnect() {
	        if (stompClient !== null) {
	            stompClient.disconnect();
	        }
	        console.log("웹소켓 Disconnected");
	    }
	</script>
</body>
</html>