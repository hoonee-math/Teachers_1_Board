package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Comment1 {
	private int commentNo;
	private int parentNo;
	private String comment;
	private Date createDate;
	private Date updateDate;
	private int level;
	private Member1 member;
	private Post1 post;

}
