package com.example.demo.collection;

public class Student extends People{
	private String grade;
	private String classNo;
	private String no;
	
	public Student () {
		
	}
	
	public Student(
		String name,
		String age,
		String sex,
		String grade,
		String classNo,
		String no
			) {
		
			this.setName(name);
			this.setAge(age);
			this.setSex(sex);
			
			this.grade = grade;
			this.classNo = classNo;
			
	}
	
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getClassNo() {
		return classNo;
	}
	public void setClassNo(String classNo) {
		this.classNo = classNo;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	@Override
	public String toString() {
		return "Student [grade=" + grade + ", classNo=" + classNo + ", no=" + no + "]"+super.toString();
	}
	
}
