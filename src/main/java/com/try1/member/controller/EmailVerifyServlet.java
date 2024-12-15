package com.try1.member.controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/check/emailVerify.do")
// 사용자가 입력한 인증번호를 해시화하여 세션의 값과 비교하고, 인증 결과에 따른 처리를 수행하는 서블릿
public class EmailVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EmailVerifyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String inputCode = request.getParameter("authCode");
        HttpSession session = request.getSession();
        // 암호화 하여 보안성 향상을 위해 주석 처리
        // String authNumber = (String) session.getAttribute("authNumber");
        // 안호화한 인증번호 session에서 가져오기
        String hashedAuthNumber = (String) session.getAttribute("hashedAuthNumber");
        // 세션 정보를 5분동안 유지하도록 변수 지정
        Long authCreateTime = (Long) session.getAttribute("authCreateTime");
        String userEmail = (String) session.getAttribute("userEmail");
        
        //문자 인코딩과 컨텐츠 타입을 모두 utf-8로 설정하기!
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("utf-8");

        // 유효시간 체크 (5분)
        if(authCreateTime == null || System.currentTimeMillis() - authCreateTime > 300000) {
        	clearSession(session);
            response.getWriter().write("<script>alert('인증번호가 만료되었습니다. 다시 시도해주세요.'); window.close();</script>");
            return;
        }

        // 입력받은 인증번호를 해시화하여 비교
        String hashedInputCode = getSHA512(inputCode);
		
		/*  //보안성 향상을 위해 처리 로직 구체화
		 * if (authNumber != null && authNumber.equals(inputCode)) {
		 * response.getWriter().write("인증 성공!"); }// 인증 성공 후 처리 로직 추가 
		 * else {
		 * response.getWriter().write("인증번호가 일치하지 않습니다."); }
		 */
        

        if (hashedAuthNumber != null && hashedAuthNumber.equals(hashedInputCode)) {
            // 인증 성공 시
            clearSession(session);
            session.setAttribute("emailVerified", true);
            request.setAttribute("result", true);  // JSP에서 사용할 결과값
            request.getRequestDispatcher("/WEB-INF/views/register/checkEmail.jsp")
                   .forward(request, response);
        } else {
            // 인증 실패 시
            Integer failCount = (Integer) session.getAttribute("failCount");
            if(failCount == null) failCount = 1;
            else failCount++;
            
            if(failCount >= 5) {
                clearSession(session);
                response.getWriter().write("""
                    <script>
                        alert('인증번호 입력 횟수를 초과했습니다. 다시 시도해주세요.');
                        window.close();
                    </script>
                    """);
            } else {
                session.setAttribute("failCount", failCount);
                String failScript = """
                    <script>
                        alert('인증번호가 일치하지 않습니다. 다시 입력해주세요.');
                        history.back();
                    </script>
                    """;
                response.getWriter().write(failScript);
            }
        }
		

		/*  // 실패한 방법 1. 계속 인증 실패 뜸
		 * boolean isVerified = authNumber != null && authNumber.equals(inputCode); //
		 * JSON 형태로 응답 response.getWriter().write("{\"result\": " + isVerified + "}");
		 */
	}
	private void clearSession(HttpSession session) {
        session.removeAttribute("hashedAuthNumber");
        session.removeAttribute("authCreateTime");
        session.removeAttribute("failCount");
        session.removeAttribute("userEmail");
    }
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
