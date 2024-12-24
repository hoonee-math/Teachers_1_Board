package com.ttt.controller.member;

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

@WebServlet("/member/mypost")
public class MemberMyPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberMyPostServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 페이징 처리를 위한 변수 선언
		int cPage, numPerPage, memberNo;
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
		
		try {
			// categoryNo 값이 있는 경우 해당 카테고리 게시글만 출력
			memberNo=Integer.parseInt(request.getParameter("memberNo"));
			param.put("memberNo",memberNo);
			boards=new BoardService().selectBoardListByMemberNo(param);
			totalData=new BoardService().selectBoardCountByMemberNo(memberNo);
		} catch(NumberFormatException e) {
			// categoryNo 값이 없는 경우 전체 게시글 출력 (공지, 뉴스 제외)
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

	}
}
