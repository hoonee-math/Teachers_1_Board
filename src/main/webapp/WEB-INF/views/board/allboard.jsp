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
	        <div style="display: flex; gap: 10px; align-items: center;">
	            <select id="numPerPage" class="form-select" style="width: 100px;">
	                <option value="10" ${numPerPage eq '10' ? 'selected' : ''}>10개</option>
	                <option value="20" ${numPerPage eq '20' ? 'selected' : ''}>20개</option>
	                <option value="30" ${numPerPage eq '30' ? 'selected' : ''}>30개</option>
	                <option value="40" ${numPerPage eq '40' ? 'selected' : ''}>40개</option>
	            </select>
	            <button class="board-btn">등록일순</button>
	            <button id="btn-post" class="board-btn board-btn-write">글쓰기</button>
	        </div>
		</div>
	</div>
	
	<div id="board-container">
			<table id="tbl-board">
				<tr>
						<th>번호</th>
						<c:choose>
							<c:when test="${categoryNo == 8 }">
								<th>전체지역</th>
								<!-- <th>시/군/구</th> -->
							</c:when>
							<c:when test="${categoryNo == 2 }">
								<th>상태</th>
							</c:when>
							<c:otherwise>
								<th>카테고리</th>
							</c:otherwise>
						</c:choose>
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
							<c:choose>
							    <c:when test="${categoryNo == 1}"> 맘스뉴스</c:when>
							    <c:when test="${categoryNo == 2}"> 고민상담</c:when>
							    <c:when test="${categoryNo == 3}"> 공지사항</c:when>
							    <c:when test="${categoryNo == 4}"> 초등</c:when>
							    <c:when test="${categoryNo == 5}"> 중등</c:when>
							    <c:when test="${categoryNo == 6}"> 고등</c:when>
							    <c:when test="${categoryNo == 7}"> 고3/N수</c:when>
							    <c:when test="${categoryNo == 8}"> 지역</c:when>
							    <c:when test="${categoryNo == 9}"> ${sessionScope.loginMember.childSchool.schoolName }</c:when>
							    <c:when test="${categoryNo == 10}"> 자유</c:when>
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

	// 페이지당 게시글 수 변경 및 페이지 로드 함수
	function loadBoardContent(page, numPerPage) {
	    const categoryNo = '${categoryNo}' || '0'; // 기본값 추가
	    
	    const params = new URLSearchParams(window.location.search);
	    params.set('cPage', page);
	    params.set('numPerPage', numPerPage);
	    if(categoryNo !== '0') params.set('categoryNo', categoryNo);
	    
	    const newUrl = `${path}/board/list?${params.toString()}`;
	    $.ajax({
	        url: "${path}/board/list",
	        type: "GET",
	        data: {
	            cPage: page,
	            numPerPage: numPerPage,
	            categoryNo: "${categoryNo}"
	        },
	        dataType: "json",
	        success: function(data) {
	            // 테이블 내용 업데이트
	            updateBoardTable(data.boards);
	            // 페이징 바 업데이트
	            $("#pageBar").html(data.pageBar);
	            
	            // URL 업데이트 (페이지 새로고침 없이)
	            const newUrl = `${path}/board/list?cPage=${page}&numPerPage=${numPerPage}&categoryNo=${categoryNo}`;
	            window.history.pushState({path: newUrl}, '', newUrl);
	        },
	        error: function(xhr, status, error) {
	            console.log("에러 발생:", error);
	        }
	    });
	}

	// 테이블 내용 업데이트 함수
	function updateBoardTable(boards) {
	    const tableBody = $("#tbl-board");
	    tableBody.empty();
	    
	    // 테이블 헤더 추가
	    const header = `
	        <tr>
	            <th>번호</th>
	            <th>${categoryNo == 8 ? '전체지역' : 
	                 categoryNo == 2 ? '상태' : 
	                 '카테고리'}</th>
	            <th>제목</th>
	            <th>작성자</th>
	            <th>조회수</th>
	            <th>시간</th>
	        </tr>`;
	    tableBody.append(header);
	    
	    if(boards.length === 0) {
	        tableBody.append(`
	            <tr>
	                <td colspan="6">조회된 결과가 없습니다.</td>
	            </tr>
	        `);
	        return;
	    }
	    
	    boards.forEach(post => {
	        let categoryName = "";
	        switch(post.categoryNo) {
	            case 1: categoryName = "맘스뉴스"; break;
	            case 2: categoryName = "고민상담"; break;
	            case 3: categoryName = "공지사항"; break;
	            case 4: categoryName = "초등"; break;
	            case 5: categoryName = "중등"; break;
	            case 6: categoryName = "고등"; break;
	            case 7: categoryName = "고3/N수"; break;
	            case 8: categoryName = "지역"; break;
	            case 9: categoryName = "${sessionScope.loginMember.childSchool.schoolName}"; break;
	            case 10: categoryName = "자유"; break;
	            default: categoryName = "기타"; break;
	        }
	        
	        const row = `
	            <tr>
		            <td>\${post.postNo}</td>
		            <td class="category">\${categoryName}</td>
		            <td class="title">
		                <a href="${path}/post/viewpost?postNo=\${post.postNo}">
		                    \${post.postTitle}
		                    \${post.status == 1 && post.isPublic == 0 ? 
		                      '<span style="color:red">[임시저장됨]</span>' : ''}
		                </a>
		                <span class="highlight">\${post.commentCount || '0'}</span>
		            </td>
	                <td>\${post.member.memberNick}</td>
	                <td class="view-count">\${post.viewCount}</td>
	                <td class="time">\${formatDate(post.createDate)}</td>
	            </tr>
	        `;
	        tableBody.append(row);
	    });
	}

	// 날짜 포맷 함수
	function formatDate(dateStr) {
	    const date = new Date(dateStr);
	    const now = new Date();
	    
	    // 날짜 비교를 위해 시간 제거
	    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
	    const postDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
	    
	    if(postDate.getTime() === today.getTime()) {
	        return `\${String(date.getHours()).padStart(2, '0')}:\${String(date.getMinutes()).padStart(2, '0')}`;
	    } else {
	        return `\${String(date.getMonth() + 1).padStart(2, '0')}/\${String(date.getDate()).padStart(2, '0')}`;
	    }
	}

	// 페이지 번호 클릭 이벤트 위임
	$(document).on('click', '#pageBar a', function(e) {
	    e.preventDefault();
	    const page = $(this).data('page');
	    const numPerPage = $('#numPerPage').val();
	    loadBoardContent(page, numPerPage);
	});

	// 게시글 수 변경 이벤트
	$('#numPerPage').change(function() {
	    const numPerPage = $(this).val();
	    loadBoardContent(1, numPerPage);
	});

	// 초기 로드
	$(document).ready(function() {
	    const urlParams = new URLSearchParams(window.location.search);
	    const currentPage = urlParams.get('cPage') || '1';
	    const currentNumPerPage = urlParams.get('numPerPage') || '10';
	    $('#numPerPage').val(currentNumPerPage);
	    loadBoardContent(currentPage, currentNumPerPage);
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />