<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
            <!DOCTYPE html>
            <html>

            <head>
                <title>살래?</title>

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
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap">

                <!-- 외부 CSS -->
                <link rel="stylesheet" href="${contextPath}/resources/css/footer.css">
            </head>

            <body>
                <!-- Footer START -->
                <footer>
                    <div>
                        <h3>형태별 검색</h3>
                        <ul>
                            <li><a href="#">전세</a></li>
                            <li><a href="#">월세</a></li>
                            <li><a href="#">아파트</a></li>
                            <li><a href="#">빌라</a></li>
                            <li><a href="#">상가</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3>고객 지원</h3>
                        <ul>
                            <li><a href="#">자주 묻는 질문(FAQ)</a></li>
                            <li><a href="#">1:1 문의</a></li>
                            <li><a href="#">Android</a></li>
                            <li><a href="#">iOS</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3>저희 회사는</h3>
                        <ul>
                            <li><a href="#">회사소개</a></li>
                            <li><a href="#">오시는 길</a></li>
                            <li><a href="#">제휴문의</a></li>
                            <li><a href="#">채용</a></li>
                        </ul>
                    </div>
                </footer>
                <!-- Footer END -->
            </body>

            </html>