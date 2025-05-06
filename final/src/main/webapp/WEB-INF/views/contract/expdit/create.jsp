<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">





<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />
<script type="text/javascript" src="/js/jquery.min.js"></script>

<jsp:include page="../../include/preScript.jsp"></jsp:include>

<style>
.mb-4{
text-align: center !important;
font-size:1.5rem;
font-weight:normal;
}
#concrt{
	background-color: #f8f9ff;
	border-radius: 20px;
	margin-top:5%;

}
.form-floating>.form-control, .form-floating>.form-select{
height: 50px !important;
}
.cmcrtb{
border-radius: 10px;
padding: 5%;
}
.contb > tr{
height: 50px;

}
.tbhd{
background-color:FCFCFC;
border:FCFCFC; }

input{
outline: none !important;
height:35px;
border-radius:5px;
border:1px solid #bfbfbf;

}
.table-responsive{

height: 20%;
}
</style>
<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../../include/header.jsp"%>

<div>
	<div class="bg-light rounded h-100 p-4">
		<div id="tbhd">
			<h3 class="mb-4">거래처리스트</h3>
			<div class="d-flex mb-2 scb">
				<input class="form-control bg-transparent" name="keyword"
					id="scbar keyword" type="text" placeholder="검색어를 입력하세요.">
				<button type="button" id="scbar2" class="btn btn-primary ms-2">검색</button>
			</div>
		</div>
		<div class="table-responsive">
			<table class="table tbhd" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						
						<th scope="col"></th>
						<th scope="col">거래처번호</th>
						<th scope="col">사업자번호</th>
						<th scope="col">거래처명</th>
						<th scope="col">대표명</th>
						<th scope="col">사업유형</th>
						<th scope="col">거래처계약담당자</th>

					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>
		</div>
<form class="form-horizontal" id="form" name="form" action="/contract/createPost"
	method="post" enctype="multipart/form-data">
	<div class="bg-light rounded h-100 contcon">
		<h6 class="mb-4">계약등록</h6>
		<table class="table cmcrtb table-bordered">
			<tbody class="contb">
			<!-- <input type="hidden" class="updtcon" name="entNo"> -->
			
				<tr>
					<th scope="row">1</th>
					<td><code>*</code>계약코드</td>
					<td><input type="text" name="contractNo" class="updtcon" placeholder="ex : 20240101+001"
						 ></td>
				</tr>
				<tr>
					<th scope="row">2</th>
					<td><code>*</code>계약명</td>
					<td><input type="text" name="contractNm" class="updtcon" placeholder="계약명"></td>
				</tr>
				<tr>
					<th scope="row">3</th>
					<td><code>*</code>계약 타입</td>
					<td>
					 <select class="form-control" id="contractType" name="contractType">
		 					<option name="contractType" value="A"> 
                  				신규
                			</option>
		 					<option name="contractType" value="B"> 
                  				연장계약
                			</option>
		 					<option name="contractType" value="C"> 
                  				변경계약
                			</option>
                    </select>
                    </td>
				</tr>
				<tr>
					<th scope="row">4</th>
					<td ><code>*</code>계약 금액</td>
					<td><input type="text" name="contractPrice" 
						class="updtcon"  placeholder="계약금액"></td>
				</tr>
				<tr>
					<th scope="row">5</th>
					<td><code>*</code>계약기간</td>
					<td><input type="date" name="fromDate" class="updtcon cdate" > ㅡ <input class="cdate"name="toDate" type="date" ></td>
				</tr>
				<tr>
					<th scope="row">6</th>
					<td><code>*</code>계약 상태</td>
					<td> <select class="form-control" id="state" name="state">
		 					<option name="state" value="0"> 
                  				계약완료
                			</option>
		 					<option name="state" value="1"> 
                  				진행중
                			</option>
		 					<option name="state" value="2"> 
                  				완료
                			</option>
		 					<option name="state" value="3"> 
                  				취소
                			</option>
                    </select></td>
				</tr>
				<tr>
					<th scope="row">7</th>
					<td>계약 승인 일자</td>
					<td>
						<input type="date" name="approvalDate">	
					</td>
				</tr>
				<tr>
					<th scope="row">7</th>
					<td>계약 승인자</td>
					<td>
						<input type="text" name="approvalEmp">	
					</td>
				</tr>
				<tr>
					<th scope="row">7</th>
					<td>계약서 첨부</td>
					<td>
						<input type="file" name="uploadFiles">	
					</td>
				</tr>
				<tr>
					<th scope="row">8</th>
					<td><code>*</code>회사계약담당자</td>
					<td><input type="text" name="empNo" 
						class="updtcon"  placeholder="회사내부 계약담당자"></td>
				</tr>
				<tr>
					<th scope="row">9</th>
					<td>계약 메모</td>
					<td><textarea rows="3" cols="40" class="updtcon" name="entMemo" placeholder="계약메모"></textarea></td>
				</tr>
				<input type="number" id="selectedEpck" name="entNo" value="" style="display:none">

			</tbody>
		</table>
		
</form>	
<button type="submit" class="btn btn-primary btn-user">등록</button>
<span style="float: right;"> <a href="/contract/list"
		class="btn btn-success btn-user"> 목록 </a>
</span>
	<%-- <p>${enterPriceVOList}</p> --%>
</div>
<script type="text/javascript">


</script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<%@ include file="../../include/footer.jsp"%>

<!-- 메인 컨텐츠 영역 끝 -->