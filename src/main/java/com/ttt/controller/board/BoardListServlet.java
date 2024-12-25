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
import javax.servlet.http.HttpSession;

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
		// 받아온 변수를 service 로 전달할 map 선언
		Map<String, Integer> param = new HashMap<>();
		// service 로 부터 return 받을 List<Post1> 선언
		List<Post1> boards = new ArrayList<>();
		
		try {cPage=Integer.parseInt(request.getParameter("cPage"));} 
		catch(NumberFormatException e) {cPage=1;}
		param.put("cPage", cPage);
		
		try {numPerPage=Integer.parseInt(request.getParameter("numPerPage"));}
		catch(NumberFormatException e) {numPerPage=5;}
		param.put("numPerPage", numPerPage);
		
		HttpSession session = request.getSession();
		String categoryNoParam = request.getParameter("categoryNo");

		if (categoryNoParam != null && !categoryNoParam.isEmpty()) {
		    categoryNo = Integer.parseInt(categoryNoParam);
		    session.setAttribute("categoryNo", categoryNo); // 세션에 저장
		} else {
		    // 세션에서 값 가져오기
		    categoryNo = session.getAttribute("categoryNo") != null 
		                 ? (int) session.getAttribute("categoryNo") 
		                 : 0; // 기본값
		}
		
		try {
			if(categoryNo!=0) {
				// categoryNo 값이 있는 경우 해당 카테고리 게시글만 출력
				param.put("categoryNo",categoryNo);
				boards=new BoardService().selectBoardListByCategoryNo(param);
				totalData=new BoardService().selectBoardCountByCategoryNo(categoryNo);
			} else if(categoryNo==0) {
				// categoryNo 값이 없는 경우 전체 게시글 출력 (공지, 뉴스 제외)
				boards=new BoardService().selectBoardListAllCategory(param);
				totalData=new BoardService().selectBoardCountAll();
			} else {
				totalData=0;
			}
		} catch(Exception e) {
			e.printStackTrace();
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
			pageBar+="<a class='page-link' href='#'>이전</a>";
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
		
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("boards", boards);
		
		// WEB-INF의 contextParameter에 만들어놓고 사용할 수 있음???? views 위치에 대해서 계속 똑같은거 사용하는데.. web.xml 을 이용할수 있음
		request.getRequestDispatcher("/WEB-INF/views/board/allboard.jsp").forward(request, response);
//		request.getRequestDispatcher(getServletContext().getInitParameter("viewpath")+"/board/allboard.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
