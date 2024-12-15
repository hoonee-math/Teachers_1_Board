<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enrollMember.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>맘스티쳐</title>

  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column;
    }

    .main-header {
      display: none;
    }

    .menu {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 20px;
      background-color: #FFE4E1;
    }

    .menu .logo-container {
      display: flex;
      align-items: center;
      padding: 10px;
      background-color: #FFE4E1;
      border-radius: 5px;
    }

    .menu .logo {
      width: 40px;
      height: auto;
    }

    .menu .logo-text {
      margin-left: 10px;
      font-size: 20px;
      font-weight: bold;
      color: #FF69B4;
    }

    .menu .left-section {
      display: flex;
      gap: 5px; 
      margin-right: auto;
      align-items: center;
    }

    .menu .left-section div {
      cursor: pointer;
      padding: 10px 15px;
      border: 1px solid #FFB6C1;
      border-radius: 5px;
      background-color: #ffffff;
      color: #FF69B4;
      text-align: center;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    .menu .left-section div:hover {
      background-color: #FFB6C1;
      color: #ffffff;
    }

    .menu .right-section {
      display: flex;
      align-items: flex-end;
      justify-content: flex-end;
      flex: 1;
      gap: 10px;
    }

    .search-box {
      display: flex;
      align-items: center;
      border: 1px solid #FFB6C1;
      border-radius: 5px;
      background-color: #ffffff;
      padding: 5px 30px;
      width: 350px;
      margin-left: 20px;
    }

    .search-box input {
      flex: 1;
      border: none;
      outline: none;
      padding: 5px;
      font-size: 16px;
    }

    #register-button {
      margin-left: 1px;
      padding: 5px 15px;
      background-color: #FF69B4;
      color: #ffffff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.3s;
    }

    #register-button:hover {
      background-color: #FFB6C1;
    }
  </style>
</head>
<body>
  <div class="menu">
    <div class="logo-container">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" class="logo">
        <ellipse cx="150" cy="100" rx="140" ry="80" fill="#FFE4E1"/>
        <path d="M100 50 L200 50 C210 50 210 150 200 150 L100 150 C90 150 90 50 100 50" fill="#FFF5EE"/>
        <path d="M110 60 L190 60 M110 80 L190 80 M110 100 L190 100 M110 120 L190 120 M110 140 L190 140" stroke="#FFB6C1" stroke-width="2"/>
        <path d="M180 40 C180 40 175 35 170 40 C165 45 170 55 170 55 L180 65 L190 55 C190 55 195 45 190 40 C185 35 180 40 180 40" fill="#FF69B4"/>
        <path d="M85 90 C85 80 95 70 105 70 C115 70 125 80 125 90 M95 95 C95 85 105 75 115 75" stroke="#FF69B4" stroke-width="3" fill="none" stroke-linecap="round"/>
        <path d="M70 110 L80 110 M90 110 L100 110 M110 110 L120 110" stroke="#FFB6C1" stroke-width="2" stroke-dasharray="2,3"/>
      </svg>
      <span class="logo-text">맘스티쳐</span>
    </div>
    <div class="left-section">
    </div>
    <div class="right-section">
      <button id="register-button">회원가입</button>
    </div>
  </div>


