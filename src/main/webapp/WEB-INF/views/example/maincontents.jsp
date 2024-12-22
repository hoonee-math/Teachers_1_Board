<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/example/sidemenu.jsp" />
<style>
/* layout.css */
.container {
	display: flex;
	max-width: 1400px;
	min-width: 1000px;
	margin: 20px auto;
	padding: 0 20px;
	gap: 20px;
}

/* 사이드 메뉴 스타일링 */
.side-menu {
	flex: 0 0 240px;
	border: 2px solid #F4D2CA;
	padding: 20px;
	background: #fff;
}

.menu-item {
	background: #fff;
	margin: 10px 0;
	padding: 10px;
	border: 1px solid #FFE4E1;
	color: #D9776A;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
}

.menu-item:hover {
	background-color: #FFE4E1;
}

/* 메인 콘텐츠 영역 */
.main-content {
	flex: 1;
	border: 2px solid #F4D2CA;
	padding: 20px;
	background: #fff;
}

.main-content h2 {
	color: #D9776A;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #FFE4E1;
}

.content-box {
	min-height: 400px;
	padding: 20px;
	border: 1px dashed #F4D2CA;
	background-color: #FFF5F5;
}

/* 그리드 레이아웃 스타일 */
.row {
	margin-bottom: 20px;
	display: flex;
	gap: 0px;
}

.col-4, .col-6, .col-8, .col-12 {
	padding: 0;
}
/* 열 너비 설정 */
.col-4 {
	flex: 0 0 33.333%;
}

.col-6 {
	flex: 0 0 50%;
}

.col-8 {
	flex: 0 0 66.666%;
}

/* 공통 컨테이너 스타일 */
.board-container, .video-container, .quick-links, .mini-board,
	.image-gallery, .side-board {
	background: white;
	border: 1px solid #F4D2CA;
	padding: 5px;
	border-radius: 8px;
}

h3 {
	color: #D9776A;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 1px solid #FFE4E1;
}

/* 바로가기 그리드 */
.links-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 10px;
}

.link-item {
	background: #FFF5F5;
	border: 1px solid #FFE4E1;
	padding: 15px;
	text-align: center;
	border-radius: 6px;
	cursor: pointer;
}

/* 이미지 갤러리 그리드 */
.gallery-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 10px;
}

