<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

<!-- 메인 콘텐츠 영역 시작 지검 -->
<section class="main-content col-10">
	<section id="post-container">
		<table id="post-tbl">
			<tr>
				<td>categoryName</td>
			</tr>
			<tr>
				<td>postName</td>
			</tr>
			<tr>
				<td>viewCount</td>
				<td>createDate</td>
			</tr>
			<tr>
				<td>memberName</td>
			</tr>
			<tr>
				<td>postContent</td>
			</tr>
		</table>	
	</section>

</section>
<!-- 메인 콘텐츠 영역 종료 -->

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>