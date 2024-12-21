/**
 * enrollMember.jsp 에서 회원가입 관련 로직을 처리하기 위한 스크립트 제공
 */

$(document).ready(function() {
    initializeEventListeners();
});

// 모든 이벤트 리스너 초기화
function initializeEventListeners() {
    $(".logo-container").click(() => location.assign(contextPath));
    $("#register-button").click(() => location.assign(`${contextPath}/member/enrollmember.do`));
    $("#emailSelect").change(handleEmailSelect);
    $("#btn_checkDuplicate").click(checkDuplicate);
    $("#password_2").keyup(validatePasswordMatch);
    $("#emailCheckBtn").click(checkEmail);
    $("#postcodeFindBtn").click(sample4_execDaumPostcode);
}

// 이메일 도메인 선택 처리
function handleEmailSelect() {
    const domainInput = $("#emailDomain");
    const domainSelect = $("#emailSelect");
    
    if(domainSelect.val() === '') {
        domainInput.val('').prop('readonly', false);
    } else {
        domainInput.val(domainSelect.val()).prop('readonly', true);
    }
}

// 회원가입 폼 유효성 검사
function fn_invalidate() {
    const userId = $("#userId_").val();
    if(userId.length < 4) {
        alert("아이디는 4글자 이상 입력해 주세요.");
        $("#userId_").focus();
        return false;
    }
    
    const passwordReg = /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,}/;
    const password = $("#password_").val();
    if(!passwordReg.test(password)) {
        alert("비밀번호는 영문자,숫자,특수기호(!@#$%^&*())를 포함한 8글자 이상으로 입력해 주세요");
        return false;
    }
    return true;
}

// 비밀번호 일치 확인
function validatePasswordMatch(e) {
    const password = $("#password_").val();
    const passwordcheck = $(e.target).val();
    const $span = $("#checkResult");
    
    if(password.length >= 4 && passwordcheck.length >= 4) {
        if(password === passwordcheck) {
            $span.text("비밀번호가 일치합니다.").css("color", "green");
            $("input[value='가입']").prop("disabled", false);
        } else {
            $span.text("비밀번호가 일치하지 않습니다.").css("color", "red");
            $("input[value='가입']").prop("disabled", true);
        }
    }
}

// 아이디 중복 확인
function checkDuplicate() {
    const inputId = $("#userId_").val();
    window.open(
        `${contextPath}/member/idduplicate.do?id=${inputId}`,
        "_blank",
        "width=300,height=200"
    );
}

// 이메일 유효성 검사
function validateEmail() {
    const emailId = $("#emailId").val();
    const emailDomain = $("#emailDomain").val();
    const fullEmail = emailId + '@' + emailDomain;
    
    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return emailPattern.test(fullEmail);
}

// 이메일 인증 처리
function checkEmail() {
    const emailId = $("#emailId").val();
    const emailDomain = $("#emailDomain").val();
    const email = encodeURIComponent(emailId + '@' + emailDomain);
    
    if(!emailId || !emailDomain) {
        alert("이메일을 입력해주세요.");
        return;
    }
    
    if(!validateEmail()) {
        alert("유효한 이메일 형식이 아닙니다.");
        return;
    }
    
    window.open(
        `${contextPath}/check/email.do?email=${email}`,
        "emailVerify",
        "width=400,height=300,left=500,top=200"
    );
}

// 우편번호 검색
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            const roadAddr = data.roadAddress;
            let extraRoadAddr = '';

            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if(data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            
            // 우편번호와 주소 정보 입력
            $("#sample4_postcode").val(data.zonecode);
            $("#sample4_roadAddress").val(roadAddr);
            $("#sample4_detailAddress").val('');

            // 안내 텍스트 처리
            const $guide = $("#guide");
            if(data.autoRoadAddress) {
                $guide.html('(예상 도로명 주소 : ' + data.autoRoadAddress + extraRoadAddr + ')').show();
            } else {
                $guide.html('').hide();
            }
        }
    }).open();
}


/* 지역 선택시 해당 지역의 구/군 목록을 가져오는 함수 */
function districtSearch(e) {
    const select = $("#district");
    select.html("<option value=''>구/군</option>");
    const region = $(e.target).val();
    
    if(!region) return;
    
    $.ajax({
        url: `${contextPath}/post/district`,
        type: "GET",
        data: { region: region },
        success: function(data) {
            data.forEach(district => {
                const option = $("<option>")
                    .val(district)
                    .text(district);
                select.append(option);
            });
        },
        error: function(error) {
            console.error("Error: ", error);
        }
    });
}

/* 구/군 선택시 해당 지역의 학교 목록을 가져오는 함수 */
function schoolSearch(e) {
    const select = $("#school-name");
    select.html("<option value=''>학교명</option>");
    const district = $(e.target).val();
    const schoolType = $("#school-type").val();
	
	console.log(district,schoolType);
    
    if(!district || !schoolType) return;
    
    $.ajax({
        url: `${contextPath}/school/selectchildschool`,
        type: "GET",
        data: { 
            district: district,
            schoolType: schoolType 
        },
        success: function(data) {
			console.log('Received data:', data);  // 데이터 구조 확인
            data.forEach(school => {
				// option의 value는 standardCode, 화면에 표시되는 텍스트는 schoolName
                const option = $("<option>")
					.val(school.standardCode)  // 실제 서버에 전송될 값 학교 코드를 value로
					.text(school.schoolName);  // 사용자에게 보여질 텍스트 학교 이름을 표시 텍스트로
                select.append(option);
            });
        },
        error: function(error) {
            console.error("Error: ", error);
        }
    });
}