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
                <h1>신고된 매물 관리</h1>

                <main>
                    <table>
                        <thead>
                            <tr>
                                <th>신고 번호</th>
                                <th>신고 내용</th>
                                <th>신고 날짜</th>
                                <th>작업</th>
                                <th>처리상태</th>
                            </tr>
                        </thead>
                      <tbody>
                            <!-- 신고된 매물 목록 반복 출력 -->
                            <c:forEach var="report" items="${reportedProperties}">
                                <tr>
                                    <td>${report.report_id}</td>
                                    <td>${report.report_content}</td>
                                    <td>${report.report_time}</td>
                                    <td>
                                        <form method="post" action="${contextPath}/admin/handlePropertyReport" >
                                            <!-- 신고 ID를 숨겨서 전송 -->
                                            <input type="hidden" name="report_id" value="${report.report_id}">
                                            <input type="hidden" name="action" value=""> 
                                           <c:if test="${report.status eq null || report.status== '' }">
                                              <button type="submit"  onclick="f_submit('resolve')">신고 무효화</button>  
                                              <button type="submit"  onclick="f_submit('delete')">매물 삭제</button>
                                           </c:if>
                                           <c:if test="${report.status != null and report.status!= '' }">
                                              <button type="submit"  disabled="disabled" onclick="f_submit('resolve')">신고 무효화</button>  
                                              <button type="submit"  disabled="disabled" onclick="f_submit('delete')">매물 삭제</button>
                                           </c:if>
                                           
                                            
                                        </form>
                                    </td>
                                      <td>
						                <c:choose>
						                    <c:when test="${report.status == 'resolved'}">반려</c:when>
						                    <c:when test="${report.status == 'deleted'}">매물 삭제</c:when>
						                    <c:otherwise>처리 중</c:otherwise>
						                </c:choose>
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
     <script>
	    function f_submit(action) {
	    	$("[name='action']").val(action); 
	    	console.log(action);
	    	alert(action) ;
	        
	    }  
	</script>
        <%@ include file="../common/footer.jsp"%>
    
   
</body>
</html>
