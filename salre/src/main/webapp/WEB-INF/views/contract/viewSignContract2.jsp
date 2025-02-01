<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<title>살래?</title>
	<link rel="stylesheet" href="${path}/resources/css/contract.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<h1 class="title">계약서</h1>
		<!-- 임차인 서명 확인 -->
		<!-- 계약서 이미지 -->
		<c:if test="${not empty contract.contract_imgpath}">
			<div class="contract-image-container">
					<img src="${path}${contract.contract_imgpath}" alt="계약서 이미지"
						class="contract-image" onclick="openModal(this.src)">
				</div>
				<div id="imageModal" class="image-modal" onclick="closeModal()">
					<span class="close">&times;</span> <img id="modalImage"
						class="modal-content">
				</div>
		</c:if>
		
		<!-- 에러 메시지 -->
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>

		<!-- 서명 요청 버튼 -->
		<section class="section">
			<div class="button-group">
				<button type="button" class="btn btn-primary" onclick="goToTenant()">서명요청</button>
				<button type="button" class="btn btn-secondary" onclick="closeWindow()">닫기</button>
			</div>
		</section>
	</div>
	


	<script>
	function successPayment(contractId) {
	    // 계약 상태값 4 - 구매자 서명 완료
	    const contractStatus = 4;

	    $.ajax({
	        type: "POST",
	        url: "${path}/contract/updateStatus",
	        contentType: "application/json",
	        data: JSON.stringify({
	            contract_id: contractId,
	            contract_status: contractStatus
	        }),
	        success: function () {
	            console.log("상태 업데이트 성공");

	            // 상태 업데이트 성공 시 송금 확인 요청 실행
	            checkPaymentToLandlord();
	        },
	        error: function () {
	            console.error("상태 업데이트 오류");
	        }
	    });
	}
	// 계약서 확인 요청
	function goToTenant() {
		// 알림 보내기
		const user_id = "${contract.user_id}";
		// 알림 내용 입력
		const notify_content = `임대인이 서명을 완료했어요.<br>서명을 완료해주세요.`;
		// 알림 클릭 시 이동할 URL
		const notify_url = "${pageContext.request.contextPath}/contract/signTenantContract/${contract_id}";

		$.ajax({
			type : "POST",
			url : `${pageContext.request.contextPath}/notify/send`,
			contentType : "application/json",
			data : JSON.stringify({
				user_id : user_id,
				notify_content : notify_content,
				notify_url : notify_url
			}),
			success : function() {
				alert("서명 요청 알림이 성공적으로 전송되었습니다.");
				console.log("알림 전송 성공");
			},
			error : function() {
				alert("서명 요청 알림 전송에 실패했습니다.");
				console.error("알림 전송 오류");
			}
		});
	};
		// 창 닫기
		function closeWindow() {
			 window.location.href = "${path}/transactions";
		}
		
		//계약서 이미지 모달 
		  function openModal(imageSrc) {
	            const modal = document.getElementById('imageModal');
	            const modalImage = document.getElementById('modalImage');

	            modal.style.display = "flex"; // 모달 창 표시
	            modalImage.src = imageSrc; // 클릭한 이미지 경로 설정
	        }

	        function closeModal() {
	            const modal = document.getElementById('imageModal');
	            modal.style.display = "none"; // 모달 창 숨김
	        }

	</script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>
