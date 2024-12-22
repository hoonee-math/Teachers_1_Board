<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<!-- header 에만 부여해도 되는 속성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맘스티쳐 비밀번호 찾기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- Bootstrap Icons을 추가하기 위한 태그 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/common/bootStrapEdit.css">

<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #FFF9F4;
	margin: 0;
	padding: 0;
}

.find-page {
	display: flex;
	flex-direction: column;
	align-items: center;
	min-height: 100vh;
	justify-content: center;
}

header {
	text-align: center;
	margin-bottom: 30px;
	display: flex;
	align-items: center;
	gap: 15px;
}

.logo-container {
	display: flex;
	align-items: center;
	cursor: pointer;
}

.logo-svg {
	width: 60px;
	height: 40px;
}

.logo {
	font-size: 54px;
	color: #D9776A;
	margin: 0;
}

.slogan {
	font-size: 20px;
	color: #A37B6E;
}

.find-box {
	background: #fff;
	padding: 45px 30px;
	border-radius: 15px;
	box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
	width: 450px;
	text-align: center;
}

h2 {
	margin-bottom: 30px;
	color: #5A433A;
}

.input-group {
	margin-bottom: 20px;
	text-align: left;
}

label {
	display: block;
	font-size: 16px;
	margin-bottom: 5px;
	color: #6B4F45;
}

input {
	width: 100%;
	padding: 12px;
	border: 1px solid #ECD7C5;
	border-radius: 8px;
	font-size: 16px;
	outline: none;
	box-sizing: border-box;
}

input:focus {
	border-color: #D9776A;
	box-shadow: 0 0 0 2px rgba(217, 119, 106, 0.3);
}

.find-button {
	background-color: #D9776A;
	color: #fff;
	border: none;
	padding: 15px;
	width: 100%;
	border-radius: 8px;
	font-size: 18px;
	cursor: pointer;
	margin-top: 15px;
}

.find-button:hover {
	background-color: #C0655D;
}

.links {
	margin-top: 20px;
	font-size: 16px;
	display: flex;
	justify-content: end;
}

.links a {
	color: #D9776A;
	text-decoration: none;
}
</style>
</head>
<body>
	<section id="findInfo-container">
		<div class="find-page">
			<header>
				<div class="logo-container">
					<svg class="logo-svg" viewBox="0 0 300 200">
          <ellipse cx="150" cy="100" rx="140" ry="80" fill="#FFE4E1" />
          <path d="M100 50 L200 50 C210 50 210 150 200 150 L100 150 C90 150 90 50 100 50" fill="#FFF5EE" />
          <path d="M110 60 L190 60 M110 80 L190 80 M110 100 L190 100 M110 120 L190 120 M110 140 L190 140" stroke="#FFB6C1" stroke-width="2" />
          <path d="M180 40 C180 40 175 35 170 40 C165 45 170 55 170 55 L180 65 L190 55 C190 55 195 45 190 40 C185 35 180 40 180 40" ill="#FF69B4" />
          <path d="M85 90 C85 80 95 70 105 70 C115 70 125 80 125 90 M95 95 C95 85 105 75 115 75" stroke="#FF69B4" stroke-width="3" fill="none" stroke-linecap="round" />
          <path d="M70 110 L80 110 M90 110 L100 110 M110 110 L120 110" stroke="#FFB6C1" stroke-width="2" stroke-dasharray="2,3" />
        </svg>
		<h1 class="logo">맘스티쳐</h1>
				</div>
				<p class="slogan">함께하는 부모들의 공간</p>
			</header>
			<div class="find-box">
				<h2>비밀번호 찾기</h2>
				<form id="find-form">
					<div class="input-group">
						<label for="text">이름</label> <input type="text" id="memberName"
							name="memberName" placeholder="이름을 입력하세요" required>
					</div>
					<div class="input-group">
						<label for="email">이메일</label> <input type="email" id="email"
							name="email" placeholder="이메일을 입력하세요" required>
					</div>
					<button type="submit" class="find-button">본인인증</button>
				</form>
				<div class="links">
					<a href="${path}/member/termsofservice">회원가입</a>
				</div>
			</div>
		</div>
	</section>
	<script>
		document.getElementById('find-form').addEventListener('submit',
				function(e) {
	        		console.log("Form submit event fired");
			        e.preventDefault(); // 폼 기본 제출 동작 방지
			        
			        const memberName = $("#memberName").val();
			        const email = $("#email").val();
			        
			        // 회원 존재 여부 확인
			        $.ajax({
			            url: '${path}/member/findpassword.do',
			            type: "POST",
			            data: {
			                memberName: memberName,
			                email: email
			            },
			            success: function(response) {
			                if(response.exists) {
			                    // 회원이 존재하면 이메일 인증 창 오픈
			                    window.open(
		                            '${path}/check/email.do?email=' + encodeURIComponent(email),
			                        "emailVerify",
			                        "width=400,height=300,left=500,top=200"
			                    );
			                } else {
			                    alert("일치하는 회원 정보가 없습니다.");
			                }
			            },
			            error: function(xhr, status, error) {
			                alert("서버 통신 중 오류가 발생했습니다.");
			                console.error("Error:", error);
			            }
			        });
	        	}
		);
		//로고에 메인 홈으로 이동하는 링크 추가
		$(".logo-container").click(function() {
			location.assign("${path}");
		});
	</script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />