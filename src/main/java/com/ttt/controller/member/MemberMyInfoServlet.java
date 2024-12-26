package com.ttt.controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member1;
import com.ttt.dto.School12;
import com.ttt.service.SchoolService;




@WebServlet("/member/myinfo")
public class MemberMyInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemberMyInfoServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		HttpSession session = request.getSession(false); //현재 로그인 되어있는 정보가 담긴 세션 가져옴
		Member1 m=new Member1();
		if (session != null) {
		    m = (Member1) session.getAttribute("loginMember"); // 세션에서 사용자 정보 가져오기
		    System.out.println("추가전:"+m);
		
		try {
		int schoolNo=m.getChildSchool().getSchoolNo();
		School12 schoolInfo=new SchoolService().selectSchoolInfoBySchoolNo(schoolNo);
		m.setChildSchool(schoolInfo);
		}catch(NullPointerException e) {
			e.printStackTrace();
		}
	    System.out.println("추가후:"+m);
		session.setAttribute("loginMember", m);
		
		request.getRequestDispatcher("/WEB-INF/views/register/myInfo.jsp").forward(request, response);
		
		
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
