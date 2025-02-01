<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>살래?</title>
<link rel="stylesheet" href="${path}/resources/css/style2.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
 <div class="container">
        <h1 class="title">부동산 정보확인</h1>
        <!-- 계약 정보 -->
        <section class="section">
 
            <div class="form-group">
                <label>회원번호:</label>
                <span>${P_user.id}</span>
            </div>
            <div class="form-group">
                <label>매물번호:</label>
                <span>${product.product_id}</span>
            </div>        
        </section>

        <!-- 회원 정보 -->
        <section class="section">
            <h2>판매자 정보</h2>
            <div class="form-group">
                <label>아이디:</label>
                <span>${P_user.user_id}</span>
            </div>
            <div class="form-group">
                <label>이름:</label>
                <span>${P_user.user_name}</span>
            </div>
            <div class="form-group">
                <label>전화번호:</label>
                <span>${P_user.phone_num}</span>
            </div>
            <div class="form-group">
                <label>이메일:</label>
                <span>${P_user.email}</span>
            </div>
        </section>
        <!-- 회원 정보 -->
        <section class="section">
            <h2>구매자 정보</h2>
            <div class="form-group">
                <label>아이디:</label>
                <span>${user.user_id}</span>
            </div>
            <div class="form-group">
                <label>이름:</label>
                <span>${user.user_name}</span>
            </div>
            <div class="form-group">
                <label>전화번호:</label>
                <span>${user.phone_num}</span>
            </div>
            <div class="form-group">
                <label>이메일:</label>
                <span>${user.email}</span>
            </div>
        </section>

        <!-- 매물 정보 -->
        <section class="section">
            <h2>매물 정보</h2>
            <div class="form-group">
                <label>매물번호:</label>
                <span>${product.product_id}</span>
            </div>
            <div class="form-group">
                <label>매물명:</label>
                <span>${product.product_name}</span>
            </div>
            <div class="form-group">
                <label>주소:</label>
                <span>${product.address}
                ${product.address_detail}
            </span>
            </div>
            <!-- 거래유형 출력 조건 -->
            <c:choose>
            <c:when test ="${product.payment_type=='전세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
               <span> <fmt:formatNumber value="${product.deposit}" type="number" groupingUsed="true"/>원</span>
 
            </div>
            </c:when> 
            <c:when test = "${product.payment_type=='월세'}">
            <div class="form-group">
                <label>거래유형:</label>
                <span>${product.payment_type}</span>
            </div>
            <div class="form-group">
                <label>월세:</label>
                <span>${product.rentfee}</span>
            </div>
            <div class="form-group">
                <label>보증금:</label>
                <span>${product.deposit} 원</span>
            </div>
            </c:when>
     </c:choose>
            <div class="form-group">
                <label>면적:</label>
                <span>${product.area} ㎡</span>
            </div>
        </section>
<!-- 제출 버튼 -->
        <div class="button-group">
        	
        	<form action="${path}/contract/inputContract" method = "post">
        	<button type="button" class="btn btn-secondary">취소</button>
        	   <input type="submit" class="btn btn-primary"  value="다음" />
        	   <input type="hidden" name="product_id" value="${product.product_id}">
        	   <input type="hidden" name="user_id" value="${user.user_id}">
        	</form>
        	 </div>
		<!--매물 사진 -->
		<section class="section">
			<h2>매물 사진</h2>
			<div class="image-preview-container">
				<img src="${path}/resources/images/products/외관img.png" alt = "매물 사진 1">
				<img src="${path}/resources/images/products/img1.png" alt = "매물 사진 1">
				<img src="${path}/resources/images/products/img2.png" alt = "매물 사진 2">
				<img src="${path}/resources/images/products/주방.png" alt = "매물 사진 4">
				<img src="${path}/resources/images/products/화장실img.png" alt = "매물 사진 3">
				<img src="${path}/resources/images/products/발코니img.png" alt = "매물 사진 5">
			</div>
		</section>

		 <div class="button-group">
        	
        	<form action="${path}/contract/inputContract" method = "post">
        	<button type="button" class="btn btn-secondary">취소</button>
        	   <input type="submit" class="btn btn-primary"  value="다음" />
        	   <input type="hidden" name="product_id" value="${product.product_id}">
        	   <input type="hidden" name="user_id" value="${P_user.user_id}">
        	</form>
        	 </div>
            
            
       
    </div>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
