<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<style>
/* layout.css */
.container {
	display: flex;
	max-width: 100%; /* 1800px 고정값에서 100%로 수정 */
	min-width: 1200px;
	margin: 10px 0;
	padding: 0 20px;
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
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #FFB6C1;
      border-radius: 5px;
      background-color: #ffffff;
      cursor: pointer;
      text-align: center;
      color: #FF69B4;
      font-weight: bold;
      transition: background-color 0.3s;
}

.menu-item:hover {
      background-color: #FFB6C1;
      color: #ffffff;
}
</style>
     
    <main class="container">
        <!-- 사이드 메뉴 영역 -->
        <section class="left-box col-1"></section>
        <section class="side-menu col-1">
            <div class="menu-item">전체글 게시판</div>
            <div class="menu-item">추천글 게시판</div>
            <div class="menu-item">공지사항</div>
            <div class="menu-item">맘스뉴스</div>
            <div class="menu-item">고민상담소</div>
        </section>
  
  

  <script>

  </script>