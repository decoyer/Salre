<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>살래?</title>

  <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
 	<%@ include file="../common/header.jsp" %>
    <link rel="stylesheet" href="${contextPath}/resources/css/detail.css">
</head>
<body>


  <div class="screen">
    <div class="left"> 
    <div>
      <img 
    class="main-image" 
    src="../../resources/images/products/${product.product_id}.jpeg" 
    onerror="this.onerror=null; this.src='https://placehold.co/600x600'" 
    alt="Main Image" 
    style="width: 600px; height: 600px; object-fit: cover;">
     </div>
		<div class="seller-profile">
		  <img class="generic-avatar" src="https://avatar.iran.liara.run/public" alt="Avatar" />
		  <p class="seller-name">
		    <span class="seller-nickname">${user_nickname}</span> 
		  </p>
		  <div style="display: flex; justify-content: flex-end; width: 100%;">
		    <form action="${contextPath}/chat/createChatRoom.do" method="post">
		      <input type="hidden" name="product_id" value="${product.product_id}">
		      <input type="hidden" name="product_user_id" value="${product.user_id}">
		      <input type="hidden" name="product_name" value="${product.product_name}">
		      <button type="submit" id="chatButton" class="chat-button">채팅하기</button>
		    </form>
		  </div>
		</div>

		<input type="hidden" id="product_status" value="${product.product_status}">

		<script>
		    // product_status 값 가져오기
		    const productStatus = document.getElementById("product_status").value;
		
		    // product_status가 2면 버튼 숨기기
		    if (productStatus === "2") {
		        document.getElementById("chatButton").style.display = "none";
		    }

            // 채팅하기 버튼 클릭 시 알림 발생
		    $('#chatButton').click(function() {
		    	// 알림 보내기
				const user_id = ${product.user_id};
				// 알림 내용 입력
				const notify_content = "매물에 대한 새로운 채팅이 있습니다.<br>채팅을 확인해주세요.";
				// 알림 클릭 시 이동할 URL
				const notify_url = "${contextPath}/chat/main.do";
				$.ajax({
					type : "POST",
					url : "${contextPath}/notify/send",
					contentType : "application/json",
					data : JSON.stringify({
						user_id : user_id,
						notify_content : notify_content,
						notify_url : notify_url
					}),
					success : function() {
						console.log("알림 전송 성공");
					},
					error : function() {
						console.error("알림 전송 오류");
					}
				});
		    });
		</script>

      <div class="division-line">
        <hr />
      </div>
