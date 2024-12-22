package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ttt.common.exception.LoginCheckException;
import com.ttt.dto.Member1;

/* 로그인 여부 확인하는 서블릿 */
@WebFilter( servletNames= {
		/* 로그인을 체크할 서블릿에 네이밍 후 서블릿네임 선언하기 */
		"updateMember", "memberInfo"
})
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    public LoginCheckFilter() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here

		// HttpSession 에 로그인 정보가 있는지 확인
		HttpSession session=((HttpServletRequest)request).getSession();
		Member1 loginMember=(Member1)session.getAttribute("loginMember");
		
		// Exception 발생시켜서 에러페이지로 이동 예외처리
		if(session==null||loginMember==null) { //jsp 를 사용하고 있기 때문에 사실은 session 은 null 이 나올 수가 없음
			throw new LoginCheckException("로그인 후 이용 가능한 서비스");
		}else if(!loginMember.getEmail().equals(request.getParameter("email"))) {
			throw new LoginCheckException("부적절한 접근입니다.");

		}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
