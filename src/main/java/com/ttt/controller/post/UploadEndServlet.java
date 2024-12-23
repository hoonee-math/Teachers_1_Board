package com.ttt.controller.post;

import java.io.IOException;
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
@WebServlet("/post/postuploadend")
public class UploadEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadEndServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = getServletContext().getRealPath("/resources/upload/post");
		
		//jsp 파일에서 hidden 처리해서 세 개 데이터 가져와야함 
		Member1 childMember = new Member1();
		int memberNo = 0;
		try {
			memberNo = Integer.parseInt(request.getParameter("memberNo"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		childMember.setMemberNo(memberNo);
		
		Post1 childPost = new Post1();
		int postNo = 0;
		try {
			postNo = Integer.parseInt(request.getParameter("postNo"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		childPost.setPostNo(postNo);
		
		List<Image1> childImgs = new PostService().selectImgAll();
		int imgNo = 0;
		try {
			imgNo = Integer.parseInt(request.getParameter("imgNo"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
//		childImgs.setImgNo(imgNo);
		
		MultipartRequest mr = new MultipartRequest(
				request, path, 1024*1024*100, "utf-8", new CustomFileRenamePolicy(memberNo, postNo, imgNo)
				);
		
		String category = mr.getParameter("category");
		//아래의 세 정보는 category에 따라 받는 정보라서 어떻게 전송해야할지 모르겠어요..
		String region = mr.getParameter("region");
		String district = mr.getParameter("district");
		String schoolName = mr.getParameter("schoolName");
		String postTitle = mr.getParameter("postTitle");
		String postWriter = mr.getParameter("postWriter");
		String postContent = mr.getParameter("postContent");
		
		String oriname = mr.getOriginalFileName("upfile");
		String rename = mr.getFilesystemName("upfile");
		
		//객체로 저장되어있는 정보들을 가져오는 
		Post1 p = Post1.builder()
				.category(category)
				.member(childMember)
				.postTitle(postTitle)
				.postContent(postContent)
				.images(childImgs)
				.build();
		
		int result = new PostService().insertPost(p);
		
		String msg, loc;
		if (result>0) {
			msg = "게시글 등록 성공 :)";
			loc = "/board/allboard";
			//카테고리에 따라 이동하는 게시판 페이지 달라지도록 분기처리 해주
		} else {
			msg = "게시글 등록 실패 :(";
			loc = "/post/uploadpost";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
