package com.ttt.controller.post;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT DISTINCT REGION FROM SCHOOL12";
		List<String> result = new ArrayList<>();
		
		try {
			Class.forName("session에서 driver 가져오기 ");
			conn = DriverManager.getConnection("session에서 url 가져오기 ","user","pw");
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String region = rs.getString("REGION");
				result.add(region);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null && !rs.isClosed()) rs.close();
				if(pstmt!=null && !pstmt.isClosed()) pstmt.close();
				if(conn!=null && !conn.isClosed()) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("SCHOOL12", result);
		
		request.getRequestDispatcher("/WEB-INF/views/post/uploadPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
