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
	    			<tr id="category">
	    				<th>카테고리</th>
	    				<td colspan="2">
	    					<select id="selector">
	    						<option value="">카테고리 선택</option>
	    						<option value="news">맘스뉴스</option>
	    						<option value="dontworry">고민상담소</option>
	    						<option value="elementary">초등 게시판</option>
	    						<option value="middle">중등 게시판</option>
	    						<option value="high">고등 게시판</option>
	    						<option value="senior">고3/n수생 게시판</option>
	    						<option value="region">지역별 게시판</option>
	    						<option value="school">학교별 게시판</option>
	    					</select>
	    				</td>
	    			</tr>
	    			<tr id="region-container" class="hidden">
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
	    			</tr>
	    			<tr id="school-container" class="hidden">
	    				<td>
	    					<select id="school-type" onchange="schoolSearch({target:document.getElementById('district')});">
	    						<option value="">초중고</option>
	    						<option value="초등학교">초등학교</option>
	    						<option value="중학교">중학교</option>
	    						<option value="고등학교">고등학교</option>
	    					</select>
	    				<td>
	    					<select id="school-name">
	          					<option value="">학교명</option>
	        				</select>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>제목</th>
	    				<td>
	    					<input type="text" name="boardTitle"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>작성자</th>
	    				<td>
	    					<input type="text" name="boardWriter"
									value="${sessionScope.loginMember.userNick }" readOnly/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>첨부파일</th>
	    				<td>
	    					<input type="file" id="upfile" multiple accept="image/*"/>
	    					<div id="preview"></div>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>내용</th>
	    				<td>
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
		const schoolType = document.getElementById("school-type").value;
		fetch("${path}/post/school?district=" + district + "&schoolType=" + schoolType)
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
	
	const selector = document.getElementById("selector");
	//const region = document.getElementById("region-container");
	//const school = document.getElementById("school-container");
	
	selector.addEventListener("change", function() {
		const val = selector.value;
		if(val==="region") {
			$("#region-container").removeClass("hidden");
			$("#school-container").addClass("hidden");
		} else if (val==="school") {
			$("#school-container").removeClass("hidden");
			$("#region-container").removeClass("hidden");
		} else {
			$("#region-container").addClass("hidden");
			$("#school-container").addClass("hidden");
		}
	})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>