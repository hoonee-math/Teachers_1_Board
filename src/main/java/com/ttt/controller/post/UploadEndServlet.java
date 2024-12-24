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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String path = getServletContext().getRealPath("/resources/upload/post");
//		
//		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
//		//jsp 파일에서 hidden 처리해서 세 개 데이터 가져와야함 
////		Member1 childMember = new Member1();
////		int memberNo = 0;
////		try {
////			memberNo = Integer.parseInt(request.getParameter("memberNo"));
////		} catch (NumberFormatException e) {
////			e.printStackTrace();
////		}
////		childMember.setMemberNo(memberNo);
//		
//		School12 childSchool = new School12();
//		int schoolNo = 0;
//		try {
//			memberNo = Integer.parseInt(request.getParameter("schoolName"));
//		} catch (NumberFormatException e) {
//			e.printStackTrace();
//		}
//		childSchool.setSchoolNo(schoolNo);
//		
////		Post1 childPost = new Post1();
////		int postNo = 0;
////		try {
////			postNo = Integer.parseInt(request.getParameter("postNo"));
////		} catch (NumberFormatException e) {
////			e.printStackTrace();
////		}
////		childPost.setPostNo(postNo);
//		
//		List<Image1> childImgs = new PostService().selectImgAll();
//		int imgOrder = 0;
//		try {
//			imgOrder = Integer.parseInt(request.getParameter("imgOrder"));
//		} catch (NumberFormatException e) {
//			e.printStackTrace();
//		}
//		
//		MultipartRequest mr = new MultipartRequest(
//				request, path, 1024*1024*100, "utf-8", new CustomFileRenamePolicy(memberNo, 0, 0)
//			);
//		
//		int categoryNo = Integer.parseInt(mr.getParameter("categoryNo"));
//		//아래의 세 정보는 category에 따라 받는 정보라서 어떻게 전송해야할지 모르겠어요..
//		String region = "";
//		String district = "";
//		String schoolName = "";
//		switch (categoryNo) {
//		case 8:
//			region = mr.getParameter("region");
//			district = mr.getParameter("district");
//			break;
//		case 9:
//			region = mr.getParameter("region");
//			district = mr.getParameter("district");
//			schoolName = mr.getParameter("schoolName");
//			break;
//		}
//		String postTitle = mr.getParameter("postTitle");
//		String postContent = mr.getParameter("postContent");
//		
//		//객체로 저장되어있는 정보들을 가져오는 
//		Post1 p = Post1.builder()
//				.postTitle(postTitle)
//				.postContent(postContent)
//				.member(childMember)
//				.categoryNo(categoryNo)
//				.school(childSchool)
//				.images(childImgs)
//				.build();
//		
//		int result = new PostService().insertPost(p);
//		
//		String msg, loc;
//		if (result>0) {
//			msg = "게시글 등록 성공 :)";
//			loc = "/board/allboard";
//			//카테고리에 따라 이동하는 게시판 페이지 달라지도록 분기처리 해주
//		} else {
//			msg = "게시글 등록 실패 :(";
//			loc = "/post/uploadpost";
//		}
//		request.setAttribute("msg", msg);
//		request.setAttribute("loc", loc);
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
	        
	        while(mr.getFileNames().hasMoreElements()) {
	        	String fileName = (String)mr.getFileNames().nextElement();
	        	String oriname = mr.getOriginalFileName(fileName);
	        	String rename = mr.getFilesystemName(fileName);
	        	
	        	if (oriname != null) {
	        		Image1 image = Image1.builder()
	        				.imgOrder(order++)
	        				.oriname(oriname)
	        				.rename(rename)
	        				.build();
	        		images.add(image);
	        	}
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
	        //3. 서비스 호출
	        post = new PostService().insertPost(post, images);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
	        //4.  결과 처리
	        String msg = "게시글 등록 성공 :)", loc = "/board/allboard";
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
		
		
		
		
		doGet(request, response);
	}
}
