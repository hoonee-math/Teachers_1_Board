package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post1;
import com.ttt.service.PostService;

@WebServlet("/post/viewpost")
public class ViewPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ViewPostServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		
		Cookie[] cookies = request.getCookies();
		String readPost = "";
		boolean readResult = false;
		if(cookies!=null) {
			for(Cookie c : cookies) {
				if(c.getName().equals("readPost")) {
					readPost = c.getValue();
					if(c.getValue().contains("|" + postNo + "|")) {
						readResult = true;
					}
				}
			}
		}
		if(!readResult) {
			Cookie c = new Cookie("readPost", readPost + "|" +postNo + "|");
			c.setPath(request.getContextPath());
			c.setMaxAge(60*60*24);
			response.addCookie(c);
		}
		
		Post1 p = new PostService().selectBoardByNo(postNo);
		
		request.setAttribute("post", p);
		request.getRequestDispatcher("WEB-INF/views/post/viewPost.jsp");
		
		
		request.getRequestDispatcher("/WEB-INF/views/post/viewPost.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