<div class="recent-review">최근 리뷰
    <div class="review-container">
        <c:choose>
 
            <c:when test="${not empty review}">
                <c:forEach var="review" items="${review}" varStatus="status">
                    <div class="review">
                        <div class="reviewer">
                            <img class="review-avatar" src="https://avatar.iran.liara.run/public/boy" alt="Avatar" />
                            <p class="seller-name">
                                <span class="review-seller-name">
                                    <c:choose>
             
                                        <c:when test="${status.index == 0}">
                                            ${username1}<br />
                                        </c:when>
  
                                        <c:when test="${status.index == 1}">
                                            ${username2}<br />
                                        </c:when>
                                    </c:choose>
                                </span>
                            </p>
                        </div>
                        <div class="review-content">
                            <p>${review.review_content}</p>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
     
            <c:otherwise>
                <p class="no-review">현재 등록된 리뷰가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>



        </div>
        <div class="right">
  
          <div class="product-info">
                      <div style="display: flex; justify-content: space-between; align-items: center;">
              <p class="product-descript-name" style="margin-top : 30px;">${product.product_name}</p>
           	<div class = "links-right" >
   
	               <div>
							<button type="button" class="btn btn-secondary" id="report"
								onclick="makeReport()">신고하기</button>
							<!-- 모달 -->
								<div id="reportModal" class="modal">
							<div class="modal-content">
								<span class="close" onclick="closeModal()">&times;</span>
								<h2>신고하기</h2>
								<p>신고 내용을 작성해주세요.</p>
								<!-- 신고 유형 선택 -->
								<label for="reportType">신고 유형:</label> <select id="reportType"
									required>
									<option value="" disabled selected>신고 유형을 선택하세요</option>
									<option value="0">허위매물</option>
									<option value="1">게시판신고</option>
									<option value="2">기타</option>
								</select> <input type="hidden" name="product_id" id="product_id"
									value="${product.product_id}">
								<textarea id="reportContent" rows="5"
									placeholder="신고 내용을 입력하세요..." required></textarea>
									<input type="hidden" id = "status" name = "status" value = "0">									
								<div class="button-group">
									<button type="button" class="btn btn-primary"
										onclick="submitReport()">확인</button>
									<button type="button" class="btn btn-secondary"
										onclick="closeModal()">취소</button>
								</div>
							</div>
						</div>
	              </div>
               
                  	<div class = "links-right2">
                      	<button class="btn_like" data-product-id="${product.product_id}" data-user-id="${user_id}">Like</button>
						<div id="like-message"></div>
             			<div class = "readCount">  조회수  ${product.view_count } 회</div>
              </div>
              </div>
            </div> 
            	<div id = "status" style="display: flex;  align-items : center;">
				<div class="info-row" id="price-row" style = "margin-right : 20px;">
				    <div class="${status}">
				        <h2>${label}</h2> 
				    </div>
				</div> 
			    <div class="payment-type" style="display:inline; margin-right : 20px;">
			        <h2>${product.payment_type}</h2>
			    </div>
			    <div class="deposit" id = "product_deposit">
			        <h2>${product.deposit} </h2>
			    </div>
			    <div class="rentfee"> 
			         <c:choose>
				        <c:when test="${product.payment_type == '월세'}">
				            <h2> / ${product.rentfee}</h2>
				        </c:when>
				        <c:otherwise>
 
				        </c:otherwise>
				    </c:choose>
				    </div>
	   		    </div>
			</div>


            <div class="info-row">
              <div class="info-category">주소</div>
              <div class="info-content">${product.address} ${product.floor } 층 ${product.address_detail }</div>
            </div> 
            
            <div class="info-row">
              <div class="info-category">면적</div>
              <div class="info-content">${product.area } 평</div>
            </div>
            <div class="info-row">
              <div class="info-category">방/욕실 수</div>
              <div class="info-content">방 ${product.room_count } 개 / 욕실 ${product.bath_count }</div>
            </div> 
            <div class="info-row">
              <div class="info-category">전세/월세</div>
              <div class="info-content">${product.payment_type }</div>
            </div>  
            <div class="info-row">
              <div class="info-category">방향</div>
              <div class="info-content">${product.direction} </div>
            </div> 
            
             <h1>대출가능여부</h1>
            <div class="info-row">
			    <div class="info-category">주택도시기금</div>
			    <div class="info-content">${product.loan1 == 1 ? '가능' : '불가능'}</div>
			</div> 
			<div class="info-row">
			    <div class="info-category">중소기업 취업 청년</div>
			    <div class="info-content">${product.loan2 == 1 ? '가능' : '불가능'}</div>
			</div>
			
			<div class="info-row">
			    <div class="info-category">버팀목 전세자금대출</div>
			    <div class="info-content">${product.loan3 == 1 ? '가능' : '불가능'}</div>
			</div>
 
            <div class="info-row">
             <div class="info-category">매물 설명</div>
             <p class="product-descript">
              ${product.description }
            </p>  
            </div>
			<div id="map" style="width:550px;height:200px;"></div>
   
           <script>
//신고하기
	// 모달 열기
function makeReport() {
    const modal = document.getElementById("reportModal");
    modal.style.display = "flex"; // 모달 표시
}
 
