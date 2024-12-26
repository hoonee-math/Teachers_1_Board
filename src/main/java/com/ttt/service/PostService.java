package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.sql.SQLException;
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
	public Post1 insertPost(Post1 post, List<Image1> images) {
		SqlSession session = getSession();
		try {
			//1. 게시글 저장하고 번호 받아오기 
			int postNo = dao.insertPostAndGetNo(session, post);
            post.setPostNo(postNo);
            
            // 2. 이미지가 있으면 이미지 정보 저장
            if(images != null && !images.isEmpty()) {
                for(Image1 image : images) {
                    image.setPostNo(postNo);
                    dao.insertPostImage(session, image);
                }
            }
            session.commit();
            return post;
		} catch(Exception e) {
			session.rollback();
			throw e;
		} finally {
			session.close();
		}
	}
	public Post1 selectBoardJoinCommentJoinMember (int postNo, boolean readResult) {
		SqlSession session = getSession();
		Post1 p = dao.selectBoardJoinCommentJoinMember(session, postNo);
		if(p!=null && !readResult) {
			int result = dao.updatePostReadCount(session, postNo);
			if( result>0) {
				session.commit();
				p.setViewCount(p.getViewCount()+1);
			}
			else session.rollback();
		}
		session.close();
		return p;
	}
	public List<Image1> selectImageNo(int postNo) {
		SqlSession session = getSession();
		List<Image1> img = dao.selectImageNo(session, postNo);
		session.close();
		return img;
	}
	public int selectCategoryNo(int postNo) {
		SqlSession session = getSession();
		int categoryNo = dao.selectCategoryNo(session, postNo);
		session.close();
		return categoryNo;
	}
	public String selectSchoolName(int memberNo) {
		SqlSession session = getSession();
		String schoolName = dao.selectSchoolName(session, memberNo);
		session.close();
		return schoolName;
	}
//	public Post1 insertPostAndGetNo(Post1 post) {
//		SqlSession session = getSession();
//		try {
//			int result = dao.insertPost(session, post);
//			if(result > 0) {
//				int postNo = dao.selectLastPostNo(session);
//				post.setPostNo(postNo);
//				session.commit();
//			}
//			return post;
//		} catch(Exception e) {
//			session.rollback();
//			e.printStackTrace();
//		} finally {
//			session.close();
//		}
//	}
	
	// Post1 과 Image1을 동시에 저장하기 위한 트랜잭션관리 (postNo를 받아와서 image 저장 관리)
	public Post1 savePostWithImages(Post1 post, List<Image1> images) {
        SqlSession session = null;
        try {
            session = getSession();
            // 트랜잭션 시작 - autocommit false
            session.getConnection().setAutoCommit(false);

            // 1. 게시글 저장 및 번호 받아오기 
            int postNo = dao.insertPostAndGetNo(session, post);  // 실패시 예외 발생
            post.setPostNo(postNo);
            
            // 2. 이미지가 있으면 이미지 정보(객체)에 postNo set 해주기!
            if(images != null && !images.isEmpty()) {
                for(Image1 image : images) {
                    image.setPostNo(postNo);
                    int result = dao.insertPostImage(session, image);
                    if(result <= 0) {
                        throw new RuntimeException("이미지 저장 실패"); // (1) 여기서 예외 발생
                    }
                }
            }
            
            // 모든 작업이 성공하면 커밋
            session.commit();
            return post;

        } catch(Exception e) { // (2) 위에서 발생한 RuntimeException은 여기서 캐치
            // 실패시 롤백
            if(session != null) session.rollback(); // (3) 롤백 처리
            throw new RuntimeException("게시글 저장 중 오류 발생", e); // (4) 새로운 예외로 감싸서 던짐 - 필요한지 검토해보기.
        } finally {
            // 세션 종료
            if(session != null) {
                try {
                    session.getConnection().setAutoCommit(true); // autocommit 상태 복구
                    session.close();
                } catch(SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
