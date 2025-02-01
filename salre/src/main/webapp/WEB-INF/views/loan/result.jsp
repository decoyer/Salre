<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico"
                type="image/x-icon" />
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

                .main-banner h1 {
                    font-size: 2.5rem;
                    color: #333;
                }

                .main-banner h2 {
                    font-size: 1.25rem;
                    color: #666;
                    margin-bottom: 2rem;
                }

                .controls {
                    display: flex;
                    justify-content: space-between;
                    width: 100%;
                    max-width: 1200px;
                    margin-bottom: 30px;
                }

                .controls button {
                    background-color: transparent;
                    border: none;
                    cursor: pointer;
                    font-size: 2rem;
                }

                .sort {
                    display: flex;
                    justify-content: space-between;
                    width: 100%;
                    max-width: 1200px;
                    margin-bottom: 30px;
                }

                .sort-buttons {
                    display: flex;
                    gap: 10px;
                }

                .sort button {
                    padding: 10px 15px;
                    background-color: #666;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 1rem;
                }

                #resultValue {
                    background-color: #999;
                    color: #fff;
                    cursor: default;
                }

                .sort button.active {
                    background-color: #f4a261;
                }

                .sort-result {
                    display: flex;
                    align-items: center;
                    font-size: 1.25rem;
                    color: #333;
                }

                .container {
                    width: 100%;
                    max-width: 1200px;
                    display: flex;
                    flex-direction: space-between;
                    gap: 30px;
                }

                .filters-section {
                    display: flex;
                    gap: 20px;
                    height: 100%;
                }

                .filters {
                    background: #fff;
                    padding-left: 20px;
                    padding-right: 20px;
                    padding-bottom: 20px;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    width: 250px;
                    accent-color: #f4a261;
                }

                .filters-display {
                    display: flex;
                    align-items: baseline;
                    justify-content: space-between;
                }

                .filters input[type="range"] {
                    width: 100%;
                }

                .filters h3 {
                    margin-bottom: 10px;
                    color: #333;
                }

                .selectControl {
                    padding: 5px 10px;
                    margin-top: 10px;
                    background-color: #999;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 0.75rem;
                }

                #filter {
                    padding: 10px 20px;
                    margin-top: 10px;
                    background-color: #f4a261;
                    color: #fff;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 1rem;
                    width: 100%
                }

                .loan-results {
                    display: grid;
                    align-items: start;
                    align-content: start;
                    grid-template-columns: repeat(2, 2fr);
                    gap: 20px;
                    width: 100%;
                    max-width: 1200px;
                }

                .loan-card {
                    background: #fff;
                    border-radius: 10px;
                    padding: 20px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    transition: transform 0.2s;
                    border: none;
                    cursor: pointer;
                    text-align: left;
                    max-height: 200px;
                }

                .loan-card:hover {
                    transform: translateY(-5px);
                    background-color: #d1d1d1;
                }

                .loan-card-content {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .bank-logo {
                    width: 64px;
                    flex-shrink: 0;
                }

                .loan-card-text {
                    display: flex;
                    flex-direction: column;
                    gap: 5px;
                }

                .loan-card-text h3,
                .loan-card-text h4 {
                    margin: 0;
                    color: #333;
                }

                .loan-card p {
                    color: #666;
                    margin: 5px 0;
                }

                #scroll {
                    position: fixed;
                    bottom: 30px;
                    right: 30px;
                    z-index: 9999;
                    border: none;
                    background-color: transparent;
                    cursor: pointer;
                    padding: 10px;
                    border-radius: 10px;
                    font-size: 2rem;
                }
            </style>
        </head>

        <body>
            <%@ include file="../common/header.jsp" %>

                <!-- Main Banner -->
                <section class="main-banner">
                    <h1>대출 조회결과</h1>
                    <h2>나에게 딱 맞는 대출을 가져왔어요</h2>

                    <!-- Controls -->
                    <div class="controls">
                        <button onclick="history.back()">
                            <img src="${pageContext.request.contextPath}/resources/images/left.png">
                        </button>
                    </div>

                    <div class="sort">
                        <div class="sort-buttons">
                            <button id="sortRate">금리순</button>
                            <button id="sortLimit">한도순</button>
                        </div>
                        <div class="sort-result">
                            <button id="resultValue" disabled></button>
                        </div>
                    </div>

                    <datalist id="markers">
                        <option value="1"></option>
                        <option value="2"></option>
                        <option value="3"></option>
                        <option value="4"></option>
                        <option value="5"></option>
                    </datalist>

                    <div class="container">
                        <div class="filters-section">
                            <div class="filters">
                                <div class="filters-display">
                                    <h3>금리</h3>
                                    <span>
                                        <span id="rate">5</span>%
                                    </span>
                                </div>
                                <input type="range" min="1" max="5" step="0.1" value="5" list="markers"
                                    oninput="document.getElementById('rate').innerHTML=this.value;">
                                <br><br>
                                <hr>
                                <div class="filters-display">
                                    <h3>한도</h3>
                                    <span>
                                        <span id="limit">5</span>억원
                                    </span>
                                </div>
                                <input type="range" min="1" max="5" step="0.1" value="5" list="markers"
                                    oninput="document.getElementById('limit').innerHTML=this.value;">
                                <br><br>
                                <hr>
                                <div class="filters-display">
                                    <h3>은행</h3>
                                    <div>
                                        <button id="selectAll" class="selectControl">전체 선택</button>
                                        <button id="deselectAll" class="selectControl">전체 해제</button>
                                    </div>
                                </div>
                                <span id="bank"></span>
                                <br>
                                <hr>
                                <div class="filters-display">
                                    <h3>상환 방식</h3>
                                </div>
                                <label><input type="checkbox" id="repay1" checked> 원리금분할상환</label> <br>
                                <label><input type="checkbox" id="repay2" checked> 원금분할상환</label> <br>
                                <label><input type="checkbox" id="repay3" checked> 만기일시상환</label>
                                <br><br>
                                <hr>
                                <div class="filters-display">
                                    <h3>정책지원 대출</h3>
                                </div>
                                <label><input type="checkbox" id="option1" checked> 중소기업 재직자 대상</label> <br>
                                <label><input type="checkbox" id="option2" checked> 청년 대상</label>
                            </div>
                        </div>

                        <div class="loan-results" id="loanResults"></div>
                    </div>
                </section>

                <%@ include file="../common/footer.jsp" %>

                    <button onclick="scrollToTop()" id="scroll">
                        <img src="${pageContext.request.contextPath}/resources/images/up.png">
                    </button>

                    <script>
                        $(document).ready(function () {
                            const userAge = `${param.age}`;
                            const paramIncome = "${param.income}";
                            const incomeValue = {
                                step: {
                                    "3500l": 35000000,
                                    "5000l": 50000000,
                                    "5000h": 2147483647
                                }
                            };
                            const userIncome = incomeValue.step[paramIncome];

                            // 필터 설정
                            const filters = {
                                byRate: (item, rate) => item.loan_rate <= parseFloat(rate),
                                byLimit: (item, limit) => item.loan_limit / 100000000 <= parseFloat(limit),
                                byBank: (item, banks) => banks.length > 0 && banks.includes(item.bank_name),
                                byRepay1: (item, isChecked) => isChecked ? true : !item.repayment_type.includes("원리금"),
                                byRepay2: (item, isChecked) => isChecked ? true : !item.repayment_type.includes("원금"),
                                byRepay3: (item, isChecked) => isChecked ? true : !item.repayment_type.includes("만기"),
                                byOption1: (item, isChecked) => isChecked ? true : !item.loan_name.includes("중소기업청년"),
                                byOption2: (item, isChecked) => isChecked ? true : !item.loan_name.includes("버팀목")
                            };

                            // 은행 로고 리스트
                            var bankObj = {
                                "BNK경남은행": "bnk_logo.png", "BNK부산은행": "bnk_logo.png", "IBK기업은행": "ibk_logo.png", "iM뱅크": "im_logo.png",
                                "KB국민은행": "kb_logo.png", "NH농협은행": "nh_logo.png", "SC제일은행": "sc_logo.png", "Sh수협은행": "sh_logo.png",
                                "광주은행": "gj_logo.png", "신한은행": "shinhan_logo.png", "우리은행": "woori_logo.png", "제주은행": "jeju_logo.png",
                                "카카오뱅크": "kakao_logo.png", "케이뱅크": "kbank_logo.png", "토스뱅크": "toss_logo.png", "하나은행": "hana_logo.png"
                            };

                            Object.entries(bankObj).forEach(function ([bank_name, bank_logo]) {
                                let bankLabel = `<label><input type="checkbox" name="bank" value="\${bank_name}" checked> \${bank_name}</label> <br>`;
                                $('#bank').append(bankLabel);
                            });

                            // 이미지 미리 로드(렌더링 속도 향상)
                            function preloadImages() {
                                Object.values(bankObj).forEach(logo => {
                                    const img = new Image();
                                    img.src = `${pageContext.request.contextPath}/resources/images/bank/\${logo}`;
                                });
                            }

                            let list = [];
                            let view = [];
                            let length = 0;

                            // 조회 결과 저장
                            function saveList() {
                                sessionStorage.setItem('list', JSON.stringify(list));
                            }

                            // 임시 조회 결과 저장
                            function saveView() {
                                sessionStorage.setItem('view', JSON.stringify(view));
                            }

                            // 조회 결과 출력
                            function draw(view) {
                                $('#loanResults').empty();
                                view.forEach(function (item) {
                                    let img = `<img src="${pageContext.request.contextPath}/resources/images/bank/\${bankObj[item.bank_name]}" alt="\${item.bank_name} 로고" class="bank-logo">`;

                                    $('#loanResults').append(`
                                        <form action="detail" method="POST">
                                            <input type="hidden" name="id" value="\${item.loan_id}" />
                                            <div class="loan-card" onclick="this.closest('form').submit()">
                                                <div class="loan-card-content">
                                                    \${img}
                                                    <div class="loan-card-text">
                                                        <h3>\${item.loan_name}</h3>
                                                        <h4>\${item.bank_name}</h4>
                                                    </div>
                                                </div>
                                                <hr>
                                                <p>기준금리: \${item.loan_rate}%</p>
                                                <p>최대한도: \${item.loan_limit.toLocaleString()}원
                                                    <span style="font-size: 1rem;">(\${item.loan_limit / 100000000}억원)</span>
                                                </p>
                                                <p>상환방식: \${item.repayment_type}</p>
                                            </div>
                                        </form>
                                    `);
                                });

                                $('#resultValue').html(`총 \${list.length}개 중 \${length}개 조회 완료`);
                            }

                            // Ajax 요청 함수
                            $.ajax({
                                url: `${pageContext.request.contextPath}/loan/select`,
                                type: 'GET',
                                data: {
                                    age: userAge,
                                    income: userIncome
                                },
                                success: function (response) {
                                    preloadImages();

                                    list = response;
                                    view = response;

                                    length = view.length;

                                    saveList();
                                    saveView();

                                    draw(view);
                                },
                                error: function (xhr, status, error) {
                                    console.log(xhr.responseText);
                                }
                            });

                            $('#sortRate').addClass('active');

                            // 금리순 정렬
                            $('#sortRate').click(function () {
                                $('#sortRate').addClass('active');
                                $('#sortLimit').removeClass('active');

                                view = JSON.parse(sessionStorage.getItem('view')) || [];
                                view.sort(function (a, b) {
                                    return a.loan_rate - b.loan_rate;
                                });

                                length = view.length;  // 필터링된 결과 개수 업데이트

                                saveView();
                                draw(view);
                            });

                            // 한도순 정렬
                            $('#sortLimit').click(function () {
                                $('#sortLimit').addClass('active');
                                $('#sortRate').removeClass('active');

                                view = JSON.parse(sessionStorage.getItem('view')) || [];
                                view.sort(function (a, b) {
                                    return b.loan_limit - a.loan_limit;
                                });

                                length = view.length;  // 필터링된 결과 개수 업데이트

                                saveView();
                                draw(view);
                            });

                            // 실시간 필터 처리
                            $('input[type="range"], input[name="bank"], input[id^="repay"], input[id^="option"]').on('input change', function () {
                                const rate = $('input[type="range"]').eq(0).val();
                                const limit = $('input[type="range"]').eq(1).val();
                                const banks = $('input[name="bank"]:checked').map(function () {
                                    return $(this).val();
                                }).get();
                                const repay1 = $('#repay1').prop('checked');
                                const repay2 = $('#repay2').prop('checked');
                                const repay3 = $('#repay3').prop('checked');
                                const option1 = $('#option1').prop('checked');
                                const option2 = $('#option2').prop('checked');

                                view = list
                                    .filter(item => filters.byRate(item, rate))
                                    .filter(item => filters.byLimit(item, limit))
                                    .filter(item => filters.byBank(item, banks))
                                    .filter(item => filters.byRepay1(item, repay1))
                                    .filter(item => filters.byRepay2(item, repay2))
                                    .filter(item => filters.byRepay3(item, repay3))
                                    .filter(item => filters.byOption1(item, option1))
                                    .filter(item => filters.byOption2(item, option2));

                                // 현재 활성화된 버튼에 따라 정렬
                                if ($('#sortRate').hasClass('active')) {
                                    view.sort(function (a, b) {
                                        return a.loan_rate - b.loan_rate;
                                    });
                                } else if ($('#sortLimit').hasClass('active')) {
                                    view.sort(function (a, b) {
                                        return b.loan_limit - a.loan_limit;
                                    });
                                }

                                length = view.length;

                                saveView();
                                draw(view);
                            });

                            // 전체 선택 및 전체 해제 버튼 처리
                            $('#selectAll').click(function () {
                                $('input[name="bank"]').prop('checked', true).trigger('change');
                            });

                            $('#deselectAll').click(function () {
                                $('input[name="bank"]').prop('checked', false).trigger('change');
                            });
                        });

                        // 페이지 상단으로 이동
                        function scrollToTop() {
                            const position =
                                document.documentElement.scrollTop || document.body.scrollTop;

                            if (position) {
                                window.requestAnimationFrame(() => {
                                    window.scrollTo({ top: 0, behavior: 'smooth' });

                                    scrollToTop();
                                });
                            }
                        }
                    </script>
        </body>

        </html>