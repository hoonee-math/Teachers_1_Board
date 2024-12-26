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
			<c:if test="${categoriName == '2' }">
			<button type="submit" id="clear-btn">고민해결</button></c:if>
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
				<td style="display: flex; justify-content:end; align-items: center;">
					<button id="like-btn" style="border:none;">
						<img id="like" width="40px" src="${path }/resources/images/emptyHeart.png">
					</button>
					<span class="like-count">${post.likeCount}</span>
				</td>
			</tr>
		</table>
		</div>
		<div id="comment-container">
			<div class="comment-editor">
				<form action="${path }/post/insertcomment.do" method="post">
					<input type="hidden" name="memberNo" value="${post.member.memberNo }"/>
					<input type="hidden" name="postNo" value="${post.postNo }"/>
					<input type="hidden" name="level" value="1" />
					<textarea name="commentContent" rows="3" style="width: 950px; resize:none;"></textarea>
					<button type="submit" id="comment-btn">등록</button>
				</form>
			</div>
			<table id="comment-tbl">
				<c:if test="${not empty post.comments }">
				    <c:forEach var="comment" items="${post.comments }">
				        <c:if test="${comment.level==1 }">
				            <tr class="level1">
				                <td>
				                    <div class="comment-info">
				                        <span class="comment-writer">${comment.member.memberNick}</span>
				                        <span class="comment-date">${comment.createDate}</span>
				                    </div>
				                    <div class="comment-content">
				                        ${comment.commentContent}
										<button type="button" class="recomment-btn" onclick="addComment()" value="${comment.commentNo }">답글</button>
				                    </div>
				                </td>
				            </tr>
				        </c:if>
				        <c:if test="${comment.level==2 }">
				            <tr class="level2">
				                <td>
				                    <div class="comment-info">
				                        <span class="comment-writer">${comment.member.memberNick}</span>
				                        <span class="comment-date">${comment.createDate}</span>
				                    </div>
				                    <div class="comment-content">
				                        ${comment.commentContent}
										<button type="button" class="recomment-btn" onclick="addComment()" value="${comment.commentNo }">답글</button>
				                    </div>
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
    let isLiked = ${isLiked != null ? isLiked : false};
    
    if(isLiked) {
    	$('#like').attr('src','${path }/resources/images/fullHeart.png')
    }
    $('#like-btn').click(function() {
    	$.ajax({
    		url: '${path}/post/like',
    		method: 'POST',
    		data: {
    			postNo: ${post.postNo}
    		},
    		success: function(data) {
    			console.log('서버 응답: ', data);
    			if(data.isLiked) {
    				// 클릭했을 때 채워진 하트 
    	            $('#like').attr('src', '${path }/resources/images/fullHeart.png');
    				
    	        } else {
    	            //다시 클릭하면 빈 하트
    	        	$('#like').attr('src', '${path }/resources/images/emptyHeart.png');
    	        }
    			//좋아요 수 업데이트
    			$('.like-count').text(data.likeCount);
    		},
    		error: function(xhr, status, error) {
    			console.log("에러 발생", error);
    			console.log("상태", status);
    			console.log("xhr:", xhr.responseText);
    		}
    		
    	});
    });
});

	
//jQuery로 이벤트 주기
$(".recomment-btn").click(e=>{
	console.log($(e.target).parents("tr"));
	
	const $parent=$(e.target).parents("tr");
	const $tr=$("<tr>");
	const $td=$("<td>").attr("colspan","2");
	const $form=$(".comment-editor>form").clone();
	
	$form.find("textarea").attr({"cols":"50","rows":"1"});
	$form.find("button").removeAttr("id").addClass("btn-insert2");
	$form.find("input[name='level']").val('2');
	$form.find("input[name='boardCommentRef']").val($(e.target).val());
	
	$td.append($form).appendTo($tr);
	$parent.after($tr);
	
	// 이벤트 제거하는 로직
	$(e.target).off("click");

})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>