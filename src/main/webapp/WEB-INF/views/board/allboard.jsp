<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
.pagebar-number {
	margin-left: 1px;
	margin-right: 1px;
	width: 2%
}

.pagebar {
	display: flex;
	text-align: center;
	justify-content: center;
	margin-top: 15px;
}

.board-btn {
	padding: 8px 16px;
	background-color: #D9776A;
	border: none;
	border-radius: 6px;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.2s ease;
	color: white;
}

.board-btn:hover {
	background-color: #C0655D;
	font-weight: 900;
}

.board-btn-write {
	float: right; /* 오른쪽으로 위치 */
	margin-right: 10px; /* 오른쪽 여백 */
	/* padding: 8px 16px; */  /* header의 account-btn 과 통일시키기 */
	/* background-color: #D9776A; */  /* header의 account-btn 과 통일시키기 */
	/* border: none;  */ /* header의 account-btn 과 통일시키기 */
	/* border-radius: 6px; */  /* header의 account-btn 과 통일시키기 */
	/* color: white; */  /* header의 account-btn 과 통일시키기 */
	/* font-weight: 600; */ /* header의 account-btn 과 통일시키기 */
	/* cursor: pointer; */ /* header의 account-btn 과 통일시키기 */
	/* transition: background-color 0.2s ease; */ /* header의 account-btn 과 통일시키기 */
}

.board-explain {
	color: black;
}

.board-header {
	padding: 20px;
	margin-left: 0px;
	color: #D9776A;
	/* box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); */ /* 쉐도우 효과 */
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f4f4f4;
	font-weight: bold;
}

.category {
	font-size: 12px;
	color: #888;
	font-weight: bold;
}

.title {
	text-align: left;
	color: #333;
}

.title a {
	text-decoration: none;
	color: inherit;
}

.title a:hover {
	color: #007bff;
}

.highlight {
	font-weight: bold;
	color: #D9776A;
}

.view-count {
	color: gray;
}

.time {
	font-size: 12px;
	color: #888;
}
</style>
<section class="main-content col-9">
	<h2 class="main-title">전체글 게시판</h2>

	<!-- 1행: 전체 너비 게시판 -->
	<div class="row full-width">
		<div>
			<p class="board-explain">맘스티쳐 전체 게시글 모음입니다 :)</p>
			<button class="board-btn">등록일순</button>
			<button id="btn-post" class="board-btn board-btn-write">글쓰기</button>
		</div>
	</div>
	<!-- 1행: 전체 너비 게시판 -->
	<div class="row full-width">
	<div>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>시간</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td class="category">고민</td>
					<td class="title"><a href="#">고민이 있어요 도와주세요</a> <span
						class="highlight">2</span></td>
					<td>알이랑</td>
					<td class="view-count">870</td>
					<td class="time">00:15</td>
				</tr>
				<tr>
					<td>2</td>
					<td class="category">고민</td>
					<td class="title"><a href="#">우리아이 어쩌면 좋을까요..?</a> <span
						class="highlight">2</span></td>
					<td>newgooday</td>
					<td class="view-count">412</td>
					<td class="time">00:15</td>
				</tr>
				<tr>
					<td>3</td>
					<td class="category">일반</td>
					<td class="title"><a href="#">상쾌한 아침산책</a> <span
						class="highlight">1</span></td>
					<td>Santorini</td>
					<td class="view-count">59</td>
					<td class="time">00:14</td>
				</tr>
				<tr>
					<td>4</td>
					<td class="category">일반</td>
					<td class="title"><a href="#">패딩 추천부탁드립니다~</a> <span
						class="highlight">4</span></td>
					<td>t.t</td>
					<td class="view-count">779</td>
					<td class="time">00:13</td>
				</tr>
				<tr>
					<td>5</td>
					<td class="category">일반</td>
					<td class="title"><a href="#">패딩 추천부탁드립니다~</a> <span
						class="highlight">4</span></td>
					<td>t.t</td>
					<td class="view-count">779</td>
					<td class="time">00:13</td>
				</tr>
				<tr>
					<td>6</td>
					<td class="category">일반</td>
					<td class="title"><a href="#">패딩 추천부탁드립니다~</a> <span
						class="highlight">4</span></td>
					<td>t.t</td>
					<td class="view-count">779</td>
					<td class="time">00:13</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>

	<div class="pagebar">
		<button class="pagebar-start">이전</button>
		<button class="pagebar-number">1</button>
		<button class="pagebar-number">2</button>
		<button class="pagebar-number">3</button>
		<button class="pagebar-number">4</button>
		<button class="pagebar-number">5</button>
		<button class="pagebar-end">다음</button>
	</div>
	<div>
			<button id="boardBtn" class="btn btn-outline-success">글쓰기</button>
			<table id="tbl-board">
				<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>시간</th>
				</tr>
				<tr>
					<td>번호</td>
					<td>
						타이틀을 누르면 상세화면으로 이동
					</td>
					<td></td>
					<td></td>
					<td>
					첨부파일이 있으면 이미지출력 / 없으면 공란
					</td>
					<td></td>
				</tr>
				<c:if test="${empty boards }">
	            	<tr>
	            		<td>
	            			죄회된 결과가 없습니다.
	            		</td>
	            	</tr>
	            </c:if>
				<c:if test="${not empty boards }">
					<c:forEach var="p" items="${boards }">
					<tr>
						<td>${p.postNo }</td>
						<td>${p.categoryNo }
						<td><a href="${path }/post/viewpost?postNo=${p.postNo}">${p.postTitle}</a></td>
						<td>${p.member.memberNick }</td>
						<td>${p.viewCount }</td>
						<td>
							<fmt:formatDate value="${p.createDate }" pattern="yyyy년 MM월 dd일"/>
						</td>
					</tr>
					</c:forEach>
	            </c:if>
			</table>
	
	        <div id="pageBar">
	        	${pageBar }
	        </div>
	    </div>
</section>
<script>
	$('#btn-post').click(function() {
	    location.assign("${path}/common/temp/post");
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />