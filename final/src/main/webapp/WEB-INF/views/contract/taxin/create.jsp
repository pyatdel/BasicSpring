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

<script type="text/javascript" src="/js/jquery.min.js"></script>


<style>
span > button{
background-color:3069CE !important;
border-color: 3069CE !important;
color:white !important;

}
.col-sm-12 {
	max-width: 85% !important;
	margin:0 auto;
}
.taxtb {
max-width:70vw;
margin: 0 auto !important;
	
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
	 table-layout: auto;
}
.tbhd-1{
margin-bottom: 0 !important;
margin-top:5% !important;}
/* input {
	margin: 0;
	font-family: inherit;
	font-size: inherit;
	line-height: inherit;
	border: none !important;
	outline: none !important;
} */
.btn-user{
width: 40px;
font-weight: 10px !important;
}
.entersear{
margin-top:10px;
/* background-color:3069CE !important;  */
color:#2a64f5 !important;
/* width: 30px; */
display: inline-block;
height: 100px;
width: 23px;
border-radius: 3px;
font-size: 14px;
padding-right: 2px;
border: 1px solid  #2a64f5 !important;
}

@media (max-width: 1209px) {
     .wgsidebar{
               display: none !important;
    }
}

.mgmodal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) !important; /* 화면 중앙 정렬 */
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    width: 1200px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    overflow-x:hidden !important;  
}


.mdimg {
position: relative;
	display: block !important;
	margin: 0 auto !important;
 overflow: auto;
	
}
.mdimg>img{
align-items: center;
display: block !important;
width: 100% !important;
height: 100%;
object-fit: contain;
 overflow: auto;
}
.modal_bgrd{
   display: none; /* 기본적으로 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7); /* 배경 어두운 반투명 색 */
    z-index: 1000;

}
.delmodal{
   position: absolute;
    bottom: 10px;
    right: 10px;
    font-size: 30px;
    font-weight: bold;
    color: #333;
    cursor: pointer; 
        z-index: 9999;
        width:100px;

}
.pagination{
justify-content: center !important;}
.table-responsive{
width:100%;
margin: 0 auto !important;
margin-top:3.5% !important;
overflow-x:hidden !important; 
}
.mon , .day{

width:30px !important;

}
.inputwidth{
width: 90% !important;

}
h3{
font-weight:normal !important;
}
#tbb{
font-size:14px;
}
.table{
border-color:#6c6c6c !important;
 max-width: 80vw !important; /* 테이블이 부모 요소 너비를 넘지 않도록 제한 */
   box-sizing: border-box; 
       margin-bottom: 0 !important;

}
.tbrigt{
border-left-color:white !important;

}
.taxincont{
max-width: 80vw;

}
.itemtable{
max-width: 90vw;
  overflow-x: auto; 
   box-sizing: border-box; 
}
 .itemtable td{
height:40px;
}
.form-control:disabled, .form-control:read-only{
background-color: white !important;

}
.flex{
display: flex;
    justify-content: flex-end;
    margin:20px;
}
.btn.btn-primary {
    color: #FFFFFF;
    width: 200px;
     background-color   : #2a64f5 !important;
     border-color: #2a64f5 !important;
     
    justify-content: center;
    display: flex
;
    align-items: center;
    flex-direction: row;
    
    
    }
    #finalTotalAmount{
    	border:none !important; 
    	outline:none !important; 
    
    }
    
    
