<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>살래?</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Chart.js for Pie Chart -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    body {
        padding: 0;
        margin: 0;
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
    }

    .section-card {
        padding: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        background-color: #ffffff;
        text-align: center;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    .section-title {
        font-size: 1.25rem;
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }

    .section-count {
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        margin: 15px 0;
    }

    .section-footer button {
        margin-top: 10px;
        padding: 10px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .section-footer button:hover {
        background-color: #0056b3;
    }

    .chart-container {
        width: 100%;
        max-width: 450px;
        margin: 0 auto;
        text-align: center;
        background-color: #ffffff;
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .dashboard-section {
        margin-bottom: 50px;
    }

    canvas {
        width: 100%;
        height: 300px; /* 차트 높이 조정 */
    }

    h2 {
        margin-bottom: 20px;
        color: #555;
        font-size: 1.75rem;
        font-weight: bold;
    }

    .row {
        margin: 0 -15px; /* 카드 간격 조정 */
    }

    .row > .col-md-4,
    .row > .col-md-6 {
        padding: 0 15px;
    }
</style>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    
  <div class="container-fluid">
    <div class="row">
        <%@ include file="../admin/sidebar.jsp"%>

        <!-- 메인 콘텐츠 -->
        <div class="col-md-9">
            <h1 class="my-4">관리자 대시보드</h1>

            <div class="row mb-4"> 
                <!-- 계약 관리 섹션과 차트 섹션을 나란히 배치 -->
                <div class="col-md-6">
                    <div class="section-card">
                        <div class="section-title">계약</div>
                        <div class="section-count">
                        총 
                            <c:out value="${contractCount}"/> 건
                        </div> 
                        <div class="section-title">진행 전</div>
                        <div class="section-count">
                            <c:out value="${contractCount}"/> 건
                        </div> 
                        <div class="section-title">진행 중</div>
                        <div class="section-count">
                            <c:out value="${contractCount}"/> 건
                        </div> 
                        <div class="section-title">계약 완료</div>
                        <div class="section-count">
                            <c:out value="${contractCount}"/> 건
                        </div> 
                    </div>
                </div>

                <!-- 계약 상태 원그래프 -->
                <div class="col-md-6" style="display: flex; justify-content: center; align-items: center;">
                    <div class="chart-container"> 
                        <canvas id="contractStatusChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- 게시판 별 게시글 수 -->
            <div class="dashboard-section mb-4">
                <h2>게시판 별 게시글 수</h2>
                <div class="row">
                    <div class="col-md-4">
                        <div class="section-card">
                            <div class="section-title">게시판 1</div>
                            <div class="section-count">
                                <c:out value="${board1PostCount}"/> 개
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="section-card">
                            <div class="section-title">게시판 2</div>
                            <div class="section-count">
                                <c:out value="${board2PostCount}"/> 개
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="section-card">
                            <div class="section-title">게시판 3</div>
                            <div class="section-count">
                                <c:out value="${board3PostCount}"/> 개
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 신고 종류별 차트 -->
            <div class="dashboard-section mb-4">
                <h2>신고 종류별</h2>
                <div class="row">
                    <div class="col-md-6" style="display: flex; justify-content: center; align-items: center;">
                        <div class="chart-container">
                            <h4>신고 종류 비율</h4>
                            <canvas id="reportTypeChart"></canvas>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="section-card">
                            <div class="section-title">매물 신고</div>
                            <div class="section-count">
                                <c:out value="${propertyReportCount}"/> 건
                            </div>
                        </div>
                        <div class="section-card">
                            <div class="section-title">게시판 신고</div>
                            <div class="section-count">
                                <c:out value="${boardReportCount}"/> 건
                            </div>
                        </div>
                        <div class="section-card">
                            <div class="section-title">유저 신고</div>
                            <div class="section-count">
                                <c:out value="${userReportCount}"/> 건
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


    <%@ include file="../common/footer.jsp"%>
 
<script>
    const contractStatusData = {
        labels: ['진행 전', '조율 중', '진행 중', '계약 완료'],
        datasets: [{
            data: [${contractStatusPending}, ${contractStatusNegotiating}, ${contractStatusOngoing}, ${contractStatusCompleted}],
            backgroundColor: ['#FF5733', '#FFBD33', '#33FF57', '#3357FF'],
        }]
    };

    const contractStatusConfig = {
        type: 'pie',
        data: contractStatusData,
    };

    const contractStatusChart = new Chart(
        document.getElementById('contractStatusChart'),
        contractStatusConfig
    );
</script>

<!-- 신고 종류 비율 원그래프 스크립트 -->
<script>
    const reportTypeData = {
        labels: ['매물 신고', '게시판 신고', '유저 신고'],
        datasets: [{
            data: [${propertyReportCount}, ${boardReportCount}, ${userReportCount}],
            backgroundColor: ['#FF5733', '#33FF57', '#3357FF'],
        }]
    };

    const reportTypeConfig = {
        type: 'pie',
        data: reportTypeData,
    };

    const reportTypeChart = new Chart(
        document.getElementById('reportTypeChart'),
        reportTypeConfig
    );
</script>
    
</body>
</html>
