package com.ttt.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/* PasswordEncryptFilter.java 필터를 통해 받아온 비밀번호를 암호화 해주는 객체 */
public class PasswordEncoding extends HttpServletRequestWrapper {
	
	public PasswordEncoding(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String name) {
		String oriVal=super.getParameter(name); // super는 위에서 request를 변환한 값을 가져오기 때문에! key값으로 받아온 값을 저장시킴!
		if(name.equals("password")) {
			String encStr=getSHA512(oriVal);
			return encStr;
		}
		return oriVal;
	}
	
	private String getSHA512(String orival) {
		//java.security.MessageDigest 클래스 이용
		MessageDigest md=null;
		
		try {
			//암호화 알고리즘 선택
			md=MessageDigest.getInstance("SHA-512");
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		byte[] orivalByte=orival.getBytes();
		md.update(orivalByte);
		byte[] encByte=md.digest();
		String encStr=Base64.getEncoder().encodeToString(encByte);
		return encStr;
	}
	
}
