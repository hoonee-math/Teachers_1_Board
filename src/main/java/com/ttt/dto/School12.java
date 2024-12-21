package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class School12 {
	private int schoolNo;
	private String region;
	private String district;
	private String schoolName;
	private int schoolType; /* 1:초등학교 2:중학교 3:고등학교 4:기타학교 */ 
	private int regionCode;
	private int standardCode;

}
