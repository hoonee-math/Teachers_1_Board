package com.ttt.controller.common;

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

import com.google.gson.Gson;
import com.ttt.dto.Member1;
import com.ttt.dto.Post1;
import com.ttt.service.BoardService;

@WebServlet(urlPatterns = {"/home", ""})
public class ToMainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ToMainPageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Accept 헤더를 확인
        String acceptHeader = request.getHeader("Accept");
        
        // Ajax 요청인 경우 (JSON 응답)
        if (acceptHeader != null && acceptHeader.contains("application/json")) {
            
			// 추천글
	        List<Post1> favoritePosts = new BoardService().selectIndexPageBoardListByCategoryNo(1);
	        
	        // 학년별 게시판(일단은 중등으로)
	        List<Post1> middlePosts = new BoardService().selectIndexPageBoardListByCategoryNo(5);

	        // 고민상담 미해결
	        List<Post1> unsolvedPosts = new BoardService().selectIndexPageBoardListByCategoryNo(2);
	        
	        // JSON 응답 생성
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	
	        // Gson 사용하여 JSON 변환
	        Gson gson = new Gson();
	        Map<String, Object> jsonData = new HashMap<>();
	        jsonData.put("unsolvedPosts", unsolvedPosts);
	        jsonData.put("middlePosts", middlePosts);
	        jsonData.put("favoritePosts", favoritePosts);
	        
	        String jsonResponse = gson.toJson(jsonData);
	        response.getWriter().write(jsonResponse);
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