.gallery-item {
	aspect-ratio: 16/9;
	background: #FFF5F5;
	border: 1px dashed #F4D2CA;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* 동영상 컨테이너 */
.video-content {
	aspect-ratio: 16/9;
	background: #FFF5F5;
	border: 1px dashed #F4D2CA;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* 게시판 콘텐츠 */
.board-content {
	min-height: 150px;
	background: #FFF5F5;
	border: 1px dashed #F4D2CA;
	padding: 10px;
}

/* 드롭다운 스타일 */
.dropdown-container {
	background: white;
	border: 1px solid #F4D2CA;
	padding: 15px;
	border-radius: 8px;
}

.custom-select {
	width: 100%;
	padding: 10px;
	border: 1px solid #FFE4E1;
	border-radius: 4px;
	color: #666;
	background-color: white;
	cursor: pointer;
}

.custom-select:hover {
	border-color: #F4D2CA;
}

.custom-select:focus {
	outline: none;
	border-color: #FF69B4;
}

/* 라디오 버튼 그룹 스타일 */
.radio-container {
	background: white;
	border: 1px solid #F4D2CA;
	padding: 15px;
	border-radius: 8px;
}

.radio-group {
	display: flex;
	gap: 20px;
	padding: 10px;
}

.radio-item {
	display: flex;
	align-items: center;
	cursor: pointer;
	padding: 10px 20px;
	border: 1px solid #FFE4E1;
	border-radius: 20px;
	transition: all 0.2s ease;
}

.radio-item:hover {
	background-color: #FFF5F5;
}

.radio-item input[type="radio"] {
	display: none;
}

.radio-item input[type="radio"]:checked+.radio-label {
	color: #D9776A;
	font-weight: bold;
}

.radio-item input[type="radio"]:checked+.radio-label::before {
	border-color: #D9776A;
}

.radio-label {
	color: #666;
	padding: 5px;
}

/* 선택된 라디오 버튼 스타일 */
.radio-item input[type="radio"]:checked {
	background-color: #FFE4E1;
}

.radio-item input[type="radio"]:checked+span {
	color: #D9776A;
}
</style>
<!-- 메인 콘텐츠 영역 -->
<section class="main-content col-9">
	<h2>메인 콘텐츠 영역</h2>

	<!-- 1행: 전체 너비 게시판 -->
	<div class="row full-width">
		<div class="board-container">
			<h3>공지사항 게시판</h3>
			<div class="board-content">게시판 내용이 들어갈 영역입니다.</div>
		</div>
	</div>
	
	<!-- 2행: 2단 분할 (1:1) -->
	<div class="row two-columns">
		<div class="col-6">
			<div class="video-container">
				<h3>추천 동영상</h3>
				<div class="video-content">16:9 비율의 동영상이 들어갈 영역입니다.</div>
			</div>
		</div>
		<div class="col-6">
			<div class="quick-links">
				<h3>바로가기</h3>
				<div class="links-grid">
					<div class="link-item">학교검색</div>
					<div class="link-item">선생님찾기</div>
					<div class="link-item">과목정보</div>
					<div class="link-item">수업후기</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 3행: 3단 분할 -->
	<div class="row three-columns">
		<div class="col-4">
			<div class="mini-board">
				<h3>최신글</h3>
				<div class="board-content">미니 게시판 내용</div>
			</div>
		</div>
		<div class="col-4">
			<div class="mini-board">
				<h3>인기글</h3>
				<div class="board-content">미니 게시판 내용</div>
			</div>
		</div>
		<div class="col-4">
			<div class="mini-board">
				<h3>추천글</h3>
				<div class="board-content">미니 게시판 내용</div>
			</div>
		</div>
	</div>

	<!-- 4행: 2:1 분할 -->
	<div class="row uneven-columns">
		<div class="col-8">
			<div class="image-gallery">
				<h3>추천 클래스</h3>
				<div class="gallery-grid">
					<div class="gallery-item">이미지1</div>
					<div class="gallery-item">이미지2</div>
					<div class="gallery-item">이미지3</div>
					<div class="gallery-item">이미지4</div>
				</div>
			</div>
		</div>
		<div class="col-4">
			<div class="side-board">
				<h3>실시간 랭킹</h3>
				<div class="rank-content">랭킹 내용이 들어갈 영역입니다.</div>
			</div>
		</div>
	</div>
	<!-- 5행: 드롭다운 메뉴 행 -->
	<div class="row dropdown-row">
		<div class="col-4">
			<div class="dropdown-container">
				<h3>학년 선택</h3>
				<select class="custom-select">
					<option selected>학년을 선택하세요</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
				</select>
			</div>
		</div>
		<div class="col-4">
			<div class="dropdown-container">
				<h3>과목 선택</h3>
				<select class="custom-select">
					<option selected>과목을 선택하세요</option>
					<option value="math">수학</option>
					<option value="english">영어</option>
					<option value="science">과학</option>
				</select>
			</div>
		</div>
		<div class="col-4">
			<div class="dropdown-container">
				<h3>지역 선택</h3>
				<select class="custom-select">
					<option selected>지역을 선택하세요</option>
					<option value="seoul">서울</option>
					<option value="gyeonggi">경기</option>
					<option value="incheon">인천</option>
				</select>
			</div>
		</div>
	</div>

	<!-- 6행: 라디오 버튼 선택 메뉴 -->
	<div class="row">
		<div class="col-12">
			<div class="radio-container">
				<h3>수업 형태 선택</h3>
				<div class="radio-group">
					<label class="radio-item"> <input type="radio"
						name="class-type" value="offline"> <span
						class="radio-label">오프라인 수업</span>
					</label> <label class="radio-item"> <input type="radio"
						name="class-type" value="online"> <span
						class="radio-label">온라인 수업</span>
					</label> <label class="radio-item"> <input type="radio"
						name="class-type" value="both"> <span class="radio-label">둘
							다 가능</span>
					</label>
				</div>
			</div>
		</div>
	</div>

</section>

        <!-- <section class="right-box col-1"></section> -->
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />