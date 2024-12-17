package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Post;

public class PostDao {
	public int uploadPost(SqlSession session, Post p) {
		return session.insert("post.insertPost",p);
	}
}
