<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<title>살래?</title>
<link rel="stylesheet" href="${path}/resources/css/contract.css">
</head>
<body>
	<div class="container">
		<h2>[임차인]계약서 보기</h2>
		<form id="contractInput" action="${path}/contract/saveSignature">
			<c:if test="${not empty contract.contract_imgpath}">
				<div class="contract-image-container">
					<img src="${path}${contract.contract_imgpath}" alt="계약서 이미지"
						class="contract-image" onclick="openModal(this.src)">
				</div>
				<div id="imageModal" class="image-modal" onclick="closeModal()">
					<span class="close">&times;</span> <img id="modalImage"
						class="modal-content">
				</div>
			</c:if>
			<c:if test="${not empty errorMessage}">
				<p style="color: red;">${errorMessage}</p>
			</c:if>
			<!-- 서명 영역 -->

			<c:if test="${contract.contract_status == '3'}">
				<section class="section">
					<h2>서명</h2>
					<canvas id="signatureCanvas" class="signature-canvas"></canvas>
					<div class="button-group">
						<button type="button" class="btn btn-primary"
							onclick="saveAndCompleteSignature()">서명 완료</button>
						<button type="button" class="btn btn-secondary"
							onclick="clearSignature()">지우기</button>
					</div>
				</section>
			</c:if>
			<c:if test="${contract.contract_status == '1'}">
				<p style="color: red;">잘못된 접근입니다.</p>
			</c:if>
			<c:if test="${contract.contract_status == '2'}">
				<p class="message">임대인 서명 전입니다.</p>
			</c:if>
			<c:if test="${contract.contract_status == 4 or contract.contract_status == 5}">
				<p class="message">서명을 이미 완료하였습니다.</p>
			</c:if>
		</form>
	</div>
	<script>
        const canvas = document.getElementById('signatureCanvas');
        const ctx = canvas.getContext('2d');
        let drawing = false;

        // 서명 시작
        canvas.addEventListener('mousedown', () => {
            drawing = true;
            ctx.beginPath();
        });

        // 서명 중
        canvas.addEventListener('mousemove', (event) => {
            if (!drawing) return;
            ctx.lineTo(event.offsetX, event.offsetY);
            ctx.stroke();
        });

        // 서명 종료
        canvas.addEventListener('mouseup', () => {
            drawing = false;
        });

        // 서명 지우기
        function clearSignature() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }

        // 서명 저장 및 완료
        function saveAndCompleteSignature() {
            const signatureData = canvas.toDataURL('image/png'); // 서명 데이터를 Base64로 변환

            fetch("${path}/contract/tenant-sign/${contract.contract_id}", {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ signature: signatureData })
            })
            .then(response => response.json())
            .then(data => {
                if (data.imagePath) {
                    alert('서명이 성공적으로 저장되었습니다.');
                    window.location.href = "${path}/contract/viewSignContract/${contract.contract_id}"; // 서명 후 계약서 보기 페이지로 이동
                } else {
                    alert('서명 저장에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error saving signature:', error);
                alert('서명을 저장하는 중 오류가 발생했습니다.');
            });
        }
      //모달 
		  function openModal(imageSrc) {
	            const modal = document.getElementById('imageModal');
	            const modalImage = document.getElementById('modalImage');

	            modal.style.display = "flex"; // 모달 창 표시
	            modalImage.src = imageSrc; // 클릭한 이미지 경로 설정
	        }

	        function closeModal() {
	            const modal = document.getElementById('imageModal');
	            modal.style.display = "none"; // 모달 창 숨김
	        }
    </script>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>