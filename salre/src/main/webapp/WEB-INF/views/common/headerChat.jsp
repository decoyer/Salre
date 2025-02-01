<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<title>살래?!</title>
	
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no, viewport-fit=cover">
	<meta name="color-scheme" content="light dark">
	
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
</head>
<body>

</body>
</html>