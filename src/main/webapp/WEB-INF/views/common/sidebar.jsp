<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/* layout.css */
.main-container {
	display: flex;
	max-width: 1600px; /* 1800px 고정값에서 100%로 수정 */
	min-width: 1400px;
	margin: 20px auto;/* 10px 0; */
	gap: 20px;
}

/* 사이드 메뉴 스타일링 */
.side-menu {
	width: 200px;
	display: flex;
	flex-direction: column;
	padding: 20px;
	/*       margin-left: 100px; */
}

.menu-item {
	margin-top: 0;
	margin-bottom: 20px;
	padding: 13px;
	border: 1px solid #F4D2CA;
	border-radius: 5px;
	background-color: #F9F9F9;
	cursor: pointer;
	text-align: center;
	color: #D9776A;
	font-weight: bold;
	transition: background-color 0.3s;
}

.menu-item:hover {
	background-color: #F4D2CA;
	color: #ffffff;
}
</style>


	<!-- 사이드 메뉴 영역 -->
	<section class="side-menu col-2">
		<div class="menu-item">전체글 게시판</div>
		<div class="menu-item">추천글 게시판</div>
		<div class="menu-item">공지사항</div>
		<div class="menu-item">맘스뉴스</div>
		<div class="menu-item">고민상담소</div>
		<div class="menu-item">예시 페이지 연결</div>
		<div class="menu-item">temp 글쓰기</div>
		<div class="menu-item">temp 글 확인</div>
		<div class="menu-item">학년별 게시판</div>
		<div class="menu-item">지역별 게시판</div>
		<div class="menu-item">학교검색</div>
	</section>



	<script>
		$('.side-menu .menu-item:nth-child(1)').click(function() {
	        location.assign("${path}/board/list");
		});
		$('.side-menu .menu-item:nth-child(2)').click(function() {
	        location.assign("${path}/board/allboard?type=recommend");
		});
		$('.side-menu .menu-item:nth-child(3)').click(function() {
	        location.assign("${path}/home");
		});
		$('.side-menu .menu-item:nth-child(4)').click(function() {
	        location.assign("${path}/board/allboard?type=news");
		});
		$('.side-menu .menu-item:nth-child(5)').click(function() {
	        location.assign("${path}/board/dontworry?type=dontworry");
		});
		$('.side-menu .menu-item:nth-child(6)').click(function() {
	        location.assign("${path}/common/maincontents.show");
		});
		$('.side-menu .menu-item:nth-child(7)').click(function() {
	        location.assign("${path}/post/uploadpost");
		});
		$('.side-menu .menu-item:nth-child(8)').click(function() {
	        location.assign("${path}/post/viewpost?postNo=72");
		});
	</script>