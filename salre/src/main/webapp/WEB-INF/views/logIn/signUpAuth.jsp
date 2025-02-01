<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" />
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

        .form-section h1 {
            margin-bottom: 20px;
            font-size: 32px;
            color: #333;
        }


        .form-section p { /*  */
            font-size: 14px;
            margin-bottom: 20px;
            color: #666;
        }

        .form-section button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            color: white;
            background-color: #f4a261;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-bottom: 15px;
        }

        .form-section button:hover {
            background-color: #e76f51;
        }

        .form-section .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-section .actions button {
            flex: 1;
            margin: 0 5px;
            background: transparent;
            border: 1px solid #f4a261;
            color: #f4a261;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-section .actions button:hover {
            background-color: #e76f51;
            color: white;
        }
        
       button:disabled {
		    background-color: #ccc !important; /* 비활성화 상태의 배경색 (회색) */
		    color: #999 !important; /* 비활성화 상태의 텍스트 색상 (밝은 회색) */
		    cursor: not-allowed !important; /* 마우스 포인터를 금지 표시로 변경 */
		    opacity: 1 !important; /* 투명도를 기본값으로 유지 */
		    pointer-events: none !important; /* hover 및 클릭 비활성화 */
		}
		
		button:disabled:hover {
		    background-color: #ccc !important; /* hover 시에도 배경색 유지 */
		    color: #999 !important; /* hover 시에도 텍스트 색상 유지 */
		}
		
    </style>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src=" https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   
    
    
    
    
     <script>
    // 포트원 SDK 초기화
    IMP.init("${impKey}"); // 예: imp00000000 
    /* window.onload = function(){
    	console.log("${impKey2}");
    	IMP.init("${impKey2}"); // 예: imp00000000
    	
    	
    }; */
     
   function requestCertification() {
 	// IMP.certification(param, callback) 호출
    IMP.certification(
      {
        // param
        channelKey: "${channelKey}",
        merchant_uid: "ORD" + new Date().getTime(),  //"ORD20180131-0000011", // 주문 번호
        popup: false
        
        
        //m_redirect_url: "{https://your-service.com/signup/complete}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
        //popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
      },
      
      
      function (rsp) {
        // callback//본인인증 완료 후 호출되는 콜백 함수. 본인인증 요청의 결과가 담긴 객체가 rsp로 전달됨.
        if (rsp.success) {
          // 인증 성공 시 로직
        	//alert("본인인증 성공: " + rsp.imp_uid);
        	console.log("본인인증을 성공하였습니다.");
          	console.log(rsp);
            // 서버로 인증 데이터를 전달하여 세션에 저장
            $.ajax({
                url: "${contextPath}/rspTest2",
                type: "POST",
                data: { imp_uid: rsp.imp_uid },
                success: function () {
                    console.log("본인인증 데이터 저장 완료");
                    document.getElementById("next-button").disabled=false;
                    //location.href = "${contextPath}/signUpInfo"; // signUpInfo.jsp로 이동
                },
                error: function () {
                    alert("본인인증 데이터 저장 중 오류 발생");
                }
            });
               
      
             //document.querySelector('[name="certified"]').value = "인증 완료";//서버는 이 값 확인해서 사용자가 본인인증 완료헀는지 판단.(아래 미인증과 관련)
             
        } else {
          // 인증 실패 시 로직
        	 alert("본인인증 실패\n" + rsp.error_msg);
        }  //if end 
      }  //함수 end 
    ); //IMP.certification end 
 }  //function end 
    

	</script>
    
    
    
    
    
    
</head>
<body>
    <div class="container">
        <!-- 좌측 이미지 섹션 -->
        <div class="image-section">
        </div>

        <!-- 우측 폼 섹션 -->
        <div class="form-section">
            <h1>회원가입</h1>
            <h2>본인인증</h2>
            <p>
                회원님의 소중한 개인정보 보호를 위해 본인확인이 필요합니다.<br>
                아래 버튼을 눌러 본인인증을 진행해주세요.<br>
            </p>
            <button type="button" onclick="requestCertification()">본인인증</button>
            <div class="actions">
                <button type="button" onclick="history.back()">이전</button> <!-- 뒤로가기 history.back 쓰기 -->
                <button id="next-button" type="button" onclick="location.href='${contextPath}/signUpInfo'" disabled >다음</button> <!-- disabled? -->
            </div>
        </div>
    </div>
</body>
</html>
 