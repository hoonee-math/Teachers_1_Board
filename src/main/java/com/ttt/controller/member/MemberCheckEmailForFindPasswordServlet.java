package com.ttt.controller.member;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.service.EmailSenderService;

@WebServlet("/member/checkemailforfindpassword.do")
// 보안 강화 버전. 회원가입 페이지에서 이메일 인증버튼 클릭을 통해 실행되는 요청
// 6자리 랜덤 인증번호를 생성하고 해시화하여 세션에 저장 후, 사용자 이메일로 원본 인증번호를 발송하는 서블릿
public class MemberCheckEmailForFindPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberCheckEmailForFindPasswordServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String email = request.getParameter("email");
	    // 인증번호 생성 및 메일 발송
	    String authNumber = generateAuthNumber();
	    HttpSession session = request.getSession();
	    
	    // 개발자 도구를 이용해서 session 정보를 노출할 위험성이 있기 때문에 암호화 하여 전달하기 위해 주석 처리
	    // session.setAttribute("authNumber", authNumber);

        // 기존 세션 정보 삭제
        session.removeAttribute("hashedAuthNumber");
        session.removeAttribute("authCreateTime");
        // 인증 실패 횟수 설정
        session.removeAttribute("failCount");

        // 인증번호 해시화하여 저장
        String hashedAuthNumber = getSHA512(authNumber);
        session.setAttribute("hashedAuthNumber", hashedAuthNumber);
        session.setAttribute("authCreateTime", System.currentTimeMillis());
        session.setAttribute("userEmail", email);
        
        // 세션 유효시간 설정 (5분)
        session.setMaxInactiveInterval(300);
        
	    EmailSenderService sender = new EmailSenderService();
	    String subject = "이메일 인증번호";
	    String content = "인증번호는 [" + authNumber + "] 입니다.";
	    
	    try {
	        sender.sendEmail(email, subject, content);
	        request.setAttribute("email", email);
	        request.getRequestDispatcher("/WEB-INF/views/register/checkEmailForFindPassword.jsp")
	               .forward(request, response);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.getWriter().write("이메일 전송 실패");
	    }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

    private String generateAuthNumber() {
        Random random = new Random();
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            builder.append(random.nextInt(10));
        }
        return builder.toString();
    }
    

    // 기존 PasswordEncoding에서 사용하던 해시 함수
    // session 에 원본 인증번호를 확인할 수 없도록 보안성 향상
    private String getSHA512(String val) {
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-512");
        } catch(NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        byte[] valBytes = val.getBytes();
        md.update(valBytes);
        byte[] encBytes = md.digest();
        return Base64.getEncoder().encodeToString(encBytes);
    }
}
