<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewPort" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/manageReports.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
}

table th, table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}

button {
    margin: 5px;
    padding: 5px 10px;
    cursor: pointer;
}

p {
    text-align: center;
    margin-top: 20px;
    font-size: 18px;
    color: #555;
}
    </style>
</head>
<body>
	<%@ include file="../common/header.jsp"%> 
  <div class="container-fluid">
    <div class="row"> 
            <%@ include file="../admin/sidebar.jsp"%>
 
        <!-- 메인 콘텐츠 -->
        <div class="col-md-9">
        <br>
            <h1>신고된 게시글 관리</h1>
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>게시글 제목</th>
                        <th>작성자</th>
                        <th>신고 사유</th>
                        <th>신고 날짜</th>
                        <th>처리 상태</th>
                        <th>작업</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="report" items="${reportList}">
                        <tr>
                            <td>${report.id}</td>
                            <td>${report.postTitle}</td>
                          <%--   <td><%reportService.getIdByUserId(%>${report.user_id }<%) %></td> --%>
                            <td>${report.reason}</td>
                            <td>${report.reportDate}</td>
                            <td>${report.status}</td>
                            <td>
                                <form method="post" action="${contextPath}/admin/handleReport">
                                    <input type="hidden" name="reportId" value="${report.id}">
                                    <button type="submit" name="action" value="resolve">신고 무효화</button>
                                    <button type="submit" name="action" value="delete">게시글 삭제</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty reportList}">
                <p>신고된 게시글이 없습니다.</p>
            </c:if>
        </div>
    </div>
</div>

    <%@ include file="../common/footer.jsp"%>
</body>
</html>
