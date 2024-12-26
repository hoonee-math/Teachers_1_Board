package com.ttt.controller.post;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.ttt.dto.Like1;
import com.ttt.dto.Member1;
import com.ttt.dto.Post1;
import com.ttt.service.PostService;

/**
 * Servlet implementation class LikeServlet
 */
@WebServlet("/post/like")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LikeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSON 응답을 위한 설정
        response.setContentType("application/json;charset=utf-8");
        
        // 세션에서 로그인 회원 정보 가져오기
        Member1 loginMember = (Member1)request.getSession().getAttribute("loginMember");
        int postNo = Integer.parseInt(request.getParameter("postNo"));
        
        Map<String, Object> result = new HashMap<>();
        
        if(loginMember != null) {
            Like1 like = Like1.builder()
                            .member(loginMember)
                            .post(Post1.builder().postNo(postNo).build())
                            .build();
                            
            boolean isLiked = new PostService().toggleLike(like);
            int likeCount = new PostService().countLikes(postNo);
            
            result.put("isLiked", isLiked);
            result.put("likeCount", likeCount);
        }
        
        new Gson().toJson(result, response.getWriter());
	}

}
