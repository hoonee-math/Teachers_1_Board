<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

<!-- 메인 콘텐츠 영역 시작 지검 -->
<section class="main-content col-10">
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

</section>
<!-- 메인 콘텐츠 영역 종료 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
