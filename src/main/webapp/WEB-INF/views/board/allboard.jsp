<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/board/allboard.css">

<section class="main-content col-9">
	<h2 class="main-title">${categoryTitle }</h2>

	<!-- 1행: 전체 너비 게시판 -->
	<div class="row full-width">
		<div>
			<p class="board-explain">맘스티쳐 전체 게시글 모음입니다 :)</p>
			<button class="board-btn">등록일순</button>
			<button id="btn-post" class="board-btn board-btn-write">글쓰기</button>
			<!-- <button id="boardBtn" class="btn btn-outline-success">글쓰기</button> -->
		</div>
	</div>
	
	<div>
			<table id="tbl-board">
				<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>시간</th>
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
						<td class="category">
							<c:set var="category" value="${p.categoryNo}"/>
							<c:choose>
							    <c:when test="${category == 1}"> 맘스뉴스</c:when>
							    <c:when test="${category == 2}"> 고민상담</c:when>
							    <c:when test="${category == 3}"> 공지사항</c:when>
							    <c:when test="${category == 4}"> 초등</c:when>
							    <c:when test="${category == 5}"> 중등</c:when>
							    <c:when test="${category == 6}"> 고등</c:when>
							    <c:when test="${category == 7}"> 고3/N수</c:when>
							    <c:when test="${category == 8}"> 지역</c:when>
							    <c:when test="${category == 9}"> 학교</c:when>
							    <c:when test="${category == 10}"> 자유</c:when>
							    <c:otherwise>기타</c:otherwise>
							</c:choose>
						</td>
						
						<td class="title">
							<a href="${path }/post/viewpost?postNo=${p.postNo}">
								${p.postTitle}
								<c:if test="${p.status==1 && p.isPublic==0 }"><span style="color:red">[임시저장됨]</span></c:if>
							</a>
							<span class="highlight">2</span></td>
						</td>
						<td>${p.member.memberNick }</td>
						<td class="view-count">${p.viewCount }</td>
						<td class="time">
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd" />
							<fmt:formatDate var="postDate" value="${p.createDate}" pattern="yyyyMMdd" />
							
							<!-- 오늘 작성한 글인 경우 시:분 으로 그 외의 경우에는 월/일 로 데이터 출력 -->
							<c:choose>
							    <c:when test="${today eq postDate}">
							        <fmt:formatDate value="${p.createDate}" pattern="HH:mm"/>
							    </c:when>
							    <c:otherwise>
							        <fmt:formatDate value="${p.createDate}" pattern="MM/dd"/>
							    </c:otherwise>
							</c:choose>
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
	    location.assign("${path}/post/uploadpost");
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />