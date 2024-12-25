package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Member1;
import com.ttt.service.MemberService;

@WebServlet("/auth/checkEmailDuplicate.do")
public class MemberFindPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberFindPasswordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType=request.getParameter("searchType");
		String email=request.getParameter("email");
		String memberName=request.getParameter("memberName");
		
		System.out.println(searchType + "," + email + ","+ memberName);
		
		Member1 m= new Member1();
		switch(searchType) {
		case "emailDuplicate" : m.setEmail(email); System.out.println(m); break;
		case "searchPassword" : m.setEmail(email); m.setMemberName(memberName);; System.out.println(m); break;
		}
		
		
		Member1 result=new MemberService().selectMemberByNameAndEmail(m);

        response.setContentType("application/json");
        response.getWriter().write("{\"exists\": " + (result != null) + "}");
	}

}
