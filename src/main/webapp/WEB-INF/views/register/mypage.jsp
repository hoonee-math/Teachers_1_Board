<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<section class="main-content col-9">
	<div class="col-12" id="mypagecontainer">
		<div id="mypageheader">
			<h2>나의 정보실</h2>
			<p>회원님의 개인정보 수정 및 나의 글에 대해 설정하실 수 있습니다. </p>
		</div>
		<div id="menucontainer">
			<div>개인정보</div>
			<div>나의 글</div>
		</div>
	</div>
</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />