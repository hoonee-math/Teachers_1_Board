<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/post/uploadPost.css">

<!--     <style>
        body {
          font-family: Arial, sans-serif;
          margin: 20px;
        }
        div#post-container {
        	display: flex;
        	flex-direction: column;
      		justify-content: center;
          	gap: 10px;
          	margin: 0 auto;
          	padding: 20px;
        }
        .dropdown {
          display: flex;
          gap: 10px;
        }
        select {
          padding: 5px;
          font-size: 16px;
        }
        #sido {
            width: 125px;
            border: 1px solid #FFB6C1;
		    border-radius: 5px;
		    background-color: #ffffff;
		    color: #FF69B4;
        }
        #gungu {
            width: 125px;
            border: 1px solid #FFB6C1;
		    border-radius: 5px;
		    background-color: #ffffff;
		    color: #FF69B4;
        }
        #school-name {
            width: 225px;
            border: 1px solid #FFB6C1;
		    border-radius: 5px;
		    background-color: #ffffff;
		    color: #FF69B4;
        }
        
        #category {
        	display: flex;
        	align-items: center;
          	gap: 10px;
        }
       	#category select {
       		width: 430px;
       		border: 1px solid #FFB6C1;
		    border-radius: 5px;
		    background-color: #ffffff;
		    color: #FF69B4;
       	}

        div#board-container {
            display: flex;
            flex-direction: column;
        }
        div#board-container div {
        	display: flex;
        	flex-direction: row;
        }
        div#button-container{
        	display: flex;
        	justify-content: space-between;
        	
        }
        div#button-container button {
        	border: 1px solid #FFB6C1;
		    border-radius: 5px;
		    background-color: #ffffff;
		    color: #FF69B4;
        }
      </style> -->
</head>
<body>
	<div id="post-container">
		<h2>게시글 작성</h2>
	    
	    <div id='board-container'>
	    	<form action='' >
	    		<table>
	    			<tr id="school-container">
	    				<td>
	    					<select id="sido">
	          					<option value="">전체지역</option>
	       					 </select>
	    				</td>
	    				<td>
	    					<select id="gungu">
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
	    					<input type="file" name="upfile"/>
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
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>