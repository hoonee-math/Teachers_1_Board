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
<style>
.file-input-hidden {
    position: absolute;
    visibility: hidden;
}
</style>
<section class="main-content col-9">
	<div id="post-container" class="col-12">
		<h2>게시글 작성</h2>
	    
	    <div id='board-container'>
	    	<form action='${path }/post/uploadpostend' id="mainForm" method="post" enctype="multipart/form-data" >
	    		<table>
	    			<tr id="category">
	    				<th>카테고리</th>
	    				<td colspan="2">
	    					<select name="categoryNo" id="selector">
	    						<option value="">카테고리 선택</option>
	    						<option value="1">맘스뉴스</option>
	    						<option value="2">고민상담소</option>
	    						<option value="4">초등 게시판</option>
	    						<option value="5">중등 게시판</option>
	    						<option value="6">고등 게시판</option>
	    						<option value="7">고3/n수생 게시판</option>
	    						<option value="8">지역별 게시판</option>
	    						<option value="9">학교별 게시판</option>
	    						<option value="10">자유게시판</option>
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
	    					<select name="district" id="district" onchange="schoolSearch(event);">
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
	    					<select name="schoolName" id="school-name">
	          					<option value="">학교명</option>
	        				</select>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>제목</th>
	    				<td>
	    					<input type="text" name="postTitle"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>작성자</th>
	    				<td>
	    					<input type="text" name="postWriter"
									value="${sessionScope.loginMember.memberName }" readOnly/>
	    				</td>
	    				<td>
	    					<input type="hidden" name="memberNo" 
	    							value="${sessionScope.loginMember.memberNo }"/>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>첨부파일</th>
	    				<td>
	    					<div class="file-upload-wrapper">
							    <input type="file" id="upfile" multiple accept="image/*"/>
							    <div id="preview"></div>
							    <div id="file-inputs-container"></div> <!-- 실제 파일 input들이 들어갈 컨테이너 -->
							</div>
	    				</td>
	    			</tr>
	    			<tr>
	    				<th>내용</th>
	    				<td>
	    					<textarea  rows="10" name="postContent" style="resize:none"></textarea>
	    				</td>
	    			</tr>
	    		</table>
			    <div id="button-container">
			    	<div class="right">
			    		<button name="save">
			    			임시저장
							<input type="hidden" name="saveStatus" value="1"/>
							<input type="hidden" name="savePublic" value="0"/>
			    		</button>
			    		<button name="submit">
			    			등록
							<input type="hidden" name="submitStatus" value="1"/>
							<input type="hidden" name="submitPublic" value="0"/>
			    		</button>
				    </div>
			    </div>
			    <input type="hidden" name="postNo" value="${post.postNo }"/>
	    	</form>
	    </div>
	 </div>

</section>

<script>
	/* 전체지역 선택시 선택값에 맞는 구/군 출력 */
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
	};
	/* 구/군 및 초중고 선택시, 선택값에 맞는 학교명 출력 */
	function schoolSearch(e) {
		const select = document.getElementById("school-name");
		select.innerHTML="<option value=''>학교명</option>";
		const district = e.target.value;
		const schoolName = document.getElementById("school-type").value;
		fetch("${path}/post/school?district=" + district + "&schoolType=" + schoolName)
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
	};
	/* 카테고리 선택에 따라 지역,학교 선택칸 출력 */
	const selector = document.getElementById("selector");
	
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
	});
	/* 파일 업로드시, 프리뷰 사진 출력 */
	$("#upfile").change(e=>{
	    const files = e.target.files;
        // 3. 이미지 정보 처리
        List<Image1> images = createImagesFromUpload(mr);
		$("#preview").html('');
	    $("#file-inputs-container").html('');
	    
	    // 파일별 preview 생성 및 hidden input 추가
	    $.each(files, (i, file) => {
	        console.log(`파일 ${i} 정보:`, file.name); // 각 파일 이름 출력
	        // 프리뷰 생성
	        const fileReader = new FileReader();
	        fileReader.readAsDataURL(file);
	        fileReader.onload = e => {
	            const path = e.target.result;
	            const $img = $("<img>").attr({
	                src: path,
	                height: "200px",
	            });
	            $("#preview").append($img);
	        }
	        
	        // 각 파일에 대한 개별 input 생성
	        const formData = new FormData();
	        formData.append(`upfile${i}`, file);
	        
	        const input = $("<input>").attr({
	            type: "file",
	            name: `upfile${i}`,
	            class: "file-input-hidden"
	        }).hide();
	        
	        // 파일 객체를 input에 할당
	        const dataTransfer = new DataTransfer();
	        dataTransfer.items.add(file);
	        input[0].files = dataTransfer.files;
	        
	        $("#file-inputs-container").append(input);
	        console.log(`input ${i} 생성 완료:`, input[0].name); // 생성된 input 확인
	    });

	    // 폼 전송 직전에 전체 input 확인
	    $("#mainForm").on('submit', function(e) {
	        console.log("폼 전송 시 input 개수:", $("#file-inputs-container input").length);
	        $("#file-inputs-container input").each(function(i, input) {
	            console.log(`전송될 input ${i}:`, input.name, input.files[0]?.name);
	        });
	    });
	});
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>