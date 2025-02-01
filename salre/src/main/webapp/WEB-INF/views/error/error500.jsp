<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>
</head>
<body>
  <h1>오류 내용</h1>
  message : <%=exception.getMessage() %>
  <p>${message}</p>
</body>
</html>