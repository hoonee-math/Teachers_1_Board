<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
     <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        /* 전체 컨테이너 */
        #container {
            display: flex;
            align-items: flex-start;
            padding: 20px;
        }

        /* 사이드바 */
   		.sidebar {
	      width: 200px;
	      display: flex;
	      flex-direction: column;
	      padding: 20px;
	      margin-left: 100px;
	    }

	    .sidebar div {
	      margin-bottom: 10px;
	      padding: 10px;
	      border: 1px solid #FFB6C1;
	      border-radius: 5px;
	      background-color: #ffffff;
	      cursor: pointer;
	      text-align: center;
	      color: #FF69B4;
	      font-weight: bold;
	      transition: background-color 0.3s;
	    }
	
	    .sidebar div:hover {
	      background-color: #FFB6C1;
	      color: #ffffff;
	    }
        }

        /* 게시판 컨테이너 */
        #all_board {
            flex: 1;
            max-width: 900px;
        }

        /* 게시판 헤더 */
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .board-header h2 {
            margin: 0;
        }

        /* 게시판 테이블 */
        #tbl-board {
            width: 100%;
            border: 1px solid black;
            border-collapse: collapse;
        }

        #tbl-board th, #tbl-board td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        #tbl-board th {
            background-color: #f2f2f2;
        }

        /* 페이지바 */
        #pageBar {
            margin-top: 10px;
            text-align: center;
            background-color: rgba(0, 188, 212, 0.3);
        }

        /* 글쓰기 버튼 */
        #boardBtn {
            margin-left: 10px;  
        }
    </style>       
 </head>
    <div id="container">
        <!-- 게시판 -->
        <div id="all_board">
            <div class="board-header">
                <h2>게시판</h2>
                <button id="boardBtn" class="btn btn-outline-success">글쓰기</button>
            </div>       
            
            <table id="tbl-board">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
               <tbody>
                    <c:if test="${not empty boards}">
                        <c:forEach var="board" items="${boards}">
                            <tr>
                                <td>${board.boardNo}</td>
                                <td>
                                    <a href="${path}/board/boardview.do?boardNo=${board.boardNo}">
                                        ${board.boardTitle}
                                    </a>
                                </td>
                                <td>${board.boardWriter}</td>
                                <td>
                                    <fmt:formatDate value="${board.boardDate}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td>${board.boardReadCount}</td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </tbody>        
                <tbody>
                	<tr>
                		<td></td>
                	</tr>	
                </tbody>
            </table>       
            
            <div id="pageBar">
                ${pageBar}
            </div>
        </div>
    </div>              
    
    

    
    


    
   
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>