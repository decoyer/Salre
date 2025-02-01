<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>
 
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
<!-- Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
<style>
.card-container {
	 /* display: grid;  */
	display:flex;
	flex-wrap: wrap; /* 넘치면 다음 줄로 */
	/* grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); */
	gap: 20px;
	width: 100%;
	margin-top: 20px;
}

.card img {
	height: 180px;
	object-fit: cover;
}

.badge-status {
	position: absolute;
	top: 20px;
	right: 20px;
	font-size: 12px;
	padding: 5px 10px;
	border-radius: 10px;
	color: white;
	z-index: 100; /* 겹침 문제 방지 */
}

.col-md-9 {
	display: block;
	width: 100%;
}


/* 설 카드디자인 */
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 250px;
            height: 550px; 
            margin: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            overflow: hidden;  
   			display: inline-block;  
        }
        .product-card img {
            border-radius: 8px;
            width: 200px;
            max-height: 200px; 
            object-fit: cover; 
            object-position: center; 
            border: 1px solid #ddd; 
  			height: auto; /* 비율 유지 */
    		transition: transform 0.3s ease; /* 확대 효과의 부드러움 설정 */
        }
        .product-card img:hover {
   		 	transform: scale(1.1); /* 마우스 오버 시 10% 확대 */
		}
        .product-card h3 {
            font-size: 18px;
            margin: 10px 0;
        }
        .product-card p {
            font-size: 16px;
            color: #666;
        }
        .product-card .price {
            font-size: 20px;
            font-weight: bold;
            color: #f4a261;
            margin-top: 10px;
        }
        
        .product-card .review-button {
		    margin-top: 15px; /* 버튼과 글씨 사이 간격 */
		    display: inline-block; /* 버튼 위치 고정 */
		}	
 





</style>

<!-- CSS -->
<style>
/* 문구가 표시될 컨테이너 */
.moving-text-container {
	position: absolute;
	bottom: 10px;
	left: 0;
	width: 100%;
	overflow: hidden;
	white-space: nowrap;
	background-color: black;
	color: white;
	padding: 5px;
	font-size: 14px;
	box-sizing: border-box;
}

/* 애니메이션이 적용된 텍스트 */
.moving-text {
	display: inline-block;
	padding-left: 100%;
	animation: moveText 5s linear infinite;
}

/* 애니메이션 정의 */
@keyframes moveText {
    0% {
        transform: translateX(100%);
    }
    100% {
        transform: translateX(-100%);
    }
}
</style>
 

