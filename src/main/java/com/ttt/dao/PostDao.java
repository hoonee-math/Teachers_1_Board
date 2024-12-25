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
	public Post1 selectBoardJoinCommentJoinMember(SqlSession session, int postNo) {
		return session.selectOne("post.selectBoardJoinCommentJoinMember", postNo);
	}
	public List<Image1> selectImageNo(SqlSession session, int postNo) {
		return session.selectList("post.selectImageNo", postNo);
	}
	public int selectCategoryNo(SqlSession session, int postNo) {
		return session.selectOne("post.selectCategoryNo", postNo);
	}
	// savePostWithImages 서비스 이용을 위해 재사용
	public int insertPostAndGetNo(SqlSession session, Post1 post) {
		int result = session.insert("post.insertPost", post);
	    if(result <= 0) {
	        throw new RuntimeException("게시글 저장 실패"); // 저장 실패한 경우를 처리해줘야함. 반환값이 0이되면 안됨.
	    }
	    return post.getPostNo();
	}
	public int insertPostImage(SqlSession session, Image1 image) {
		return session.insert("post.insertPostImage", image);
	}
	//조회수 기능 구현
	public int updatePostReadCount(SqlSession session, int postNo) {
		return session.update("post.updatePostReadCount", postNo);
	}
}
