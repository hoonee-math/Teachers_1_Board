package com.ttt.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/enroll")
// 회원가입 버튼 클릭시 회원 가입 화면을 출력해주는 서블릿
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberEnrollServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 학부모인지 교사인지 체크 후 회원가입 화면으로 이동
		String memberType = request.getParameter("memberType");
        request.setAttribute("memberType", memberType);
        request.getRequestDispatcher("/WEB-INF/views/register/enrollMember.jsp").forward(request, response);
    }
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
