package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
		
		MultipartRequest mr = new MultipartRequest(
				request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy()
				);
		
		String category = mr.getParameter("category");
		String region = mr.getParameter("region");
		String district = mr.getParameter("district");
		String schoolName = mr.getParameter("schoolName");
		String postTitle = mr.getParameter("postTitle");
		String postWriter = mr.getParameter("postWriter");
		String postContent = mr.getParameter("postContent");
		
		String oriname = mr.getOriginalFileName("upfile");
		String rename = mr.getFilesystemName("upfile");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
