package com.ttt.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// memberEnroll 네이밍을 통해 password 필터처리
@WebServlet(name="memberEnroll", urlPatterns="/member/enrollend")
// enrollMember.jsp 로부터 회원가입 form 작성이 끝난후 회원가입 요청을 처리하는 servlet
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberEnrollEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String emailId=request.getParameter("emailId");
		String emailDomain=request.getParameter("emailDomain");
		
		// 서블릿 name="memberEnroll" 인 경우 PasswordEncryptFilter 에서 필터처리하도록 설정. -> PasswordEncoding 진행 -> getParameter 의 key값이 memberPw 인경우 인코딩하여 반환.
		String memberPw=request.getParameter("memberPw");
		String memberName=request.getParameter("memberName");
		String memberNick=request.getParameter("memberNick");
		
		String addressNo=request.getParameter("addressNo");
		String addressRoad=request.getParameter("addressRoad");
		String addressDetail=request.getParameter("addressDetail");
		String address="("+addressNo+") "+addressRoad+" "+addressDetail;
		
		int memberType=Integer.parseInt(request.getParameter("memberType")); // 0:관리자 1:학부모 2:교사 
		int standardCode=Integer.parseInt(request.getParameter("standardCode")); // 자녀 학교 정보 or 교사 소속 학교
		
		
		
		
		//db에 저장
		//mybatis 설정하기!
		String msg,loc="/";
		
		try {
			// int result=new MemberService().insertMember(m);
			msg="회원가입 성공!";
			loc="/member/login";
		} catch(RuntimeException e) { //MemberService 에서 insertMember 에서 SQLException 이 발생할 경우 던져주도록 설정했기 때문에 오류가 사라짐!
			//마찬가지로 dao 도 SQLException 으로 던져버림!
			msg="회원가입 실패.. 다시 시도하세요.";
			loc="/member/enroll";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
