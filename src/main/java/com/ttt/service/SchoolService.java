package com.ttt.service;

import static com.ttt.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ttt.dao.SchoolDao;
import com.ttt.dto.School12;

public class SchoolService {

	private SchoolDao dao=new SchoolDao();
	
	public List<School12> selectNameAndCode(Map<String,Object> inputSchoolInfo) {
		SqlSession session=getSession();
		List<School12> result=dao.selectNameAndCode(session,inputSchoolInfo);
		session.close();
		return result;
		
	}

}
