package com.ttt.controller.board;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ttt.dto.Member1;
import com.ttt.dto.Post1;

@WebServlet("/board/dontworry")
public class ToDontWorryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToDontWorryServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 더미 데이터 생성 - 미해결 게시판용
        List<Post1> unsolvedPosts = new ArrayList<>();
        
        // 더미 데이터 생성 - 해결된 게시판용
        List<Post1> solvedPosts = new ArrayList<>();

		HttpSession session = request.getSession();
	    session.setAttribute("categoryNo", 2); // 세션에 저장
		
        // 현재 시간을 밀리초로 전달
        request.setAttribute("currentTime", System.currentTimeMillis());
        
        request.setAttribute("unsolvedPosts", unsolvedPosts);
        request.setAttribute("solvedPosts", solvedPosts);
        
		request.getRequestDispatcher("/WEB-INF/views/board/dontworry3.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
