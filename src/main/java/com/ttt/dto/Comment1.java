package com.ttt.dto;

import com.ttt.dao.Date;
import com.ttt.dao.Member1;
import com.ttt.dao.Post1;

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
