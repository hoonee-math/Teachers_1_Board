package com.ttt.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Post1;

public class BoardDao {
	
	public List<Post1> selectBoardByCategory(SqlSession session, int categoryNo){
		return session.selectList("board.selectBoardByCategory",categoryNo);
	}
}
