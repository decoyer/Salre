<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>살래?</title>
<link rel="stylesheet" href="${path}/resources/css/style2.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="title">추가 정보 입력</h1>
        <form action="${path}/contract/saveAdditionalInfo" method="post">
            <input type="hidden" name="contract_id" value="${contract.contract_id}" />
            <div class="form-group">
                <label for="account">계좌번호:</label>
                <input type="text" id="account" name="account" required >
            </div>
            <div class="form-group">
                <label for="account_name">예금주:</label>
                <input type="text" id="account_name" name="account_name" required >
            </div>
              <div class="form-group">
            <label for="bank_name">은행명:</label>
            <select id="bank_name" name="bank_name" required>
                <option value="">은행을 선택하세요</option>
                <option value="BNK경남은행">BNK경남은행</option>
                <option value="BNK부산은행">BNK부산은행</option>
                <option value="IBK기업은행">IBK기업은행</option>
                <option value="iM뱅크">iM뱅크</option>
                <option value="KB국민은행">KB국민은행</option>
                <option value="NH농협은행">NH농협은행</option>
                <option value="SC제일은행">SC제일은행</option>
                <option value="Sh수협은행">Sh수협은행</option>
                <option value="광주은행">광주은행</option>
                <option value="신한은행">신한은행</option>
                <option value="우리은행">우리은행</option>
                <option value="제주은행">제주은행</option>
                <option value="카카오뱅크">카카오뱅크</option>
                <option value="케이뱅크">케이뱅크</option>
                <option value="토스뱅크">토스뱅크</option>
                <option value="하나은행">하나은행</option>
            </select>
        </div>
            <section class="section">
				<!-- 증빙 서류 등록 -->
				<h2>증빙 서류 등록</h2>
				<div class="form-group">
					<label for="photo">신분증 사본 *</label> <input type="file" id="photo"
						name="identificationCard" accept="image/*">
				</div>
				<div class="form-group">
					<label for="photo">통장 사본 *</label> <input type="file" id="photo"
						name="bankAccount" accept="image/*" >
				</div>
			</section>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">완료</button>
            </div>
        </form>
    </div>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>