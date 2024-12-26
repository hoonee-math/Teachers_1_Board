<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/enroll/enrollMember.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/enroll/enrollHeader.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
#bodycontainer {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height : 80%;
}
.logocenter {
  margin-bottom: 20px;
}
.question {
  font-size: 24px;
  margin-bottom: 30px;
}
.options {
  display: flex;
  gap: 20px;
}
.option {
  width: 150px;
  height: 100px;
  background-color: #E0E0E0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: bold;
  cursor: pointer;
  border: 1px solid #D3D3D3;
  border-radius: 8px;
  transition: background-color 0.3s, transform 0.3s;
}
.option:hover {
  background-color: #D9776A;;
  transform: scale(1.05);
}
</style>
<header>
	<div class="menu">
		<div class="logo-container">
			<jsp:include page="/WEB-INF/views/common/logo2.jsp"/>
			<span class="logo-text">맘스티쳐</span>
			<jsp:include page="/WEB-INF/views/common/logo2.jsp"/>
		</div>
	</div>
</header>
<body></body>
<div id="bodycontainer">
  <div class="logocenter">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" width="200" height="150">
      <ellipse cx="150" cy="100" rx="140" ry="80" fill="#FFE4E1"/>
      <path d="M100 50 L200 50 C210 50 210 150 200 150 L100 150 C90 150 90 50 100 50"
            fill="#FFF5EE"/>
      <path d="M110 60 L190 60 M110 80 L190 80 M110 100 L190 100 M110 120 L190 120 M110 140 L190 140"
            stroke="#FFB6C1"
            stroke-width="2"/>
      <path d="M180 40 C180 40 175 35 170 40 C165 45 170 55 170 55 L180 65 L190 55 C190 55 195 45 190 40 C185 35 180 40 180 40"
            fill="#FF69B4"/>
      <path d="M85 90 C85 80 95 70 105 70 C115 70 125 80 125 90 M95 95 C95 85 105 75 115 75"
            stroke="#FF69B4"
            stroke-width="3"
            fill="none"
            stroke-linecap="round"/>
      <path d="M70 110 L80 110 M90 110 L100 110 M110 110 L120 110"
            stroke="#FFB6C1"
            stroke-width="2"
            stroke-dasharray="2,3"/>
    </svg>
  </div>

  <div class="question">학부모/교사 선택해주세요 :)</div>
<form name="memberForm" action="${path}/member/enroll" method="post">
  <div class="options">
    <div class="option" onclick="selectOption('학부모')">학부모</div>
    <div class="option" onclick="selectOption('교사')">교사</div>
  </div>
</form>
</div>
</body>
  <script>
  $(document).ready(function() {
	    $(".option").click(function() {
	        // 선택된 타입에 따른 값 설정
	        const selectedType = $(this).text() === "학부모" ? "1" : "2";
	        
	        // form의 hidden input 초기화 후 추가
	        $("input[name='memberType']").remove();
	        $("form[name='memberForm']").append("<input type='hidden' name='memberType' value='" + selectedType + "'>");
	        $("form[name='memberForm']").submit();
	    });
	});
  
  </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />