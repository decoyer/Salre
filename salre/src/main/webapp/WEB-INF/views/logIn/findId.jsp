<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

        <!DOCTYPE html>
        <html lang="en">

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
                }

                .container {
                    display: flex;
                    width: 90%;
                    max-width: 1200px;
                    height: 80%;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                    border-radius: 8px;
                    overflow: hidden;
                }

                .image-section {
                    flex: 1;
                    background: url('resources/house.jpg') no-repeat center center;
                    background-size: cover;
                }

                .form-section {
                    flex: 1;
                    padding: 40px;
                    background-color: #fff;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .controls {
                    display: flex;
                    justify-content: space-between;
                    width: 100%;
                    max-width: 1200px;
                    margin-bottom: 30px;
                }

                .controls button {
                    background-color: #fff;
                    border: none;
                    cursor: pointer;
                    font-size: 2rem;
                }

                .form-section h1 {
                    margin-bottom: 20px;
                    font-size: 32px;
                    color: #333;
                }

                .form-section form {
                    display: flex;
                    flex-direction: column;
                }

                .form-section form .form-group {
                    margin-bottom: 20px;
                }

                .form-section form label {
                    display: block;
                    margin-bottom: 8px;
                    font-size: 14px;
                    color: #666;
                }

                .form-section form input {
                    width: 100%;
                    padding: 10px;
                    font-size: 14px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
                }

                .form-section form .password-toggle {
                    position: relative;
                }

                .form-section form .password-toggle input {
                    padding-right: 40px;
                }

                .form-section form .password-toggle .toggle {
                    position: absolute;
                    top: 50%;
                    right: 10px;
                    transform: translateY(-50%);
                    cursor: pointer;
                    color: #f4a261;
                }

                .form-section form .actions {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .form-section form .actions a {
                    font-size: 14px;
                    color: #f4a261;
                    text-decoration: none;
                }

                .form-section form button {
                    width: 100%;
                    padding: 10px;
                    font-size: 16px;
                    color: white;
                    background-color: #f4a261;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .form-section form button:hover {
                    background-color: #e76f51; /* 호버 시 색상 */
                }

                .form-section .signup-link {
                    text-align: center;
                    margin-top: 20px;
                }

                .form-section .signup-link a {
                    color: #f4a261;
                    text-decoration: none;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="image-section">
                </div>
                <div class="form-section">

                    <!-- Controls -->
                    <div class="controls">
                        <button onclick="history.back()">
                            <img src="${pageContext.request.contextPath}/resources/images/left.png">
                        </button>
                    </div>

                    <h1>아이디 찾기</h1>
                    <form action="${contextPath}/findId" method="post">
                        <label for="name">이름</label>
                        <input type="text" id="name" name="user_name" placeholder="이름 입력" required><br><br>
                        <!--   <label for="resident_num">ResidentNum:</label>
        <input type="text" id="birthday" name="resident_num" placeholder="First digits of Resident Registration Number(주민번호앞6자리)" required><br><br> -->
                        <label for="email">이메일</label>
                        <input type="email" id="email" name="email" placeholder="가입시 등록한 이메일 주소 입력" required><br><br>
                        <button type="submit">아이디 찾기</button>
                    </form>
                    <br>
                    <!-- ID찾기 결과 메시지 -->
                    <c:if test="${not empty message}">
                        <p style="color: green;">${message}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red;">${error}</p>
                    </c:if>
                </div>
            </div>





        </body>

        </html>