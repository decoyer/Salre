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
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

                    <h1>로그인</h1>
                    <!-- 에러 메시지 표시 -->
                    <c:if test="${not empty error}">
                        <p style="color: red; margin-bottom: 10px;">${error}</p>
                    </c:if>

                    <form action="${contextPath}/login" method="post">
                        <div class="form-group">
                            <label for="id">아이디</label>
                            <input type="text" id="id" name="id" placeholder="아이디 입력" required>
                        </div>
                        <div class="form-group password-toggle">
                            <label for="password">비밀번호</label>
                            <input type="password" id="password" name="password" placeholder="비밀번호 입력" required>
                        </div>
                        <div class="actions">
                            <!--
                            <label>
                                <input type="checkbox" name="remember"> Remember me
                            </label>
                        -->
                            <a href="${contextPath}/findId">아이디 찾기</a>
                            <a href="${contextPath}/findPassword">비밀번호 찾기</a>
                        </div>
                        <br>
                        <button type="submit">로그인</button>
                    </form>
                    <div class="signup-link">
                        <p>아직 계정이 없다면?</p>
                        <p><a href="${contextPath}/signup">회원가입</a></p>
                    </div>
                </div>
            </div>
            <script>
                function togglePassword() {
                    const passwordInput = document.getElementById('password');
                    if (passwordInput.type === 'password') {
                        passwordInput.type = 'text';
                    } else {
                        passwordInput.type = 'password';
                    }
                }
            </script>
        </body>

        </html>