<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
    <!-- 외부 CSS -->
    <link rel="stylesheet" href="${contextPath}/resources/css/insert.css">
</head>
<body>
    <!-- 메인 배너 -->
    <section class="main-banner">
        <h1>매물 등록</h1>
        <p>
            주소를 다르게 입력한 경우 위치비교를 참고할 수 있으니 꼭 동일하게 입력 바랍니다.<br>
            * 표 처리된 항목은 반드시 입력해야 합니다.
        </p>
    </section>

    <!-- 매물 정보 -->
    <section class="form-section">
        <h2>매물 정보</h2>
        <form action="/salre/product/insert.do" method="post" enctype="multipart/form-data" onsubmit="return handleSubmit();">
            <div class="form-group">
                <label for="product_type">매물 유형 *</label>
                <select id="product_type" name="product_type" required>
                    <option value="원룸">원룸</option>
                    <option value="아파트">아파트</option>
                    <option value="빌라">빌라</option>
                </select>
            </div>

            <!-- 매물 주소 -->
            <div class="form-group">
                <label for="address">매물 주소 *</label>
                <br>
                <input type="text" name="address" id="address" placeholder="주소" style="width: calc(100%); padding: 10px;">
                <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" style="width: 30%; padding: 5px 10px; font-size: 0.9rem; display: inline-block;">
                <br>
                <div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

                <script>
                    var mapContainer = document.getElementById('map'),
                        mapOption = {
                            center: new daum.maps.LatLng(37.537187, 127.005476),
                            level: 5,
                            draggable: false
                        };
                    var map = new daum.maps.Map(mapContainer, mapOption);
                    var geocoder = new daum.maps.services.Geocoder();
                    var marker = new daum.maps.Marker({
                        position: new daum.maps.LatLng(37.537187, 127.005476),
                        map: map
                    });

                    function sample5_execDaumPostcode() {
                        new daum.Postcode({
                            oncomplete: function(data) {
                                var addr = data.address;
                                var sigungu = data.sigungu;

                                document.getElementById("address").value = addr;

                                geocoder.addressSearch(data.address, function(results, status) {
                                    if (status === daum.maps.services.Status.OK) {
                                        var result = results[0];
                                        var coords = new daum.maps.LatLng(result.y, result.x);
                                        mapContainer.style.display = "block";
                                        map.relayout();
                                        map.setCenter(coords);
                                        marker.setPosition(coords);
                                    }
                                });

                                var sigunguInput = document.getElementById("sigungu");
                                if (sigunguInput) {
                                    sigunguInput.value = sigungu;
                                }
                            }
                        }).open();
                    }
                </script>
            </div>

            <!-- 상세 주소 -->
            <div class="form-group">
                <label for="address_detail">상세 주소</label>
                <input type="text" id="address_detail" name="address_detail" placeholder="상세 주소(없는 경우 비움)">
            </div>

            <!-- 매물 크기 -->
            <div class="form-group">
                <label for="area">매물 크기 *</label>
                <input type="number" id="area" name="area" placeholder="크기 입력 (㎡)" required>
            </div>

            <!-- 방 개수 -->
            <div class="form-group">
                <label for="room_count">방 개수 *</label>
                <input type="number" id="room_count" name="room_count" placeholder="방 개수" required>
            </div>

            <!-- 화장실 수 -->
            <div class="form-group">
                <label for="bath_count">화장실 수 *</label>
                <input type="number" id="bath_count" name="bath_count" placeholder="화장실 개수" required>
            </div>

            <!-- 층 -->
            <div class="form-group">
                <label for="floor">층 *</label>
                <input type="number" id="floor" name="floor" placeholder="층" required>
            </div>

            <!-- 방향 -->
            <div class="form-group">
                <label for="direction">방향 *</label>
                <input type="radio" id="direction" name="direction" value="동" required> 동
                <input type="radio" id="direction" name="direction" value="서" required> 서
                <input type="radio" id="direction" name="direction" value="남" required> 남
                <input type="radio" id="direction" name="direction" value="북" required> 북
            </div>

            <!-- 거래 정보 -->
            <h2>거래 정보</h2>
            <div class="form-group">
                <label for="payment_type">거래 종류 *</label>
                <input type="radio" id="rent" name="payment_type" value="월세" required onclick="toggleRentField()"> 월세
                <input type="radio" id="sell" name="payment_type" value="전세" required onclick="toggleRentField()"> 전세
            </div>

            <!-- 보증금 -->
            <div class="form-group">
                <label for="deposit">보증금 *</label>
                <input type="text" id="deposit" name="deposit" required placeholder="원">
            </div>

            <!-- 월세 -->
            <div class="form-group" id="rentField">
                <label for="rent">월세</label>
                <input type="number" id="rentfee" name="rentfee" placeholder="원">
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    toggleRentField();
                });

                function toggleRentField() {
                    const rentField = document.getElementById("rentField");
                    const rentInput = document.getElementById("rentfee");
                    const isRent = document.getElementById("rent").checked;

                    if (isRent) {
                        rentField.style.display = "block";
                        rentInput.value = "";
                        rentInput.required = true;
                    } else {
                        rentField.style.display = "none";
                        rentInput.value = 0;
                        rentInput.required = false;
                    }
                }
            </script>

            <!-- 관리비 -->
            <div class="form-group">
                <label for="manage_fee">관리비 *</label>
                <input type="text" id="manage_fee" name="manage_fee" placeholder="월 5만원">
            </div>

            <!-- 입주 가능일 -->
            <div class="form-group">
                <label for="enter_day">입주 가능일 *</label>
                <input type="date" id="enter_day" name="enter_day" required>
            </div>

            <!-- 사진 등록 -->
            <h2>사진 등록</h2>
            <div class="form-group">
                <label for="photo">기본 사진 *</label>
                <input type="file" id="photo" name="photo" accept="image/*" required onchange="return validateImageFile(this);">
            </div>

            <!-- 기본 정보 -->
            <h2>기본 정보</h2>
            <div class="form-group">
                <label for="product_name">제목 *</label>
                <input type="text" id="product_name" name="product_name" placeholder="예: 역세권 원룸 매물" required>
            </div>
            <div class="form-group">
                <label for="description">상세 설명 *</label>
                <textarea id="description" name="description" rows="5" placeholder="매물에 대한 상세 정보를 입력해주세요." required></textarea>
            </div>

            <!-- 건설 정보 -->
            <h2>건설 정보</h2>
            <div class="form-group">
                <label for="land_type">토지 - 지목 *</label>
                <input id="land_type" name="land_type" placeholder="'전', '답', '대', '임야', '도로', '공장용지', '잡종지', '기타'" required>
            </div>

            <div class="form-group">
                <label for="land_area">토지 - 면적 *</label>
                <input id="land_area" name="land_area" placeholder="184.1분의 12.483㎡" required>
            </div>

            <div class="form-group">
                <label for="building_structure">건물 - 구조 *</label>
                <input id="building_structure" name="building_structure" placeholder="RC', 'SRC', 'S', '조적조', '목조', '경량철골조', '기타'" required>
            </div>

            <div class="form-group">
                <label for="building_usage">건물 - 용도 *</label>
                <input id="building_usage" name="building_usage" placeholder="'주거용', '상업용', '공업용', '기타'" required>
            </div>

            <div class="form-group">
                <label for="rental_area">임대할 부분</label>
                <input id="rental_area" name="rental_area" placeholder="'전체', '1층', '2층 일부', '사무실 한 칸'">
            </div>

            <!-- 사용 승인일 -->
            <div class="form-group">
                <label for="approve_day">사용 승인일 *</label>
                <input type="date" id="approve_day" name="approve_day" required>
            </div>
			<!-- 대출 가능 여부 -->
