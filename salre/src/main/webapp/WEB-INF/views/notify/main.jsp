<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" type="image/x-icon" />
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>살래?</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            .main-banner {
                padding: 40px;
                background: #f5f5f5;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .main-banner>div {
                width: 50%;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
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

            button {
                width: 100%;
                padding: 0.75rem;
                margin: 1rem 0;
                font-size: 1rem;
                border-radius: 5px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            .notify-list {
                display: grid;
                align-items: start;
                align-content: start;
                width: 100%;
                max-width: 1200px;
            }

            .notify-list button {
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: #fff;
                color: #000;
                border-radius: 10px;
                margin: 0.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s;
                border: none;
                cursor: pointer;
                text-align: left;
                padding: 20px;
            }

            .notify-list button.checked {
                background-color: #e5e5e5;
                filter: grayscale(100%);
            }

            .notify-list button:hover {
                background-color: #d5d5d5;
                filter: none;
            }

            .notify-icon {
                font-size: 2.5rem;
                margin-right: 20px;
            }

            .notify-content {
                font-size: 1.25rem;
                flex-grow: 1;
                text-align: left;
            }

            .notify-time {
                font-size: 1rem;
                color: #666;
                align-self: flex-start;
                margin-left: 20px;
            }
        </style>
    </head>

    <body>
        <%@ include file="../common/header.jsp" %>

            <!-- Main Banner -->
            <section class="main-banner">
                <h1>알림 확인</h1>
                <span class="count"></span>
                <div class="notify-list"></div>
            </section>

            <%@ include file="../common/footer.jsp" %>

                <script>
                    const user_id = "${loggedInUser.user_id}";

                    // 알림 키워드 리스트
                    var iconObj = {
                        "채팅": "🤗", "계약": "📜", "서명": "✒️", "송금": "💸"
                    };

                    $(document).ready(function () {
                        // 서버와 SSE 연결
                        const eventSource = new EventSource(`${pageContext.request.contextPath}/notify/subscribe/\${user_id}`);

                        init();

                        eventSource.addEventListener('NOTIFY', function (event) {
                            init();
                        });

                        eventSource.onerror = function () {
                            console.error('SSE 연결 오류');
                        };
                    });

                    // 페이지 출력
                    function init() {
                        draw(`\${user_id}`);
                        count(`\${user_id}`);
                    }

                    // Ajax 요청 함수
                    function draw(item) {
                        $.ajax({
                            type: "GET",
                            url: `${pageContext.request.contextPath}/notify/list/\${user_id}`,
                            contentType: "application/json",
                            success: function (data) {
                                // 기존 알림 목록 초기화
                                $('.notify-list').empty();

                                data.forEach(function (item) {
                                    const is_check = item._check ? 'checked' : '';
                                    const icon = getIcon(item.notify_content);

                                    $('.notify-list').append(`
                                    <button class="\${is_check}" onclick="doClick(\${item.notify_id}, '\${item.notify_url}')">
                                        <span class="notify-icon">\${icon}</span>
                                        <span class="notify-content">\${item.notify_content}</span>
                                        <span class="notify-time">\${time(item.notify_time)}</span>
                                    </button>
                                `);
                                });
                            },
                            error: function () {
                                console.error("알림 조회 오류");
                            }
                        });
                    }

                    // 알림 개수 조회
                    function count(item) {
                        $.ajax({
                            type: "GET",
                            url: `${pageContext.request.contextPath}/notify/unread/\${user_id}`,
                            contentType: "application/json",
                            success: function (data) {
                                $('.count').html(`<h2>확인하지 않은 알림이 \${data}개 있어요</h2><hr>`);
                            },
                            error: function () {
                                console.error("알림 조회 오류");
                            }
                        });
                    }

                    // 알림 아이콘 지정
                    function getIcon(item) {
                        for (const keyword in iconObj) {
                            if (item.includes(keyword)) {
                                return iconObj[keyword];
                            }
                        }
                        return "🔔";
                    }

                    // 알림 읽음 처리 및 페이지 이동
                    function doClick(notify_id, notify_url) {
                        $.ajax({
                            type: "POST",
                            url: `${pageContext.request.contextPath}/notify/check/\${notify_id}`,
                            data: {
                                notify_id: notify_id
                            },
                            success: function () {
                                // notify_id를 세션에 저장
                                sessionStorage.setItem('notify_id', notify_id);
                                window.location.href = notify_url;
                            },
                            error: function () {
                                console.error("읽음 처리 오류");
                            }
                        });
                    }

                    // 알림 시간 계산
                    function time(timestamp) {
                        const now = Date.now(); // 현재 시간 (밀리초)
                        const diff = now - timestamp; // 차이 계산 (밀리초)

                        // 시간 단위 계산
                        const minute = 60 * 1000;
                        const hour = 60 * minute;
                        const day = 24 * hour;
                        const week = 7 * day;
                        const month = 30 * day;

                        if (diff < minute) {
                            return '방금 전';
                        } else if (diff < hour) {
                            return `\${Math.floor(diff / minute)}분 전`;
                        } else if (diff < day) {
                            return `\${Math.floor(diff / hour)}시간 전`;
                        } else if (diff < week) {
                            return `\${Math.floor(diff / day)}일 전`;
                        } else if (diff < month) {
                            return `\${Math.floor(diff / week)}주 전`;
                        } else {
                            return `\${Math.floor(diff / month)}개월 전`;
                        }
                    }
                </script>
    </body>

    </html>