// 모달 닫기
function closeModal() {
    const modal = document.getElementById("reportModal");
    modal.style.display = "none"; // 모달 숨김
}
// 신고 내용 제출
function submitReport() {
	 // 각 요소의 값을 변수에 저장
    const reportType = document.getElementById("reportType").value;
    const reportContent = document.getElementById("reportContent").value;
    const productId = "${product.product_id}";
    if (!reportType) {
        alert("신고 유형을 선택하세요.");
        return;
    }
    if (!reportContent.trim()) {
        alert("신고 내용을 입력하세요.");
        return;
    }
    // 데이터 전송
    const formData = new FormData();
    formData.append("reportType", reportType);
    formData.append("reportContent", reportContent);
    formData.append("product_id", productId);
    formData.append("status",status);
   
	
    fetch("${pageContext.request.contextPath}/addreports", {
        method: "POST",
        body: formData
    })
        .then(response => {
            if (response.ok) {
                alert("신고가 성공적으로 접수되었습니다.");
                closeModal(); // 모달 닫기
                document.getElementById("reportType").value = ""; // 초기화
                document.getElementById("reportContent").value = ""; // 초기화
            } else {
                alert("신고 접수에 실패했습니다. 다시 시도해주세요.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        });
}
   
    let map; // 전역 변수로 지도 객체 생성
    const query = "${product.address }"
 

    window.onload = function () {
 
        if (query) {
            console.log("query : " + query);
            searchAddress();
        } else {
            console.log('query가 없음');
        }
  
	        const depositElement = document.getElementById('product_deposit');
	        const depositValue = parseInt(depositElement.innerText, 10); 
	        
	        depositElement.innerHTML = '<h2>' + formatNumber(depositValue) + ' </h2>';
 
    };

//     document.querySelector('.btn_like').addEventListener('click', function () {
//         const productId = this.getAttribute('data-product-id');
//         const userId = this.getAttribute('data-user-id');
//         const url = `/salre/toggleLike/${product_product_id}/${user_id}`;

//         fetch(url, {
//             method: 'GET',
//         })
//             .then((response) => response.text())
//             .then((data) => {
//                 // 서버로부터 반환된 메시지를 처리
//                 document.getElementById('like-message').innerText = data;
//             })
//             .catch((error) => {
//                 console.error('Error:', error);
//             });
//     });
    
    // Kakao 지도 초기화 함수
    function initMap(x, y) {
        const mapContainer = document.getElementById('map'); // 지도를 표시할 div
        const mapOption = {
            center: new kakao.maps.LatLng(y, x), // 동적으로 받은 x, y 값 사용
            level: 3, // 확대 레벨
            draggable: false 
        };

        // 지도 생성	
        map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 생성
        const marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(y, x)
        });

        // 지도 중심 설정
        map.setCenter(new kakao.maps.LatLng(y, x));
    }

    async function searchAddress() { 
    	
        const encodedQuery = encodeURIComponent(query); 
        const apiUrl = `https://dapi.kakao.com/v2/local/search/address.json?query=\${encodedQuery}`;
        console.log("API 요청 URL: " + apiUrl); // 여기서 로그 출력

        try {
            const response = await fetch(apiUrl, {
                method: "GET",
                headers: {
                    "Authorization": "KakaoAK 0a921d8f6de257f50d4e45968e437ec5"
                }
            });

            if (!response.ok) {
            	console.log("API 호출 실패: " + response.status);
                throw new Error("API 호출 실패: " + response.status);
            }

            const data = await response.json();

            if (data.documents.length === 0) {
                console.log("검색 결과가 없습니다.");
                return;
            }

            const result = data.documents[0];
            const address = result.address.address_name;
            const x = result.x;
            const y = result.y;

            initMap(x, y); 
            
        } catch (error) {
            console.error("Error:", error);
            alert("API 호출 중 오류가 발생했습니다.");
        }
    }
		</script>

		<div class="product-address" id="address">
		 	${product.address } ${product.address_detail}
		</div>
		<div id="copyNotification" style="display: none; color: green; font-size: 1rem; margin-top: 10px;">주소가 복사되었습니다!</div>
	
 	   <script>
		  document.getElementById("address").addEventListener("click", function() {
		    var copyText = document.getElementById("address");
		    var notification = document.getElementById("copyNotification");

		    copyText.style.color = "#f4a261"; // 복사된 후 텍스트 색 변경
		
		    navigator.clipboard.writeText(copyText.innerText)
		      .then(function() {
		        // 복사 성공 후 알림 메시지 표시
		        notification.style.display = "block";
		        setTimeout(function() {
		          notification.style.display = "none";
		        }, 2000); // 2초 후 알림 숨기기
		      })
		      .catch(function(err) {
		        alert("복사 실패: " + err);
		      });
		  });
		  
		  $('.btn_like').click(function () {
			   $(this).toggleClass("on")
			 });
		</script> 
    </div>   
	         	</div>         
 
	
	 <script> 

	 function formatNumber(num) {
		    const units = ["백만", "천만", "억"]; // 각 단위 정의
		    let result = ''; // 결과 문자열
		    let unitIndex = 0; // 단위 인덱스
			console.log(num);
		    // 1억 단위로 나누면서 단위 붙임
		    while (num > 0) {
		        const remainder = num % 10000; // 10,000으로 나눈 나머지
		        if (remainder > 0) {
		            let part = remainder.toString(); // 나머지를 문자열로 변환
		            if (unitIndex > 0) {
			                part = part.replace(/0+$/, ''); // 뒤에 있는 0 제거
		            }
		            result = part + (units[unitIndex] ? units[unitIndex] : '') + result; // 결과에 추가
		        }
		        num = Math.floor(num / 10000); // 10,000으로 나눈 몫을 다시 num에 저장
		        unitIndex++; // 단위 인덱스 증가
		    }

		    // "백", "천" 단위가 중간에 있을 경우 제거
		    result = result.replace(/(천|백)(?=\d)/g, ''); // 백, 천이 중간에 있을 경우 제거

		    // "만" 단위도 절삭
		    if (result.includes("백만") && !result.includes("천")) {
		        result = result.replace(/만$/, ''); // 만 단위가 필요 없으면 제거
		    }
			console.log(result);
		    return result || '0'; // 결과 반환, 0이면 '0' 반환
		} 
	</script> 
		<%@ include file="../common/footer.jsp" %>
</body> 
</html>