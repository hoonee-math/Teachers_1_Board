package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.PostDao;
import com.ttt.dto.Image1;
import com.ttt.dto.Post1;

public class PostService {
	private PostDao dao = new PostDao();
	
	public int uploadPost(Post1 p) {
		SqlSession session = getSession();
		int result = dao.uploadPost(session, p);
		if (result>0) session.commit();
		else session.rollback();
		
		session.close();
		return result;
	}
	public List<Image1> selectImgAll() {
		SqlSession session = getSession();
		List<Image1> childImgs = dao.selectImgAll(session);
		session.close();
		return childImgs;
	}
	public int insertPost(Post1 p) {
		SqlSession session = getSession();
		int result = dao.insertPost(session, p) ;
		if(result>0) session.commit();
		else session.rollback();
		
		session.close();
		return result;
	}
	public Post1 selectBoardJoinCommentJoinMember (int postNo) {
		SqlSession session = getSession();
		Post1 p = dao.selectBoardJoinCommentJoinMember(session, postNo);
		session.close();
		return p;
	}
	
	public Post1 insertPostAndGetNo(Post1 post) {
		SqlSession session = getSession();
		try {
			int result = dao.insertPost(session, post);
			if(result > 0) {
				int postNo = dao.selectLastPostNo(session);
				post.setPostNo(postNo);
				session.commit();
			}
			return post;
		} catch(Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
}
