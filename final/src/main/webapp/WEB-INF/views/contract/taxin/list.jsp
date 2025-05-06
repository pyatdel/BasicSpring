<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>



<!-- 라이브러리 include  -->
   <jsp:include page="../../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
  
<style>
.tbc {
	background-color: 3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.page-item.active .page-link {
	background-color: 3069CE !important;
	border-color: 3069CE !important;
}

#example2_paginate ul {
	justify-content: center !important;
}

#tbhd {
	display: flex;
}

#scbar {
	height: 40px !important;
}

#scbar2 {
	font-size: 13px !important;
	height: 40px !important;
	width: 70px !important;
	background-color: 3069CE !important;
	border: none !important;
}

.scb {
	margin-left: auto !important;
	width: 20%;
}

.cona {
	color: white !important;
}

.conbtn {
	background-color: 3069CE !important;
	border: none !important;
}

td>a {
	color: 3069CE !important;
}

.contlist {
	font-weight: normal;
}

.maxwidth {
	max-width: 95%;
	margin: 0 auto !important;
}

.table {
	margin-top: 1%;
	border-color:  #FCFCFC !important;
}

.bg-transparent {
	height: 40px !important;
}
.taxindate{
display: flex;
margin-left: 3%;
}
.taxincontain{
background-color: #FCFCFC;
border-radius: 10px;
border: 1px solid #c4c4c4;

}
.datebtn{
text-align: center;
margin-bottom: 1%;



}
.databtn > button { 
margin: 0 !important;
}

.taxlist{

border: 1px solid #c4c4c4 !important;
}
.taxlist{
text-align: center;}
.Taxprice{
text-align: right;
padding-right: 20px !important;
}
.contCre{

font-size:1.75rem;
font-weight: normal;
padding:0 20px 30px 20px;

}


