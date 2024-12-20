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

import com.google.gson.Gson;
import com.ttt.common.SqlSessionTemplate;

/**
 * Servlet implementation class SchoolServlet
 */
@WebServlet("/post/school")
public class SchoolServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SchoolServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String district = request.getParameter("district");
		List<String> schools = new ArrayList<>();
		
		try {
			SqlSession session = SqlSessionTemplate.getSession();
			schools = session.selectList("post.selectSchool",district);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setContentType("application/json;charset=UTF-8");
		new Gson().toJson(schools, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
