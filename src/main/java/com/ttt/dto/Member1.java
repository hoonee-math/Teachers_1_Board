package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member1 {
	private int memberNo;
	private String memberName;
	private String email;
	private String memberPw;
	private String memberNick; // 닉네임 중복시 뒤에 번호 추가하는건 어떤지 의논해보기(자동부여)
	private int memberType; // 관리자:0 학부모:1 교사:2
	private School12 childSchool; // 자녀중 대표 한 명의 학교만 저장	
	private Date enrollDate;
}
