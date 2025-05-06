package com.example.demo.gwang;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

public class SampleVO {
	public static void main(String[] args) {
		// svn실습을 위한 샘플
//		String nameA = "홍길동";
//		String nameB = "홍길동";
//		String nameC = new String("홍길동");
//		String nameD = new String("홍길동");
//		
//		System.out.println(nameA == nameB);
//		System.out.println(nameA == nameC);
//		System.out.println(nameC == nameD);
//		System.out.println(nameC.equals(nameD));
//		
		
		String name = null;
		
//		System.out.println("홍길동".equals(name)); //2
		// 상수값을 앞으로 두고 변수값을 뒤로 
//		System.out.println(name != null && name.equals("홍길동")); //1
//		System.out.println(name != null & name.equals("홍길동")); //2
		// 두개다 실행해 보고 null 해서 오류가난다.
		
//		List<String> lines = new ArrayList<String>();
//		for(int i =0; i < 100; i++) {
//			lines.add("샘플데이터 생성 라인"+(i+1)+ "번쨰");
//		}
//		File file = new File("D:/temp/filetest.txt");
//		
//		try {
//			FileUtils.writeLines(file, lines, true);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		/*
		
		try {
			File file = new File("D:/temp/filetest.txt");
			List<String> lines = FileUtils.readLines(file, "UTF-8");
			System.out.println("lines.size():" +lines.size());
			for(String line:lines) {
				System.out.println(line);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		
		String fullFileName = "D:/temp/filetest.txt";
		
		System.out.println(FilenameUtils.getBaseName(fullFileName));
		System.out.println(FilenameUtils.getExtension(fullFileName));
		System.out.println(FilenameUtils.getPath(fullFileName));
		System.out.println(FilenameUtils.getName(fullFileName));
		System.out.println(FilenameUtils.getPrefix(fullFileName));
		System.out.println(UUID.randomUUID().toString());
		
		
		String fullFileName2 = "D:/upload_files/img.png";
		
		System.out.println(FilenameUtils.getBaseName(fullFileName2));
		System.out.println(FilenameUtils.getExtension(fullFileName2));
		System.out.println(FilenameUtils.getPath(fullFileName2));
		System.out.println(FilenameUtils.getName(fullFileName2));
		System.out.println(FilenameUtils.getPrefix(fullFileName2));
		System.out.println(UUID.randomUUID().toString());
		
//		for(int i=0; i < 10; i++) {
//			for(int j= 0; j<i; j++) {
//					System.out.print("*");
//			}
//			System.out.println("");
//		}
		
		
		// 1 2 3 4 5
		// 1 3 5 7 9
		// 4 3 2 1 0
		int lineCnt = 5;
		for(int i =0; i < lineCnt+1; i++) {
			for(int k = lineCnt-i; k > 0; k--) {
				System.out.print(" ");
			}
			for(int j=0; j < i*2-1; j++) {
				System.out.print("*");
			}
			
			System.out.println("");
		}
		
		
		
		
	}
	
	
	

}
