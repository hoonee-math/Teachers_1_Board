package com.ttt.controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/enrollmemberend.do")
// enrollMember.jsp 로부터 회원가입 form 작성이 끝난후 회원가입 요청을 처리하는 servlet
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberEnrollEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String userId=request.getParameter("userId");
		String password=request.getParameter("password"); // 이때 바로 암호화하면 더이상 처리해줄 필요도 없음 // 얘는 HTTPServlet 메소드.. HTTPServlet 객체를 재정의 할 수 있음! wrapper 클래스 이용! 재정의 해서 사용
		String userName=request.getParameter("userName");
		int age;
		try {
			age=Integer.parseInt(request.getParameter("age"));
		} catch(NumberFormatException e) {
			age=0;
		}
		String email=request.getParameter("email");
		String gender=request.getParameter("gender");
		String[] hobby=request.getParameterValues("hobby");
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		
		/*
		 * Member m=Member.builder() .userId(userId) .password(password)
		 * .userName(userName) .gender(gender) .age(age) .email(email) .phone(phone)
		 * .hobby(hobby) .phone(address) .build();
		 */
		
		//db에 저장. web 계쩡의 member 테이블에 저장
		//mybatis 설정하기!
		String msg,loc="/";
		
		try {
			// int result=new MemberService().insertMember(m);
			msg="회원가입 성공!";
		} catch(RuntimeException e) { //MemberService 에서 insertMember 에서 SQLException 이 발생할 경우 던져주도록 설정했기 때문에 오류가 사라짐!
			//마찬가지로 dao 도 SQLException 으로 던져버림!
			msg="회원가입 실패.. 다시 시도하세요.";
			loc="/member/enrollmember.do";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
