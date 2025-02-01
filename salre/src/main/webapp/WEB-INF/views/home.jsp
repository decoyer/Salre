<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- Meta Tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>살래?!</title>

    <!-- Kakao Map API -->
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
	
    <!-- Swiper -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/home.css">
    
    <style>
    .stats h3 {
        font-size: 1.5em;
        font-weight: bold;
        text-align: center;
        margin-top: 20px;
    }

    .stats .count {
        font-size: 1.8em;
        color: #007bff;
        font-weight: bold;
        display: inline-block;
        position: relative;
        overflow: hidden;
    }

    .stats .count::after {
        content: "";
        display: block;
        width: 100%;
        height: 100%;
        background: #f8f9fa;
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
        animation: slide-up 0.3s ease-out forwards;
    }

    @keyframes slide-up {
        from {
            transform: translateY(100%);
        }
        to {
            transform: translateY(0);
        }
    }
</style>
</head>

<body>
    <!-- Content -->
    <div class="container">
        <section class="main-banner">
            <h1>살래?</h1>
            <p>찾고, 보고, 사고 내가 원하는 부동산</p>
            <form action="product" method="GET">
                <input type="text" name="search" placeholder="원하시는 지역, 건물을 입력해주세요.">
                <button type="submit">검색</button>
            </form>
        </section>

   <section class="stats" id="stats">
    <h3>
        현재 <span id="regionCount">0</span>개의 지역에서 
        <span id="userCount">0</span>명이 
        <span id="productCount">0</span>개의 집을 보고 있습니다.
    </h3>
