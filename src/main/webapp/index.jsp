<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
    .sidebar {
      width: 200px;
      display: flex;
      flex-direction: column;
      padding: 20px;
      margin-left: 100px;
    }

    .sidebar div {
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

    .sidebar div:hover {
      background-color: #FFB6C1;
      color: #ffffff;
    }
  </style>
  <div class="sidebar">
    <div onclick="moveToPage('전체글')">전체글 게시판</div>
    <div onclick="moveToPage('추천글')">추천글 게시판</div>
    <div onclick="moveToPage('공지사항')">공지사항</div>
    <div>맘스뉴스</div>
    <div>고민상담소</div>
  </div>

  <script>
    function moveToPage(pageName) {
      alert(`${pageName}으로 이동합니다.`);
     
    }
  </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>