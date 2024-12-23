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
	public Post1 selectBoardByNo (int postNo) {
		SqlSession session = getSession();
		Post1 p = dao.selectBoardByNo(session, postNo);
		session.close();
		return p;
	}
}
