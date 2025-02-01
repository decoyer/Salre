<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

        <% String certifiedName=(String) session.getAttribute("certifiedName"); String certifiedPhone=(String)
            session.getAttribute("certifiedPhone"); String certifiedBirthday=(String)
            session.getAttribute("certifiedBirthday"); System.out.println("Info 세션 데이터:"); System.out.println("Name: " + certifiedName);
		    System.out.println(" Phone: " + certifiedPhone);
		    System.out.println(" Birthday: " + certifiedBirthday);
		%>

<!DOCTYPE html>
<html lang=" en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>살래?</title>
                <!-- Favicon -->
                <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">
                <style>
                    body {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                        margin: 0;
                        font-family: Arial, sans-serif;
                        background-color: #f9f9f9;
                    }

                    .container {
                        display: flex;
                        width: 90%;
                        max-width: 1200px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                        border-radius: 8px;
                        overflow: hidden;
                        background-color: #fff;
                    }

                    .image-section {
                        flex: 1;
                        background: url('resources/house.jpg') no-repeat center center;
                        background-size: cover;
                    }

                    .form-section {
                        flex: 1;
                        padding: 40px;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                    }

                    .form-section h1 {
                        font-size: 28px;
                        color: #333;
                        margin-bottom: 20px;
                    }

                    .form-section p {
                        font-size: 14px;
                        color: #666;
                        margin-bottom: 20px;
                    }

                    form {
                        display: flex;
                        flex-direction: column;
                    }

                    .form-group {
                        margin-bottom: 20px;
                        display: flex;
                        flex-direction: column;

                    }

                    .residenseTop {
                        margin-bottom: 20px;
                    }

                    .form-group-inline {
                        display: flex;
                        align-items: center;
                        /* 세로 중앙 정렬 */
                        gap: 15px;
                        /* 입력 필드와 버튼 사이 간격 */

                    }

                    .form-group-inline input {

                        flex: 1;
                        /* 입력 필드가 남은 공간을 차지하도록 설정 */
                        padding: 10px;
                        font-size: 14px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        /*background-color: #f8f9fa;  입력 필드 배경색 */
                        background-color: white;
                        color: #6c757d;
                        /* 텍스트 색상 */

                        width: 75%
                    }

                    .labelInput {

                        flex: 1;
                        /* 입력 필드가 남은 공간을 차지하도록 설정 */

                        width: 75%
                    }

                    .form-group-inline button {

                        padding: 10px;
                        /* 버튼 내부 좌우 여백 */
                        font-size: 14px;
                        /* font-weight: bold; */
                        color: white;
                        background-color: #f4a261;
                        /* 버튼 배경색 */
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        width: 25%
                    }

                    .form-group-inline button:hover {
                        background-color: #e76f51;
                        /* 마우스 오버 시 버튼 색상 */
                    }

                    input {
                        padding: 10px;
                        font-size: 14px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                    }

                    button {
                        width: 100%;
                        padding: 10px;
                        font-size: 16px;
                        color: white;
                        background-color: #f4a261;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                    }

                    button:hover {
                        background-color: #e76f51;
                    }

                    .navigation-buttons {
                        display: flex;
                        gap: 10px;
                    }

                    .navigation-buttons button {
                        flex: 1;
                        background: transparent;
                        border: 1px solid #f4a261;
                        color: #f4a261;
                        border-radius: 4px;
                        cursor: pointer;
                    }

                    .navigation-buttons button:hover {
                        background-color: #e76f51;
                        color: white;
                    }

                    button:disabled {
                        background-color: #ccc !important;
                        /* 비활성화 상태의 배경색 (회색) */
                        color: #999 !important;
                        /* 비활성화 상태의 텍스트 색상 (밝은 회색) */
                        cursor: not-allowed !important;
                        /* 마우스 포인터를 금지 표시로 변경 */
                        opacity: 1 !important;
                        /* 투명도를 기본값으로 유지 */
                        pointer-events: none !important;
                        /* hover 및 클릭 비활성화 */
                    }

                    button:disabled:hover {
                        background-color: #ccc !important;
                        /* hover 시에도 배경색 유지 */
                        color: #999 !important;
                        /* hover 시에도 텍스트 색상 유지 */
                    }

                    a {
                        text-align: center;
                        margin-top: 15px;
                        font-size: 14px;
                        color: #f4a261;
                        text-decoration: none;
                    }

                    a:hover {
                        text-decoration: underline;
                    }

                    .success-message {
                        color: green;
                        /* 초록색 */
                        font-size: 14px;
                        margin-top: 5px;
                    }

                    .error-message {
                        color: red;
                        /* 빨간색 */
                        font-size: 14px;
                        margin-top: 5px;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <div class="image-section"></div>
                    <!--  스크롤   <div class="form-section" style = "overflow:auto;   height : 500px;"> -->
                    <div class="form-section">
                        <h1>회원가입</h1>
                        <h2>회원정보 입력</h2>
                        <form id="signupForm" action="${contextPath}/signup" method="post">
                            <div class="form-group">
                                <label for="id">아이디</label>
                                <div class="form-group-inline">
                                    <input type="text" id="id" name="id" placeholder="아이디 입력" required>
                                    <button type="button" onclick="checkIdAvailability()">아이디 중복체크</button>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password">비밀번호</label>
                                <input type="password" id="password" name="password" placeholder="비밀번호 입력" required>
                            </div>


                            <div class="form-group">
                                <label for="name">이름</label>
                                <input type="text" id="name" name="user_name" value="${sessionScope.certifiedName}" readonly>
                            </div>


                            <div class="form-group">
                                <label for="phone">전화번호</label>
                                <input type="text" id="phone" name="phone_num" value="${sessionScope.certifiedPhone}" readonly>
                            </div>


                            <label for="birthday">주민등록번호</label>
                            <div class="form-group-inline">
                                <input type="text" id="birthday" name="resident_num"
                                    value="${sessionScope.certifiedBirthday}" readonly>
                                -
                                <input type="password" id="birthday2" name="resident_num2" placeholder="주민등록번호 뒷자리 입력"
                                    oninput="validateNumbersOnly(this)" maxlength="7"><br>
                            </div>
                            <br>

                            <div class="form-group">
                                <label for="email">이메일</label>
                                <input type="email" id="email" name="email" placeholder="이메일 주소 입력" required
                                    onblur="checkEmailAvailability(this)">
                                <span id="email-check-message" style="font-size: 14px;"></span>
                            </div>


                            <div class="form-group">
                                <label for="address">주소</label>
                                <div class="form-group-inline">
                                    <input type="text" id="address" name="address" placeholder="주소" required>
                                    <button type="button" onclick="checkAddress()">주소 검색</button>

                                </div>
                                <input type="text" id="address_detail" name="address_detail" placeholder="상세 주소 입력"
                                    required><br>
                            </div>
                            <br>
                            <div class="navigation-buttons">
                                <button type="button" onclick="history.back()">이전</button>
                                <button type="submit" disabled>다음</button>

                            </div>

                        </form>
                    </div>
                </div>
                <script>

                    // 아이디 중복체크
                    function checkIdAvailability() {
                        const id = document.querySelector('[name="id"]').value.trim();
                        if (!id) {
                            alert("아이디를 입력하세요.");
                            return;
                        }
                        // AJAX 요청을 통해 ID 중복 체크
                        $.ajax({
                            url: "${contextPath}/checkId",
                            type: "GET",
                            data: { id },
                            success: function (response) {
                                if (response === "available") {
                                    alert("사용 가능한 아이디입니다.");
                                } else {
                                    alert("이미 사용 중인 아이디입니다.");
                                }
                            },
                            error: function () {
                                alert("아이디 중복 체크 중 오류가 발생했습니다.");
                            },
                        });
                    }

                    // 주민등록번호 유효성 검사
                    function validateNumbersOnly(input) {
                        input.value = input.value.replace(/[^0-9]/g, '');  // 숫자가 아닌 문자는 제거
                    }

                    // 이메일 유효성 검사
                    function checkEmailAvailability(input) {
                        const email = input.value.trim();
                        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

                        if (!email) {
                            showMessage("email-check-message", "이메일 주소를 입력하세요.", "error-message");
                            return;
                        }

                        if (!emailPattern.test(email)) {
                            showMessage("email-check-message", "올바른 이메일 주소를 입력하세요.", "error-message");
                        }

                        else {
                            // AJAX 요청으로 이메일 중복 체크
                            $.ajax({
                                url: "${contextPath}/checkEmail",
                                type: "GET",
                                data: { email },
                                success: function (response) {
                                    if (response === "available") {
                                        showMessage("email-check-message", "사용 가능한 이메일 주소입니다.", "success-message");
                                    } else {
                                        showMessage("email-check-message", "이미 가입된 이메일 주소입니다.", "error-message");
                                    }
                                },
                                error: function () {
                                    showMessage("email-check-message", "이메일 중복 체크 중 오류가 발생했습니다.", "error-message");
                                }
                            });
                        }
                    }

                    /* 주소검색 */
                    function checkAddress() {
                        new daum.Postcode({
                            oncomplete: function (data) {
                                var addr = data.address;//기본주소
                                // 주소 정보를 해당 필드에 넣는다
                                document.getElementById("address").value = addr;
                            }
                        }).open();
                    }

                    // 메시지 표시 함수
                    function showMessage(elementId, message, className) {
                        const messageElement = document.getElementById(elementId);
                        messageElement.textContent = message;
                        messageElement.className = className;
                    }

                    function validateForm() {
                        const form = document.getElementById('signupForm');

                        // 입력 필드들
                        const id = form.querySelector('[name="id"]').value.trim();
                        const password = form.querySelector('[name="password"]').value.trim();
                        const name = form.querySelector('[name="user_name"]').value.trim();
                        const phone = form.querySelector('[name="phone_num"]').value.trim();
                        const birthday = form.querySelector('[name="resident_num"]').value.trim();
                        const birthday2 = form.querySelector('[name="resident_num2"]').value.trim();
                        const email = form.querySelector('[name="email"]').value.trim();
                        const address = form.querySelector('[name="address"]').value.trim();
                        const addressDetail = form.querySelector('[name="address_detail"]').value.trim();

                        // 모든 필드가 채워졌는지 확인
                        const isValid = id && password && name && phone && birthday && birthday2 && email && address && addressDetail;

                        // "다음" 버튼의 disabled 속성 설정/해제
                        const submitButton = form.querySelector('button[type="submit"]');
                        submitButton.disabled = !isValid; // 모든 필드가 유효하면 disabled 해제
                    }

                    // 모든 입력 필드에 이벤트 리스너 추가
                    document.addEventListener('DOMContentLoaded', function () {
                        const form = document.getElementById('signupForm');
                        const inputs = form.querySelectorAll('input');

                        inputs.forEach(function (input) {
                            input.addEventListener('input', validateForm);
                        });
                    });

                </script>
            </body>

            </html>