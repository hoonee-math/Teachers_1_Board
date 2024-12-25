package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
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

    private PostService postService = new PostService();

	public UploadEndServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String path = getServletContext().getRealPath("/resources/upload/post");
//
//		CustomFileRenamePolicy renamePolicy = new CustomFileRenamePolicy(0, 0, 0); // 기본값 생성
//
//		MultipartRequest mr = new MultipartRequest(
//				request, path, 1024*1024*100, "utf-8",renamePolicy
//			);
//		
//		Member1 m = new Member1();
//		Post1 post = new Post1();
//		List<Image1> images = new ArrayList<>();
//		int order = 0;
//		
//		try {
//			//1. 기본 데이터 처리
//			m = Member1.builder()
//					.memberNo(Integer.parseInt(mr.getParameter("memberNo")))
//					.build();
//			post = Post1.builder()
//					.postTitle(mr.getParameter("postTitle"))
//					.postContent(mr.getParameter("postContent"))
//					.member(m)
//					.categoryNo(Integer.parseInt(mr.getParameter("categoryNo")))
//					.build();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		try { 
//			//2. 파일 처리
//			java.util.Enumeration<String> fileNames = mr.getFileNames();
//			while(fileNames.hasMoreElements()) {  // Enumeration 객체를 변수에 저장하여 사용
//			    String fileName = fileNames.nextElement();
//			    String oriname = mr.getOriginalFileName(fileName);
//			    String renamed = mr.getFilesystemName(fileName);
//			    
//			    if (oriname != null) {
//			        Image1 image = Image1.builder()
//			                .imgSeq(order++)
//			                .oriname(oriname)
//			                .renamed(renamed)
//			                .build();
//			        images.add(image);
//			    }
//			}
//	        //3. 서비스 호출
//	        post = new PostService().insertPost(post, images);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		int memberNo = Integer.parseInt(mr.getParameter("memberNo"));
//		int categoryNo = Integer.parseInt(mr.getParameter("categoryNo"));
//		System.out.println(mr.getParameter("postNo"));
//		int postNo = Integer.parseInt(mr.getParameter("postNo"));
//		String postTitle = mr.getParameter("postTitle");
//		String postContent = mr.getParameter("postContent");
//		
//		renamePolicy.setMemberNo(memberNo);
//		renamePolicy.setPostNo(postNo);
//		renamePolicy.setImgSeq(order);
//		
//		try {
//	        //4.  결과 처리
//	        String msg = "게시글 등록 성공 :)", loc = "/board/list";
//	        if(post.getPostNo() == 0) {
//	        	msg = "게시글 등록 실패 :(";
//	        	loc = "/post/uploadpost";
//	        }
//	        
//	        request.setAttribute("msg", msg);
//	        request.setAttribute("loc", loc);
//	        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
//	               .forward(request, response);
//		} catch (Exception e) {
//			e.printStackTrace();
//			request.setAttribute("msg", "게시글 등록 중 오류 발생");
//	        request.setAttribute("loc", "/post/uploadpost");
//	        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
//	               .forward(request, response);
//		}
		

        try {
            // 1. 파일 업로드 처리
        	MultipartRequest mr = handleFileUpload(request);
            
            // 2. 게시글 기본 정보 처리
            Post1 post = createPostFromRequest(mr);
            
            // 3. 이미지 정보 처리
            List<Image1> images = createImagesFromUpload(mr);
            System.out.println("1."+images);
            // 4. 서비스 호출하여 저장
            Post1 savedPost = postService.savePostWithImages(post, images);
            
            // 5. 결과 처리
            handleResponse(request, response, savedPost);
            
        } catch (Exception e) {
            handleError(request, response, e);
        }
	}

	private MultipartRequest handleFileUpload(HttpServletRequest request) throws Exception {
	    String path = getServletContext().getRealPath("/resources/upload/post");
	    return new MultipartRequest(
	        request, 
	        path, 
	        1024*1024*100, 
	        "utf-8",
	        new DefaultFileRenamePolicy() // CustomFileRenamePolicy 대신 기본 정책 사용
	    );
	}

    private Post1 createPostFromRequest(MultipartRequest mr) {
        return Post1.builder()
                .postTitle(mr.getParameter("postTitle"))
                .postContent(mr.getParameter("postContent"))
                .member(Member1.builder()
                        .memberNo(Integer.parseInt(mr.getParameter("memberNo"))) // 여기서는 예외처리를.. 안해줘도 되겠니? 무조건 받아올 값이니까?
                        .build())
                .categoryNo(Integer.parseInt(mr.getParameter("categoryNo")))
                .status(Integer.parseInt(mr.getParameter("status")))
                .isPublic(Integer.parseInt(mr.getParameter("isPublic")))
                .build();
    }

    private List<Image1> createImagesFromUpload(MultipartRequest mr) {
        List<Image1> images = new ArrayList<>();
        int order = 0;
        
        @SuppressWarnings("unchecked")
        Enumeration<String> fileNames = mr.getFileNames();  // MultipartRequest의 메서드 사용
        System.out.println("==== 파일 처리 시작 ====");

        // fileNames 목록 먼저 확인
        List<String> namesList = new ArrayList<>();
        while(fileNames.hasMoreElements()) {
            namesList.add(fileNames.nextElement());
        }
        System.out.println("전체 파일 name 속성들: " + namesList);

        // 다시 enumeration 얻기 (위에서 소진했으므로)
        fileNames = mr.getFileNames();
        
        while(fileNames.hasMoreElements()) {
            String fileName = fileNames.nextElement();
            
            // upfile로 시작하는 name attribute만 처리
            if(fileName.startsWith("upfile")) {
                String oriname = mr.getOriginalFileName(fileName);
                String renamed = mr.getFilesystemName(fileName);
            
	            if (oriname != null) {
	                Image1 image = Image1.builder()
	                        .imgSeq(order++)
	                        .oriname(oriname)
	                        .renamed(renamed)
	                        .build();
	                images.add(image);
	                System.out.println("이미지 추가됨: " + image);
	            }
            }
        }
        System.out.println("최종 이미지 목록 크기: " + images.size());
        System.out.println("==== 파일 처리 완료 ====");
        return images;
    }

    private void handleResponse(HttpServletRequest request, HttpServletResponse response, Post1 post) 
            throws ServletException, IOException {
        String msg = post.getPostNo() > 0 ? "게시글 등록 성공 :)" : "게시글 등록 실패 :(";
        String loc = post.getPostNo() > 0 ? "/board/list" : "/post/uploadpost";
        
        request.setAttribute("msg", msg);
        request.setAttribute("loc", loc);
        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e) 
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("msg", "게시글 등록 중 오류 발생: " + e.getMessage());
        request.setAttribute("loc", "/post/uploadpost");
        request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
    }
    
}
