<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath"
	value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewPort" content="width=device-width, initial-scale=1.0">
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
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
	gap: 20px;
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

.heart-btn {
	background: none;
	border: none;
	color: gray;
}

.heart-btn.liked {
	color: red;
}

/* 설 카드디자인 */
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 250px;
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
				<h1 class="mb-4">나의 관심매물</h1>

				<!-- 구매자 콘텐츠 -->
				 <div id="buyer-content">
					<div class="row mb-3">
						<!-- <div class="col">
							<button class="btn btn-secondary">등록순</button>
							<button class="btn btn-secondary">거래순</button>
							<button class="btn btn-secondary">조회수 순</button>
							<button class="btn btn-secondary">평점 순</button>
						</div> -->
						<!-- <div class="col text-end">
							<input type="date" class="form-control d-inline-block w-auto"
								id="startDate"> <span>~</span> <input type="date"
								class="form-control d-inline-block w-auto" id="endDate">
						</div> -->
					</div>

					<!-- 매물 목록 -->
							<section class="search-results" id="search-results">
						        <c:if test="${not empty favoritesList}">
						        
						            <c:forEach var="product" items="${favoritesList}">
						            
						             <a href="/salre/product/detail/${product.product_id}" class="product-card-link">
						                <div class="product-card" id="#card-${product.product_id}" style="position:relative;">
						                    
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
						                    <p>방 수: ${productB.room_count} | 욕실 수: ${product.bath_count}</p>
						                    <p>층수: ${product.floor}층 | 면적: ${product.area}㎡</p>
						                   
						                     <div class="price"> 
						                        <c:choose>
						                            <c:when test="${product.deposit >= 100000000}"> 
						                                보증금
						                                <c:if test="${(product.deposit % 100000000) / 10000 >= 0}">  
						                                    <fmt:formatNumber pattern="####" value = "${product.deposit / 100000000}" />
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
						                        <button onclick="toggleLike(this, '${product.product_id}', event)"
													class="heart-btn liked">
													<i class="bi bi-heart-fill"></i>
												</button>
						                    </div>
						                 </div>
						              </a>
													
			
						            </c:forEach>
						        </c:if>
						        <c:if test="${empty favoritesList}">
						            <p style="text-align: center; font-size: 20px; color: #999;">검색 결과가 없습니다.</p>
						        </c:if>
						    </section> 
						    
						</div>
			
				
				
				<!-- 판매자 콘텐츠 -->
				<div id="seller-content" style="text-align: center;">
					<h3>판매자는 관심매물을 확인할 수 없습니다.</h3>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../common/footer.jsp"%><!-- include랑..?랑 컴파일되는 시점? 동작하는원리??????? -->

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
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
	</script>
	
	<!-- 좋아요 기능 -->
	<script>
	
	function toggleLike(button, product_id, event) {
    // 이벤트 전파 차단
    if (event) {
    	event.preventDefault();
        event.stopPropagation();
    }

    // 현재 liked 상태 확인
    const is_liked = button.classList.contains("liked");
    
    // 좋아요 취소 시 확인 창 표시
    if (is_liked && !confirm("'좋아요!'를 취소하시겠습니까? ")) {
        return; // 취소 버튼 클릭 시 동작 중단
    }

    $.ajax({
        url: `${contextPath}/toggleLike`, // 서버 API 경로
        type: "POST",
        contentType: "application/json", // JSON 데이터 전송
        data: JSON.stringify({
            product_id: product_id,
            user_id:user_id,
            is_liked: is_liked // 현재 상태를 서버로 전송
        }),
        success: function (response) {
        	  console.log("AJAX Response:", response); // 응답 내용 확인
    
            location.href = "${contextPath}/favorites"// 좋아요 해제한 매물목록 삭제 후 F5역할
            
        },
        error: function () {
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}
  
</script>    
</body>
</html>