<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>살래?</title>
    	<link rel="stylesheet" href="${path}/resources/css/viewaccountt.css">
</head>
<body>
    <h2>계좌 정보</h2>
    계좌번호 : ${contract.account}<br>
    예금주 : ${contract.account_name}<br>
    은행명 : ${contract.bank_name}<br>
          <section class="section">
            <div class="button-group">
                <button type="button" class="btn btn-primary" onclick="payComplete()">송금 완료</button>
            </div>
        </section>
    
        <script>
        function payComplete() {
            // 알림창 표시
            alert("판매자에게 송금확인을 요청했어요! 확인 될때까지 기다려주세요. 감사합니다.");
        }
        
        </script>
        <%@ include file="../common/footer.jsp" %>
</body>
</html>