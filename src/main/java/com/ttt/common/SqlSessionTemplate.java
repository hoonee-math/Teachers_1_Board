package com.ttt.common;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionTemplate {
	public static SqlSession getSession() {
	      SqlSession session=null;
	      String fileName="mybatis-config.xml";
	      try(InputStream config=Resources.getResourceAsStream(fileName)){  
	         SqlSessionFactoryBuilder sfb=new SqlSessionFactoryBuilder();
	         SqlSessionFactory factory=sfb.build(config);
	         session=factory.openSession(false);
	         
	      } catch(IOException e) {
	         e.printStackTrace();
	      }
	      return session;
	   }
}
