<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- jQuery 주소로 로드 / 파일로 로드시 현재 오류 발생 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- header 에만 부여해도 되는 속성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맘스티쳐</title>
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/common/bootStrapEdit.css">
</head>
<body>
	<header class="header">
		<div class="header-container">
			<!-- 로고 섹션 -->
			<div class="logo-section">
				<div class="logo-wrapper">
					<jsp:include page="/WEB-INF/views/common/logo.jsp" />
				</div>
				<h1 class="logo-text">맘스티쳐</h1>
			</div>

			<div class="flex-spacer"></div>
			<!-- 네비게이션 섹션 -->
			<!-- <nav class="nav-section">
				<button class="nav-button" id="grade-board">학년별 게시판</button>
				<button class="nav-button">지역별 게시판</button>
				<button class="nav-button">학교검색</button>
			</nav>-->
			
			<!-- 검색 섹션 -->
			<div class="search-section">
				<div class="search-box">
					<svg class="search-icon" xmlns="http://www.w3.org/2000/svg"
						width="16" height="16" fill="currentColor"
						class="bi bi-search-heart" viewBox="0 0 16 16">
					  <path
							d="M6.5 4.482c1.664-1.673 5.825 1.254 0 5.018-5.825-3.764-1.664-6.69 0-5.018" />
					  <path
							d="M13 6.5a6.47 6.47 0 0 1-1.258 3.844q.06.044.115.098l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1-.1-.115h.002A6.5 6.5 0 1 1 13 6.5M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11" />
					</svg>

					<input type="text" placeholder="검색어를 입력하세요" style="border:none; background-color:white;">
				</div>
			</div>
			<div class="flex-spacer"></div>
			<!-- 계정 섹션 -->
			<div class="account-section">
				<c:if test="${sessionScope.loginMember == null}">
	        		<!-- 로그인하지 않은 경우 -->
					<button id="btn_login" class="account-button">로그인</button>
					<button id="btn_enroll" class="account-button">회원가입</button>
			    </c:if>
			    <c:if test="${sessionScope.loginMember != null}">
			        <!-- 로그인한 경우 -->
			        <div class="user-info">
			            <span class="welcome-message" style="font-size: calc(.6rem + .6vw) !important; color:#D9776A !important; font-weight:bold;">${loginMember.memberName}님 환영합니다</span>
						    <c:choose>
						        <c:when test="${sessionScope.loginMember.email != null && sessionScope.loginMember.email.equals('admin@admin')}">
						            <i id="adminPage" class="bi bi-gear-fill" style="cursor:pointer; font-size: calc(.9rem + .5vw) !important; color: #D9776A; padding-left:10px;"></i>
						        </c:when>
						        <c:otherwise>
						            <i id="mypagego" class="bi bi-person-heart" style="cursor:pointer; font-size: calc(.9rem + .5vw) !important; color: #D9776A; padding-left:10px;"></i>
						        </c:otherwise>
						    </c:choose>
			        	<i id="btn_logout" class="bi bi-box-arrow-right" style="cursor:pointer; font-size: calc(.9rem + .5vw) !important; color: #D9776A; padding-left:10px;"></i>
			        </div>
			    </c:if>
			</div>
		</div>
	</header>
	<main class="main-container"> <!-- main 끝 태그 : footer 제일 위에 위치 -->
<script>
    /* const gradeBoard = document.getElementById('grade-board');

    gradeBoard.addEventListener('mouseover', () => {
      
    });

    gradeBoard.addEventListener('mouseout', () => {
      
    }); */
    
    $(".logo-text").click(function() {
        location.assign("${path}");
	});
	//로그인 버튼 연결 링크
	$(".account-section .account-button:nth-child(1)").click(function() {
        location.assign("${path}/member/login");
	});
	//회원가입 버튼 연결 링크
	$("#btn_enroll").click(function() {
        location.assign("${path}/member/termsofservice");
	});
	//회원가입 버튼 연결 링크
	$("#btn_logout").click(function() {
        location.assign("${path}/member/logout.do");
	});
	//마이페이지 클릭 연결 링크
	$("#mypagego").click(function() {
		location.assign("${path}/member/mypage");
	})
	
	
  </script>
  
  
  