<section id=enroll-container>
        <h2>회원 가입 정보 입력</h2>
        <!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
        <!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
        <form action="${path}/member/enrollmemberend.do" method="post" onsubmit="return fn_invalidate();" >
        <table>
			<tr>
			    <th>이메일</th>
			    <td>    
			        <input type="text" name="emailId" id="emailId" style="width: 150px;"> @
			        <input type="text" name="emailDomain" id="emailDomain" style="width: 150px;">
			        <select name="emailSelect" id="emailSelect" onchange="handleEmailSelect()">
			            <option value="">직접입력</option>
			            <option value="gmail.com">gmail.com</option>
			            <option value="naver.com">naver.com</option>
			            <option value="daum.net">daum.net</option>
			            <option value="hanmail.net">hanmail.net</option>
			            <option value="nate.com">nate.com</option>
			        </select>
			        <input type="button" value="이메일 인증" onclick="checkEmail()">
			    </td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" placeholder="4글자이상" name="userId" id="userId_" >
					<input type="button" value="중복확인" onclick="checkDuplicate()">
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="password" id="password_" ><br>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" id="password_2" ><br>
					<span id="checkResult"></span>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
				<input type="text"  name="userName" id="userName" ><br>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>	
				<input type="number" name="age" id="age"><br>
				</td>
			</tr> 
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" placeholder="" name="address" id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M">
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동"><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산"><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서"><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임"><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행"><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
        </form>
    </section>
    
    <script>
    	document.getElementById("register-button").addEventListener("click",()=>{
    		location.assign("${path}/member/enrollmember.do")
    	})
    	
    	// 이메일 도메인 선택 시 처리하는 함수
		function handleEmailSelect() {
		    const domainInput = document.getElementById('emailDomain');
		    const domainSelect = document.getElementById('emailSelect');
		    
		    if(domainSelect.value === '') {
		        // 직접입력 선택 시
		        domainInput.value = '';
		        domainInput.readOnly = false;
		    } else {
		        // 도메인 선택 시
		        domainInput.value = domainSelect.value;
		        domainInput.readOnly = true;
		    }
		}
    	
    	const fn_invalidate=()=>{
    		const userId=document.querySelector("#userId_").value;
    		if(userId.length<4){
    			alert("아이디는 4글자 이상 입력해 주세요.");
    			document.querySelector("#userId_").focus();
    			return false;
    		}
    		const passwordReg=/(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,}/;
    		const password=document.querySelector("#password_").value;
    		if(!passwordReg.test(password)){
    			alert("비밀번호는 영문자,숫자,특수기호(!@#$%^&*())를 포함한 8글자 이상으로 입력해 주세요");
    			return false;
    		}
    	}
    	
    	
    	document.querySelector("#password_2").addEventListener("keyup",e=>{
    		const password=document.querySelector("#password_").value;
    		/* 현재 이벤트가 발생한 객체를 불러올 때, e.target 사용함! */
    		const passwordcheck=e.target.value;
   			const $span=document.querySelector("#checkResult");
   			if(password.length>=4 && passwordcheck.length>=4){
	    		if(password==passwordcheck){
	    			$span.innerText="비밀번호가 일치합니다.";
	    			$span.style.color = "green";   
	    			document.querySelector("input[value='가입']").disabled=false;
	    		} else{
	    			$span.innerText="비밀버호가 일치하지 않습니다.";
	    			$span.style.color = "red"; 
	    			document.querySelector("input[value='가입']").disabled=true;
	    		}
   			}
    	});
    	
    	const checkDuplicate=(e)=>{
    		const inputId=$("#userId_").val(); 

    		open("${path}/member/idduplicate.do?id="+inputId,"_blank","width=300,height=200");
    	}
    	
		// 이메일 유효성 검사 함수 (필요시 사용)
		function validateEmail() {
		    const emailId = document.getElementById('emailId').value;
		    const emailDomain = document.getElementById('emailDomain').value;
		    const fullEmail = emailId + '@' + emailDomain;
		    
		    // 이메일 정규식 패턴
		    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
		    
		    return emailPattern.test(fullEmail);
		}
		const checkEmail = (e) => {
		    const emailId = $("#emailId").val();
		    const emailDomain = $("#emailDomain").val();
		    const fullEmail = emailId + '@' + emailDomain;
		    
		    if(emailId.trim() === "" || emailDomain.trim() === "") {
		        alert("이메일을 입력해주세요.");
		        return;
		    }
		    
		    // 이메일 유효성 검사 추가
		    if(!validateEmail()) {
		        alert("유효한 이메일 형식이 아닙니다.");
		        return;
		    }
		    
		    window.open(
		        "${path}/check/email.do?email=" + fullEmail,
		        "emailVerify",
		        "width=400,height=300,left=500,top=200"
		    );
		}
    	
    </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

