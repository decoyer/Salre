<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/headerBoard.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시글 수정</title>
	
	<!-- Meta Tags -->
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- Favicon -->
	<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
	
	<!-- Google Font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap">

	<!-- Plugins CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/font-awesome/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/bootstrap-icons/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/tiny-slider/tiny-slider.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/glightbox/css/glightbox.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/aos/aos.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/choices/css/choices.min.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/quill/css/quill.snow.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/vendor/stepper/css/bs-stepper.min.css">

	<!-- Theme CSS -->
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/bootstrap/assets/css/style.css">
	
	<!-- 외부 CSS -->
	<link rel="stylesheet" href="${contextPath}/resources/css/boardList.css">
</head>
<body>
	<!-- =======================
	Steps START -->
	<section>
		<div class="container">
			<div class="card bg-transparent border rounded-3 mb-4">
				<!-- Course description -->
				<div class="col-12">
					<div class="card-header bg-transparent border-bottom">
						<h3 class="mb-0">${boardDTO.board_class} 수정하기</h3>
					</div>
					
					<div class="col-12 p-2">
						<input class="form-control" type="text" name="board_title" value="${boardDTO.board_title}">
					</div>
					
					<!-- Editor toolbar -->
					<div class="bg-light border border-bottom-0 rounded-top py-3" id="quilltoolbar">
						<span class="ql-formats">
							<select class="ql-size"></select>
						</span>
						<span class="ql-formats">
							<button class="ql-bold"></button>
							<button class="ql-italic"></button>
							<button class="ql-underline"></button>
							<button class="ql-strike"></button>
						</span>
						<span class="ql-formats">
							<select class="ql-color"></select>
							<select class="ql-background"></select>
						</span>
						<span class="ql-formats">
							<button class="ql-code-block"></button>
						</span>
						<span class="ql-formats">
							<button class="ql-list" value="ordered"></button>
							<button class="ql-list" value="bullet"></button>
							<button class="ql-indent" value="-1"></button>
							<button class="ql-indent" value="+1"></button>
						</span>
						<span class="ql-formats">
							<button class="ql-link"></button>
							<button class="ql-image"></button>
						</span>
						<span class="ql-formats">
							<button class="ql-clean"></button>
						</span>
					</div>

					<!-- Main toolbar -->
					<div class="bg-body border rounded-bottom h-400px overflow-y-auto" id="quilleditor">
						<!-- 게시글 내용 -->
						${boardDTO.board_content}
					</div>
				</div>
			</div>
			<!-- Button -->
			<div class="d-flex justify-content-end mt-2 mt-md-0">
				<a href="javascript:doCheck(doUpdate);" class="btn btn-success mb-0">완료</a>
				<a href="${contextPath}/board/detail?board_id=${boardDTO.board_id}" class="btn btn-secondary mb-0 ms-2">취소</a>
			</div>
		</div>
	</section>
	<!-- =======================
	Steps END -->
	
	<!-- Back to top -->
	<div class="back-top"><i class="bi bi-arrow-up-short position-absolute top-50 start-50 translate-middle"></i></div>
	
	<!-- Bootstrap JS -->
	<script src="${contextPath}/resources/bootstrap/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Vendors -->
	<script src="${contextPath}/resources/bootstrap/assets/vendor/choices/js/choices.min.js"></script>
	<script src="${contextPath}/resources/bootstrap/assets/vendor/aos/aos.js"></script>
	<script src="${contextPath}/resources/bootstrap/assets/vendor/glightbox/js/glightbox.js"></script>
	<script src="${contextPath}/resources/bootstrap/assets/vendor/quill/js/quill.min.js"></script>
	<script src="${contextPath}/resources/bootstrap/assets/vendor/stepper/js/bs-stepper.min.js"></script>
	
	<!-- Template Functions -->
	<script src="${contextPath}/resources/bootstrap/assets/js/functions.js"></script>
	
	<!-- Footer -->
	<%@ include file="../common/footerBoard.jsp" %>
	
	<!-- 공지사항 수정 -->
	<script type="text/javascript">
		// 콜백 함수로 게시글 수정 함수 호출
		function doCheck(callback) {
			let board_title = $('[name="board_title"]').val();
			let board_content = $('.ql-editor').text();
			let board_content_imgCheck = $('.ql-editor').find('img').length;
			
			if (board_title == "") {
				alert("제목을 입력하시기 바랍니다.");
				$('[name="board_title"]').focus();
				return false;
			}
			
			if (calBytes(board_title) > 255) {
                alert("최대 255Bytes까지 입력 가능합니다.");
                $('[name="board_title"]').focus();
                return false;
            }
			
			// text와 img가 없으면 내용 없음
			if (board_content == "" && board_content_imgCheck == "0") {
				alert("내용을 입력하시기 바랍니다.");
				return false;
			}
			
			// MySQL TEXT 데이터 타입 최대 크기 : 65,535Bytes
			if (calBytes($('.ql-editor').html()) > 65535) {
                alert("내용은 최대 65,535Bytes까지 입력 가능합니다.");
                return false;
            }
			
			callback(); // 유효성 검사 후 게시글 수정
		}
		
		// 게시글 수정 함수
		function doUpdate() {
			let board_title = $('[name="board_title"]').val();
			let board_content = $('.ql-editor').html();
			const board_class = "${boardDTO.board_class}";
			
			let jsonData = {
					"board_id": ${boardDTO.board_id},
					"board_class": board_class,
					"board_title": board_title,
					"board_content": board_content
			};
			
			$.ajax({
				url: "${contextPath}/board/update",
				type: "POST",
				contentType: "application/json", // default : application/x-www-form-urlencoded
				data: JSON.stringify(jsonData),
				success: function(res) {
					alert(res);
					// 게시글 수정 이후 게시판 목록 조회로 이동
					location.href="${contextPath}/board/list?type=" + board_class;
				},
				error: function(err) {
					alert(err);
				}
			});
		}
		
		// 글자 길이 바이트 단위로 체크하기(바이트값 전달)
        function calBytes(str) {
        	let tcount = 0;  // 최종 바이트 수를 저장할 변수
        	let strCnt = str.length;  // 문자열의 길이 (문자 수)
		
        	let onechar;  // 개별 문자를 저장할 변수
		    for (let i = 0; i < strCnt; i++) {
		        onechar = str.charAt(i);  // 문자열에서 i번째 문자 추출
		
		        // encodeURIComponent를 사용하여 해당 문자의 URL 인코딩된 문자열 길이를 확인
		        // encodeURIComponent로 인코딩된 문자열 길이가 3보다 크면 2바이트 이상으로 인코딩된 문자임
		        if (encodeURIComponent(onechar).length > 1) {
		            tcount += 2;  // 2바이트 이상인 문자로 계산
		        } else {
		            tcount += 1;  // 1바이트 문자로 계산
		        }
		    }
		
		    return tcount;  // 총 바이트 수 반환
		}
	</script>
</body>
</html>