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
	margin-bottom : 0px;
}
#myinfobody {
	display : flex;
	flex-direction : column;
	gap : 20px;
	 
}
#nickcomment, #passwordcaution {
	margin-top : 5px;
	padding : 0px;
}
</style>
<section class="main-content col-9">
	<div class="col-10">
		<div id="myinfoheader" class="main-title">
			<h2>나의 정보</h2>
			<p id="headercomment">회원님의 개인정보 및 보안강화 그리고 이용 환경을 설정하실 수 있습니다.</p>
		</div>
		<div id="myinfobody">
			<div id="email"> 이메일 <input type="text" value="가져온 이메일 고정" placeholder="가져온 이메일로 고정"></div>
			<div id="nick"> 별명 <input type="text"></div>
			<div id="nickcommentbox"><p id="nickcomment"> * 명예훼손, 비방, 욕설등의 별명은 피해주세요.</p></div>
			<div id="password"> 비밀번호 <input type="password"></div>
			<div id="passwordcaution"><p>* 최소 8글자 이상이며 영문자,숫자,특수기호를 혼합하여 작성해주세요.</p></div>
			<div id="passwordcheck"> 비밀번호 확인 <input type="password"></div>
		</div>
		<div id="checkbutton">
			<button id="save">저장</button>
			<button id="cancle">취소</button>
		</div>
	</div>
</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />