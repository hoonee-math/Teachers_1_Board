package com.ttt.dao;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.Member1;

/* MemberService 클래스로부터 session 을 넘겨받아 실행시킬 쿼리문을 함수로 만들어 결과를 반환하는 클래스 */
public class MemberDao {

	public int insertMember(SqlSession session, Member1 m) {
		return session.insert("member.insertMember",m);
	}
	
	public Member1 selectMemberById(SqlSession session, String email) {
		return session.selectOne("member.selectMemberById",email);
	}
	
	public Member1 selectMemberByNameAndEmail(SqlSession session, Member1 m) {
		return session.selectOne("member.selectMemberByNameAndEmail",m);
	}
	
	public int updatePassword(SqlSession session, Member1 m) {
		return session.update("member.updatePassword", m);
	}
}
