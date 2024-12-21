package com.ttt.common.exception;

public class LoginCheckException extends RuntimeException { //tomcat 이 예외처리를 인지하게 하려면 RuntimeException 을 상속받아야함
	
	public LoginCheckException(String msg) {
		// 예외 발생 시간등의 정보도 담아서 저장시킬 수 있음
		super(msg);
	}
}
