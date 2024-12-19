<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    
    <main class="container">
        <!-- 사이드 메뉴 영역 -->
        <section class="side-menu col-1">
			<div class="menu-item">전체글 게시판</div>
			<div class="menu-item">추천글 게시판</div>
			<div class="menu-item">공지사항</div>
			<div class="menu-item">맘스뉴스</div>
			<div class="menu-item">고민상담소</div>
			<div class="menu-item">예시 페이지 연결</div>
			<div class="menu-item">temp 글쓰기</div>
			<div class="menu-item">temp 글 확인</div>
        </section>

	<script>
		$('.side-menu .menu-item:nth-child(1)').click(function() {
	        location.assign("${path}/board/allboard");
		});
		$('.side-menu .menu-item:nth-child(2)').click(function() {
	        location.assign("${path}/board/allboard");
		});
		$('.side-menu .menu-item:nth-child(3)').click(function() {
	        location.assign("${path}/board/allboard");
		});
		$('.side-menu .menu-item:nth-child(4)').click(function() {
	        location.assign("${path}/board/allboard");
		});
		$('.side-menu .menu-item:nth-child(5)').click(function() {
	        location.assign("${path}/board/dontworry");
		});
		$('.side-menu .menu-item:nth-child(6)').click(function() {
	        location.assign("${path}/common/maincontents.show");
		});
		$('.side-menu .menu-item:nth-child(7)').click(function() {
	        location.assign("${path}/common/temp/post");
		});
		$('.side-menu .menu-item:nth-child(8)').click(function() {
	        location.assign("${path}/post/viewpost");
		});
	</script>