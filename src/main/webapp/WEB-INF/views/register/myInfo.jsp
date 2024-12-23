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
}
</style>
<section class="main-content col-9">
	<div class="col-10">
		<div id="myinfoheader" class="main-title">
			<h2>나의 정보</h2>
			<p id="headercomment">회원님의 개인정보 및 보안강 그리고 이용 환경을 설정하실 수 있습니다.</p>
		</div>
		<div id="myinfobody">
			<div id="email"> 이메일 <input type="text" value="가져온 이메일 고정" placeholder="가져온 이메일로 고정"></div>
			<div id="nick"> 별명 <input type="text"></div>
			<div id="nickcommentbox"><p id="nickcomment">별명은 </p></div>
		</div>
	</div>
</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />