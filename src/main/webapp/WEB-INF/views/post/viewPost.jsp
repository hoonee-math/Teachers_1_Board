<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/post/viewPost.css">
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

<!-- 메인 콘텐츠 영역 시작 지검 -->
<section class="main-content col-9">
	<section id="post-container">
		<div id="content-container">
			<button type="submit" id="update-btn">수정</button>
			<button type="submit" id="delete-btn">삭제</button>		
		
		<table id="post-tbl">
			<tr class="category-name">
				<td colspan="2">categoryName</td>
			</tr>
			<tr class="post-title">
				<td colspan="2"><h3>${post.postTitle }</h3></td>
			</tr>
			<tr class="info">
				<td><img src="https://img.icons8.com/?size=100&id=30M9wv1iFkcH&format=png&color=000000" width="10px">  viewCount</td>
				<td>${post.createDate }</td>
			</tr>
			<tr class="member-name">
				<td colspan="2">${post. }</td>
			</tr>
			<tr class="file">
				<td colspan="2">if test orifile!=null -> file.png</td>
			</tr>
			<tr class="content">
				<td colspan="2">postContent</td>
			</tr>
		</table>
		</div>
		<div id="comment-container">
			<div class="comment-editor">
				<form action="${path }/post/postcomment.do" method="post">
					<input type="hidden" name="postRef" value="%{}"/>
					<input type="hidden" name="level" value="1"/>
					<input type="hidden" name="writer" value="${loginMember.memberNick }"/>
					<input type="hidden" name="postCommentRef" value="0"/>
					<textarea name="content" rows="3" style="width: 950px; resize:none;"></textarea>
					<button type="submit" id="comment-btn">등록</button>
				</form>
			</div>
			<table id="comment-tbl">
				<tr class="level1">
					<td class="comment-writer">댓글 작성자명 ${comment.postCommentWriter }</td>
					<td class="comment-date">댓글 작성일 ${comment.postCommentDate }</td>
				</tr>
				<tr>
					<td class="comment-content">댓글 내용 ${comment.postCommentContent }</td>	
				</tr>
			</table>
		</div>
		<div id="recommnet-container">
			<button id="recomment-btn" value="${comment.postCommentNo }">대댓글 작성</button>
			
		</div>
	</section>
	
</section>
<!-- 메인 콘텐츠 영역 종료 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>