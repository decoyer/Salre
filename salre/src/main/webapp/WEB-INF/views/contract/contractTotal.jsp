<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/style2.css">
<title>살래?</title>
</head>
<body>
	<div class="container">
		<h1 class="title">계약서 최종확인</h1>
		<form id="contractInput" method="post">
			<!-- 회원 정보 -->
			<section class="section">
				<h2>임대인 정보</h2>
				<div class="form-group">
					<label>아이디:</label> <span>${p_user.id}</span>
				</div>
				<div class="form-group">
					<label>이름:</label> <span>${p_user.user_name}</span>
				</div>
				<div class="form-group">
					<label>전화번호:</label> <span>${p_user.phone_num}</span>
				</div>
				<div class="form-group">
					<label>이메일:</label> <span>${p_user.email}</span>
				</div>
			</section>
			<section class="section">
				<h2>임차인 정보</h2>
				<div class="form-group">
					<label>이름:</label> <span>${tenant_user.user_name}</span>
				</div>
				<div class="form-group">
					<label>전화번호:</label> <span>${tenant_user.phone_num}</span>
				</div>
				<div class="form-group">
					<label>이메일:</label> <span>${tenant_user.email}</span>
				</div>
				<div class="form-group">
					<label>주소:</label> <span>${tenant_user.address}${tenant_user.address_detail}</span>
				</div>
			</section>
			<!-- 매물 정보 -->
			<section class="section">
				<h2>매물 정보</h2>
				<div class="form-group">
					<label>매물번호:</label> <span>${product.product_id}</span>
				</div>
				<div class="form-group">
					<label>매물명:</label> <span>${product.product_name}</span>
				</div>
				<div class="form-group">
					<label>주소:</label> <span>${product.address}
						${product.address_detail}</span>
				</div>
				<c:choose>
					<c:when test="${product.payment_type == '전세'}">
						<div class="form-group">
							<label>거래유형:</label> <span>${product.payment_type}</span>
						</div>
						<div class="form-group">
						<label>보증금:</label>
					<span><fmt:formatNumber value="${product.deposit}" type="number" groupingUsed="true"/>원</span>
						</div>
					</c:when>
					<c:when test="${product.payment_type == '월세'}">
						<div class="form-group">
							<label>거래유형:</label> <span>${product.payment_type}</span>
						</div>
						<div class="form-group">
							<label>월세:</label> <span>${product.rentfee}</span>
						</div>
						<div class="form-group">
							<label>보증금:</label> <span>${product.deposit} 원</span>
						</div>
					</c:when>
				</c:choose>
				<div class="form-group">
					<label>면적:</label> <span>${product.area} ㎡</span>
				</div>
			</section>

			<!-- 계약 내용 -->
			<section class="section">
				<h2>계약 내용</h2>
				<div class="form-group">
					<label>보증금:</label>
					<span><fmt:formatNumber value="${product.deposit}" type="number" groupingUsed="true"/>원</span>
				</div>
				<div class="form-group">
					<label>계약금:</label>
					<span><fmt:formatNumber value="${contract.price}" type="number" groupingUsed="true"/>원</span>
				</div>
				
					
					<c:if test="${not empty contract.middle_payment}">
					<div class="form-group">
					<label>중도금:</label>
					<span><fmt:formatNumber value="${contract.middle_payment}" type="number" groupingUsed="true"/>원</span>
					<label>중도금 지급일:</label> <span>${contract.middle_payment_day}</span>
					</div>				
					</c:if>
					 
				
				
				<div class="form-group">
					<c:if test="${not empty contract.balance_payment}">
						<label>잔금:</label> 
					 <span><fmt:formatNumber value="${contract.balance_payment}" type="number" groupingUsed="true"/>원</span>
					 <label>잔금 지급일:</label> <span>${contract.balance_payment_day}</span>
					 </c:if>
					 
				</div>
				<div class="form-group">
					<label>임대차 기간:</label> <span>${product.enter_day}</span> ~ <span>${contract.contract_date}</span>
				</div>
				<div class="form-group">
					<label>계약일:</label> <span>${contract.contract_date}</span>
				</div>
			</section>

			<!-- 특약사항 -->
			<section class="section">
				<h2>특약사항</h2>
				<div class="contract-rule">
					<span>${contract.contract_rule}</span>
				</div>
			</section>
			<!-- 제출 버튼 -->
			<div class="button-group">
    <button type="button" class="btn btn-primary" onclick="makeContractPaper()">계약서 생성</button>
    <div id="closeButtonContainer"></div>
    </div>
		</form>
	</div>

	<script>
	// JSP에서 contextPath를 가져옴
	const contextPath = "${pageContext.request.contextPath}";

	// 계약서 초안 생성
	function makeContractPaper() {
	    console.log("초안 생성 시작:", contextPath);

	    // 새 창 열기
	    const newWindow = window.open(
	        contextPath + `/contract/sample/${contract.contract_id}`,
	        '_blank',
	        'width=800,height=600'
	    );

	    // 팝업 차단 확인
	    if (!newWindow || newWindow.closed || typeof newWindow.closed === 'undefined') {
	        alert("새 창을 열 수 없습니다. 팝업 차단 설정을 확인하세요.");
	        return;
	    }

	    // 새 창 감시
	    const timer = setInterval(() => {
	        if (newWindow.closed) {
	            clearInterval(timer); // 타이머 종료

	            // 닫기 버튼 동적 생성
	            const closeButtonContainer = document.getElementById("closeButtonContainer");
	            closeButtonContainer.innerHTML = `
	                <button type="button" class="btn btn-secondary" onclick="closeWindow()">마이페이지</button>
	            `;
	        }
	    }, 500);
	}

	// 창 닫기
	function closeWindow() {
	    window.location.href = "${path}/transactions";
	}

</script>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
