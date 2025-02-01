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
</head>
<body>
    <h2>계약서 보기</h2>
        <c:if test="${not empty contract.contract_imgpath}">
            <img src="${path}${contract.contract_imgpath}" alt="계약서 이미지" style="width: 70%; height: 80%;">
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red;">${errorMessage}</p>
        </c:if>
        <div class="button-group">
		  <%-- <a href="${path}/resources/pdf/contract_sample_${contract_id}.pdf" class="btn btn-primary" download> 다운로드</a>
	 --%></div>
     <script>
     
     function notice() {
    	 
     }
     // 창 닫기
    function closeWindow() {
        window.close();
    }
    </script>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>