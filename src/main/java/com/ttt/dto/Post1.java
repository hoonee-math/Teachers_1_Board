package com.ttt.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Post1 {
	private int categoryNo;
	private int postNo;
	private Member1 member;
	private String postTitle;
	private String postContent;
	private int viewCount;
	private int likeCount;
	private Date createdDate;
	private Date updateDate;
	private int status;
	private int isPublic;
	private int isNotice;
	private int commentCount;
	private List<Image1> images;
	private School12 school;
	private List<Comment1> comments;
}
