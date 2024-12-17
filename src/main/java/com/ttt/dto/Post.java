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
public class Post {
	private int postNo;
	private String postWriter;
	private String postTitle;
	private String postContent;
	private int view_count;
	private int like_count;
	private Date createdDate;
	private Date updateDate;
	private int status;
	private int isNotsecret;
	private int isNotice;

}
