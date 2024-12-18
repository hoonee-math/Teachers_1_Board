<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/* 게시판 레이아웃 */
.mini-board {
	background: none;
	border: none;
	padding: 5px;
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
}

.board-header h2 {
	margin: 0;
}

/* 게시판 테이블 */
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
<section class="main-content col-9">
	<div class="row two-columns">
		<!-- 첫 번째 게시판 -->
		<div class="col-6">
			<div class="mini-board">
				<div class="board-header">
					<h2>미해결 게시판</h2>
					<button id="boardBtn1" class="btn btn-outline-success">글쓰기</button>
				</div>

				<table id="tbl-board">
					<tr>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<tbody>
						<c:if test="${not empty boards1}">
							<c:forEach var="board" items="${boards1}">
								<tr>
									<td>${board.boardNo}</td>
									<td><a
										href="${path}/board/boardview.do?boardNo=${board.boardNo}">
											${board.boardTitle} </a></td>
									<td>${board.boardWriter}</td>
									<td><fmt:formatDate value="${board.boardDate}"
											pattern="yyyy-MM-dd" /></td>
									<td>${board.boardReadCount}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>

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
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<tbody>
						<c:if test="${not empty boards2}">
							<c:forEach var="board" items="${boards2}">
								<tr>
									<td>${board.boardNo}</td>
									<td><a
										href="${path}/board/boardview.do?boardNo=${board.boardNo}">
											${board.boardTitle} </a></td>
									<td>${board.boardWriter}</td>
									<td><fmt:formatDate value="${board.boardDate}"
											pattern="yyyy-MM-dd" /></td>
									<td>${board.boardReadCount}</td>
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
    document.getElementById("boardBtn1").addEventListener("click", () => {
        location.assign("${path}/board/boardwrite.do?boardType=1");
    });

    document.getElementById("boardBtn2").addEventListener("click", () => {
        location.assign("${path}/board/boardwrite.do?boardType=2");
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
