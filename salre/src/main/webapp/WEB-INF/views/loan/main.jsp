<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>살래?</title>

        <style>
            .main-banner {
                padding: 40px;
                background: #f5f5f5;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .main-banner>div {
                width: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }

            .form-box {
                background-color: white;
                padding: 2rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                max-width: 400px;
                width: 100%;
                text-align: left;
            }

            .main-banner h1 {
                font-size: 2.5rem;
                color: #333;
            }

            .main-banner h2 {
                font-size: 1.25rem;
                color: #666;
                margin-bottom: 3rem;
            }

            .form-box h3 {
                margin: 0 auto;
                font-size: 1.25rem;
                padding-bottom: 1.5rem;
            }

            input,
            select,
            button {
                width: 100%;
                padding: 0.75rem;
                margin: 1rem 0;
                font-size: 1rem;
                border-radius: 5px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            button {
                background-color: #f4a261;
                color: white;
                cursor: pointer;
                border: none;
            }

            button:hover {
                background-color: #e76f51;
            }
        </style>
    </head>

    <body>
        <%@ include file="../common/header.jsp" %>

            <!-- Main Banner -->
            <section class="main-banner">
                <div>
                    <h1>대출 맞춤비교</h1>
                    <h2>나에게 딱 맞는 대출을 찾아드려요</h2>

                    <div class="form-box">
                        <form action="result" method="POST">
                            <h3>
                                <label for="age">나이</label>
                                <input type="number" name="age" min="19" max="100" placeholder="만 나이 입력" required />
                                <label for="income">연 소득</label>
                                <select name="income">
                                    <option value="3500l">3500만원 이하</option>
                                    <option value="5000l">5000만원 이하</option>
                                    <option value="5000h">5000만원 이상</option>
                                </select>
                                <label for="product_type">매물유형</label>
                                <select name="product_type">
                                    <option value="month">월세</option>
                                    <option value="2year">전세</option>
                                </select>
                            </h3>
                            <button type="submit">조회</button>
                        </form>
                    </div>
                </div>
            </section>

            <%@ include file="../common/footer.jsp" %>
    </body>

    </html>