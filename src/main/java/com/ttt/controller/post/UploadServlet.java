package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.common.SqlSessionTemplate;
import com.ttt.dto.Member1;
import com.ttt.service.PostService;

@WebServlet(name="uploadPost", urlPatterns="/post/uploadpost")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public UploadServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		//현재 로그인한 회원의 MemberNo 가져오기 
		HttpSession session = request.getSession();
		Member1 loginMember = (Member1)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			String schoolName = new PostService().selectSchoolName(loginMember.getMemberNo());
			request.setAttribute("schoolName", schoolName);
		}
		
		//region 리스트 조회 로직
		List<String> result = new ArrayList<>();
	
		try {
			SqlSession sqlSession = SqlSessionTemplate.getSession();
			result = sqlSession.selectList("post.selectRegion");
			sqlSession.commit();
			sqlSession.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.setAttribute("regions", result);
		
		request.getRequestDispatcher("/WEB-INF/views/post/uploadPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
