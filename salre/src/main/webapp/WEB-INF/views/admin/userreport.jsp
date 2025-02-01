<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath"
    value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>살래?</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/admin/manageReports.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        header {
            text-align: center; 
        } 
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

            <div class="col-md-9">
            <br>
                <h1>신고된 회원 관리</h1>

                <main>
                    <table>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>매물 제목</th>
                                <th>작성자</th>
                                <th>신고 사유</th>
                                <th>신고 날짜</th>
                                <th>처리 상태</th>
                                <th>작업</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 신고된 매물 목록 반복 출력 -->
                            <c:forEach var="report" items="${reportedProperties}">
                                <tr>
                                    <td>${report.id}</td>
                                    <td>${report.propertyTitle}</td>
                                    <td>${report.owner}</td>
                                    <td>${report.reason}</td>
                                    <td>${report.reportDate}</td>
                                    <td>${report.status}</td>
                                    <td>
                                        <form method="post" action="${contextPath}/admin/handlePropertyReport">
                                            <!-- 신고 ID를 숨겨서 전송 -->
                                            <input type="hidden" name="reportId" value="${report.id}">
                                            <button type="submit" name="action" value="resolve">신고 무효화</button>
                                            <button type="submit" name="action" value="delete">매물 삭제</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 신고된 매물이 없을 때 -->
                    <c:if test="${empty reportedProperties}">
                        <p>신고된 매물이 없습니다.</p>
                    </c:if>
                </main>
            </div>
        </div>
    </div>
        <%@ include file="../common/footer.jsp"%>
</body>
</html>