</style>
<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../../include/header.jsp"%>
<div class="taxtb">
<form class="form-horizontal" id="form" action="/taxin/createPost" method="post">
    <div class="taxincont">
        <h3 class="mb-4">세금계산서 발행</h3>
        <div class="bg-light rounded h-100 taxtbflex">
            <table class="table table-bordered tableleft">
                <thead>
                    <tr>
                        <th colspan="6" class="tealine">전자 세금 계산서</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan='5' class="txsero">공 급 자</td>
                        <th class="txgaro">등록 <br>번호</th>
                        <td colspan="2">243-23-24654</td>
                        <th class="txgaro">사업장 <br>번호</th>
                        <td colspan="2">459-01-23456</td>
                    </tr>
                    <tr>
                        <th>상호<br>법인명</th>
                        <td colspan="2">노수면그룹웨어</td>
                        <th>성명<br>(대표자)</th>
                        <td colspan="2">양마강</td>
                    </tr>
                    <tr>
                        <th>사업장 <br>주소</th>
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
            <table class="table table-bordered tbrigt">
                <thead>
                    <tr>
                        <th colspan="6"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan='5' class="txsero">공 급 받는 자
                        <a href="#" class="entersear">거래처 검색</a></td>
                        <th class="txgaro">계약 <br>번호</th>
                        <td colspan="2"><input type="number" class="contractNo" id="contractNo" name="contractNo" value=""></td>
                        <th class="txgaro">사업장 <br>번호</th>
                        <td colspan="2"><input type="text" class="busNo" name="" value="" readonly></td>
                    </tr>
                    <tr>
                        <th>상호<br>법인명</th>
                        <td colspan="2"><input type="text" class="entName" name="" value="" readonly></td>
                        <th>성명<br>(대표자)</th>
                        <td colspan="2"><input type="text" class="repName" name="" value="" readonly></td>
                    </tr>
                    <tr>
                        <th>사업장 <br>주소</th>
                        <td colspan="5">
                         <input type="hidden" name="totalAmount" id="totalinput" class="" value=""/>
                        <input type="text" class="detailAdd inputwidth" name="" value="${taxinvoiceVO.entType}" readonly></td>
                    </tr>
                    <tr>
                        <th>업종</th>
                        <td colspan="5"><input type="text" class="entType inputwidth" name="" value="" readonly></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td colspan="5"><input type="text" class="entEmail inputwidth" name="" value="" readonly></td>
                    
                    </tr>
                    <input type="hidden" name="entNo" id="entNo" class="entNo" value=""/>
                    <input type="hidden" name="tiSupplyprice" id="supplyPrice" class="supplyPrice" value=""/>
                    <input type="hidden" name="tiVat" id="totalVat" class="totalVat" value=""/>
                </tbody>
            </table>
        </div>
    </div>
</form>

<!-- Modal for 거래처 리스트 -->
<div class="modal_bgrd" style="display: none;">
    <div class="mgmodal">
        <div class="table-responsive">
            <table class="table" id="tbb">
                <thead class="thc tbhd-1">
                    <h3>거래처 리스트</h3>
                    <tr class="tbc">
                        <th scope="col">No.</th>
                        <th scope="col">거래처명</th>
                        <th scope="col">거래처유형</th>
                        <th scope="col">사업장번호</th>
                        <th scope="col">대표명</th>
                        <th scope="col">거래처번호</th>
                        <th scope="col">사업자주소</th>
                        <th scope="col">거래처이메일</th>
                    </tr>
                </thead>
                <tbody id="tby"></tbody>
            </table>
            <div class="pagebox">
                <div class="row justify-content-center" id="divPagingArea"></div>
                <button type="button" class="btn btn-primary btn-user delmodal">close</button>
            </div>
        </div>
    </div>
</div>

