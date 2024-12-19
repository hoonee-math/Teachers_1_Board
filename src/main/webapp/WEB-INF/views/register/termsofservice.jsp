<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enroll/enrollMember.css">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<<style>
	#terms-body {
		d-flex;
	}

</style>
<section id="enroll-container">
	<div id="terms-header">
		<h2>회원 가입 약관</h2>
	</div>
	<div class="row full-width">
		<div id="terms-body">
			<div id="termsofagree">이용약관 동의</div>
			<div id="agreecolor">(필수)</div>
			<button id="termsofbtn">동의</button>
		</div>
	</div>
	








</section>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>