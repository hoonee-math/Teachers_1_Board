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
		
		
		String emailId=request.getParameter("emailId");
		String emailDomain=request.getParameter("emailDomain");
		String memberPw=request.getParameter("memberPw"); // 이때 바로 암호화하면 더이상 처리해줄 필요도 없음 // 얘는 HTTPServlet 메소드.. HTTPServlet 객체를 재정의 할 수 있음! wrapper 클래스 이용! 재정의 해서 사용
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
