package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Post1;

public class PostDao {
	public int uploadPost(SqlSession session, Post1 p) {
		return session.insert("post.insertPost",p);
	}
}
