	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/* 게시판 레이아웃 */
.mini-board, .video-container{
	background: none;
	border: none;
	padding: 0 20px 0 12px; /* 12px은 col-6의 margin값 -12를 맞춰주기 위함 값. */
	border-radius: 8px;
}
/* 게시판 헤더 */
.board-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
	/* padding: 15px; */ /* 내부 여백 */
	/* background: #f8f9fa; */ /* 배경색 */
	/* border-radius: 4px; */ /* 모서리 둥글게 */
}

.board-header h2 {
	margin: 0;
	font-weight: 900;
	/* font-size: 1.25rem; */ /* 제목 크기 */
	/* color: #212529; */ /* 제목 색상 */
}
/* 게시글 목록 관련 스타일 */
.post-row {
    padding: 20px 15px;              /* 내부 여백 */
    border-bottom: 1px solid #dee2e6; /* 구분선 */
    transition: background-color 0.2s; /* 호버 효과 전환 */
}

/* 제목과 통계를 감싸는 컨테이너 */
.post-row .d-flex > div:first-child {
    flex: 1;                        /* 남은 공간 모두 사용 */
    min-width: 0;                   /* 말줄임이 제대로 작동하게 함 */
    display: flex;                  /* 내부 요소 정렬을 위한 flex */
    align-items: center;            /* 수직 가운데 정렬 */
    gap: 8px;                       /* 내부 요소 간격 */
}

.post-row:hover {
    background-color: #f8f9fa;       /* 호버시 배경색 */
}

.post-title {
    text-decoration: none;
    color: #212529;                  /* 글자색 */
    font-size: 0.95rem;              /* 글자 크기 */
    font-weight: 500;                /* 글자 굵기 */
    white-space: nowrap;             /* 줄바꿈 방지 */
    overflow: hidden;                /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis;         /* 말줄임(...) 표시 */
    max-width: 450px;                /* 최대 너비 설정 */
    display: inline-block;           /* 인라인 블록 요소로 변경 */
}

.post-info {
    font-size: 0.8rem;               /* 시간 정보 글자 크기 */
    color: #6c757d;                  /* 시간 정보 색상 */
    margin-left: 8px;                /* 왼쪽 여백 */
}

.post-stats {
    flex-shrink: 0;   
    color: #6c757d;                  /* 통계 정보 색상 */
    font-size: 0.85rem;              /* 통계 정보 크기 */
}

.post-stats i {
    margin: 0 2px 0 8px;             /* 아이콘 여백 */
}
</style>

<!-- 메인 콘텐츠 영역 시작 지검 -->
<section class="main-content col-9">
	<!-- 2행: 2단 분할 (1:1) -->
	<div class="row two-columns">
		<div style="width:550px; padding:0;">
			<div class="video-container">
				<div class="main-title board-header">
					<h2>추천 동영상</h2>
					<!-- <button id="btn-post" class="account-button">글쓰기</button> -->
				</div>
				<div class="video-content"><img alt="moms" src="${path }/resources/images/momsTeacher.png" style="width:100%"></div>
				<div class="video-content">
					<iframe 
					    width="100%" 
					    height="100%" 
					    src="https://www.youtube.com/embed/3tLv12xK1xo?si=VS2g-5M6-kyjcyFa&amp;controls=0&amp;autoplay=1&amp;mute=1" 
					    title="YouTube video player" 
					    frameborder="0" 
					    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
					    referrerpolicy="strict-origin-when-cross-origin" 
					    allowfullscreen>
					</iframe>
				</div>
			</div>
		</div>
		<div style="width:550px; padding:0;">
			<div class="mini-board">
				<div class="main-title board-header">
					<h2>추천글</h2>
					<!-- <button id="btn-post" class="account-button">글쓰기</button> -->
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
								</div>
								<div class="post-info"> 
					                <!-- 좋아요, 댓글 수 정보 -->
					                <span class="post-stats">
					                    <i class="bi bi-suit-heart-fill"></i> ${post.likeCount}
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount+300}
					                </span>
				                </div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>

	<div class="row two-columns">
		<!-- 첫 번째 게시판 -->
		<div style="width:550px; padding:0;">
			<div class="mini-board">
				<div class="main-title board-header">
					<h2>학년별(로그인한 정보)</h2>
					<!-- <button id="btn-post" class="account-button">글쓰기</button> -->
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
								</div>
								<div class="post-info"> 
					                <!-- 좋아요, 댓글 수 정보 -->
					                <span class="post-stats">
					                    <i class="bi bi-suit-heart-fill"></i> ${post.likeCount}
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount+300}
					                </span>
				                </div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
		<!-- 두 번째 게시판 -->
		<div style="width:550px; padding:0;">
			<div class="mini-board">
				<div class="main-title board-header">
					<h2>고민상담</h2>
					<!-- <button id="btn-post" class="account-button">글쓰기</button> -->
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
								</div>
								<div class="post-info"> 
					                <!-- 좋아요, 댓글 수 정보 -->
					                <span class="post-stats">
					                    <i class="bi bi-suit-heart-fill"></i> ${post.likeCount}
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount+300}
					                </span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 메인 콘텐츠 영역 종료 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
