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
		<div id="content-container" style="min-height:550px;">
		<c:if test="${post.member.memberNick==loginMember.memberNick }">
			<button type="submit" id="clear-btn">고민해결</button>
			<button type="submit" id="update-btn">수정</button>
			<button type="submit" id="delete-btn">삭제</button>		
		</c:if>
		<table id="post-tbl">
			<tr class="category-name">
				<td colspan="2">${categoryName }</td>
			</tr>
			<tr class="post-title">
				<td colspan="2"><h3>${post.postTitle }</h3></td>
			</tr>
			<tr class="info">
				<td><img src="https://img.icons8.com/?size=100&id=30M9wv1iFkcH&format=png&color=000000" width="10px">     ${post.viewCount }</td>
				<td>${post.createDate }</td>
			</tr>
			<tr class="member-name">
				<td colspan="2">${post.member.memberNick }</td>
			</tr>
			<tr class="file">
				<td colspan="2">
					<c:forEach var="image" items="${images }">
						<img src="${path }/resources/upload/post/${image.renamed }" style="max-width:400px; max-height:400px; margin:5px;">
					</c:forEach>
				</td>
			</tr>
			<tr class="content">
				<td colspan="2">${post.postContent }</td>
			</tr>
			<tr id="like-container">
				<td>
					<button id="like-btn">
						<img id="like" width="40px" src="${path }/resources/images/emptyHeart.png">
					</button>
				</td>
			</tr>
		</table>
		</div>
		<div id="comment-container">
			<div class="comment-editor">
				<form action="${path }/post/postcomment.do" method="post">
					<input type="hidden" name="memberNo" value="${post.member.memberNo }"/>
					<input type="hidden" name="postNo" value="${post.postNo }"/>
					<input type="hidden" name="postRef" value="%{}"/>
					<input type="hidden" name="level" value="1" />
					<input type="hidden" name="writer" value="${loginMember.memberNick }"/>
					<input type="hidden" name="postCommentRef" value="0"/>
					<textarea name="content" rows="3" style="width: 950px; resize:none;"></textarea>
					<button type="submit" id="comment-btn">등록</button>
				</form>
			</div>
			<table id="comment-tbl">
			<c:if test="${not empty post.comments }">
				<c:forEach var="comment" items="${post.comments }">
					<c:if test="${comment.level==1 }">
						<tr class="level1">
							<td class="comment-writer">댓글 작성자명 ${comment.member.memberNick }</td>
							<td class="comment-date">댓글 작성일 ${comment.createDate }</td>
						</tr>
						<tr>
							<td class="c
							omment-content">댓글 내용 ${comment.comment }</td>	
							<td>
								<button class="recomment-btn" value="${comment.commentNo }">대댓글</button>
							</td>
						</tr>
					</c:if>
					<c:if test="${comment1.level==2 }">
						<tr class="level2">
							<td class="comment-writer">댓글 작성자명 ${comment.member.memberNick }</td>
							<td class="comment-date">댓글 작성일 ${comment.createDate }</td>
						</tr>
						<tr>
							<td class="comment-content">댓글 내용 ${comment.comment }</td>	
							<td>
								<button class="recomment-btn" value="${comment.commentNo }">대댓글</button>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
				
				
			</table>
		</div>
		<div id="recommnet-container">
		</div>
	</section>
	
</section>
<!-- 메인 콘텐츠 영역 종료 -->
<script>
//하트(좋아요) 눌렀을 때 변화를 출력해주는 기능
$("#like-btn").ready(function() {
    let isLiked = false;
    $('#like-btn').click(function() {
        if(!isLiked) {
            $('#like').attr('src', '${path }/resources/images/fullHeart.png');

            //$(this).css('background-color', 'rgba(217,119,106,0.3)'); // 클릭했을 때 연갈색으로
        } else {
        	$('#like').attr('src', '${path }/resources/images/emptyHeart.png');
            //$(this).css('background-color', '#f9f9f9'); // 다시 클릭하면 배경색으로
        }
        isLiked = !isLiked;
    });
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>