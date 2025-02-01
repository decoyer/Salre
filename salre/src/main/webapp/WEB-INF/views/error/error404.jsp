<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>
</head>
<body>
  <h1>오류: 주소확인 필요</h1>
  <p><%=request.getRequestURL().toString() %></p>
  <p id="here"></p>
  <script>
    document.querySelector("#here").innerHTML = location.href;
  </script>
</body>
</html>