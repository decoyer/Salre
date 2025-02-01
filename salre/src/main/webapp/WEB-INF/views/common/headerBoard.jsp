<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<title>살래?</title>
	
	<!-- Meta Tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <!-- Favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

	<!-- 외부 CSS -->
    <%-- <link rel="stylesheet" href="${contextPath}/resources/css/home.css"> --%>
    <link rel="stylesheet" href="${contextPath}/resources/css/header.css">
</head>
<body>
	<!-- Header START -->
    <header>
        <div class="logo">
            <nav>
                <a href="${contextPath}/">
                    <div style="padding-right: 20px;">
                        <img src="${contextPath}/resources/images/favicon.ico">
                    </div>
                    <div>살래?</div>
                </a>
            </nav>
        </div>
        <div class="menu">
            <nav>
                <a href="${contextPath}/product?search=">매물</a>
                <a href="${contextPath}/product/insert.do">방내놓기</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                            <a href="${contextPath}/chat/main.do" target="_blank">채팅</a>
                    </c:when>
                    <c:otherwise>
                            <a href="${contextPath}/chat/main.do">채팅</a>
                    </c:otherwise>
                </c:choose>
                <a href="${contextPath}/board/list">게시판</a>
                <a href="${contextPath}/loan/main">대출상품</a>
            </nav>
        </div>
        <div class="auth">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <!-- 로그인 상태일 때 -->
                    <span style="color: #f5f5f5; font-size: 15px; font-weight: bold;">
                        <u>${loggedInUser.user_name}</u> 님 환영합니다.
                    </span>
                    <a href="${contextPath}/logout">로그아웃</a>
                    <a href="${contextPath}/transactions">마이페이지</a>
                </c:when>
                <c:otherwise>
                    <!-- 로그아웃 상태일 때 -->
                    <a href="${contextPath}/login">로그인</a>
                    <a href="${contextPath}/signup">회원가입</a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>
    <!-- Header END -->
</body>
</html>