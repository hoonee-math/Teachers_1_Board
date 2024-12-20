package com.ttt.controller.post;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.ttt.common.SqlSessionTemplate;

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
		
		response.setContentType("text/html;charset=UTF-8");
		
		List<String> result = new ArrayList<>();
	
		try {
			SqlSession session = SqlSessionTemplate.getSession();
			System.out.println(session);
			result = session.selectList("post.selectRegion");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String sql = "SELECT DISTINCT REGION FROM SCHOOL12";
////		List<String> result = new ArrayList<>();
//		
//		try {
//			Class.forName("oracle.jdbc.driver.OracleDriver");
//			conn = DriverManager.getConnection("jdbc:oracle:thin:@3.34.104.219:8877:xe","teachers","tryteam");

            // 연결 상태 확인
//            System.out.println("DB 연결 상태: " + (!conn.isClosed() ? "성공" : "실패"));
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			System.out.println("1");
//			while (rs.next()) {
//				String region = rs.getString("REGION");
//				System.out.println("rs : " + rs);
//				result.add(region);
//				System.out.println(region);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(rs!=null && !rs.isClosed()) rs.close();
//				if(pstmt!=null && !pstmt.isClosed()) pstmt.close();
//				if(conn!=null && !conn.isClosed()) conn.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		System.out.println("Retry" + result);
		request.setAttribute("regions", result);
		
		request.getRequestDispatcher("/WEB-INF/views/post/uploadPost.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
