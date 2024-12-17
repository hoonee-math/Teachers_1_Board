<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="path" value="${pageContext.request.contextPath }" />
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enroll/enrollMember.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enroll/enrollHeader.css">

<!DOCTYPE html>
<html></html>
<head>
<meta charset="UTF-8">
<title>맘스티쳐</title>
</head>
<body>
	<div class="menu">
		<div class="logo-container">
			<jsp:include page="/WEB-INF/views/common/logo.jsp"/>
			<span class="logo-text">맘스티쳐</span>
		</div>
		<div class="left-section"></div>
		<div class="right-section">
			<button id="register-button">회원가입</button>
		</div>
	</div>


	<section id=enroll-container>
		<h2>회원 가입 정보 입력</h2>
		<!-- onsubmit 발생했을 때 action 속성을 이용해 enrollmemberend.do 로 post 요청. onsubmit 속성을 통해 유효성검사 실시-->
		<!-- onsubmit 값의 return 값이 true 일때 post 로 요청! -->
		<form action="${path}/member/enrollmemberend.do" method="post"
			onsubmit="return fn_invalidate();">
			<table>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="emailId" id="emailId"
						style="width: 150px;"> @ <input type="text"
						name="emailDomain" id="emailDomain" style="width: 150px;">
						<select name="emailSelect" id="emailSelect"
						onchange="handleEmailSelect()">
							<option value="">직접입력</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
					</select> <input type="button" value="이메일 인증" onclick="checkEmail()">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" placeholder="4글자이상" name="userId"
						id="userId_"> <input type="button" value="중복확인"
						onclick="checkDuplicate()"></td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="password" name="password" id="password_"><br>
					</td>
				</tr>
				<tr>
					<th>패스워드확인</th>
					<td><input type="password" id="password_2"><br>
						<span id="checkResult"></span></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName" id="userName"><br>
					</td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="number" name="age" id="age"><br>
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="tel" placeholder="(-없이)01012345678"
						name="phone" id="phone" maxlength="11" required><br>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" placeholder="" name="address"
						id="address"><br></td>
				</tr>
				<tr>
					<th>성별</th>
					<td><input type="radio" name="gender" id="gender0" value="M">
						<label for="gender0">남</label> <input type="radio" name="gender"
						id="gender1" value="F"> <label for="gender1">여</label></td>
				</tr>
				<tr>
					<th>취미</th>
					<td><input type="checkbox" name="hobby" id="hobby0" value="운동"><label
						for="hobby0">운동</label> <input type="checkbox" name="hobby"
						id="hobby1" value="등산"><label for="hobby1">등산</label> <input
						type="checkbox" name="hobby" id="hobby2" value="독서"><label
						for="hobby2">독서</label><br /> <input type="checkbox" name="hobby"
						id="hobby3" value="게임"><label for="hobby3">게임</label> <input
						type="checkbox" name="hobby" id="hobby4" value="여행"><label
						for="hobby4">여행</label><br /></td>
				</tr>
			</table>
			<input type="submit" value="가입"> <input type="reset"
				value="취소">
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
		    const email = emailId + '@' + emailDomain;
		    
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
		        "${path}/check/email.do?email=" + email,
		        "emailVerify",
		        "width=400,height=300,left=500,top=200"
		    );
		}
    	
    </script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />