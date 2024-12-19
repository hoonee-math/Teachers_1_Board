<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
/* 게시판 레이아웃 */
.mini-board {
	background: none;
	border: none;
	padding: 0 20px 0 12px; /* 12px은 col-6의 margin값 -12를 맞춰주기 위함 값. */
	border-radius: 8px;
}

/* 게시판 컨테이너 */
.board-container {
	width: 48%; /* 두 개의 게시판이 나란히 배치될 수 있도록 너비를 설정 */
	margin-right: 10px; /* 오른쪽 여백 추가 */
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
	/* font-size: 1.25rem; */ /* 제목 크기 */
	/* color: #212529; */ /* 제목 색상 */
}

/* 우측 게시판 테이블 */
#tbl-board {
	width: 100%;
	border: 1px solid black;
	border-collapse: collapse;
}

#tbl-board th, #tbl-board td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

#tbl-board th {
	background-color: #f2f2f2;
}

/* 글쓰기 버튼 */
.board-header .btn {
	margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
}
</style>

<style>
/* 게시글 목록 관련 스타일 */
.post-row {
    padding: 12px 15px;              /* 내부 여백 */
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
    max-width: 360px;                /* 최대 너비 설정 */
    display: inline-block;           /* 인라인 블록 요소로 변경 */
}

.post-info {
    font-size: 0.8rem;               /* 시간 정보 글자 크기 */
    color: #6c757d;                  /* 시간 정보 색상 */
    margin-left: 8px;                /* 왼쪽 여백 */
}

.post-stats {
    color: #6c757d;                  /* 통계 정보 색상 */
    font-size: 0.85rem;              /* 통계 정보 크기 */
}

.post-stats i {
    margin: 0 2px 0 8px;             /* 아이콘 여백 */
}
</style>
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
					                    <i class="bi bi-chat-left-heart-fill"></i> ${post.commentCount}
					                </span>
								</div>
								<div class="post-info"> 
									<c:set var="postTime" value="${post.createdDate.time}" />
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
											<fmt:formatDate value="${post.createdDate}" pattern="MM/dd" />
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
				<div class="board-header">
					<h2>해결된 게시판</h2>
					<button id="boardBtn2" class="btn btn-outline-success">글쓰기</button>
				</div>

				<table id="tbl-board">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>댓글수</th>
					</tr>
					<tbody>
						<c:if test="${empty solvedPosts}">
							<tr>
								<td colspan="5">등록된 게시글이 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${not empty solvedPosts}">
							<c:forEach var="post" items="${solvedPosts}">
								<tr>
									<td>${post.postNo}</td>
									<td><a
										href="${path}/board/postview.do?postNo=${post.postNo}">
											${post.postTitle} </a></td>
									<td>${post.member.memberNick}</td>
									<td>${post.viewCount}</td>
									<td>${post.commentCount}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>

			</div>
		</div>
	</div>
</section>

<script>
	$('#btn-post').click(function() {
	    location.assign("${path}/common/temp/post");
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
