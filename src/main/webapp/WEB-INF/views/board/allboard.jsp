<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<section class="main-content col-9">
	<div class="board-container">
		<div class="board-header">
			<h2>전체글 게시판</h2>
			<p class="board-explain">맘스티쳐 전체 게시글 모음입니다 :)</p>
			<button class="board-btn">등록일순</button>
			<button class="board-btn-write">글쓰기</button>
		</div>
		<div class="board-body">
			<div class="row full-width">
			    <table>
			        <thead>
			            <tr>
			                <th>번호</th>
			                <th>카테고리</th>
			                <th>제목</th>
			                <th>작성자</th>
			                <th>조회수</th>
			                <th>시간</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td>1</td>
			                <td class="category">고민</td>
			                <td class="title">
			                    <a href="#">고민이 있어요 도와주세요</a> 
			                    <span class="highlight">2</span>
			                </td>
			                <td>알이랑</td>
			                <td class="view-count">870</td>
			                <td class="time">00:15</td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td class="category">고민</td>
			                <td class="title">
			                    <a href="#">우리아이 어쩌면 좋을까요..?</a> 
			                    <span class="highlight">2</span>
			                </td>
			                <td>newgooday</td>
			                <td class="view-count">412</td>
			                <td class="time">00:15</td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td class="category">일반</td>
			                <td class="title">
			                    <a href="#">상쾌한 아침산책</a> 
			                    <span class="highlight">1</span>
			                </td>
			                <td>Santorini</td>
			                <td class="view-count">59</td>
			                <td class="time">00:14</td>
			            </tr>
			            <tr>
			                <td>4</td>
			                <td class="category">일반</td>
			                <td class="title">
			                    <a href="#">패딩 추천부탁드립니다~</a> 
			                    <span class="highlight">4</span>
			                </td>
			                <td>t.t</td>
			                <td class="view-count">779</td>
			                <td class="time">00:13</td>
			            </tr>
			            <tr>
			                <td>5</td>
			                <td class="category">일반</td>
			                <td class="title">
			                    <a href="#">패딩 추천부탁드립니다~</a> 
			                    <span class="highlight">4</span>
			                </td>
			                <td>t.t</td>
			                <td class="view-count">779</td>
			                <td class="time">00:13</td>
			            </tr>
			            <tr>
			                <td>6</td>
			                <td class="category">일반</td>
			                <td class="title">
			                    <a href="#">패딩 추천부탁드립니다~</a> 
			                    <span class="highlight">4</span>
			                </td>
			                <td>t.t</td>
			                <td class="view-count">779</td>
			                <td class="time">00:13</td>
			            </tr>
			        </tbody>
			    </table>
						</div>
					</div>	
				</div>
				<div class="pagebar">
					<button class="pagebar-start">이전</button>
					<button class="pagebar-number">1</button>
					<button class="pagebar-number">2</button>
					<button class="pagebar-number">3</button>
					<button class="pagebar-number">4</button>
					<button class="pagebar-number">5</button>
					<button class="pagebar-end">다음</button>
				</div>          
			
			
</section>

<style>
	
		.board-explain {
			color : black;
			
		}
		.board-header {
			padding : 20px;
			margin-left : 0px;
			color: #FF69B4;
		}
			
		.board-container {
			
		}
		body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        table {
            width: 80%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        .category {
            font-size: 12px;
            color: #888;
            font-weight: bold;
        }
        .title {
            text-align: left;
            color: #333;
        }
        .title a {
            text-decoration: none;
            color: inherit;
        }
        .title a:hover {
            color: #007bff;
        }
        .highlight {
            font-weight: bold;
            color: #FF69B4;
        }
        .icon-img {
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }
        .view-count {
            color: gray;
        }
        .time {
            font-size: 12px;
            color: #888;
        }
  <%--      .pagebar-number {
		margin-left : 1px;
		margin-right : 1px;
		width : 2%
		
		}
		.pagebar {
			display : flex;
			text-align: center;
			justify-content : center;
			margin-top : 15px;
	
		}
	
		.board-btn {
			padding: 8px 16px;
			background-color: #FF69B4;
			border: none;
			border-radius: 6px;
			font-weight: 600;
			cursor: pointer;
			transition: background-color 0.2s ease;
			color : white;
		}
		.board-btn-write { 
			float: right; /* 오른쪽으로 위치 */
	  		margin-right: 10px; /* 오른쪽 여백 */
	  		padding: 8px 16px;
			background-color: #FF69B4;
			border: none;
			border-radius: 6px;
			color: white;
			font-weight: 600;
			cursor: pointer;
			transition: background-color 0.2s ease;
		}       --%>
</style>
<section class="right-box col-1"></section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>