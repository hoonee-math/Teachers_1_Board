package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/member/verifyComplete.do")
public class MemberVerifyCompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberVerifyCompleteServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        
        try {
            // 비밀번호 재설정을 위한 인증 상태를 세션에 저장
            session.setAttribute("passwordResetAuthorized", true);
            session.setAttribute("email", email);
            
            // 세션 유효시간 설정 (10분)
            session.setMaxInactiveInterval(600);
            
            // 성공 응답
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
	}

}
