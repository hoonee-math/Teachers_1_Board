package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.ttt.common.CustomFileRenamePolicy;
import com.ttt.dto.Image1;
import com.ttt.dto.Member1;
import com.ttt.dto.Post1;
import com.ttt.service.PostService;

/**
 * Servlet implementation class UploadEndServlet
 */
@WebServlet("/post/uploadpostend")
public class UploadEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadEndServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/resources/upload/post");

		MultipartRequest mr = new MultipartRequest(
				request, path, 1024*1024*100, "utf-8", new CustomFileRenamePolicy(0, 0, 0)
			);
		
		Member1 m = new Member1();
		Post1 post = new Post1();
		List<Image1> images = new ArrayList<>();
		
		
		try {
			//1. 기본 데이터 처리
			m = Member1.builder()
					.memberNo(Integer.parseInt(mr.getParameter("memberNo")))
					.build();
			post = Post1.builder()
					.postTitle(mr.getParameter("postTitle"))
					.postContent(mr.getParameter("postContent"))
					.member(m)
					.categoryNo(Integer.parseInt(mr.getParameter("categoryNo")))
					.build();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try { 
			//2. 파일 처리
	        int order = 0;

			java.util.Enumeration<String> fileNames = mr.getFileNames();
			while(fileNames.hasMoreElements()) {  // Enumeration 객체를 변수에 저장하여 사용
			    String fileName = fileNames.nextElement();
			    String oriname = mr.getOriginalFileName(fileName);
			    String renamed = mr.getFilesystemName(fileName);
			    
			    if (oriname != null) {
			        Image1 image = Image1.builder()
			                .imgSeq(order++)
			                .oriname(oriname)
			                .renamed(renamed)
			                .build();
			        images.add(image);
			    }
			}
	        //3. 서비스 호출
	        post = new PostService().insertPost(post, images);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
	        //4.  결과 처리
	        String msg = "게시글 등록 성공 :)", loc = "/board/list";
	        if(post.getPostNo() == 0) {
	        	msg = "게시글 등록 실패 :(";
	        	loc = "/post/uploadpost";
	        }
	        
	        request.setAttribute("msg", msg);
	        request.setAttribute("loc", loc);
	        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
	               .forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "게시글 등록 중 오류 발생");
	        request.setAttribute("loc", "/post/uploadpost");
	        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
	               .forward(request, response);
		}
		
		
		int memberNo = Integer.parseInt(mr.getParameter("memberNo"));
		int categoryNo = Integer.parseInt(mr.getParameter("categoryNo"));
		String postTitle = mr.getParameter("postTitle");
		String postContent = mr.getParameter("postContent");
		
	}
}
