<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
#headercomment {
	color : grey;
	margin-bottom: 10px;
}
#personalinfo {
	border : 1px solid black;
}
</style>
<section class="main-content col-9">
	<div class="col-10" id="mypagecontainer">
		<div id="mypageheader" class="main-title">
			<h2>나의 정보실</h2>
			<p id="headercomment">회원님의 개인정보 수정 및 나의 글에 대해 설정하실 수 있습니다:) </p>
		</div>
		<div id="menucontainer" class="row two-columns">
			<div class="col-6">
				<div id="personalinfo">개인정보</div>
			</div>
			<div class="col-6">
				<div id="mypost">나의 글</div>
			</div>
		</div>
	</div>
</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />