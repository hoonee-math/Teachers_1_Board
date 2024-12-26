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
		
		Comment1 c=Comment1.builder()
				.post(p)
				.member(m)
				.level(level)
				.parentNo(parentNo)
				.commentContent(commentContent)
				.build();
		
		int result=new Comment1().insertPostComment(c);
		
		String msg,loc="/board/boardview.do?boardNo="+postNo;
		if(result>0) {
			msg="댓글 등록 성공";
		} else {
			msg="댓글 등록 실패";
		}
		request.setAttribute("msg",msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(getServletContext().getInitParameter("viewpath")+"/common/msg.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
