package com.ttt.common;

import java.io.File;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class CustomFileRenamePolicy implements FileRenamePolicy {
	private int memberNo;
	private int postNo;
	private int imgSeq;
	
	public CustomFileRenamePolicy (int memberNo, int postNo, int imgSeq) {
		this.memberNo = memberNo;
		this.postNo = postNo;
		this.imgSeq = imgSeq;
	}
	
	@Override
	public File rename(File file) {
		//기존 파일 확장자 추출 
		String oriname = file.getName();
		String ext = "";
		
		int dotIndex = oriname.lastIndexOf(".");
		if (dotIndex != -1) {
			ext = oriname.substring(dotIndex);
		}
		
		//새로운 파일 이름 생성
		String rename = memberNo+"_"+postNo+"_"+imgSeq+ext;
		
		//파일 객체 생성
		File newFile = new File(file.getParent(), rename);
		
		return newFile;
	}
}
