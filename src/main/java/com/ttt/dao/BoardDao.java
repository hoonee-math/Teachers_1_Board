package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Post1;

public class BoardDao {
	
	public List<Post1> selectIndexPageBoardListByCategoryNo(SqlSession session, int categoryNo){
		return session.selectList("board.selectIndexPageBoardListByCategoryNo",categoryNo);
	}
	
	// cPage값과 numPerPage 값을 이용해 페이징처리를 위한 RowBounds 객체 생성
	public List<Post1> selectBoardListAllCategory(SqlSession session, Map<String, Integer> param){
		
		int cPage=param.get("cPage");
		int numPerPage=param.get("numPerPage");

		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.selectBoardListAllCategory",null,rb);
	}
	
	// cPage값과 numPerPage 값을 이용해 페이징처리를 위한 RowBounds 객체 생성 및 categoryNo mapper 로 넘겨주기
	public List<Post1> selectBoardListByCategoryNo(SqlSession session, Map<String, Integer> param){
		
		int cPage=param.get("cPage");
		int numPerPage=param.get("numPerPage");
		int categoryNo=param.get("categoryNo"); // mapper 에는 categoyNo 만 전달 

		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.selectBoardListAllCategory",categoryNo,rb);
	}

	// 쿼리문을 실행키셔 totalData 값(int)을 받아오는 view
	public int selectBoardCountAll(SqlSession session) {
		return session.selectOne("board.selectBoardCountAll");
	}
		
	// 쿼리문을 실행키셔 totalData 값(int)을 받아오는 view
	public int selectBoardCountByCategoryNo(SqlSession session, int categoryNo) {
		return session.selectOne("board.selectBoardCountByCategoryNo",categoryNo);
	}
	
	//내가 작성한 글을 가져오기 위한 쿼리문을 실행시킬 함수
	public List<Post1> selectBoardListByMemberNo(SqlSession session, Map<String,Integer> param){

		int cPage=param.get("cPage");
		int numPerPage=param.get("numPerPage");
		int memberNo=param.get("memberNo"); // mapper 에는 categoyNo 만 전달 

		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.selectBoardListByMemberNo",memberNo,rb);
	}
	public int selectBoardCountByMemberNo(SqlSession session, int memberNo) {
		return session.selectOne("board.selectBoardCountByMemberNo",memberNo);
	}
	
}