<!-- New form -->
<!-- <form class="form-horizontal" id="form2" action="/taxin/insertAll" method="post">
 -->    <div class="btb">
        <div class="rounded h-100">
            <table class="table-bordered itemtable">
                <thead>
                    <tr>
                        <th scope="col">월</th>
                        <th scope="col">일</th>
                        <th scope="col">품목명</th>
                        <th scope="col">품목코드</th>
                        <th scope="col">단가</th>
                        <th scope="col">수량</th>
                        <th scope="col">공급가액</th>
                        <th scope="col">세액</th>
                        <th scope="col">총금액</th>
                    </tr>
                </thead>
                <tbody class="contractDetailsBody">
                    <c:forEach var="i" begin="0" end="5"> <!-- 5개 항목을 예시로 사용, 실제 동적으로 항목 개수를 설정하세요. -->
                        <tr>
                            <td><input type="number" class="mon contractDetailNo" name="" value="" minlength="2" min="1"></td>
                            <td><input type="number" class="day" name="" value="" min="1"></td>
                            <td>
                                <select class="form-control" id="prodLgu${i}" name="" onchange="itemlist(event, ${i})">
                                    <option value="" selected>선택</option>
                                    <c:forEach var="contractObjectVO" items="${contractObjectVOList}">
                                        <option value="${contractObjectVO.itemName}" data-name="${contractObjectVO.itemCode}" data-price="${contractObjectVO.amt}">
                                            ${contractObjectVO.itemName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="text" class="itemCode" id="itemName${i}" name="contractDetailList[${i}].itemCode" value=""></td>
                            <td><input  type="text" class="amt" id="amt${i}" name="contractDetailList[${i}].amt" value=""></td>
                            <td><input type="number" class="itemQty" id="itemQty${i}" name="contractDetailList[${i}].itemQty" value="" min="1" onchange="updatePrice(${i})"></td>
                            <td><input type="text" class="tiSupplyprice" id="tiSupplyprice${i}" name="contractDetailList[${i}].itemPrice" value=""></td>
                            <td><input type="text" class="tiVat" id="tiVat${i}" name="contractDetailList[${i}].tiVat" value=""></td>
                        	<td class="totalAmount"> <input type="text" id="totalAmount${i}"></td>
                        	
                        </tr>
                        
                    </c:forEach>
                    <input type="hidden" id="contractNoCopy1" name="contractNoCopy1"> 
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
					
				<%--  	 <c:forEach var="contractObjectVO" items="${contractObjectVOList}"
				varStatus="stat">  
				 <c:if test="${contractObjectVO.contractNo == taxinvoiceVO.contractNo}"> --%>
						<tr>

		<%-- tiIssuedate에서 월만 추출 --%>
							<td ><input type="text" id="finalTotalAmount"> </td>
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
    <div class="flex">
<button type="button" class="btn btn-primary btn-user" onclick="submitForm()" id="submitBothBtn">국세청 발행 / 전송</button>	
    </div>
</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script type="text/javascript" src="/js/jquery.min.js"></script>

<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js"></script>
<script type="text/javascript">
//contractNo 입력 필드의 값을 다른 필드에 자동으로 반영하기
document.getElementById('contractNo').addEventListener('input', function() {
    // 입력한 값을 가져옵니다.
    let contractNoValue = document.getElementById('contractNo').value;
    
    // 값을 자동으로 다른 입력 필드에 넣습니다.
    // 예시로 두 개의 필드에 값을 넣기
    document.getElementById('contractNoCopy1').value = contractNoValue;
});

// 품목 비동기 등록 처리   
async function submitForm() {
    // 데이터 넘길 빈 배열 선언
	const contractDetails = [];
	
    // 5개 항목에 대해 데이터를 수집
     for (let i = 0; i < 5; i++) {
    	 // 사용자 입력 값 가져오기
    	 	const contractNo = document.querySelector("#contractNoCopy1").value;
			const itemCode = document.querySelector(`[name='contractDetailList[\${i}].itemCode']`).value;
			const itemQty = document.querySelector(`[name="contractDetailList[\${i}].itemQty"]`).value;
			//const contractDetailNo = document.querySelector(`[name="contractDetailList[\${i}].contractDetailNo"]`).value;
			const itemPrice = document.querySelector(`[name="contractDetailList[\${i}].itemPrice"]`).value;
			const tiVat = document.querySelector(`[name="contractDetailList[\${i}].tiVat"]`).value;
			const amt = document.querySelector(`[name="contractDetailList[\${i}].amt"]`).value;
		console.log("찍히냐",itemCode,itemQty,itemPrice,tiVat,contractNo)
        
		// 값 null 체크
        if ( itemCode && itemQty && itemPrice && tiVat) {
            contractDetails.push({
            	contractNo,
                itemCode,
                itemQty,
                itemPrice,
                tiVat,
                amt
            });
            
            console.log("얘는 찍히냐?",contractDetails)
        }
    }
    const data = contractDetails; 

    try {
        // axios를 사용하여 JSON 데이터 전송
        const Url = "http://localhost:8020/taxin/insertAll"
        const response = await axios.post(Url, data, {
            headers: {
                'Content-Type': 'application/json'
            }
        });
        // 동기 form 제출 
        submitSyncForm()
        alert('데이터가 성공적으로 전송되었습니다.');
        
    } catch (error) {
        console.error('오류 발생:', error);
        alert('데이터 전송 중 오류가 발생했습니다.');
    }
}

// 동기 폼 제출 함수
function submitSyncForm() {
	
    // 동기 폼 제출
    document.getElementById('form').submit(); // form의 id가 syncForm이라고 가정
}



$(function() {
	$(".entersear").on("click",function(){
		$(".modal_bgrd").css("display","block");
				

		// value는 +로 구분 가능 but, object는 반드시 +로 구분해야 함
		/* console.log("contractNo : " + contractNo); */
		let currentPage = $(this).data("currentPage");
		let keyword = $(this).data("keyword");
		// 비동기 목록
		selectLprodList(currentPage,keyword);
		
	})
	$(".delmodal").on("click",function(){
		$(".modal_bgrd").css("display","none");
		
		
	})
	$(document).on("click",".clsPagingArea",function(){
		// 클릭한 것은 하나
		// <a .. data-current-page="2" data-keyword="".. class="page-link clsPagingArea">2</a>
		let currentPage = $(this).data("currentPage");
		let keyword = $(this).data("keyword");
		
		console.log("currentPage :" + currentPage);
		console.log("keyword :" + keyword);
		
		// 회원 목록 호출
		selectLprodList(currentPage,keyword);
		
	
	})
});


	 
	 function itemlist(event, selectNumber) {
		  // currentTarget 셀렉트박스 가져옴
		  let selectedOption = event.currentTarget.selectedOptions[0];

		  // itemName , price 데이터 추출
		  var itemName = selectedOption.getAttribute('data-name');
		  var itemPrice = selectedOption.getAttribute('data-price');

		  // input 필드에 값 채우기
		  document.getElementById('itemName' + selectNumber).value = itemName;
		  document.getElementById('amt' + selectNumber).value = itemPrice;
		}

	 function updatePrice(selectNumber) {
			// alert("미강체킁")
		  
		// 선택된 itemPrice 가져오기
		  let selectedOption = document.getElementById('prodLgu' + selectNumber).selectedOptions[0];
		  let itemPrice = parseFloat(selectedOption.getAttribute('data-price'));
		  console.log("selectedOption : ", selectedOption);
		  console.log("itemPrice : ", itemPrice);
		  
		  
		  // 수량입력에서 값 가져오기
		  let quantity = parseInt(document.getElementById('itemQty' + selectNumber).value);

		  // 금액 계산
		  let totalPrice = itemPrice * quantity;
		  
		  // price필드에 계산된 값 넣기
		  document.getElementById('tiSupplyprice' + selectNumber).value = totalPrice;
		  
		  console.log("total",totalPrice) 
		let tiSupplyprice = parseInt(document.getElementById('tiSupplyprice' + selectNumber).value);
	 	let vat =  tiSupplyprice / 10;
		  document.getElementById('tiVat' + selectNumber).value = vat;		  
		  console.log("vat", vat)
		  
	    // 총액 계산 (공급가액 + 세액)
	    let totalAmount = tiSupplyprice + vat;

	    // 총액 필드에 계산된 값 넣기
	    document.getElementById('totalAmount' + selectNumber).value = totalAmount;
	    console.log("totalAmount (총액) : ", totalAmount);
	    updateTotalAmount();
	 }

	 // 전체 총액 계산 함수
	 function updateTotalAmount() {
	     let totalAmount = 0;
	     let totalSupplyPrice = 0; 
	     let totalVat = 0;   
	     
	     const vatFields = document.querySelectorAll('[id^="tiVat"]');
	     const supplyPriceFields = document.querySelectorAll('[id^="tiSupplyprice"]');
	     // 각 항목의 totalAmount 값을 모두 합산
	     const totalAmountFields = document.querySelectorAll('[id^="totalAmount"]'); // totalAmount 필드들을 모두 선택
	     // 공급가액 계산
	     supplyPriceFields.forEach(field => {
	         let supplyPrice = parseFloat(field.value) || 0;  // null이나 빈값이 있으면 0 처리
	         totalSupplyPrice += supplyPrice;  // 공급가액 합산
	     });
	     totalAmountFields.forEach(field => {
	         let amount = parseFloat(field.value) || 0; // null이나 빈값이 있으면 0 처리
	         totalAmount += amount;
	     });
	     vatFields.forEach(field => {
	         let vat = parseFloat(field.value) || 0;  // null이나 빈값이 있으면 0 처리
	         totalVat += vat;  // 부가세 합산
	     });
	     console.log("총 공급가액: " + totalSupplyPrice);
	     // 최종 총액 필드에 값 넣기
	     document.getElementById('finalTotalAmount').value = totalAmount;
	     document.getElementById('totalinput').value = totalAmount;
	     document.getElementById('supplyPrice').value = totalSupplyPrice;
	     document.getElementById('totalVat').value = totalVat;
	     console.log("최종 총액 : ", totalAmount);
	 }
	
function loadEnterpriceDetails(){
	
	$(".modal_bgrd").css("display","none");
	let data= event.currentTarget;
	let row = $(data).closest('tr'); 
	
	let nameText = row.find('.entName').text().trim();
	let busNo = row.find('.busNo').text().trim();
	let repName = row.find('.repName').text().trim();
	let entTel = row.find('.entTel').text().trim();
	let detailAdd = row.find('.detailAdd').text().trim();
	let entEmail = row.find('.entEmail').text().trim();
	let entType = row.find('.entType').text().trim();
	let entNo = row.find('.entNo').text().trim();
	
	alert(nameText);
	$('.entName').val(nameText);
	$('.busNo').val(busNo);
	$('.repName').val(repName);
	$('.entTel').val(entTel);
	$('.detailAdd').val(detailAdd);
	$('.entEmail').val(entEmail);
	$('.entType').val(entType);
	$('.entNo').val(entNo);
	
}
function selectLprodList(currentPage,keyword){
	let data = {
			  "currentPage":currentPage,
			  "keyword":keyword
			}
	console.log("data : " , data);
	$.ajax({
		url:"/taxin/entListAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"POST",
		dataType:"json",
		success:function(articlePage){
			console.log(" articlePage : " ,  articlePage);
			// articlePage.content : List<MemberVO>
			console.log("articlePage.content : ", articlePage.content);
			let str = "";
			$.each(articlePage.content , function(idx,enterPriceVO){
	               str += ` <tr>
	                   <td>\${enterPriceVO.entNo}</td>
	                   <td class="entName" onclick="loadEnterpriceDetails(this)" style="cursor:pointer;color:3069CE;">\${enterPriceVO.entName}</td>
	                   <td class="entType">\${enterPriceVO.entType}</td>
	                   <td class="busNo">\${enterPriceVO.busNo}</td>
	                   <td class="repName">\${enterPriceVO.repName}</td>
	                   <td class="entTel">\${enterPriceVO.entTel}</td> 
	                   <td class="detailAdd">\${enterPriceVO.detailAdd}</td> 
	                   <td class="entEmail">\${enterPriceVO.entEmail}</td> 
	                   <td class="entNo" style="display:none;">\${enterPriceVO.entNo}</td> 
	                 </tr>`;

			})
			// 엘리먼트.append() : 누적 / 엘리먼트.html() : 덮어쓰기
			$("#tby").html(str);
			console.log("articlePage.pagingArea",articlePage.pagingArea)
			// 페이징 처리
			$("#divPagingArea").html(articlePage.pagingArea);
		}
		
	})
	
}// end getList()
	
</script>

<!-- 메인 컨텐츠 영역 끝 -->