package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Image1;
import com.ttt.dto.Like1;
import com.ttt.dto.Member1;
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
		
		Post1 p = new PostService().selectPostByNo(postNo, readResult);
		List<Image1> imgs = new ArrayList<>();
		try {
			imgs = new PostService().selectImageNo(postNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int categoryNo = new PostService().selectCategoryNo(postNo);
		if (categoryNo>80000) categoryNo=8;
		String categoryName = "";
		switch(categoryNo) {
			case 1: categoryName="맘스뉴스"; break;
			case 2: categoryName="고민상담소"; break;
			case 3: categoryName="공지사항"; break;
			case 4: categoryName="초등 게시판"; break;
			case 5: categoryName="중등 게시판"; break;
			case 6: categoryName="고등 게시판"; break;
			case 7: categoryName="고3/n수생"; break;
			case 8: categoryName="지역별 게시판"; break;
			case 9: categoryName="학교별 게시판"; break;
			case 10: categoryName="자유 게시판"; break;
		}
		
		Post1 p1 = new PostService().selectBoardJoinCommentJoinMember(postNo, readResult);
		// 현재 사용자의 좋아요 상태 확인
		boolean isLiked = false;
		if(request.getSession().getAttribute("loginMember") != null) {
		    Member1 loginMember = (Member1)request.getSession().getAttribute("loginMember");
		    Like1 like = Like1.builder()
		            .member(loginMember)
		            .post(Post1.builder().postNo(postNo).build())
		            .build();
		    isLiked = new PostService().checkLikeStatus(like) > 0;
		}
		request.setAttribute("isLiked", isLiked);
		
		
		
		request.setAttribute("post", p);
		request.setAttribute("images", imgs);
		request.setAttribute("categoryName", categoryName);
		request.getRequestDispatcher("/WEB-INF/views/post/viewPost.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
