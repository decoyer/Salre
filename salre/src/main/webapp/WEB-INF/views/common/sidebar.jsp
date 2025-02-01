<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		<!-- Bootstrap CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Icons -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
		<link rel="stylesheet" href="${contextPath}/resources/css/myPage.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	</head>
	<style>

	</style>

	<body>

		<!-- Sidebar -->
		<div class="col-md-3 sidebar">

			<div class="container mt-5">
				<div class="profile-container">
					<!-- Profile Image -->
					 <!-- <img src="https://via.placeholder.com/100" alt="Profile Image"> -->
			   		 <img src="${contextPath}/resources/profile.png" alt="Profile Image">
					<!-- Toggle Buyer/Seller -->
					<div class="toggle-container">
						<span>구매자</span>
						
						<div class="form-check form-switch">
							<input class="form-check-input" type="checkbox" id="toggleSwitch">
						</div>
						
						<span>판매자</span>
					</div>
					<!-- Icon Buttons -->
					<div class="icon-buttons">
						<!-- User Icon -->
						<button title="User Profile" onclick="location.href='${contextPath}/myPage'">
							<i class="bi bi-person-circle"></i>
						</button>
						<!-- Settings Icon -->
						<!-- <button title="Settings">
						<i class="bi bi-gear"></i>
					</button> -->
						<!-- Notifications Icon -->
						<button title="Notifications" class="notification-badge"
							onclick="location.href='${contextPath}/notify/main'">
							<i class="bi bi-bell"></i>
						</button>
					</div>
				</div>
			</div>

			<ul>
				<li><a href="${contextPath}/transactions">나의 거래현황</a></li>
				<li><a href="${contextPath}/favorites">나의 관심매물</a></li>
				<li><a href="${contextPath}/posts">내가 작성한 글</a></li>
				<li><a href="${contextPath}/reviews">나의 거래후기</a></li>
				<li><a href="${contextPath}/reports">나의 신고내역</a></li>
				<!-- <li><a href="${contextPath}/myPage">나의 정보</a></li> -->
			</ul>
		</div>

		<script>
			const user_id = "${loggedInUser.user_id}";

			$(document).ready(function () {
				// 서버와 SSE 연결
				const eventSource = new EventSource(`${pageContext.request.contextPath}/notify/subscribe/\${user_id}`);

				eventSource.addEventListener('INIT', function (event) {
					count(`\${user_id}`);
				});

				eventSource.addEventListener('NOTIFY', function (event) {
					count(`\${user_id}`);
				});

				eventSource.onerror = function () {
					console.error('SSE 연결 오류');
				};
			});
			
			 $(document).ready(function () {
		            // 페이지 로드 시 "나의 거래현황"에서만 활성화
		            if (window.location.href.includes('/transactions')) {
		                $('#toggleSwitch').prop('disabled', false);
		            } else {
		                $('#toggleSwitch').prop('disabled', true).prop('checked', false);
		            }

		            // 메뉴 클릭 이벤트 처리
		            $('ul li a').on('click', function (event) {
		                const href = $(this).attr('href');

		                if (href.includes('/transactions')) {
		                    // "나의 거래현황"에서 토글 활성화
		                    $('#toggleSwitch').prop('disabled', false);
		                } else {
		                    // 다른 메뉴에서는 토글 비활성화
		                    $('#toggleSwitch').prop('disabled', true).prop('checked', false);
		                }
		            });
		        });

			function count(item) {
				$.ajax({
					type: "GET",
					url: `${pageContext.request.contextPath}/notify/unread/\${user_id}`,
					contentType: "application/json",
					success: function (data) {
						if (data > 0) {
							$('.notification-badge').append(`<span class="badge">\${data}</span>`);
						}
					},
					error: function () {
						console.error("알림 조회 오류");
					}
				});
			}
		</script>
		
	</body>

	</html>