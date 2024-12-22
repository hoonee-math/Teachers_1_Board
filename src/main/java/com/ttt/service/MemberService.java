package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.MemberDao;
import com.ttt.dto.Member1;

/* Connection 과 MemberDao 객체를 만들어서 서버와 db 서버가 서로 통신할 수 있게 서비스를 제공하는 클래스 */
public class MemberService {
	
	private MemberDao dao=new MemberDao();
	
	public int insertMember(Member1 m) {
		SqlSession session=getSession();
	    int result = 0;
	    try {
	        result = dao.insertMember(session, m);
	        if(result > 0) {
	            session.commit();
	        } else {
	            session.rollback();
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	        session.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
		return result;
	}
	
	public Member1 selectMemberById(String email) {
		SqlSession session=getSession();
		return dao.selectMemberById(session, email);
	}
}
