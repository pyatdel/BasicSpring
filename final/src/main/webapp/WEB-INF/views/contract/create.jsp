<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">




<style>

body {
    margin: 0;
    font-family: "Heebo", sans-serif;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #757575;
    -webkit-text-size-adjust: 100%;
    -webkit-tap-highlight-color: red;
}
       ::-webkit-scrollbar {
            width: 12px;
            height: 12px; 
        }

        ::-webkit-scrollbar-track {
            background: #ffffff;
            border-radius: 10px; 
        }

        ::-webkit-scrollbar-thumb {
            background: #d4edeb; 
            border-radius: 10px; 
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #d0d0d0; 
        }

.table-responsive {
    overflow-x: auto;
    height: 40vh !important;
}
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
thead, tbody, tfoot, tr, td, th {
    border-color: #828797 !important;
    border-style: solid;
    border-width: 0;
}
.entBgrd{
border-radius: 20px;
box-shadow:5px 5px 10px #000000a6;
margin-bottom: 1%;

}

.bdn  {
    border-color: white !important;
    border-style: solid;
    border-width: 0;
    text-align: center !important;
}
.mb-4{

text-align: left !important;
padding:20px !important;
padding-bottom:10px !important;
margin-bottom:0 !important;
}


#tbhd{
    border-bottom: 1px solid  #e9ecef ;
    width: 97%;
    margin: 0 auto;

}
select{
width: 218px !important;

}
.contCre{

font-size:1.75rem;
font-weight: normal;
padding:0 20px 30px 20px;

}



.contCreSub{
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
.btBox{
display: flex;
    justify-content: space-between;
    flex-direction: row-reverse;
}
.conte{

width: 90%;
margin: 0 auto;
margin-top:1%;

}
</style>



<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../include/header.jsp"%>

<div class="conte">
	<div class="">
		<h6 class="contCre">계약등록</h6>
		<div class="entBgrd">
		<div id="tbhd">
			<h3 class="mb-4">거래처리스트</h3>
			<div class="d-flex mb-2 scb">
				<!-- <input class="form-control bg-transparent" name="keyword"
					id="scbar keyword" type="text" placeholder="검색어를 입력하세요.">
				<button type="button" id="scbar2" class="btn btn-primary ms-2">검색</button> -->
			</div>
		</div>
		<div class="table-responsive bdn">
			<table class="table tbhd bdn" id="tbb">
				<thead class="thc bdn">
					<tr class="tbc bdn">
						
						<th scope="col" class="bdn"></th>
						<th scope="col" class="bdn no">거래처번호</th>
						<th scope="col" class="bdn">사업자번호</th>
						<th scope="col" class="bdn">거래처명</th>
						<th scope="col" class="bdn">대표명</th>
						<th scope="col" class="bdn">사업유형</th>
						<th scope="col" class="bdn">거래처계약담당자</th>

					</tr>
				</thead>
				<tbody class="bdn"> 
					<c:forEach var="enterPriceVO" items="${enterPriceVOList}"
						varStatus="stat">
						<tr class="bdn custom-checkbox">
							<th scope="row" class="th1 bdn">
							<input type="checkbox" id="ckbox" name="epck" onclick="updateHiddenInput(this)"data-value="${enterPriceVO.entName}" value="${enterPriceVO.entNo}">
							<span class="checkmark"></span>
							</th>
							<th scope="row" class="bdn no"> ${enterPriceVO.entNo}</th>
							<td class="bdn"> ${enterPriceVO.busNo}</td>
							<td value="${enterPriceVO.entName}" class="td2 bdn">${enterPriceVO.entName}</td>
							<td class="bdn">${enterPriceVO.repName}</td>
							<td class="bdn">${enterPriceVO.entType}</td>
							<td class="bdn">${enterPriceVO.entCust}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
<form class="form-horizontal" id="form" name="form" action="/contract/createPost"
	method="post" enctype="multipart/form-data">
	<div class="bg-light rounded h-100 contcon">
		<table class="table cmcrtb table-bordered">
			<tbody class="contb">
			<!-- <input type="hidden" class="updtcon" name="entNo"> -->
			
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
						<input type="text" name="approvalEmp" placeholder="계약 승인자 ">	
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
						class="updtcon"  placeholder="계약 담당자 사번"></td>
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
<div class="btBox">
<button type="submit" class="btn btn-primary btn-user">등록</button>
<span style="float: left;"> <a href="/contract/list"
		class="btn btn-success btn-user"> 목록 </a>
</span>
		<%@ include file="../include/footer.jsp"%>
	<%-- <p>${enterPriceVOList}</p> --%>
</div>
</div>

<script type="text/javascript" src="/js/jquery.min.js"></script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
const checkbox = document.querySelector('input[type="checkbox"]');
checkbox.addEventListener('change', function() {
  if (this.checked) {
    console.log('체크됨');
  } else {
    console.log('체크되지 않음');
  }
});

//체크박스를 클릭할 때마다 해당 값만 hidden input에 저장
function updateHiddenInput(checkbox) {
  // 선택된 체크박스의 value 값을 가져옵니다.
  var selectedValue = '';

  // 체크박스가 체크된 경우에만 그 값을 숨겨진 input에 설정
  if (checkbox.checked) {
    selectedValue = Number(checkbox.value);
   
  }
  let ckbox = document.querySelector("#ckbox");
  let contalert = ckbox.getAttribute('data-value'); 
  // 숨겨진 input에 선택된 값 저장
  let no = $('#selectedEpck').val(selectedValue);
	//alert("거래처 " + selectedValue + "을 선택하셨습니다.")
}
    // 결과를 표시

</script>

<!-- 메인 컨텐츠 영역 끝 -->