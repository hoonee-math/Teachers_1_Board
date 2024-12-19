package com.ttt.controller.post;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/post/uploadpost")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UploadServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String path = getServletContext().getRealPath("/resources/upload/post");
////		MultipartRequest mr = new MultipartRequest(
////				request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
//		String postTitle = request.getParameter("postTitle");
//		String postContent = request.getParameter("postContent");
//		String postWriter = request.getParameter("postWriter");
//		
//		Post1 p = Post1.builder()
//				.postTitle(postTitle)
//				.postContent(postContent)
//				.build();
//		
//		int result = new PostService().uploadPost(p);
//		String msg, loc;
//		if (result>0) {
//			msg = "게시글 등록 성공!";
//			loc = "/allboard.main";
//		} else {
//			msg = "게시글 등록 실패";
//			loc = "/uploadpost.do";
//		}
//		request.setAttribute("msg", msg);
//		request.setAttribute("loc", loc);
		
		List<String> regions = new ArrayList<>();
		String url = "jdbc:oracle:thin:@3.34.104.219:8877:xe";
		String id = "teachers";
		String pw = "tryteam";
		Connection conn = null;
		
		try{
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, id, pw);
//		
//			 Statement stmt = conn.createStatement();
//			 ResultSet rs = stmt.executeQuery("SELECT DISTINCT REGION_CONDE FROM SCHOOL12"); {
//			
//			while(rs.next()) {
//				String region = rs.getString("REGION_CODE");
//			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			conn.close();
		}
		
		request.setAttribute("regions", regions);
		request.getRequestDispatcher("/WEB-INF/views/post/uploadPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
