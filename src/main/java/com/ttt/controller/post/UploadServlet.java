package com.ttt.controller.post;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Post;
import com.ttt.service.PostService;

@WebServlet("/post/uploadpost")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UploadServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/resources/upload/post");
//		MultipartRequest mr = new MultipartRequest(
//				request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
		String postTitle = request.getParameter("postTitle");
		String postContent = request.getParameter("postContent");
		String postWriter = request.getParameter("postWriter");
		
		Post1 p = Post.builder()
				.postTitle(postTitle)
				.postContent(postContent)
				.postWriter(postWriter)
				.build();
		
		int result = new PostService().uploadPost(p);
		String msg, loc;
		if (result>0) {
			msg = "게시글 등록 성공!";
			loc = "/allboard.main";
		} else {
			msg = "게시글 등록 실패";
			loc = "/uploadpost.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/post/uploadPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
