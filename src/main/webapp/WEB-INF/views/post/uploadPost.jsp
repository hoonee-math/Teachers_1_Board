<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/post/uploadPost.css">
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<section class="main-content col-9">
	<div id="post-container" class="col-12">
		<h2>게시글 작성</h2>
	    
	    <div id='board-container'>
	    	<form action='${path }/post/uploadpost' method="post" enctype="multipart/form-data" >
	    		<table>
	    			<tr id="school-container">
	    				<td>
	    					<select name="region" id="region" onchange="districtSearch(event);">
								<option value=''>전체지역</option>
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
	    				</td>
	    				<td>
	    					<select id="district" onchange="schoolSearch(event);">
	          					<option value=''>구/군</option>
	        				</select>
	    				</td>
	    				<td>
	    					<select id="school-name">
	          					<option value="">학교명</option>
	        				</select>
	    				</td>
	    			</tr>
	    			<tr id="category">
	    				<th>카테고리</th>
	    				<td colspan="2">
	    					<select>
	    						<option value="">카테고리 선택</option>
	    					</select>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>제목</th>
	    				<td colspan="2">
	    					<input type="text" name="boardTitle"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>작성자</th>
	    				<td colspan="2">
	    					<input type="text" name="boardWriter"
									value="${sessionScope.loginMember.userNick }" readOnly/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>첨부파일</th>
	    				<td colspan="2">
	    					<input type="file" id="upfile" multiple accept="image/*"/>
	    					<div id="preview"></div>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>내용</th>
	    				<td colspan="2">
	    					<textarea  rows="5" name="boardContent" style="resize:none"></textarea>
	    				</td>
	    			</tr>
	    		</table>
	    	</form>
	    </div>
	    <div id="button-container">
	    	<div class="right">
	    		<input type="submit" value="저장"> <input type="submit" value="등록">
		    </div>
	    </div>
	 </div>
<section class="right-box col-1"></section>
</section>
</main>

<script>
	$("#upfile").change(e=>{
		$("preview").html('');
		$.each($(e.target)[0].files,(i,file)=>{
			const fileReader = new FileReader();
			fileReader.readAsDataURL(file);
			fileReader.onload=e=>{
				const path = e.target.result;
				const $img = $("<img>").attr({
					src:path,
					height:"400px",
				});
				$("#preview").append($img);
			}
		})
	});
	
	function districtSearch(e) {
		const select = document.getElementById("district");
		select.innerHTML="<option value=''>구/군</option>";
		const region=e.target.value;
		fetch("${path}/post/district?region=" + region)
			.then(response => response.json())
			.then(data => {
				data.forEach(district => {
					const option = document.createElement("option");
					option.value = district;
					option.textContent = district;
					select.appendChild(option);
				});
			})
			.catch(error => console.error("Error : ",error));
	}
	
	function schoolSearch(e) {
		const select = document.getElementById("school-name");
		select.innerHTML="<option value=''>학교명</option>";
		const district = e.target.value;
		fetch("${path}/post/school?district=" + district)
			.then(response => response.json())
			.then(data => {
				data.forEach(school => {
					const option = document.createElement("option");
					option.value = school;
					option.textContent = school;
					select.appendChild(option);
				});
			})
			.catch(error => console.error("Error : ",error));
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>