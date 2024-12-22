package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.model.dto.Member;
import com.web.model.service.MemberService;

@WebServlet("/member/idduplicate.do")
public class IdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IdDuplicateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("id");
		request.setAttribute("userId", userId);
		
		//DB member 테이블에 일치하는 값이 있는지 확인
		Member m=new MemberService().selectMemberById(userId);
		//boolean result=new MemberService().selectMemberById(userId);
		
		request.setAttribute("result", m==null); // 일회용 데이터이기 때문에 request 
		
		//조회해서 출력하거나, 값, 페이지 전환할때는 RequestDispatcher & forward
		//이전에 있던 값을 날려버리고 새 요청을 보내야 할때, login logout 등등 (1210-T.1110) 할때는 sendRedirect
		request.getRequestDispatcher("/WEB-INF/views/common/idDuplicate.jsp").forward(request, response);
		//jsp 가 만들어졌을 때, service를 호출할거임... contentType 정하고... 응답용으로만 사용함!
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
