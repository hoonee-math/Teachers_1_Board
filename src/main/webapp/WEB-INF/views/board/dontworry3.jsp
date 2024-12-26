<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board/dontworry.css">

<section class="main-content col-9">
	<div class="row two-columns">
		<!-- 첫 번째 게시판 -->
		<div class="col-6">
			<div class="mini-board">
				<div class="main-title board-header">
					<h2>미해결 게시판</h2>
					<button id="btn-post" class="account-button">글쓰기</button>
				</div>

				<!-- 게시판 테이블 대신 리스트 형태로 변경 -->
				<div class="board-list">
					<c:forEach var="post" items="${unsolvedPosts}">
						<div class="post-row">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<!-- 게시글 제목 -->
									<a href="${path}/board/postview.do?postNo=${post.postNo}"
										class="post-title"> ${post.postTitle} </a> 
					                <!-- 좋아요, 댓글 수 정보 -->
					                <span class="post-stats">
					                    <i class="bi bi-suit-heart-fill"></i> ${post.likeCount}
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount+300}
					                </span>
								</div>
								<div class="post-info"> 
									<c:set var="postTime" value="${post.createDate.time}" />
									<c:set var="currentTime" value="${currentTime}" />
									<c:set var="timeDiff" value="${(currentTime - postTime) / (1000 * 60)}" />
									<c:choose>
										<c:when test="${timeDiff < 6}">
								            방금 전
								        </c:when>
										<c:when test="${timeDiff < 60}">
											<fmt:parseNumber value="${timeDiff}" integerOnly="true" />분 전
								        </c:when>
										<c:when test="${timeDiff < 1440}">
											<fmt:parseNumber value="${timeDiff/60}" integerOnly="true" />시간 전
								        </c:when>
										<c:otherwise>
											<fmt:formatDate value="${post.createDate}" pattern="MM/dd" />
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
		<!-- 두 번째 게시판 -->
		<div class="col-6">
			<div class="mini-board">
				<div class="main-title board-header">
					<h2>미해결 게시판</h2>
					<button id="btn-post" class="account-button">글쓰기</button>
				</div>

				<!-- 게시판 테이블 대신 리스트 형태로 변경 -->
				<div class="board-list">
					<c:forEach var="post" items="${solvedPosts}">
						<div class="post-row">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<!-- 게시글 제목 -->
									<a href="${path}/board/postview.do?postNo=${post.postNo}"
										class="post-title"> ${post.postTitle} </a> 
					                <!-- 좋아요, 댓글 수 정보 -->
					                <span class="post-stats">
					                    <i class="bi bi-suit-heart-fill"></i> ${post.likeCount}
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount+300}
					                </span>
								</div>
								<div class="post-info"> 
									<c:set var="postTime" value="${post.createDate.time}" />
									<c:set var="currentTime" value="${currentTime}" />
									<c:set var="timeDiff" value="${(currentTime - postTime) / (1000 * 60)}" />
									<c:choose>
										<c:when test="${timeDiff < 6}">
								            방금 전
								        </c:when>
										<c:when test="${timeDiff < 60}">
											<fmt:parseNumber value="${timeDiff}" integerOnly="true" />분 전
								        </c:when>
										<c:when test="${timeDiff < 1440}">
											<fmt:parseNumber value="${timeDiff/60}" integerOnly="true" />시간 전
								        </c:when>
										<c:when test="${timeDiff < 1440}">
											<fmt:parseNumber value="${timeDiff/1440}" integerOnly="true" />일 전
								        </c:when>
										<c:otherwise>
											<fmt:formatDate value="${post.createDate}" pattern="MM/dd" />
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
	$('#btn-post').click(function() {
	    location.assign("${path}/post/uploadpost");
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