</head>
<body>

	<%@ include file="../common/header.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<%@ include file="../common/sidebar.jsp"%>

			<!-- Main Content -->
			<div class="col-md-9" style="margin-top: 30px;">
				<h1 class="mb-4">나의 거래현황</h1>

				<!-- 구매자 콘텐츠 -->
				<div id="buyer-content">
					 <div class="row mb-3">
						
					</div>

					<!-- 구매자 거래 매물 목록 -->					
	<section class="search-results" id="search-results">
        <c:if test="${not empty buyerProductList}">
        
         
            <c:forEach var="productB" items="${buyerProductList}">
             <a href="/salre/product/detail/${productB.product_id}" class="product-card-link">
                <div class="product-card" style="position:relative;">
                
                          <c:choose>
                                <c:when test="${productB.product_status == 1}">
                                    <span class="badge-status bg-danger">거래중</span>
                                </c:when>
                                <c:when test="${productB.product_status == 2}">
                                    <span class="badge-status bg-secondary">거래완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status bg-success">거래가능</span>
                                </c:otherwise>
                            </c:choose>
                
                    <img class="product-image" 
                         src="resources/images/products/${productB.product_id}.jpeg" 
                         alt="${product.product_name}" 
                         onerror="this.src='https://placehold.co/200x200';">
				
				    
                            
                    <h3 style="color: black;">${productB.product_name}</h3>
                    <p>${productB.address}, ${productB.address_detail}</p>
                    <p>방 수: ${productB.room_count} | 욕실 수: ${productB.bath_count}</p>
                    <p>층수: ${productB.floor}층 | 면적: ${productB.area}㎡</p>
                   
                     <div class="price"> 
                        <c:choose>
                            <c:when test="${productB.deposit >= 100000000}"> 
                                보증금
                                <c:if test="${(productB.deposit % 100000000) / 10000 >= 0}">  
                                    <fmt:formatNumber pattern="####" value = "${productB.deposit / 100000000}" />
                                    억
                                </c:if>
                                <c:if test="${(productB.deposit / 100000000) < 1}">
                                    <fmt:formatNumber pattern="####" value = "${productB.deposit}" />
                                    만
                                </c:if>
                                원 
                            </c:when>
                            <c:otherwise>
                                보증금
                                <fmt:formatNumber pattern="####" value = "${productB.deposit / 10000}" />
                                만 원                             
                            </c:otherwise>
                        </c:choose>
                        <c:if test = "${productB.payment_type == '월세' }">
                            / ${productB.rentfee} 만 원 월세
                        </c:if>
                    </div>  
                     
					<c:choose>
                                <c:when test="${productB.product_status == 2}">
                                    <span class="badge-status bg-secondary">거래완료</span>        
								    <button 
									    class="btn btn-outline-danger review-button" 
									    <%-- data-bs-toggle="modal" 
									    data-bs-target="#reviewModal" 
									    data-review-id="${productB.product_id} --%>
									    onclick="openReviewModal(event, this)">
									    리뷰작성
									</button>
					   			</c:when>
					  </c:choose>      
                </div>
                </a>
                 		
            </c:forEach>
        </c:if>
        <c:if test="${empty buyerProductList}">
            <p style="text-align: center; font-size: 20px; color: #999;">검색 결과가 없습니다.</p>
        </c:if>
    </section> 
					
</div>
 
				
				<!-- 판매자 콘텐츠 -->
				 <div id="seller-content" style="text-align: center;">
					 <div class="row mb-3">
						
					</div>


				<!-- 판매자 거래 매물 목록 -->
				<div class="card-container">
     
                <!-- 판매자 매물목록/ 디자인통일 -->
      <section class="search-results" id="search-results">
        <c:if test="${not empty productList}">
        
            <c:forEach var="product" items="${productList}">
             <a href="/salre/product/detail/${product.product_id}" class="product-card-link">
                <div class="product-card"  style="position:relative;">
                
                          <c:choose>
                                <c:when test="${product.product_status == 1}">
                                    <span class="badge-status bg-danger">거래중</span>
                                </c:when>
                                <c:when test="${product.product_status == 2}">
                                    <span class="badge-status bg-secondary">거래완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status bg-success">거래가능</span>
                                </c:otherwise>
                          </c:choose>
                
                    <img class="product-image" 
                         src="resources/images/products/${product.product_id}.jpeg" 
                         alt="${product.product_name}" 
                         onerror="this.src='https://placehold.co/200x200';">
                         
                    <h3 style="color: black;">${product.product_name}</h3>
                    <p>${product.address}, ${product.address_detail}</p>
                    <p>방 수: ${product.room_count} | 욕실 수: ${product.bath_count}</p>
                    <p>층수: ${product.floor}층 | 면적: ${product.area}㎡</p>
                   
                     <div class="price"> 
                        <c:choose>
                            <c:when test="${product.deposit >= 100000000}"> 
                                보증금
                                <c:if test="${(product.deposit % 100000000) / 10000 >= 0}">  
                                    <fmt:formatNumber pattern="####" value = "${productB.deposit / 100000000}" />
                                    억
                                </c:if>
                                <c:if test="${(product.deposit / 100000000) < 1}">
                                    <fmt:formatNumber pattern="####" value = "${product.deposit}" />
                                    만
                                </c:if>
                                원 
                            </c:when>
                            <c:otherwise>
                                보증금
                                <fmt:formatNumber pattern="####" value = "${product.deposit / 10000}" />
                                만 원                             
                            </c:otherwise>
                        </c:choose>
                        <c:if test = "${product.payment_type == '월세' }">
                            / ${product.rentfee} 만 원 월세
                        </c:if>
                    </div>  
                </div>
                </a>
            </c:forEach>
        </c:if>
        <c:if test="${empty productList}">
            <p style="text-align: center; font-size: 20px; color: #999;">검색 결과가 없습니다.</p>
        </c:if>
    </section> 
                
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Review Registration Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateModalLabel">후기 작성</h5>

                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reviewForm">
                    <input type="hidden" id="review_id" name="review_id">
                    <div class="mb-3">
                        <h7>거래는 어떠셨나요? </h7><br>
                        <h7>판매자에 대한 후기를 남겨주세요.</h7><br><br>
                        
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
                    <button type="button" class="btn btn-primary" id="submitReview">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
	<script>
	   // 모달 초기화
    const updateModal = document.getElementById('reviewModal');
    updateModal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget; // Trigger 버튼
        const review_id = button.getAttribute('data-review-id');
