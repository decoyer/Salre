<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>


<%
String certifiedName = (String) session.getAttribute("certifiedName");
String certifiedPhone = (String) session.getAttribute("certifiedPhone");
String certifiedBirthday = (String) session.getAttribute("certifiedBirthday");
System.out.println("Info 세션 데이터:");
System.out.println("Name: " + certifiedName);
System.out.println("Phone: " + certifiedPhone);
System.out.println("Birthday: " + certifiedBirthday);
%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/css/myPage.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src=" https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
.certification-btn {
	width: 80%; /* 버튼의 너비를 폼 섹션의 100%로 설정 */
	padding: 10px; /* 버튼의 상하 좌우 여백 */
	font-size: 16px; /* 버튼 글씨 크기 */
	color: white; /* 버튼 글씨 색상 */
	background-color: #007bff; /* 버튼 배경색 (파란색) */
	border: none; /* 버튼 테두리 없음 */
	border-radius: 4px; /* 버튼 모서리를 둥글게 */
	cursor: pointer; /* 마우스를 올리면 포인터 모양 */
	margin-bottom: 15px; /* 버튼 아래 여백 */
}

.certification-btn:hover {
	background-color: #0056b3; /* 버튼에 마우스를 올렸을 때 배경색을 더 진한 파란색으로 변경 */
}



</style>

