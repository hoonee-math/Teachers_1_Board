<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <style>
        body {
          font-family: Arial, sans-serif;
          margin: 20px;
        }
        div#post-container {
        	display: flex;
        	flex-direction: column;
      		justify-content: center;
      		margin: 0 auto;
          	gap: 10px;
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
            text-align:center;
        }
        div#board-container h2 {
            margin:10px 0;
        }
        table#tbl-board {
            width:500px;
            margin:0 auto;
            border:1px solid black;
            border-collapse:collapse;
        }
        table#tbl-board th {
            width:125px;
            border:1px solid;
            padding:5px 0;
            text-align:center;
        }
        table#tbl-board td {
            border:1px solid;
            padding:5px 0 5px 10px;
            text-align:left;
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
      </style>
</head>
<body>
	<div id="post-container">
		<h2>게시판 작성</h2>
	    <div class="school-container">
	      <div class="dropdown">
	        <select id="sido">
	          <option value="">전체지역</option>
	        </select>
	        <select id="gungu">
	          <option value="">구/군</option>
	        </select>
	        <select id="school-name">
	          <option value="">학교명</option>
	        </select>
	      </div>
	    </div>
	    
	    <div id="category">
	    	<h4>카테고리</h4>
	    	<select>
	    		<option value="">카테고리 선택</option>
	    	</select>
	    </div>
	    
	    <div id="button-container">
	    	<div class="left">
		    	<button id="delete">X</button>
	    	</div>
	    	<div class="right">
		    	<button id="save">저장</button>
		    	<button id="post">등록</button>
		    </div>
	    </div>
	
	    <div id='board-container'>
			<form action='' >
				<table id='tbl-board'>
					<tr>
						<th>제목</th>
						<td><input type="text" name="boardTitle"/></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>
							<input type="text" name="boardWriter"
								value="${sessionScope.loginMember.userId }"
								readOnly/> 
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td><input type="file" name="upfile"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea cols="45" rows=5 name="boardContent" style="resize:none"></textarea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
    <script>
      async function fetchData(endpoint, targetElement) {
        try {
          const response = await fetch(endpoint);
          const data = await response.json();
  
          const selectElement = document.getElementById(targetElement);
          selectElement.innerHTML = `<option value="">전체${targetElement}</option>`;
  
          data.forEach(item => {
            const option = document.createElement('option');
            option.value = item.value;
            option.textContent = item.label;
            selectElement.appendChild(option);
          });
        } catch (error) {
          console.error('데이터를 가져오는 중 오류 발생:', error);
        }
      }
  
      document.addEventListener('DOMContentLoaded', () => {
        fetchData('fetch_regions.php', 'sido');
  
        const regionSelect = document.getElementById('sido');
        regionSelect.addEventListener('change', () => {
          fetchData(`fetch_districts.php?region=${regionSelect.value}`, 'gungu');
        });
  
        const districtSelect = document.getElementById('gungu');
        districtSelect.addEventListener('change', () => {
          fetchData(`fetch_schools.php?district=${districtSelect.value}`, 'school-name');
        });
      });
    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>