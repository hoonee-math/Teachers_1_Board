package com.ttt.controller.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ttt.dto.Comment1;
import com.ttt.dto.Member1;
import com.ttt.dto.Post1;
import com.ttt.service.PostService;

@WebServlet("/post/insertcomment.do")
public class InsertCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertCommentServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int memberNo=Integer.parseInt(request.getParameter("memberNo"));
		int postNo=Integer.parseInt(request.getParameter("postNo"));
		int level=Integer.parseInt(request.getParameter("level"));
		int parentNo=Integer.parseInt(request.getParameter("parentNo"));
		String commentContent=request.getParameter("commentContent");
		
		Post1 p= new Post1();
		p.setPostNo(postNo);
		Member1 m= new Member1();
		m.setMemberNo(memberNo);
		System.out.println("서블릿 post 객체:" + p);
		System.out.println("서블릿 멤버 객체 :"+ m);
		
		Comment1 c=Comment1.builder()
				.post(p)
				.member(m)
				.level(level)
				.parentNo(parentNo)
				.commentContent(commentContent)
				.build();
		System.out.println("서블릿 댓글 객체"+c);
		int result=new PostService().insertPostComment(c);
		
		String msg,loc="/post/viewpost?postNo="+postNo;
		if(result>0) {
			msg="댓글 등록 성공";
		} else {
			msg="댓글 등록 실패";
		}
		request.setAttribute("msg",msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