/*         const reviewRate = button.getAttribute('data-review-rate');
        const reviewContent = button.getAttribute('data-review-content'); */

    // 리뷰 등록 시 review_id는 필요 없으므로 초기화
        document.getElementById('review_id').value = ''; 
        document.getElementById('review_rate').value = '';
        document.getElementById('review_content').value = '';
    });
    const product_id = '13';
 	// 저장 버튼 클릭 이벤트
  document.getElementById('submitReview').addEventListener('click', function () {
    const review_rate = document.getElementById('review_rate').value;
    const review_content = document.getElementById('review_content').value;
    //const product_id = document.getElementById('product_id').value;
   
    
    const reviewData = {
        review_rate: review_rate,
        review_content: review_content
    };

    $.ajax({
        url: `${contextPath}/transactions/registerReview//?product_id=` + product_id,  // product_id는 쿼리 파라미터로 전송
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(reviewData),  // reviewDTO 데이터 전송
        success: function (response) {
            if (response.success) {
                alert('후기가 성공적으로 등록되었습니다.');
                location.reload();  // 페이지 새로고침
            } else {
            	 
                alert(response.message || '후기 등록에 실패하였습니다.');
            }
        },
        error: function () {
            alert('서버 오류가 발생했습니다.');
        }
    });
});

   
	/* 토글스위치 동작(구매자-판매자) */
	    $(document).ready(function () {
	    	// 페이지 로드 시 기본적으로 구매자 콘텐츠만 표시
			$('#buyer-content').show();
			$('#seller-content').hide();
	
	    	
	        // 토글 스위치 동작
	        $('#toggleSwitch').on('change', function () {
	            const isChecked = $(this).is(':checked');
	            if (isChecked) {
	                // 판매자 상태
	                alert('판매자 모드로 전환되었습니다.');
	                // 원하는 추가 작업 수행
	                $('#buyer-content').hide();
	                $('#seller-content').show();
	            } else {
	                // 구매자 상태
	                alert('구매자 모드로 전환되었습니다.');
	                // 원하는 추가 작업 수행
	                $('#seller-content').hide();
	                $('#buyer-content').show();
	            }
	        });
	    });
	
	    function openReviewModal(product_id) {
	    	
	    	// 이벤트 전파 차단
	        if (event) {
	            event.stopPropagation();
	        	event.preventDefault();
	        }

	        // 리뷰 ID를 숨겨진 필드에 설정
	        document.getElementById('review_id').value = product_id;

	        // Bootstrap 모달을 열기
	        const reviewModal = new bootstrap.Modal(document.getElementById('reviewModal'));
	        reviewModal.show();
	    }
	</script>
	
</body>
</html>