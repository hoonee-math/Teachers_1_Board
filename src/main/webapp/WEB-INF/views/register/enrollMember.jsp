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

<style>
/* 입력 필드 초기화 */
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

</style>

</head>
<body>
	<div class="menu">
		<div class="logo-container">
			<jsp:include page="/WEB-INF/views/common/logo2.jsp"/>
			<span class="logo-text">맘스티쳐</span>
			<jsp:include page="/WEB-INF/views/common/logo2.jsp"/>
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
					<td>
						<input type="text" name="emailId" id="emailId" style="width: 150px;"> 
						@ <input type="text" name="emailDomain" id="emailDomain" style="width: 150px;">
						<select name="emailSelect" id="emailSelect" onchange="handleEmailSelect()">
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
					<td><input type="password" name="password" id="password_" placeholder="대소문자, 숫자, 특수문자 포함"><br>
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
					<td>
						<div style="margin-bottom:10px">
						<input type="text" id="sample4_postcode" placeholder="우편번호">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						</div>
						<div>
						<input type="text" id="sample4_roadAddress" placeholder="도로명주소" style="width: 300px;">
						<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width: 300px;"> -->
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" placeholder="상세주소" style="width: 200px;">
						<!-- <input type="text" id="sample4_extraAddress" placeholder="참고항목" style="width: 150px;"> -->
						</div>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td><input type="radio" name="gender" id="gender0" value="M">
						<label for="gender0">남</label> <input type="radio" name="gender"
						id="gender1" value="F"> <label for="gender1">여</label></td>
				</tr>
				<!-- <tr>
					<th>취미</th>
					<td>
						<input type="checkbox" name="hobby" id="hobby0" value="운동"><label for="hobby0">운동</label> 
						<input type="checkbox" name="hobby" id="hobby1" value="등산"><label for="hobby1">등산</label> 
						<input type="checkbox" name="hobby" id="hobby2" value="독서"><label for="hobby2">독서</label><br/> 
						<input type="checkbox" name="hobby" id="hobby3" value="게임"><label for="hobby3">게임</label> 
						<input type="checkbox" name="hobby" id="hobby4" value="여행"><label for="hobby4">여행</label><br />
					</td>
				</tr> -->
			</table>
			<div class="enrollsubmit">
				<input type="submit" value="가입"> <input type="reset" value="취소">
			</div>
		</form>
	</section>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(".logo-container").click(function() {
			location.assign("${path}");
		})
	
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
    	
    	const findAddress=()=>{
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
    	
    	function sample4_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 참고 항목 변수

                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraRoadAddr !== ''){
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample4_postcode').value = data.zonecode;
                    document.getElementById("sample4_roadAddress").value = roadAddr;
                    document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                    
                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    if(roadAddr !== ''){
                        document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                    } else {
                        document.getElementById("sample4_extraAddress").value = '';
                    }

                    var guideTextBox = document.getElementById("guide");
                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if(data.autoRoadAddress) {
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                        guideTextBox.style.display = 'block';

                    } else if(data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                        guideTextBox.style.display = 'block';
                    } else {
                        guideTextBox.innerHTML = '';
                        guideTextBox.style.display = 'none';
                    }
                }
            }).open();
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