<h2>대출 가능 여부</h2>
<div class="form-group">
    <label for="loan">주택도시기금 *</label>
    <input type="radio" id="loan_yes" name="loan" value="1" required> 가능
    <input type="radio" id="loan_no" name="loan" value="0" required> 불가능
</div>

<div class="form-group">
    <label for="loan2">중소기업 취업 청년 *</label>
    <input type="radio" id="loan2_yes" name="loan2" value="1" required> 가능
    <input type="radio" id="loan2_no" name="loan2" value="0" required> 불가능
</div>

<div class="form-group">
    <label for="loan3">버팀목 전세자금대출 *</label>
    <input type="radio" id="loan3_yes" name="loan3" value="1" required> 가능
    <input type="radio" id="loan3_no" name="loan3" value="0" required> 불가능
</div>
 
			
            <input type="hidden" id="sigungu" name="sigungu">
            <input type="hidden" id="product_status" name="product_status" value="0">
            <input type="hidden" id="user_id" name="user_id" value="${sessionScope.loggedInUser.user_id}" required>

            <!-- 제출 버튼 -->
            <button type="submit">매물 등록</button>
        </form>

        <script>
            // 이미지 파일 검증 (jpeg, png, gif 형식만 허용)
            function validateImageFile(input) {
                const file = input.files[0];
                const allowedTypes = ['image/jpeg'];
                if (file && !allowedTypes.includes(file.type)) {
                    alert("허용된 파일 형식은 jpeg 입니다.");
                    input.value = "";  // 파일 선택 초기화
                    return false;
                }
                return true;
            }

            // 폼 제출 전 검증
            function handleSubmit() {
                if (!validateForm()) {
                    return false;
                }
                return true;
            }
            
            function validateForm() {
                // 필수 항목이 비어 있지 않은지 확인
                const area = document.getElementById("area").value;
                const roomCount = document.getElementById("room_count").value;
                const bathCount = document.getElementById("bath_count").value;
                const floor = document.getElementById("floor").value;

                if (area <= 0) {
                    alert("매물 크기는 0보다 커야 합니다.");
                    return false;
                }

                if (roomCount <= 0) {
                    alert("방 개수는 0보다 커야 합니다.");
                    return false;
                }

                if (bathCount <= 0) {
                    alert("화장실 수는 0보다 커야 합니다.");
                    return false;
                }

                if (floor <= 0) {
                    alert("층은 0보다 커야 합니다.");
                    return false;
                }
             // 오늘 날짜를 구하기
                const today = new Date();
                const todayString = today.toISOString().split('T')[0]; // yyyy-mm-dd 형식

                // 사용 승인일과 입주 가능일 입력 값 가져오기
                const approvalDate = document.getElementById("approval_date").value;  // 사용 승인일
                const moveInDate = document.getElementById("move_in_date").value;    // 입주 가능일

                // 사용 승인일 검증: 오늘 이전이어야 함
                if (approvalDate >= todayString) {
                    alert("사용 승인일은 오늘 이전이어야 합니다.");
                    return false;
                }

                // 입주 가능일 검증: 최소 오늘보다 일주일 후이어야 함
                const moveInDateObj = new Date(moveInDate);
                const oneWeekLater = new Date(today);
                oneWeekLater.setDate(today.getDate() + 7); // 일주일 후 날짜 계산

                if (moveInDateObj < oneWeekLater) {
                    alert("입주 가능일은 최소 오늘보다 일주일 후이어야 합니다.");
                    return false;
                }

                return true;
            }

            // 폼 제출 전에 validateForm을 호출하여 입력값 확인
            document.querySelector("form").onsubmit = function() {
                return validateForm();
            };
        </script>
    </section>
</body>
</html>
