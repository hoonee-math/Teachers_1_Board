<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<style>
	.maincontainer {
        display: flex; /* 플렉스 박스 설정 */
        justify-content: flex-start; /* 왼쪽 정렬 */
        align-items: flex-start; /* 세로 정렬 */
        padding: 20px;
    }

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
     .no-underline {
  	  text-decoration: none;
  	  }
  </style>
<div class="maincontainer">
  <div class="sidebar">
    <a href="${path}/allboard.main" class="no-underline">
      <div>전체글 게시판</div>
    </a>
    <a href="/recommendboard.main" class="no-underline">
      <div>추천글 게시판</div>
    </a>
    <a href="" class="no-underline">
      <div>공지사항</div>
    </a>
    <a href="" class="no-underline">
      <div>맘스뉴스</div>
    </a>
    <a href="" class="no-underline">
      <div>고민상담소</div>
    </a>
  </div>
  
  
  
  

  <script>

  </script>