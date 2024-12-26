package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member1;
import com.ttt.service.MemberService;




@WebServlet(name="memberUpdate", urlPatterns="/member/update")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemberUpdateServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String emailId = request.getParameter("emailId");
		String memberPw = request.getParameter("memberPw");
		String memberName = request.getParameter("memberName");
		String memberNick = request.getParameter("memberNick");
		
		Member1 m = Member1.builder()
				.memberName(memberName)
				.email(emailId)
				.memberPw(memberPw)
				.memberNick(memberNick)
				.build();
		
		int result = new MemberService().updateMember(m); 
		String msg,loc;
		if(result>0) {
			msg="회원정보 수정 완료";
			loc="/";
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", m);
		}else {
			msg="회원정보 수정 실패";
			loc="/member/myinfo";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
