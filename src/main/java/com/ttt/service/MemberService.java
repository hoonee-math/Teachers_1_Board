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
		int result=dao.insertMember(session,m);
		return result;
	}
}
