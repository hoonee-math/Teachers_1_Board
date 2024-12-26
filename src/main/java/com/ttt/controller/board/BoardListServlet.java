package com.ttt.controller.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.Post1;
import com.ttt.service.BoardService;

@WebServlet("/board/list")
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 페이징 처리를 위한 변수 선언
		int cPage, numPerPage, categoryNo;
		int totalData, totalPage, pageBarSize, pageNo, pageEnd;
		String categoryTitle;
		
		// 받아온 변수를 service 로 전달할 map 선언
		Map<String, Integer> param = new HashMap<>();
		// service 로 부터 return 받을 List<Post1> 선언
		List<Post1> boards = new ArrayList<>();
		
		try {cPage=Integer.parseInt(request.getParameter("cPage"));} 
		catch(NumberFormatException e) {cPage=1;}
		param.put("cPage", cPage);
		
		try {numPerPage=Integer.parseInt(request.getParameter("numPerPage"));}
		catch(NumberFormatException e) {numPerPage=10;}
		param.put("numPerPage", numPerPage);
		
		String categoryNoParam = request.getParameter("categoryNo");

		if (categoryNoParam != null && !categoryNoParam.isEmpty()) {
		    categoryNo = Integer.parseInt(categoryNoParam);
		    request.setAttribute("categoryNo", categoryNo); // 세션에 저장
		} else {
		    // 세션에서 값 가져오기
		    categoryNo = request.getAttribute("categoryNo") != null 
		                 ? (int) request.getAttribute("categoryNo") 
		                 : 0; // 기본값
		}
		System.out.println(categoryNo);
		try {
			if(categoryNo!=0) {
				// categoryNo 값이 있는 경우 해당 카테고리 게시글만 출력
				param.put("categoryNo",categoryNo);
				boards=new BoardService().selectBoardListByCategoryNo(param);
				totalData=new BoardService().selectBoardCountByCategoryNo(categoryNo);
				switch(categoryNo) {
					case 1: categoryTitle="맘스뉴스"; break;
					case 2: categoryTitle="고민상담소"; break;
					case 3: categoryTitle="공지사항"; break;
					case 4: categoryTitle="초등 게시판"; break;
					case 5: categoryTitle="중등 게시판"; break;
					case 6: categoryTitle="고등 게시판"; break;
					case 7: categoryTitle="고3/N수 게시판"; break;
					case 8: categoryTitle="지역 게시판"; break;
					case 9: categoryTitle="학교 게시판"; break;
					case 10: categoryTitle="자유게시판"; break;
					case 20: categoryTitle="추천글 게시판"; break;
					default: categoryTitle="error"; break;
				}
			} else if(categoryNo==0) {
				// categoryNo 값이 없는 경우 전체 게시글 출력 (공지, 뉴스 제외)
				boards=new BoardService().selectBoardListAllCategory(param);
				totalData=new BoardService().selectBoardCountAll();
				categoryTitle="전체글 게시판";
			} else {
				categoryTitle="error";
				totalData=0;
			}
		} catch(Exception e) {
			e.printStackTrace();
			categoryTitle="error";
			totalData=0;
		}
		
		totalPage=(int)Math.ceil((double)totalData/numPerPage);
		pageBarSize=5;
		pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		pageEnd=pageNo+pageBarSize-1;
		
		//페이징 처리 로직
		String pageBar="<ul class='pagination justify-content-center'>";
		
		if(pageNo==1) {
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' data-page='"+(pageNo)+"' href='#'>"+pageNo+"</a>";
			pageBar+="</li>";
		} else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='"
					+request.getRequestURI()
					+"?cPage="+(pageNo-1)
					+"&numPerPage="+numPerPage
					+"'>이전</a>"; 
			pageBar+="</li>";
		}
//		while(pageNo<=pageEnd&&pageNo<=totalPage) {
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			if(pageNo==cPage) {
				pageBar+="<li class='page-item disabled'>";
				pageBar+="<a class='page-link' href='#'>"+pageNo+"</a>";
				pageBar+="</li>";
			} else {
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' href='"
						+request.getRequestURI()
						+"?cPage="+(pageNo)
						+"&numPerPage="+numPerPage
						+"'>"+pageNo+"</a>"; 
				pageBar+="</li>";
			}
			pageNo++;
		}
		if(pageNo>totalPage) {
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' href='#'>다음</a>";
			pageBar+="</li>";
		} else {
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='"
					+request.getRequestURI()
					+"?cPage="+(pageNo)
					+"&numPerPage="+numPerPage
					+"'>다음</a>"; 
			pageBar+="</li>";
		}
		pageBar+="</ul>";
		
		request.setAttribute("categoryTitle", categoryTitle);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("boards", boards);

		// Ajax 요청과 일반 요청 구분
		if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
		    // Ajax 요청인 경우 JSON 응답
		    response.setContentType("application/json;charset=utf-8");
		    Map<String, Object> result = new HashMap<>();
		    result.put("boards", boards);
		    result.put("pageBar", pageBar);
		    result.put("categoryTitle", categoryTitle);
		    
		    // categoryNo 파라미터가 있으면 포함
		    if(categoryNo != 0) {
		        result.put("categoryNo", categoryNo);
		    }
		    
		    // JSON 응답 전송
		    response.getWriter().write(new Gson().toJson(result));
		} else {
		    // 일반 요청인 경우 JSP로 포워딩
		    request.getRequestDispatcher("/WEB-INF/views/board/allboard.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
