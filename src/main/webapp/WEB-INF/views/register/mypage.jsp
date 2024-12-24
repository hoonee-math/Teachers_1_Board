<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
#headercomment, #personalcomment, #mypostcomment {
	margin-top : 20px;
	color : grey;
	margin-bottom: 10px;
}
#personalbox, #mypostbox {
	width : 90%;
	height : 400px;
	padding : 20px;
	border: 1px solid brown;
	border-radius: 15px;
	color: #D9776A;
	display : flex;
	flex-direction: column;
	align-items : center;
	margon-top : 10px;
}
#mypostcomment, #personalcomment {
	display : flex;
	justify-content : center;
}
#personala, #mypost {
	margin-top : 25px;
}
a {
	color : brown;
}
</style>
<section class="main-content col-9">
	<div class="col-10" id="mypagecontainer">
		<div id="mypageheader" class="main-title">
			<h2>나의 정보실</h2>
			<p id="headercomment">회원님의 개인정보 수정 및 나의 글에 대해 설정하실 수 있습니다:)</p>
		</div>
		<div id="menucontainer" class="row two-columns">
			<div class="col-6">
				<div id="personalbox">
					<div id="personalinfo"><h3>개인정보</h3></div>
					<div><img src="${path}/resources/images/personalshape.png"></div>
					<div><p id="personalcomment">개인정보를 수정할 수 있는<p>
						 <p id="personalcomment">내정보 페이지로 이동합니다.</p>
					</div>
					<div id="personala">
						<a href="${path}/member/myinfo">개인정보 보러가기</a>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div id="mypostbox">
					<div id="mypost"><h3>나의 글</h3></div>
					<div><img src="${path}/resources/images/postshape.png"></div>
					<div><p id="mypostcomment">회원님이 작성한 글의 내역을 확인하는</p>
						 <p id="mypostcomment">페이지로 이동합니다.</p>
					</div>
					<div id="mypost">
						<a href="${path}/member/mypost">나의 글 보러가기</a> <%-- ?id=${sessionScope.loginMember.email } --%>
					</div>
				</div>	
			</div>
		</div>
	</div>
</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />