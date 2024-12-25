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
		<div class="menu-item" data-category="0">전체글 게시판</div>
		<div class="menu-item" data-category="20">추천글 게시판</div>
		<div class="menu-item" data-category="3">공지사항</div>
		<div class="menu-item" data-category="1">맘스뉴스</div>
		<div class="menu-item" data-category="2">고민상담소</div>
		<hr style="margin-top:0px">
		<div class="menu-item" data-category="5">학년별 게시판(생각해보기)</div>
		<div class="menu-item" data-category="8">지역별 게시판</div>
		<div class="menu-item" data-category="9">학교검색</div>
		<hr style="margin-top:0px">
		<div class="menu-item" data-post="uploadpost">temp 글쓰기</div>
		<div class="menu-item" data-post="viewpost?postNo=72">temp 글 확인</div>
	</section>



	<script>
	    // HTML5 History API를 사용한 URL 변경
		$('.side-menu .menu-item').click(function() {
		    var categoryNo = $(this).data('category');
		    var post = $(this).data('post');
		    
		    if(categoryNo){
			    // 페이지 이동
			    location.href = "${path}/board/list?categoryNo=" + categoryNo;
		    }
		    else if(post){
		    	location.href = "${path}/post/" + post;
		    }
		});
	</script>