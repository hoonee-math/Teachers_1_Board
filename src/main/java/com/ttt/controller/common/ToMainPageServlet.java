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
	        List<Post1> favoritePosts = new BoardService().selectBoardByCategory(1);
	        
	        // 학년별 게시판(일단은 중등으로)
	        List<Post1> middlePosts = new BoardService().selectBoardByCategory(5);

	        // 고민상담 미해결
	        List<Post1> unsolvedPosts = new BoardService().selectBoardByCategory(2);
	        
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
	    // 일반 요청인 경우 (페이지 로드)
	    else {
	    	// 현재 시간 가져오기
	        LocalDateTime now = LocalDateTime.now();
	        
			// 더미 데이터 생성 - 미해결 게시판용
	        List<Post1> unsolvedPosts = new ArrayList<>();
	        for(int i=1; i<=10; i++) {
	            // 각 게시글마다 5분씩 이전 시간으로 설정
	            LocalDateTime postTime = now.minusMinutes(i * 5);
	            
	            Post1 post = Post1.builder()
	                .postNo(i)
	                .postTitle("이것은 더미 데이터 미해결 게시글 dsafasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf" + i)
	                .member(Member1.builder().memberNick("작성자"+i).build())
	                .viewCount(10+i)
	                .createDate(new Date(Timestamp.valueOf(postTime).getTime()))
	                .commentCount(i)
	                .build();
	            unsolvedPosts.add(post);
	        }
	        
	        // 더미 데이터 생성 - 해결된 게시판용
	        List<Post1> solvedPosts = new ArrayList<>();
	        for(int i=1; i<=10; i++) {
	            // 각 게시글마다 5분씩 이전 시간으로 설정
	            LocalDateTime postTime = now.minusMinutes(i * 5);
	            
	            Post1 post = Post1.builder()
	                .postNo(i)
	                .postTitle("해결된 게시글 " + i)
	                .member(Member1.builder().memberNick("작성자"+i).build())
	                .viewCount(20+i)
	                .createDate(Date.valueOf(postTime.toLocalDate()))
	                .commentCount(i*2)
	                .build();
	            solvedPosts.add(post);
	        }

	        // 현재 시간을 밀리초로 전달
	        request.setAttribute("currentTime", System.currentTimeMillis());
	        
	        request.setAttribute("unsolvedPosts", unsolvedPosts);
	        request.setAttribute("solvedPosts", solvedPosts);
	        
			request.getRequestDispatcher("/index.jsp").forward(request, response);
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
