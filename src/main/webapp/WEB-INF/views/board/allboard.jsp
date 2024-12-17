<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<section class="main-content col-9">
	<div class="board-container">
		<div class="board-header">
			<h2>전체글 게시판</h2>
			<p class="board-explain">맘스티쳐 전체 게시글 모음입니다 :)</p>
			<button class="board-btn">등록일순</button>
			<button class="board-btn">글쓰기</button>
		</div>
		<div>
			
		</div>	
	</div>
	
	
	
	
	
	
	
	
	

</section>

<style>
	.board-
	.board-explain {
		color : black;
		
	}
	.board-header {
		border : 1px solid red;
		padding : 20px;
		margin-left : 0px;
		color: #FF69B4;
		box-shadow : ;
	}
		
	.board-container {
		border : 1px solid red;
	}
</style>
<section class="right-box col-1"></section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>