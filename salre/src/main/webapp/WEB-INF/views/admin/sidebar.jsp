<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/css/myPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
    .profile-container {
        cursor: pointer; /* 클릭 가능하게 커서 스타일 변경 */
         
    } 
</style>
</head>
<body> 
	<!-- Sidebar -->
	<div class="col-md-3 sidebar">

		<div class="container mt-5">
				<div class="profile-container" onclick="window.location.href='${contextPath}/admin/productreport';">
				 
			    <!-- Profile Image -->
			    <!-- <img src="https://via.placeholder.com/100" alt="Profile Image"> -->
			    <img src="${contextPath}/resources/profile.png" alt="Profile Image">
			    <!-- Toggle Buyer/Seller -->
			    <div class="toggle-container">
			        <span>관리자</span>
			    </div>
			</div>
		</div>	
 
		<ul> 
			<%-- <li><a href="${contextPath}/admin/boardreport">게시물 신고 관리</a></li> --%>
			<li><a href="${contextPath}/admin/productreport">매물 신고 관리</a></li>
			<%-- <li><a href="${contextPath}/admin/userreport">사용자 신고 관리</a></li> --%>
		</ul>
	</div>
</body>
</html>