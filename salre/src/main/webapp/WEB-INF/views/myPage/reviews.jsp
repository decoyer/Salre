<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>살래?</title>
<!-- Favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
<style>
/* 전체 배경 */
body {
    background-color: #f8f9fa;
}

/* 테이블 컨테이너 */
.table-container {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}

/* 테이블 헤더 스타일 */
.table th {
    background-color: #f1f1f1;
    color: #333;
    text-align: center;
    font-weight: bold;
}

/* 테이블 본문 스타일 */
.table tbody tr:hover {
    background-color: #f5f5f5;
    cursor: pointer;
}

/* 테이블 본문 텍스트 정렬 */
.table td {
    text-align: center;
    vertical-align: middle;
}

/* 버튼 스타일 */
/* .table .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.table .btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
} */
.table .custom-view-btn {
    background-color: #ff5722; /* 새로운 배경색 (주황색 예시) */
    border-color: #ff5722;     /* 테두리 색상 */
    color: white;              /* 텍스트 색상 */
}

.table .custom-view-btn:hover {
    background-color: #e64a19; /* 호버 시 색상 */
    border-color: #e64a19;
}
</style>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <%@ include file="../common/sidebar.jsp" %>

        <!-- Main Content -->
        <div class="col-md-9">
            <h1 class="mb-4" style="margin-top: 30px;">나의 거래후기</h1>
            <br>
            
            <h2>내가 작성한 후기</h2>

            <!-- 작성한 글 테이블 -->
            <div class="table-container">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>리뷰번호</th><!-- 매물번호로 바꿔야할듯 -->
                            <th>매물정보</th>
                            <th>판매자 ID</th>
                            <th>평점</th>
                            <th>후기내용</th>
                            <th>수정</th>
                            <th>삭제</th>
                       
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 서버에서 데이터를 받아오는 부분 -->
						
                        <c:forEach var="review" items="${reviewList}"> 
                      
                        <tr>
                           <%--  <tr onclick="redirectToDetail('${contextPath}/post/detail?id=${post.id}')"> --%>
                                <td>${review.review_id}</td>
                                <td>${review.product_name}</td>
                                <td>${review.seller_name}</td>
                                <td>${review.review_rate}</td>
                                <td>${review.review_content}</td>
                            
                        <!--        <td>
                                <a href="#" class="btn btn-primary btn-sm">수정</a>
                            </td> -->
                            <td>
							    <button class="btn custom-view-btn" 
							            data-bs-toggle="modal" 
							            data-bs-target="#updateModal" 
							            data-review-id="${review.review_id}" 
							            data-review-rate="${review.review_rate}" 
							            data-review-content="${review.review_content}">
							        수정
							    </button>
							</td>
                          <!--   <td>
                                <a href="#" class="btn btn-danger btn-sm">삭제</a>
                            </td> -->
                            
                            <td>
							    <button class="btn btn-danger btn-sm"
							            data-review-id="${review.review_id}"
							            onclick="deleteReview(this)">
							        삭제
							    </button>
							                   <br>
							</td>
             
                           <!--  </tr> -->
                           </tr>
                        </c:forEach>
                          <!-- 데이터가 없을 경우 -->
                        <c:if test="${empty reviewList}">
                            <tr>
                                <td colspan="6">작성한 리뷰가 없습니다.</td>
                            </tr>
                        </c:if>
                  
                     <!--     더미 데이터 (테스트용) 
                        <tr onclick="redirectToDetail('#')">
                            <td>20241010</td>
                            <td>치와와</td>
                            <td>별별별별별</td>
                            <td>월세를 깎아주셔서 감사했어요.</td>
                            
                             <td>
                                <a href="#" class="btn btn-primary btn-sm">수정</a>
                            </td>
                            <td>
                                <a href="#" class="btn btn-danger btn-sm">삭제</a>
                            </td>
                            
                             더미 데이터 (테스트용)
                        <tr onclick="redirectToDetail('#')">
                            <td>20241210</td>
                            <td>리트리버</td>
                            <td>별</td>
                            <td>계약끝났는데 돈없다며 보증금 안돌려주고 배째라고 함.</td>
                            
                             <td>
                                <a href="#" class="btn btn-primary btn-sm">수정</a>
                            </td>
                            <td>
                                <a href="#" class="btn btn-danger btn-sm">삭제</a>
                            </td>
                        </tr> -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>




<%@ include file="../common/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">후기 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="updateForm">
                    <input type="hidden" id="review_id" name="review_id">
                    <div class="mb-3">
                        <label for="review_rate" class="form-label">평점</label>
                        <select id="review_rate" class="form-select" required>
                            <option value="1">★</option>
                            <option value="2">★★</option>
                            <option value="3">★★★</option>
                            <option value="4">★★★★</option>
                            <option value="5">★★★★★</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="review_content" class="form-label">후기 내용</label>
                        <textarea id="review_content" class="form-control" rows="3" required></textarea>
                    </div>
                    <button type="button" class="btn btn-primary" id="saveChanges">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    
                </form>
            </div>
        </div>
    </div>
</div>



<!-- JavaScript -->
<!-- <script>
    function redirectToDetail(url) {
        window.location.href = url;
    }
</script> -->


<!-- JavaScript -->
<script>
    // 모달 초기화
    const updateModal = document.getElementById('updateModal');
    updateModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget; // Trigger 버튼
        const reviewId = button.getAttribute('data-review-id');
        const reviewRate = button.getAttribute('data-review-rate');
        const reviewContent = button.getAttribute('data-review-content');

        // 모달 내부 필드에 데이터 설정
        document.getElementById('review_id').value = reviewId; 
        document.getElementById('review_rate').value = reviewRate;
        document.getElementById('review_content').value = reviewContent;
    });

    // 저장 버튼 클릭 이벤트
    document.getElementById('saveChanges').addEventListener('click', function () {
       const review_id = document.getElementById('review_id').value; 
        const review_rate = document.getElementById('review_rate').value;
        const review_content = document.getElementById('review_content').value;

        // AJAX 요청
        $.ajax({
            url: `${contextPath}/reviews/update`,
            type: 'POST',
            data: {
            	review_id: review_id,
                review_rate: review_rate,
                review_content: review_content
            },
            success: function (response) {
                if (response.success) {
                    alert('후기가 성공적으로 수정되었습니다.');
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message);
                }
            },
            error: function () {
                alert('서버 오류가 발생했습니다.');
            }
        });
    });
    // 삭제 버튼 클릭 이벤트
    function deleteReview(button) {
        const review_id = button.getAttribute('data-review-id');

        if (confirm("정말로 이 후기를 삭제하시겠습니까?")) {
            // AJAX 요청
            $.ajax({
                url: `${contextPath}/reviews/delete`,
                type: 'POST',
                data: { review_id: review_id },
                success: function (response) {
                    if (response.success) {
                        alert("후기가 성공적으로 삭제되었습니다.");
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert(response.message);
                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        }
    }
</script>

</body>
</html>