</section>
        <div id="map1" style="width: 100%; height: 600px;"></div>

        <!-- 추천 상품 캐러셀 -->
        <section class="carousel-section" style="text-align: center;">
            <h2>근처 핫한 매물</h2>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <!-- 추천 상품 리스트 반복문 -->
                    <c:forEach var="product" items="${recommendedProducts}">
                        <div class="swiper-slide">
                            <a href="/product/detail/${product.product_id}" class="product-link">
                                <img src="https://placehold.co/200x100" alt="${product.product_name}" class="carousel-image">
                                <h3>${product.product_name}</h3>
                                <p>${product.description}</p>
                                <p><strong>${product.payment_type}</strong></p>
                                <p id="formatted-deposit-${product.product_id}"></p> <!-- 변경된 부분 -->
                                <p id="formatted-rentfee-${product.product_id}"></p> <!-- 변경된 부분 -->
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-pagination"></div>
            </div>
        </section>
    </div>

    <script>
        // deposit과 rentfee를 읽기 쉽게 포맷팅하는 함수
        function formatCurrency(value) {
            // 정수만 남기고 소수점 제거
            value = Math.floor(value);
            
            if (value >= 100000000) {
                return (value / 100000000).toFixed(0) + ' 억';
            } else if (value >= 10000000) {
                return (value / 10000).toFixed(0) + ' 만';
            } else {
                return value.toLocaleString() + ' 원'; // 기본적으로 원 단위로 표시
            }
        }

        // 페이지 로딩 후 추천 상품의 deposit과 rentfee 값 포맷팅
        <c:forEach var="product" items="${recommendedProducts}">
            document.getElementById("formatted-deposit-${product.product_id}").innerText = formatCurrency(${product.deposit});
            document.getElementById("formatted-rentfee-${product.product_id}").innerText = formatCurrency(${product.rentfee});
        </c:forEach>

        // 지도 표시
        var mapContainer = document.getElementById('map1');
        var mapOption = {
            center: new kakao.maps.LatLng(37.5642135, 127.0016985), // 서울 중심 좌표
            draggable: false,
            level: 8 // 확대 레벨
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 이미지 설정
        var imageSrc = 'https://cdn-icons-png.flaticon.com/512/5973/5973800.png',
            imageSize = new kakao.maps.Size(40, 40),
            imageOption = { offset: new kakao.maps.Point(20, 40) };
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // 서버에서 전달된 JSON 데이터 (JSP에서 전달)
        var regions = <c:out value="${regions}" escapeXml="false" />;

        regions.forEach(function (region) {
            var markerPosition = new kakao.maps.LatLng(region.latitude, region.longitude);

            var marker = new kakao.maps.Marker({
                position: markerPosition,
                image: markerImage,
                map: map
            });

            kakao.maps.event.addListener(marker, 'click', function () {
                if (!region.province) {
                    console.error('지역 정보가 없습니다:', region);
                    return;
                }
                var query = encodeURIComponent(region.province);
                var url = "/salre/product?search=" + query;
                window.location.href = url;
            });
        });

        // Swiper 초기화
        let swiperInstance;
        function initializeSwiper() {
            swiperInstance = new Swiper('.swiper-container', {
                slidesPerView: 3,
                spaceBetween: 10,
                loop: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
            });
        }
 
        function updateSwiper(products) {
            const swiperWrapper = document.querySelector('.swiper-wrapper');
            swiperWrapper.innerHTML = ''; // 기존 슬라이드 초기화

            products.forEach(product => {
                if (product.product_name && product.description && product.payment_type && product.deposit && product.rentfee) {
                    const slide = document.createElement('div');
                    slide.className = 'swiper-slide';
                    slide.innerHTML = `
                        <a href="/salre/product/detail/\${product.product_id}" class="product-link" style="text-decoration: none;">
                            <img src="resources/images/products/\${product.product_id}.jpeg" 
                            onerror="this.src='https://placehold.co/200x200'" 
                            alt="\${product.product_name}" class="carousel-image"
                            style="width: 250px; height: 150px; object-fit: cover;">
                            <h3>\${product.product_name}</h3> 
                            <p><strong>\${product.payment_type}</strong></p>
                            <p>\${formatCurrency(product.deposit)} 원 / \${formatCurrency(product.rentfee)}</p>
                        </a>
                    `;

                    swiperWrapper.appendChild(slide);
                }
            });

            if (swiperInstance) swiperInstance.destroy();
            initializeSwiper();
        }

        // 위치 정보 처리
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function (position) {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    const geocoder = new kakao.maps.services.Geocoder();
                    const coord = new kakao.maps.LatLng(latitude, longitude);

                    geocoder.coord2RegionCode(coord.getLng(), coord.getLat(), function (result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            const region = result.find(r => r.region_type === 'H');
                            const regionName = region.address_name;
                            if (!regionName.includes('서울')) {
                                alert('서울 지역만 지원합니다.');
                                return;
                            }
                            const districtName = regionName.replace('서울특별시', '').split(' ')[1];
                            sendRegionToServer(districtName);
                        }
                    });
                },
                function () {
                    sendRegionToServer('종로구');
                }
            );
        }

        function sendRegionToServer(regionName) {
            fetch('/salre/nearby-products', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ region: regionName }),
            })
                .then(response => {
                    if (!response.ok) throw new Error('네트워크 응답에 문제가 있습니다.');
                    return response.json();
                })
                .then(data => {
                    if (data && data.length > 0) updateSwiper(data);
                    else console.warn('추천 상품 데이터가 없습니다.');
                })
                .catch(error => console.error('지역 정보 전송 중 오류:', error));
        }

        initializeSwiper(); // Swiper 초기화 호출
 		
        const targetNumbers = {
          regionCount : '${regionCount}',
          userCount : 67,
          productCount : '${productCount}'
        };
        
        document.addEventListener("DOMContentLoaded", () => {
       
        

            const duration = 1500;  
             
            Object.keys(targetNumbers).forEach(id => {
                const element = document.getElementById(id);
                const target = targetNumbers[id];
                animateCount(element, target, duration);
            });

            function animateCount(element, target, duration) {
                let start = 0; 
                const increment = Math.ceil(target / (duration / 16));  
                const interval = setInterval(() => {
                    start += increment;
                    if (start >= target) {
                        start = target;  
                        clearInterval(interval);
                    }
                    element.textContent = start.toLocaleString();  
                }, 13);  
            }
        }); 
        
    </script>
    <%@ include file="common/footer.jsp" %>
</body>

</html>
