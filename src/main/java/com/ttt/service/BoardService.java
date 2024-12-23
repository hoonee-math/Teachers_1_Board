package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.BoardDao;
import com.ttt.dto.Post1;

public class BoardService {
	
	private BoardDao dao=new BoardDao();
	
	public List<Post1> selectIndexPageBoardListByCategoryNo(int categoryNo){
		SqlSession session=getSession();
		return dao.selectBoardByCategory(session, categoryNo);
	}
}
