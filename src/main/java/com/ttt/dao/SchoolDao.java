package com.ttt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dto.School12;

/* 서비스 클래스로부터 session 을 넘겨받아 쿼리문을 실행하는 클래스 */
public class SchoolDao {
	
	public List<School12> selectNameAndCode(SqlSession session, Map<String,String> inputInfo){
		return session.selectList("school12.selectNameAndCode",inputInfo);
	}
}