.taxinSub{
color:#3069CE !important;
font-weight: bold;

}
.contractSub {

display: block !important;
height: auto !important;

}
.contractSide ,.contractSide > .menu-icon > i {
color:#3069CE !important;
font-weight: bold;
}
.btn-user{
background-color: #3069CE !important;

color:white;
border:none;

}
.btn-success{
background-color: #278986 !important;

color:white;
border:none;


}
.mb-4{

font-weight: normal !important;
font-size: 1.75rem;
    padding: 0 20px 30px 20px;
}
.bluBt{
background-color: #3069CE;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}
.btBox{
display: flex;
    justify-content: flex-end;

}
.greenBt{
background-color: #278986;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin-left: 35%;

}
.page-item.active .page-link {
    z-index: 1;
    color: white;
    background-color: #3069CE !important;
    border-color: #3069CE !important;
}
.next > a{
    color: #3069CE !important;

}
.page-item > a{
    color: #3069CE ;
}
</style>

<!-- 메인 컨텐츠 영역 시작 -->
<%-- <p>${contractMasterVOList}</p> --%>
<%@ include file="../../include/header.jsp"%>
<div class="">
<%-- <div>${taxinvoiceVOList}</div> --%>
	<h3 class="mb-4">세금계산서 관리</h3>
	<div class="taxincontain">
	
	<div class="taxindate">
		<table class="table cmcrtb table-bordered">
			<tbody class="contb">
				<!-- <input type="hidden" class="updtcon" name="entNo"> -->

				<tr>
					<td>계약코드</td>
					<td><input type="number" name="contractNo" class="updtcon"
						placeholder="계약코드" value="${param.contractNo}"></td>
				</tr>
				<tr>
					<td>기간</td>
					<td><input type="date" name="tiTransdate" class="updtcon cdate">
						ㅡ <input class="cdate" name="tiIssuedate" type="date"></td>
				</tr>


			</tbody>
		</table>
		<table class="table cmcrtb table-bordered">
			<tbody class="contb">
				<!-- <input type="hidden" class="updtcon" name="entNo"> -->

				<tr>
					<td>거래처 상호</td>
					<td><input type="text" name="entName" class="updtcon"
						placeholder="거래처 상호명"></td>
				</tr>
				<tr>
					<td>사업자 등록번호</td>
					<td><input type="text" name="busNo" class="updtcon"
						placeholder="사업자등록번호"></td>
				</tr>



			</tbody>
		</table>
		
</div>
<div class="datebtn">
<button type="button" id="edit" class="bluBt">조회하기</button>
</div>
	</div>

	<table class="table table-bordered taxlist">
		<thead>
			<tr>
				<th scope="col">No.</th>
				<th scope="col">계산서 코드</th>
				<th scope="col">작성일자</th>
				<th scope="col">발급일자</th>
				<th scope="col">계약코드</th>
				<th scope="col">사업장번호</th>
				<th scope="col">상호</th>
				<th scope="col">공급가액</th>
				<th scope="col">부가가치세</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		
		<tbody id="tby">
			<c:forEach var="taxinvoiceVO" items="${articlePage.content}"
				varStatus="stat">
				<tr>
					<th scope="row">${taxinvoiceVO.rnum}</th>
					<td><a
						href="/taxin/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&tiCode=${taxinvoiceVO.tiCode}">${taxinvoiceVO.tiCode}</a></td>
					<td>${taxinvoiceVO.tiTransdate}</td>
					<td>${taxinvoiceVO.tiIssuedate}</td>
					<td>${taxinvoiceVO.contractNo}</td>
					<td>${taxinvoiceVO.busNo}</td>
					<td>${taxinvoiceVO.entName}</td>
					<td class="Taxprice">
					<fmt:formatNumber value="${taxinvoiceVO.tiSupplyprice}" pattern="#,###" />&nbsp; 원</td>
					<td  class="Taxprice">
					<fmt:formatNumber value="${taxinvoiceVO.tiVat}" pattern="#,###" />&nbsp;원</td>
					
					</td>
					<td>${taxinvoiceVO.tiRmrk}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="btBox">
	<center>
			<div class="row justify-content-center" id="divPagingArea">
				${articlePage.pagingArea}</div>
		</center>
	<button type="button" id="edit" class="greenBt conbtn"><a href="/taxin/create" class="cona">세금계산서 발행</a></button>
	</div>
<%@ include file="../../include/footer.jsp"%>
</div>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script>

function nvl(expr1, expr2) {
	   if (expr1 === undefined || expr1 == null || expr1 == "") {
	      expr1 = expr2;
	   }
	 return expr1;
	 }  

function selectLprodList(contractNo,entName,busNo,tiTransdate,tiIssuedate,busNo){
	let data = {
			  "currentPage":"1",
			  "contractNo":contractNo,
			 /*  "contractNo":contractNo, */
			  "entName":entName,
			  "busNo":busNo,
			  "tiTransdate":tiTransdate,
			  "tiIssuedate":tiIssuedate,
			}
	console.log("data : " , data);
	$.ajax({
		url:"/taxin/listAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"POST",
		dataType:"json",
		success:function(articlePage){
			console.log(" articlePage : " ,  articlePage);
			// articlePage.content : List<MemberVO>
			console.log("articlePage.content : ", articlePage.content);
			let str = "";
			$.each(articlePage.content , function(idx,taxinvoiceVO){
	               str += ` <tr>
	                   <td>\${taxinvoiceVO.rnum}</td>
	                   <td><a href="/taxin/detail?tiCode=\${taxinvoiceVO.tiCode}">\${taxinvoiceVO.tiCode}</a></td>
	                   <td>\${taxinvoiceVO.tiTransdate}</td>
	                   <td>\${taxinvoiceVO.tiIssuedate}</td>
	                   <td>\${taxinvoiceVO.contractNo}</td>
	                   <td>\${taxinvoiceVO.busNo}</td>
	                   <td>\${taxinvoiceVO.entName}</td>
	                   <td>\${taxinvoiceVO.tiSupplyprice}</td>
	                   <td>\${taxinvoiceVO.tiVat}</td>
	                   <td>\${taxinvoiceVO.tiRmrk}</td>
	                 </tr>`;

			})
			// 엘리먼트.append() : 누적 / 엘리먼트.html() : 덮어쓰기
			$("#tby").html(str);
			
			// 페이징 처리
			$("#divPagingArea").html(articlePage.pagingArea);
		}
		
	})
	
}// end getList()
$(function() {
	console.log("체킁");

	// 검색 
	$("#edit").on("click", function(){
		// id로 찾는 방법
		// let keyword = $("#keyword").val();
		
		// name으로 찾는 방법 
		// => 태그+name으로 접근 -> <input type="text" name="keyword"...>
		/* let contractNo = $("input[name='contractNo']").val(); */
		let entName = $("input[name='entName']").val();
		let tiTransdate = $("input[name='tiTransdate']").val();
		let tiIssuedate = $("input[name='tiIssuedate']").val();
		let busNo = $("input[name='busNo']").val();
		let contractNo =  parseInt($("input[name='contractNo']").val(),10);

		// value는 +로 구분 가능 but, object는 반드시 +로 구분해야 함
		/* console.log("contractNo : " + contractNo); */
		
		// 비동기 목록
		selectLprodList(contractNo,entName,busNo,tiTransdate,tiIssuedate);
	});
	
});

</script>

<!-- 메인 컨텐츠 영역 끝 -->