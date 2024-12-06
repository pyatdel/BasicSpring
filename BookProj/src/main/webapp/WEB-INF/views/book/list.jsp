<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<title>도서 목록</title>
</head>
<body>
	<h2>도서 목록</h2>
	<p>
		<!-- action속성 및 값이 생략 시, 현재 URI(/list)를 재요청. 
		method는 GET(form 태그의 기본 HTTP 메소드는 GET임) 
		param : keyword=알탄
		요청URI : /list?keyword=알탄 or /list or /list?keyword=
		요청파라미터 : keyword=알탄
		요청방식 : get
		
		EL에서 keyword=설 : param
		-->
		<form>
			<input type="text" name="keyword" 
				value="${param.keyword}" placeholder="검색어를 입력해주세요" />
			<!-- submit(생략 시 기본) / button / reset -->
			<button type="submit">검색</button>
		</form>
	</p>
	<hr />
	<p>
		<table border="1">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>카테고리</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
				<!-- 
				forEach 태그? 배열(String[], int[][]), Collection(List, Set) 또는 
				Map(HashTable, HashMap, SortedMap)에 저장되어 있는 값들을 
				순차적으로 처리할 때 사용함. 자바의 for, do~while을 대신해서 사용함
				var : 변수
				items : 아이템(배열, Collection, Map)
				varStatus : 루프 정보를 담은 객체 활용
					- index : 루프 실행 시 현재 인덱스(0부터 시작)
					- count : 실행 회수(1부터 시작. 보통 행번호 출력)
				 -->
				<c:forEach var="bookVO" items="${bookVOList}" varStatus="stat">
					<tr>
						<td>${stat.count}</td>
						<td>${bookVO.title}</td>
						<td>${bookVO.category}</td>
						<td>${bookVO.price}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</p>
</body>
</html>