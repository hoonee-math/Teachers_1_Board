package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member1;
import com.ttt.service.MemberService;

@WebServlet(name="memberLoginServlet", urlPatterns="/member/login.do")
public class MemerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemerLoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String memberPw=request.getParameter("memberPw");
		String saveId=request.getParameter("saveId");
		
		if(saveId!=null) {
			//Cookie 객체를 만들어서 접속정보 저장
			Cookie c=new Cookie("saveId",email);
			c.setMaxAge(60*60*24*7);
			c.setPath("/");
			response.addCookie(c);
		} else {
			Cookie c=new Cookie("saveId","");
			c.setMaxAge(0);
			c.setPath("/");
			response.addCookie(c);
		}
		
		Member1 m =new MemberService().selectMemberById(email);
		
		System.out.println(m);
		
		// 로그인 성공시 처리할 로직 (아이디, 비번 일치)
		if(m!=null && m.getMemberPw().equals(memberPw)) {
			// 로그인 유지를 위한 session 정보 저장
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
			// 메인화면으로 리다이렉트 시킴! 이전 주소 날려버리고 재요청!
			response.sendRedirect(request.getContextPath()); 
		} else {
			// 로그인 실패
			request.setAttribute("msg", "아이디와 패스워드가 일치하지 않습니다."); //실패하면 통상 alert 띄워주기 때문에 사용
			request.setAttribute("loc","/"); 
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
		/* doGet(request, response); */
	}

}
