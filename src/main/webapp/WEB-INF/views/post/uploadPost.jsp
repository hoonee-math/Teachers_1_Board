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
	    					<select id="region">
	          					<option value="">전체지역</option>
	          					<%
	          					System.out.println("Attribute regions : " + request.getAttribute("regions"));
	          					List<String> regions = Arrays.asList((String)request.getAttribute("regions"));
	          					//List<String> regions = (List<String>)request.getAttribute("regions");
	          					System.out.println("regions : " + regions);
	          					if(regions != null) {
	          						for (String region : regions) {
	    	          					System.out.println("region : " + region);

	          					%>
	          							<option value="<%= region %>"><%= region %></option>
	          					<%
	          						}
	          					}
	          					%>
	       					 </select>
	    				</td>
	    				<td>
	    					<select id="district">
	          					<option value="">구/군</option>
	        				</select>
	    				</td>
	    				<td>
	    					<select id="school-name">
	          					<option value="">학교/학원명</option>
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

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>