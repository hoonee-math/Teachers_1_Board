package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image1 {
	private int imgNo;
	private int imgSeq;
	private String oriname;
	private String renamed;
	private int postNo;
}
