<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/headerBoard.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 상세보기</title>
	
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
	<link rel="stylesheet" href="${contextPath}/resources/css/boardDetail.css">
</head>
<body>
	<!-- =======================
	Page content START -->
	<section class="pt-5">
		<div class="container">
			<div class="row">
				<!-- Left sidebar START -->
				<div class="col-xl-3">
					<!-- Responsive offcanvas body START -->
					<div class="offcanvas-xl offcanvas-end" tabindex="-1" id="offcanvasSidebar">
						<!-- Offcanvas header -->
						<div class="offcanvas-header bg-light">
							<h5 class="offcanvas-title" id="offcanvasNavbarLabel">My profile</h5>
							<button  type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#offcanvasSidebar" aria-label="Close"></button>
						</div>
						<!-- Offcanvas body -->
						<div class="offcanvas-body p-3 p-xl-0">
							<div id="dashboard" class="border rounded-3 pb-0 p-3 w-100">
								<!-- Dashboard menu -->
								<div class="list-group list-group-dark list-group-borderless">
									<a class="list-group-item" href="${contextPath}/board/list"><i class="bi bi-pencil-square fa-fw me-2"></i>공지사항</a>
									<a class="list-group-item" href="${contextPath}/board/list?type=자유게시판"><i class="bi bi-pencil-square fa-fw me-2"></i>자유게시판</a>
								</div>
							</div>
						</div>
					</div>
					<!-- Responsive offcanvas body END -->
				</div>
				<!-- Left sidebar END -->
				
				<!-- Main content START -->
				<div class="col-xl-9">
					<!-- 게시판 상세보기 START -->
					<div class="card bg-transparent border rounded-3">
						<!-- Card header -->
						<div class="card-header bg-transparent border-bottom">
							<h3 class="card-header-title mb-0">${boardDTO.board_title}</h3>
							<span class="me-3 small">
								<c:choose>
									<c:when test="${boardDTO.board_class == '공지사항'}">
										관리자
									</c:when>
									<c:otherwise>
										${board.writer}
									</c:otherwise>
								</c:choose>
							</span>
							<span class="me-3 small"><fmt:formatDate value="${boardDTO.created_at}" pattern="yyyy-MM-dd HH:mm" /></span>
							<span class="me-3 small">조회 ${boardDTO.click_cnt}</span>
							<span class="small float-end">댓글 수 ${commentCnt}</span>
						</div>
						<!-- Card body START -->
						<div class="card-body">
						
							<!-- 게시글 내용 -->
							<div class="bg-body border rounded-bottom h-400px overflow-y-auto p-2">
								${boardDTO.board_content}
							</div>
							<hr>
							
							<!-- 댓글 -->
							<div class="mt-4">
								<div id="comment_area" class="d-flex flex-column">
									<c:forEach items="${commentDTOList}" var="comment" varStatus="status">
										<!-- 작성자, 작성일자 -->
										<div id="comment_item${comment.comment_id}" class="mb-2 d-flex flex-column">
											<div class="d-flex align-items-center">
												<h6 class="m-0">${comment.comment_writer}</h6>
												
												<!-- 댓글 수정, 삭제 버튼 -->
												<div class="dropdown ms-auto me-2">
													<button class="btn btn-link p-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
														<i class="bi bi-three-dots text-dark"></i>
													</button>
													<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										                <li><a class="dropdown-item" href="javascript:doUpdatePage(${comment.comment_id});">수정</a></li>
										                <li><a class="dropdown-item" href="javascript:doDeleteComment(${comment.comment_id}, ${comment.board_id});">삭제</a></li>
										            </ul>
									            </div>
											</div>
											<%-- 날짜 형식 변환; 2024-12-30 11:20:30.0 => 2024-12-30 11:20:30 --%>
											<span class="me-3 small">
												<fmt:formatDate value="${comment.created_at}" pattern="yyyy-MM-dd HH:mm" />
											</span>
										
											<!-- Content -->
											<div>
												<p>${comment.comment_content}</p>
												<hr>
											</div>
										</div>
									</c:forEach>
								</div>
								
								<!-- Button -->
								<div class="text-end">
									<a class="btn btn-sm btn-light mb-0" data-bs-toggle="collapse" href="#collapseComment" role="button" aria-expanded="false" aria-controls="collapseComment">
										댓글 달기
									</a>
									<!-- 댓글 등록 -->
									<div class="collapse show" id="collapseComment">
										<div class="d-flex mt-3">
											<textarea id="comment_content" class="form-control mb-0" placeholder="댓글을 남겨보세요" rows="2" spellcheck="false"></textarea>
											<!-- 댓글 등록 버튼 -->
											<c:choose>
												<c:when test="${userDTO eq null}">
													<button class="btn btn-sm btn-primary-soft ms-2 px-4 mb-0 flex-shrink-0" disabled>
														<i class="fas fa-paper-plane fs-5"></i>
													</button>
												</c:when>
												<c:otherwise>
													<button onclick="doCheck(commentRegister)" class="btn btn-sm btn-primary-soft ms-2 px-4 mb-0 flex-shrink-0">
														<i class="fas fa-paper-plane fs-5"></i>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<!-- Button -->
							<div class="d-flex justify-content-end mt-4">
								<a href="${contextPath}/board/list?type=${boardDTO.board_class}" class="btn btn-primary">목록으로 이동</a>
								<%-- 본인이 작성한 글만 수정, 삭제 가능 --%>
								<c:if test="${userDTO.id == boardDTO.writer}">
									<a href="${contextPath}/board/update?board_id=${boardDTO.board_id}" class="btn btn-success ms-2">수정</a>
									<button onclick="javascript:doDelete(${boardDTO.board_id})" class="btn btn-danger ms-2">삭제</button>
								</c:if>
							</div>
						</div>
						<!-- Card body END -->
					</div>
					<!-- 게시판 상세보기 END -->
				</div>
				<!-- Main content END -->
			</div>
			<!-- Row END -->
		</div>
	</section>
	<!-- =======================
	Page content END -->
	
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
	
	<!-- 게시글 삭제 -->
	<script type="text/javascript">
		function doDelete(board_id) {
			const msg = confirm("작성한 글을 삭제하시겠습니까?");
			
			if (msg == true) { // 확인 누를 경우
				location.href = "${contextPath}/board/delete?board_id=" + board_id;
			} else {
				return false; // 삭제 취소
			}
		}
	</script>
	
	<!-- 댓글 등록 -->
	<script type="text/javascript">
		// 콜백 함수로 댓글 등록 함수 호출
		function doCheck(callback) {
			/* let content = document.querySelector("#comment_content").value; */
			let comment_content = $('#comment_content').val();
			
			if (comment_content == "") {
				alert("댓글 내용을 입력하시기 바랍니다.");
				$('#comment_content').focus();
				return false;
			}
			
			if (calBytes(comment_content) > 255) {
	            alert("최대 255Bytes까지 입력 가능합니다.");
	            $('#comment_content').focus();
	            return false;
	        }
			
			callback(); // 유효성 검사 후 댓글 등록
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
		
		// 댓글 등록 함수
		function commentRegister() {
			const user_id = ${userDTO.user_id};
			const board_id = ${boardDTO.board_id};
			const comment_writer = "${userDTO.id}";
			let comment_content = $('#comment_content').val();
			/* let comment_content = document.querySelector("#comment_content").value; */
			
			$.ajax({
				url: "${contextPath}/comment/register",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify({
					user_id: user_id,
					board_id: board_id,
					comment_writer: comment_writer,
					comment_content: comment_content
				}),
				success: function(commentDTOList) {
					// 댓글 입력 칸 비우기
					$('#comment_content').val("");
					
					// 댓글 목록을 출력할 때 날짜 형식(타임스탬프)을 사람이 읽을 수 있는 형식으로 변환
			        commentDTOList.forEach(function(comment) {
			            let timestamp = comment.created_at; // 예: 1735538039000
			            let date = new Date(timestamp);
			            
			         	// UTC에서 9시간을 더해 한국 시간(KST)으로 변환
			            date.setHours(date.getHours() + 9);
			            
			         	// 한국 시간으로 변환된 날짜를 원하는 형식으로 출력
			            comment.created_at = date.toISOString().slice(0, 16).replace("T", " "); // 예: 2024-12-30 14:53
			        });
					
					// 댓글 목록을 출력하는 함수 호출
					let output = printCommentList(commentDTOList);
					
					// 댓글 영역에 새로운 댓글 목록 삽입
					$("#comment_area").html(output);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
		
		// 댓글 등록 후 리스트 보여주기(commentRegister 함수에서 호출)
		function printCommentList(commentList) {
			let dynamicRows = "";
			$.each(commentList, function(index, comment) {
				dynamicRows += `
					<!-- 작성자, 작성일자 -->
					<div id="comment_item\${comment.comment_id}" class="mb-2 d-flex flex-column">
						<div class="d-flex align-items-center">
							<h6 class="m-0">\${comment.comment_writer}</h6>
							
							<!-- 댓글 수정, 삭제 버튼 -->
							<div class="dropdown ms-auto me-2">
								<button class="btn btn-link p-0" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
									<i class="bi bi-three-dots text-dark"></i>
								</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					                <li><a class="dropdown-item" href="javascript:doUpdatePage(\${comment.comment_id});">수정</a></li>
					                <li><a class="dropdown-item" href="javascript:doDeleteComment(\${comment.comment_id}, \${comment.board_id});">삭제</a></li>
					            </ul>
				            </div>
						</div>
						<span class="me-3 small">
							\${comment.created_at}
						</span>
					
						<!-- Content -->
						<div>
							<p>\${comment.comment_content}</p>
							<hr>
						</div>
					</div>
				`
			});
			
			let output = `
				\${dynamicRows}
			`
			
			return output;
		}
	</script>
	
	<!-- 댓글 수정 -->
	<script type="text/javascript">
		// 기존 댓글을 댓글 수정 화면으로 바꿔서 표시
		function doUpdatePage(comment_id) {
			$.ajax({
				url: "${contextPath}/comment/update",
				type: "GET",
				data: { comment_id: comment_id },
				success: function(commentDTO) {
					// 댓글 수정할 수 있는 영역
					let output = printCommentUpdate(commentDTO);
					
					$("#comment_item" + commentDTO.comment_id).html(output);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
		
		// 댓글 수정할 수 있는 영역
		function printCommentUpdate(commentDTOInfo) {
			let output = `
				<div class="collapse show" id="collapseComment">
					<div class="d-flex mt-3">
						<textarea id="comment_content\${commentDTOInfo.comment_id}" class="form-control mb-0" rows="2" spellcheck="false">\${commentDTOInfo.comment_content}</textarea>
						<button onclick="doUpdate(\${commentDTOInfo.comment_id}, \${commentDTOInfo.board_id})" class="btn btn-sm btn-primary-soft ms-2 mb-0 flex-shrink-0">등록</button>
						<button onclick="doUpdateCancel(\${commentDTOInfo.board_id})" class="btn btn-sm btn-secondary-soft ms-2 mb-0 flex-shrink-0">취소</button>
					</div>
					<hr>
				</div>
			`
			
			return output;
		}
		
		// 댓글 수정
		function doUpdate(comment_id, board_id) {
			$.ajax({
				url: "${contextPath}/comment/update",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify({
					comment_id: comment_id,
					board_id: board_id,
					comment_content: $('#comment_content' + comment_id).val()
				}),
				success: function(response) {
					alert(response.resultMessage);
					
					// 댓글 목록을 출력할 때 날짜 형식(타임스탬프)을 사람이 읽을 수 있는 형식으로 변환
			        response.commentDTOList.forEach(function(comment) {
			            let timestamp = comment.created_at; // 예: 1735538039000
			            let date = new Date(timestamp);
			            
			         	// UTC에서 9시간을 더해 한국 시간(KST)으로 변환
			            date.setHours(date.getHours() + 9);
			            
			         	// 한국 시간으로 변환된 날짜를 원하는 형식으로 출력
			            comment.created_at = date.toISOString().slice(0, 16).replace("T", " "); // 예: 2024-12-30 14:53
			        });
					
					// 댓글 수정 완료 후 댓글 목록을 출력하는 함수 호출
					let output = printCommentList(response.commentDTOList);
					
					// 댓글 영역에 댓글 목록 삽입
					$("#comment_area").html(output);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
		
		// 댓글 수정 취소
		function doUpdateCancel(board_id) {
			$.ajax({
				url: "${contextPath}/comment/updateCancel",
				type: "GET",
				data: { board_id: board_id },
				success: function(commentDTOList) {
					// 댓글 목록을 출력할 때 날짜 형식(타임스탬프)을 사람이 읽을 수 있는 형식으로 변환
			        commentDTOList.forEach(function(comment) {
			            let timestamp = comment.created_at; // 예: 1735538039000
			            let date = new Date(timestamp);
			            
			         	// UTC에서 9시간을 더해 한국 시간(KST)으로 변환
			            date.setHours(date.getHours() + 9);
			            
			         	// 한국 시간으로 변환된 날짜를 원하는 형식으로 출력
			            comment.created_at = date.toISOString().slice(0, 16).replace("T", " "); // 예: 2024-12-30 14:53
			        });
					
					// 댓글 수정 취소 후 댓글 목록을 출력하는 함수 호출
					let output = printCommentList(commentDTOList);
					
					// 댓글 영역에 댓글 목록 삽입
					$("#comment_area").html(output);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
	</script>
	
	<!-- 댓글 삭제 -->
	<script type="text/javascript">
		function doDeleteComment(comment_id, board_id) {
			const msg = confirm("댓글을 삭제하시겠습니까?");
			
			if (msg == true) { // 확인 누를 경우
				$.ajax({
					url: "${contextPath}/comment/deleteComment",
					type: "GET",
					data: {
						comment_id: comment_id,
						board_id: board_id
					},
					success: function(commentDTOList) {
						// 댓글 목록을 출력할 때 날짜 형식(타임스탬프)을 사람이 읽을 수 있는 형식으로 변환
				        commentDTOList.forEach(function(comment) {
				            let timestamp = comment.created_at; // 예: 1735538039000
				            let date = new Date(timestamp);
				            
				         	// UTC에서 9시간을 더해 한국 시간(KST)으로 변환
				            date.setHours(date.getHours() + 9);
				            
				         	// 한국 시간으로 변환된 날짜를 원하는 형식으로 출력
				            comment.created_at = date.toISOString().slice(0, 16).replace("T", " "); // 예: 2024-12-30 14:53
				        });
						
						// 댓글 수정 취소 후 댓글 목록을 출력하는 함수 호출
						let output = printCommentList(commentDTOList);
						
						// 댓글 영역에 댓글 목록 삽입
						$("#comment_area").html(output);
					},
					error: function(err) {
						alert(err);
					}
				});
			} else {
				return false; // 삭제 취소
			}
		}
	</script>
</body>
</html>