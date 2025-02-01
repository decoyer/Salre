<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<% 
    String contextPath = request.getContextPath();
    session.removeAttribute("loggedInUser"); // 세션에서 'user' 속성 제거
%>
<script>
    window.location.href = "<%= contextPath %>/";
</script>

</body>
</html> 
 
