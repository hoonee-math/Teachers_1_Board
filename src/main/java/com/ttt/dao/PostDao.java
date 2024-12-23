package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Image1;
import com.ttt.dto.Post1;

public class PostDao {
	public int uploadPost(SqlSession session, Post1 p) {
		return session.insert("post.insertPost",p);
	}
	public List<Image1> selectImgAll(SqlSession session) {
		return session.selectList("post.selectImgAll");
	}
	public int insertPost(SqlSession session, Post1 p) {
		return session.insert("post.insertPost", p);
	}
	public Post1 selectPostJoinCommentByNo(SqlSession session, int postNo) {
		return session.selectOne("post.selectPostJoinCommentByNo", postNo);
	}
}