</head>
<body>
	<%@ include file="../common/header.jsp"%>


	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<%@ include file="../common/sidebar.jsp"%>

			<!-- Main Content -->
			<div class="col-md-9 content">

				<h1 class="mb-4" style="margin-top: 30px;">나의 정보관리(수정)</h1>
				<br> <br>

				<h4 class="mb-4" style="margin-top: 30px;">나의 정보(수정)</h4>
				<!-- <form> -->

				<div class="center-container" >
				
					<!-- Hidden Fields to Keep Data -->
					<input type="hidden" id="user_id" name="user_id"
						value="${loggedInUser.user_id}" /> <input type="hidden"
						id="password" name="password" value="${loggedInUser.password}" />
					

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="id" class="form-label">ID</label> <input type="text"
								id="id" class="form-control" value="${loggedInUser.id}" readonly>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="name" class="form-label">이름</label> <input
								type="text" id="name" class="form-control"
								value="${loggedInUser.user_name}" readonly>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="resident" class="form-label">주민등록번호</label> <input
								type="text" id="resident" class="form-control"
								value="${loggedInUser.resident_num}" readonly>
						</div>

					</div>


					<div class="row mb-3 align-items-center">
						<label for="phone" class="form-label me-2 mb-0">Phone</label>
						<div class="col-md-6 d-flex align-items-center">
							<input type="text" id="phone" class="form-control me-2 mb-3"
								value="${loggedInUser.phone_num}">
							<button type="button" class="certification-btn"
								onclick="requestCertification()">본인인증</button>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="email" class="form-label">Email</label> <input
								type="email" id="email" class="form-control"
								value="${loggedInUser.email}">
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-md-6">
							<label for="address" class="form-label">주소</label> <input
								type="text" id="address" class="form-control"
								value="${loggedInUser.address}"> <input type="text"
								id="address_detail" name="address_detail" class="form-control"
								value="${loggedInUser.address_detail}" />
						</div>
					</div>






					<br> <br>

					<%-- <div class="row mb-3">
						<div class="col-md-6">
							<label for="password" class="form-label">Password</label>
							<input
								type="password" id="password" class="form-control"
								value="${loggedInUser.password}" > --%>
					<%-- 	<div class="input-group">
								<input type="password" id="password" class="form-control"
									value="${loggedInUser.password}" >
								<button type="button" class="btn btn-outline-secondary"
									onclick="togglePassword()">👁</button> 
							</div> --%>

					<!-- 			</div>
					</div> -->

					<%-- 	<button onclick="call()" type="button" class="btn btn-primary w-10">회원정보수정</button>
					
					<form action="${contextPath}/deleteUser" method="post" onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
					    <input type="hidden" name="id" value="${loggedInUser.id}">
					    <button type="submit" class="btn btn-danger">회원탈퇴</button>
					</form> --%>
					<div class="d-flex justify-content-front  align-items-center">
						<!-- <button onclick="call()" type="button" class="btn btn-primary me-2">회원정보수정</button> -->
						<%--  <button onclick="location.href='${contextPath}/myPage'" type="button" class="btn btn-primary me-2">회원정보수정</button> --%>
						<button type="button" class="btn btn-primary me-2"
							onclick="updateUserInfo()">회원정보수정</button>
						<button type="button" class="btn btn-primary"
							onclick="location.href='${contextPath}/findPassword'">비밀번호재설정</button>	
					</div>
				</div>


			</div>
		</div>
	</div>


	<!--  <script type="text/javascript">
    	function call(){
    		$.ajax({
    			url : '${contextPath}/myPage/myPage',
    			type: 'post',
    			data:{"id":$("#id").val(),  "user_name":"ppp" },
    			success:function(a){
    				alert(a);
    			}
    		});
    			
    		
    	}
    </script>
 -->

	<%@ include file="../common/footer.jsp"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Icons -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">


	<!-- 회원정보수정(password 보이게) -->
	<script>
		function togglePassword() {
			const passwordInput = document.getElementById('password');
			if (passwordInput.type === 'password') {
				passwordInput.type = 'text';
			} else {
				passwordInput.type = 'password';
			}
		}
		
		
		/* 본인인증(휴대폰 인증) */
	    // 포트원 SDK 초기화
	/*     IMP.init("imp74358381"); // 예: imp00000000
	     
	   function requestCertification() {
	 	// IMP.certification(param, callback) 호출
	    IMP.certification(
	      {
	        // param
	        channelKey: "{channel-key-338d3c61-d13e-4639-9997-033ab26725cd}",
	        merchant_uid: "ORD" + new Date().getTime(),  //"ORD20180131-0000011", // 주문 번호
	        popup: false
	        //m_redirect_url: "{https://your-service.com/signup/complete}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
	        //popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
	      },
	      
	      
	      function (rsp) {
	        // callback//본인인증 완료 후 호출되는 콜백 함수. 본인인증 요청의 결과가 담긴 객체가 rsp로 전달됨.
	        if (rsp.success) {
	          // 인증 성공 시 로직
	        	//alert("본인인증 성공: " + rsp.imp_uid);
	        	alert("본인인증을 성공하였습니다.");
	          	console.log(rsp);
	            // 서버로 인증 데이터를 전달하여 세션에 저장
	            $.ajax({
	                url: "${contextPath}/rspTest2",
	                type: "POST",
	                data: { imp_uid: rsp.imp_uid },
	                success: function () {
	                    alert("본인인증 데이터 저장 완료");
	                    location.href = "${contextPath}/signUpInfo"; // signUpInfo.jsp로 이동
	                },
	                error: function () {
	                    alert("본인인증 데이터 저장 중 오류 발생");
	                }
	            });
	               
	      
	             //document.querySelector('[name="certified"]').value = "인증 완료";//서버는 이 값 확인해서 사용자가 본인인증 완료헀는지 판단.(아래 미인증과 관련)
	             document.getElementById("signup-button").disabled=false;
	        } else {
	          // 인증 실패 시 로직
	        	 alert("본인인증 실패: " + rsp.error_msg);
	        }  //if end 
	      }  //함수 end 
	    ); //IMP.certification end 
	 }  //function end  */
	    
	

	 <!-- JavaScript 수정 -->

	     function requestCertification() {
	         // 본인인증 API 호출
	         IMP.init("imp74358381");
	         IMP.certification({
	             channelKey: "{channel-key-338d3c61-d13e-4639-9997-033ab26725cd}",
	             merchant_uid: "ORD" + new Date().getTime(),
	             popup: true
	         }, function (rsp) {
	             if (rsp.success) {
	                 // 서버에 인증 데이터 전송
	                 $.ajax({
	                     url: "${contextPath}/rspTest3",
	                     type: "POST",
	                     data: { imp_uid: rsp.imp_uid },
	                     success: function () {
	                         alert("본인인증이 성공적으로 완료되었습니다.");
	                         // 세션에서 업데이트된 데이터를 가져와 폼 필드를 업데이트
	                         $.ajax({
	                             url: "${contextPath}/getSessionData",
	                             type: "GET",
	                             success: function (data) {
	                                 // 업데이트된 데이터로 필드 값 설정
	                                 /* document.getElementById("name").value = data.name;
	                                 document.getElementById("resident").value = data.birthday;
	                                 document.getElementById("phone").value = data.phone; */
	                                 
	                            	  // 폼 필드 갱신
	                                 document.getElementById("name").value = data.name || document.getElementById("name").value;
	                                 document.getElementById("resident").value = data.birthday || document.getElementById("resident").value;
	                                 document.getElementById("phone").value = data.phone || document.getElementById("phone").value;

	                                 // 기존 값 유지
	                                 document.getElementById("id").value = document.getElementById("id").value;
	                                 document.getElementById("email").value = document.getElementById("email").value;
	                                 document.getElementById("address").value = document.getElementById("address").value;
	                             
	                             },
	                             error: function () {
	                                 alert("본인인증 데이터를 가져오는 데 실패했습니다.");
	                             }
	                         });
	                     },
	                     error: function () {
	                         alert("본인인증 중 오류가 발생했습니다.");
	                     }
	                 });
	             } else {
	                 alert("본인인증에 실패하였습니다: " + rsp.error_msg);
	             }
	         });
	     }
	     
	     function updateUserInfo() {
	            const userData = {
	            	 user_id: document.getElementById("user_id").value,
	            	 id: document.getElementById("id").value,
	            	 password:document.getElementById("password").value,
	            	 user_name: document.getElementById("name").value,
	            	 phone_num: document.getElementById("phone").value,
	            	 email: document.getElementById("email").value,
	            	 resident_num: document.getElementById("resident").value,
	            	 address: document.getElementById("address").value,
	                 address_detail: document.getElementById("address_detail").value
	                /*  auth_seller: document.getElementById("auth_seller").value */
	            	
	            };

	            $.ajax({
	                url: "${contextPath}/updateUserInfo",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(userData),
	                success: function (response) {
	                    if (response.success) {
	                        alert("회원정보가 성공적으로 수정되었습니다.");
	                        location.reload();
	                    } else {
	                        alert("회원정보 수정에 실패했습니다.");
	                    }
	                },
	                error: function () {
	                    alert("서버 오류가 발생했습니다.");
	                }
	            });
	        }
	


	</script>
</body>
</html>
