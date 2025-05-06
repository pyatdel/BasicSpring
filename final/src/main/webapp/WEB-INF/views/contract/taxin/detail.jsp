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
span > button{
background-color:3069CE !important;
border-color: 3069CE !important;
color:white !important;

}
.col-sm-12 {
	width: 85% !important;
	margin:0 auto;
}

.taxtb {
	
}

.taxtbflex {
	display: flex !important;
}

.col-xl-6 {
	width: 90% important;
}

.tealine {
	text-align: center;
}

.txsero {
	writing-mode: vertical-rl;
	text-align: center;
	width: 10px;
}

.txgaro {
	width: 13%;
	text-align: center;
	text-align: center;
}

* {
	text-align: center;
	margin: 0;
	padding: 0;
	align-items: center;
	color: black;
}

th {
	height: 50px;
}

.btb {
	height: 100%;
}
.table{
margin-bottom: 0 !important;
    border-color: #6c6c6c !important;

}
input {
	margin: 0;
	font-family: inherit;
	font-size: inherit;
	line-height: inherit;
	border: none !important;
	outline: none !important;
}
.totaltb th {
width: 100px;}
.totaltbh{
}
.tbin{
width: 200px;
height: 20px;
background-color: black;
}
.tbinn{
border-bottom: white solid 1px !important;

}
.price{
text-align: right;
padding-right: 30px !important;


}
</style>
<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../../include/header.jsp"%>
<div class="taxtb">
<%--  <div>${taxinvoiceVO}</div> --%>
	<form class="form-horizontal" id="form" action="/taxin/create"
	method="post" enctype="multipart/form-data">
	<div class="col-sm-12 ">
	<h3 class="mb-4">세금계산서 상세</h3>
		<div class="bg-light rounded h-100 taxtbflex">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th colspan="6" class="tealine">전자 세금 계산서</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan='5' class="txsero">공 급 자</td>
						<th class="txgaro">등록 <br>번호</th>
						<td colspan="2"></td>
						<th class="txgaro">사업장 <br>번호
						</th>
						<td colspan="2">459-01-23456</td>
					</tr>
					<tr>
						<th>상호<br>법인명
						</th>
						<td colspan="2">노수면그룹웨어</td>
						<th>성명</th>
						<td colspan="2">양마강</td>
					</tr>
					<tr>
						<th>사업장 <br>주소
						</th>
						<td colspan="5">대전광역시 중구 오류동 179-3</td>
					</tr>
					<tr>
						<th>업종</th>
						<td colspan="5">IT</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="5">test1234@naver.com</td>
					</tr>

				</tbody>
			</table>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th colspan="6">승인번호</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan='5' class="txsero">공 급 자</td>
						<th class="txgaro">등록 <br>번호
						</th>
						<td colspan="2"><input type="text" class="updtcon" name="tiCode"
						value="${taxinvoiceVO.tiCode}" readonly></td>
						<th class="txgaro">사업장 <br>번호
						</th>
						<td colspan="2"><input type="text" class="updtcon" name=""
						value="${taxinvoiceVO.busNo}" readonly></td>
					</tr>
					<tr>
						<th>상호<br>법인명
						</th>
						<td colspan="2"><input type="text" class="updtcon" name=""
						value="${taxinvoiceVO.entName}" readonly></td>
						<th>성명</th>
						<td colspan="2"><input type="text" class="updtcon" name=""
						value="${taxinvoiceVO.entCust}" readonly></td>
					</tr>
					<tr>
						<th>사업장 <br>주소
						</th>
						<td colspan="5">대전광역시 중구 오류동 234-12</td>
					</tr>
					<tr>
						<th>업종</th>
						<td colspan="5"><input type="text" class="updtcon" name=""
						value="${taxinvoiceVO.entType}" readonly></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="5">${taxinvoiceVO.entEmail }</td>
					</tr>

				</tbody>
			</table>

		</div>


		<div class="btb">
			<div class="bg-light rounded h-100">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">품목코드</th>
							<th scope="col">품목명</th>
							<th scope="col">수량</th>
							<th scope="col">단가</th>
							<th scope="col">공급가액</th>
							<th scope="col">세액</th>
						</tr>
					</thead>
					
					<tbody>
					 	<c:forEach var="contractDetail" items="${taxinvoiceVO.contractDetailVOList}" varStatus="status">
					    <tr>
					      <td>${status.index + 1}</td> 
					        <td>${contractDetail.itemCode}</td> <!-- itemCode (GRP-01, GRP-02 등) -->
					        <td>${contractDetail.contractObjectVO != null ? contractDetail.contractObjectVO.itemName : 'Unknown Item'}</td> <!-- itemName (null 체크) -->
					        <td>${contractDetail.itemQty}</td> <!-- itemQty -->
					        <td class="price">
					        <fmt:formatNumber
									value="${contractDetail.amt}" pattern="#,###" /></td> 
									<td  class="price">
					        <fmt:formatNumber
									value="${contractDetail.itemPrice}" pattern="#,###" />
					        </td> <!-- itemPrice -->
					        <td class="price">
					         <fmt:formatNumber
									value="${contractDetail.vat}" pattern="#,###" />
					        </td> <!-- tiVat -->
					    </tr>
					</c:forEach>
						  
					</tbody>
				</table>
			</div>
			<div class="bg-light rounded h-100">
				<table class="table table-bordered totaltbh">
					<thead class="totaltb">
						<tr>
							<th >합계금액</th>
							<th scope="col">현금</th>
							<th scope="col">수표</th>
							<th scope="col">어음</th>
							<th scope="col">외상미수금</th>
							<th scope="col" class="tbinn">이 금액을 청구 함</th>
							
						</tr>
					</thead>
					<tbody>

		<%-- tiIssuedate에서 월만 추출 --%>
							<td   class="price">
							 <fmt:formatNumber
									value="${taxinvoiceVO.totalAmount}" pattern="#,###" /> &nbsp;원
							</td>
							<td ></td>
							<td ></td>
									<td></td> 
									<td></td>
									<td></td>
						</tr>
						<%-- </c:if>
						  </c:forEach>  --%>
						  
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%-- <p>${contractObjectVOList}</p>  --%>
	<%-- <p>${contractObjectVOList}</p>  --%>
<%-- 	<c:forEach var="contractObjectVO" items="${taxinvoiceVO.contractObjectVOList}">
    <tr>
        <td>${contractObjectVO.itemCode}</td>
        <td>${contractObjectVO.itemName}</td>
    </tr>
</c:forEach> --%>
	
	
	
	

	
	</form>
	<div class="col-sm-12 ">
	<span id="spn1" class="justify-between" style="display: block;">
	<span style="float: left;">
		<button type="button" id="delete" class="btn btn-primary m-2">삭제</button>
</span><a href="/taxin/list"><button type="button" class="btn btn-outline-primary m-2 " style="float: right;">목록</button></a>
</span>
	</div><%-- 
	 <p>${taxinvoiceVO }</p> 
	 --%>
</div>


<%-- <p>${taxInvoiceVO}</p> --%>

<script>
$(function(){
	
    var inputValue = $('#itemPrice').val(); // 입력 필드의 값 가져오기
    console.log(inputValue)
    
	
	$("#delete").attr("readonly", true);

	
	$("#delete").on("click", function() {
		$("#form").attr("action", "/taxin/delete")

		let result = confirm("삭제하시겠습니까?")

		if (result > 0) {
			$("#form").submit()

		} else {
			alert("삭제 취소되었습니다")

		}

	})
    
})
    </script>
</head>
</html>

</script>

<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 메인 컨텐츠 영역 끝 -->