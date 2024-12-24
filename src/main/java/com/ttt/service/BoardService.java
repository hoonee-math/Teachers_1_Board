package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.BoardDao;
import com.ttt.dto.Post1;

public class BoardService {
	
	private BoardDao dao=new BoardDao();

	// categotyNo 값을 받아서 index.jsp 의 각 섹션에 맞는 글 목록을 view 해주는 서비스
	public List<Post1> selectIndexPageBoardListByCategoryNo(int categoryNo){
		SqlSession session=getSession();
		return dao.selectIndexPageBoardListByCategoryNo(session, categoryNo);
	}
	
	//cPage, numPerPage 값을 받아서 해당 카테고리에 맞는 글 목록을 view 해주는 서비스
	public List<Post1> selectBoardListAllCategory(Map<String, Integer> param){
		SqlSession session=getSession();
		return dao.selectBoardListAllCategory(session, param);
	}

	// categotyNo, cPage, numPerPage 값을 받아서 해당 카테고리에 맞는 글 목록을 view 해주는 서비스
	public List<Post1> selectBoardListByCategoryNo(Map<String, Integer> param){
		SqlSession session=getSession();
		return dao.selectBoardListAllCategory(session, param);
	}
	
	// (totalData) 카테고리별 게시글 수를 확인시켜주는 서비스
	public int selectBoardCountAll() {
		SqlSession session=getSession();
		return dao.selectBoardCountAll(session);
	}
	
	// (totalData) 전체 게시글 수를 확인시켜주는 서비스
	public int selectBoardCountByCategoryNo(int categoryNo) {
		SqlSession session=getSession();
		return dao.selectBoardCountByCategoryNo(session, categoryNo);
	}
	
	// 내가 작성한 글 리스트를 가져오기 위해 DB와 통신하는 서비스
	public List<Post1> selectBoardListByMemberNo(Map<String,Integer> param){
		SqlSession session=getSession();
		return dao.selectBoardListByMemberNo(session, param);
	}
	// (totalData) 내가 작성한 글 전체 게시글 수 확인
	public int selectBoardCountByMemberNo(int memberNo) {
		SqlSession session=getSession();
		return dao.selectBoardCountByMemberNo(session, memberNo);
	}
	
	
}
