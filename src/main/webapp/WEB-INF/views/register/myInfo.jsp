<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enroll/enrollMember.css">
<style>
button, input, select, textarea {
    margin: 0;
    padding: 0;
}

/* 입력 필드 텍스트 스타일 */
button, input, select, td, textarea, th {
    font-size: 14px;
    line-height: 1.5;
    font-family: 'Malgun Gothic','맑은 고딕',sans-serif;
    color: #222;
}

/* IE 브라우저 clear 버튼 숨김 */
input[type=text]::-ms-clear {
    display: none;
}

/* 입력 필드 검색 취소 버튼 숨김 */
input[type=search]::-webkit-search-cancel-button {
    -webkit-appearance: none;
}

/* 우편번호 입력 필드 */
#sample4_postcode {
    width: 100px;  /* 우편번호는 짧게 */
}
/*개인정보 수정 컨테이너의 위치*/
#enroll-container {
	margin-top : 20px;
	margin-left : 40px;
}
</style>

	<!-- jQuery 주소로 로드 / 파일로 로드시 현재 오류 발생 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<!-- 다음 우편번호 서비스 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- path 변수 이용 -->
	<c:set var="path" value="${pageContext.request.contextPath }" />
	<script> const contextPath = "${pageContext.request.contextPath}";	</script> <!-- EL -->
	<!-- 사용자 정의 JS 파일 로드 -->
	<script src="${pageContext.request.contextPath}/resources/js/enroll/enrollMember.js"></script>

<section id=enroll-container>
		<h2>개인정보 수정</h2>
		<!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
		<!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
		<form action="${path}/member/update" method="post"
			onsubmit="return fn_invalidate2();">
			<table>
				<tr>
					<th>이메일 *</th>
					<td>
						<input type="text" name="emailId" id="emailId2" value="${loginMember.email}" style="width: 325px;" readonly>
					</td> 
				<tr>
					<th>패스워드 *</th>
					<td><input type="password" name="memberPw" id="password_" placeholder="대소문자, 숫자, 특수문자 포함" required><br>
					</td>
				</tr>
				<tr>
					<th>패스워드확인 *</th>
					<td><input type="password" id="password_2" required><br>
						<span id="checkResult"></span></td>
				</tr>
				<tr>
					<th>이름 *</th>
					<td><input type="text" name="memberName" id="userName" value="${loginMember.memberName}" readonly><br>
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" name="memberNick" id="memberNick" style="width:325px;" value="${loginMember.memberNick}"><br>
					</td>
				</tr>
				<tr>
				    <th>자녀 학교</th>
				    <td>
				        <div style="margin-bottom:10px">
				            <select class="child_school" name="region" id="region" onchange="districtSearch(event);" style="width:108px">
				            	<c:if test="${loginMember.childSchool!=null}"> 
				                <option value="${loginMember.childSchool.region}"></option></c:if>
				                <option value="서울">서울</option>
				                <option value="경기">경기</option>
								<option value="인천">인천</option>
								<option value="부산">부산</option>
								<option value="세종">세종</option>
								<option value="광주">광주</option>
								<option value="대구">대구</option>
								<option value="대전">대전</option>
								<option value="울산">울산</option>
								<option value="강원">강원</option>
								<option value="충남">충남</option>
								<option value="충북">충북</option>
								<option value="경남">경남</option>
								<option value="경북">경북</option>
								<option value="전남">전남</option>
								<option value="전북">전북</option>
								<option value="제주">제주</option>
				            </select>
				            <select class="child_school" id="district" onchange="schoolSearch(event);" style="width:88px">
				            	<c:if test="${loginMember.childSchool!=null}"> 
				                <option value="${loginMember.childSchool.district}"></option></c:if>
				                <option value=''>구/군</option>
				            </select>
				            <select class="child_school" id="school-type" onchange="schoolSearch({target:document.getElementById('district')});" style="width:108px">
				                <c:if test="${loginMember.childSchool!=null}"> 
				                <option value="${loginMember.childSchool.schoolType}"></option></c:if>
				                <option value="">초중고</option>
				                <option value="초등학교">초등학교</option>
				                <option value="중학교">중학교</option>
				                <option value="고등학교">고등학교</option>
				                <option value="고등학교">기타학교</option>
				            </select>
				            <!-- name에 standardCode 를 입력하여 회원정보에는 학교 코드가 저장되도록 설정 -->
				            <select class="child_school" id="school-name" name="schoolNo" style="width:186px">
				            	<c:if test="${loginMember.childSchool!=null}"> 
				                <option value="${loginMember.childSchool.schoolName}"></option></c:if>
				                <option value="">학교명</option>
				            </select>
				        </div>
				    </td>
				</tr>
			</table>
			<div class="enrollsubmit">
				<input type="submit" id="save" value="저장"> <input type="button" id="cancle" value="취소">
			</div>
		</form>
	</section>
	<script>
	//취소 누를시 메인으로 가는 기능
	$("#cancle").click(function() {
		location.assign("${path}/home");
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />