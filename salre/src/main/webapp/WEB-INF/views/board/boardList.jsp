<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/headerBoard.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 목록</title>
	
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
							<h5 class="offcanvas-title" id="offcanvasNavbarLabel">Board Class</h5>
							<button  type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#offcanvasSidebar" aria-label="Close"></button>
						</div>
						<!-- Offcanvas body -->
						<div class="offcanvas-body p-3 p-xl-0">
							<div id="dashboard" class="border rounded-3 pb-0 p-3 w-100">
								<!-- Dashboard menu -->
								<div class="list-group list-group-dark list-group-borderless">
									<a class="list-group-item" href="${contextPath}/board/list?type=공지사항"><i class="bi bi-pencil-square fa-fw me-2"></i>공지사항</a>
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
			
					<!-- Card START -->
					<div class="card border bg-transparent rounded-3">
						<!-- Card header START -->
						<div class="card-header bg-transparent border-bottom">
							<h3 class="mb-0">${boardList[0].board_class}</h3>
						</div>
						<!-- Card header END -->
			
						<!-- Card body START -->
						<div class="card-body">
			
							<!-- Order list table START -->
							<div class="table-responsive border-0">
								<!-- Table START -->
								<table class="table align-middle p-4 mb-0 table-hover">
									<!-- Table head -->
									<thead style="background-color: #CF8E4A;">
										<tr>
											<th scope="col" class="border-0 rounded-start text-light">제목</th>
											<th scope="col" class="border-0 text-light">작성자</th>
											<th scope="col" class="border-0 text-light">작성일시</th>
											<th scope="col" class="border-0 rounded-end text-light">조회수</th>
										</tr>
									</thead>
			
									<!-- Table body START -->
									<tbody>
										<c:forEach items="${boardList}" var="board">
											<c:choose>
												<%-- 게시글이 없을 경우 --%>
												<c:when test="${board.board_id eq 0}">
													<tr>
														<td colspan="4" class="text-center">${board.board_class} 게시글이 없습니다.</td>
													</tr>
												</c:when>
												<%-- 게시글이 있을 경우 --%>
												<c:otherwise>
													<!-- Table item -->
													<tr>
														<!-- Table data -->
														<td>
															<h6 class="table-responsive-title mt-2 mt-lg-0 mb-0"><a href="${contextPath}/board/detail?board_id=${board.board_id}">${board.board_title}</a></h6>
														</td>
														<!-- Table data -->
														<td class="text-center text-sm-start text-primary-hover">
															<c:choose>
																<c:when test="${board.board_class == '공지사항'}">
																	관리자
																</c:when>
																<c:otherwise>
																	${board.writer}
																</c:otherwise>
															</c:choose>
														</td>
						
														<!-- Table data -->
														<td>
															<fmt:formatDate value="${board.created_at}" pattern="yyyy-MM-dd HH:mm" />
														</td>
						
														<!-- Table data -->
														<td>${board.click_cnt}</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tbody>
									<!-- Table body END -->
								</table>
								<!-- Table END -->
							</div>
							<!-- Order list table END -->
			
							<!-- Pagination START -->
							<div class="d-sm-flex justify-content-sm-center align-items-sm-center mt-4 mt-sm-3">
								<!-- Pagination -->
								<nav aria-label="navigation">
									<ul class="pagination pagination-sm pagination-primary-soft d-inline-block d-md-flex rounded mb-0">
										<c:choose>
											<%-- 현재 페이지가 1페이지면 '<'만 보여줌 --%>
											<c:when test="${pageDTO.page <= 1}">
												<li class="page-item mb-0"><a class="page-link" tabindex="-1"><i class="fas fa-angle-left"></i></a></li>
											</c:when>
											<%-- 1페이지가 아닌 경우에는 '<'을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
											<c:otherwise>
												<li class="page-item mb-0"><a class="page-link" href="${contextPath}/board/list?type=${type}&page=${pageDTO.page - 1}" tabindex="-1"><i class="fas fa-angle-left"></i></a></li>
											</c:otherwise>
										</c:choose>
										
										<%-- for(int i = startPage; i <= endPage; i++) --%>
										<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="i" step="1">
											<c:choose>
												<%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 숫자만 보이게 --%>
												<c:when test="${i eq pageDTO.page}">
													<li class="page-item mb-0"><a class="page-link">${i}</a></li>
												</c:when>
												
												<c:otherwise>
													<li class="page-item mb-0"><a class="page-link" href="${contextPath}/board/list?type=${type}&page=${i}">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:choose>
											<c:when test="${pageDTO.page >= pageDTO.maxPage}">
												<li class="page-item mb-0"><a class="page-link"><i class="fas fa-angle-right"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item mb-0"><a class="page-link" href="${contextPath}/board/list?type=${type}&page=${pageDTO.page + 1}"><i class="fas fa-angle-right"></i></a></li>
											</c:otherwise>
										</c:choose>
									</ul>
								</nav>
							</div>
							<!-- Pagination END -->
							
							<c:if test="${boardList[0].board_class == '공지사항'}">
								<%-- 로그인한 아이디가 'admin'일 때만 글쓰기 버튼 보이게 설정 --%>
								<c:if test="${userDTO.id == 'admin'}">
									<a id="btn_write" class="btn btn-secondary float-end mt-3" href="${contextPath}/board/insert.do?type=공지사항">
										<i class="bi bi-pencil-square fa-fw me-2"></i>글쓰기
									</a>
								</c:if>
							</c:if>
							<c:if test="${boardList[0].board_class == '자유게시판'}">
								<a id="btn_write" class="btn btn-secondary float-end mt-3" href="${contextPath}/board/insert.do?type=자유게시판"><i class="bi bi-pencil-square fa-fw me-2"></i>글쓰기</a>
							</c:if>
						</div>
						<!-- Card body END -->
					</div>
						<!--Card END  -->
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
	
	<%@ include file="../common/footerBoard.jsp" %>
</body>
</html>