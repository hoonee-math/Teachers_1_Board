package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.ttt.common.CustomFileRenamePolicy;
import com.ttt.dto.Post1;

/**
 * Servlet implementation class UploadEndServlet
 */
@WebServlet("/post/postuploadend")
public class UploadEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/resources/upload/post");
		
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		int imgOrder = Integer.parseInt(request.getParameter("imgOrder"));
			//jsp 파일에서 hidden 처리해서 세 개 데이터 가져와야함 
		
		MultipartRequest mr = new MultipartRequest(
				request, path, 1024*1024*100, "utf-8", new CustomFileRenamePolicy(memberNo, postNo, imgOrder)
				);
		
		String category = mr.getParameter("category");
		//아래의 세 정보는 category에 따라 받는 정보라서 어떻게 전송해야할지 모르겠어요..
//		String region = mr.getParameter("region");
//		String district = mr.getParameter("district");
//		String schoolName = mr.getParameter("schoolName");
		String postTitle = mr.getParameter("postTitle");
		String postWriter = mr.getParameter("postWriter");
		String postContent = mr.getParameter("postContent");
		
		String oriname = mr.getOriginalFileName("upfile");
		String rename = mr.getFilesystemName("upfile");
		
		//객체로 저장되어있는 정보들을 가져오는 
		Post1 p = Post1.builder()
				.category(category)
				.postTitle(postTitle)
//				.postWriter(postWriter)
				.postContent(postContent)
//				.rename(rename)
				.build();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
