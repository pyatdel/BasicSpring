<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- jQuery -->
    <title>지출 신청</title>
<!-- 헤더에 추가 -->
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
<jsp:include page="../include/preScript.jsp"></jsp:include>
<style>
.nav-tabs.custom-tabs .nav-link.active {
    color: black !important;
    background-color: #F3F6F9 !important;
    border-color: #dee2e6 !important;
}
.cashSub{
display: block !important;
height: auto !important;
}
</style>
<%@ include file="../include/header.jsp" %>

<div class="bg-light text-center rounded p-4">
 	<h3 class="mb-0"></h3>
         	<div class="nav nav-tabs custom-tabs mb-4">
			    <a class="nav-link" href="/cash/cashList" data-type="cashList">매출 정보</a>
			    <a class="nav-link" href="/cash/cashPercent" data-type="cashPercent">매출 현황</a>
			    <a class="nav-link" href="/cash/cashAnaly" data-type="cashAnaly">매출 통계</a>
			    <a class="nav-link" href="/cash/cashCreate" data-type="cashCreate">지출 신청</a>
			</div>



<!-- ///// content 시작 ///// -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js CDN -->
<h6>지출 신청</h6>
<div class="bg-light text-center rounded p-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h6 class="mb-0"></h6>
    </div>
    <div class="d-flex justify-content-between mb-3" id="right-align">
    <div class="right-align">
            <a href="/cash/create" class="btn btn-outline-link m-2">등록</a>
        </div>
    </div>
    
    
    <div class="table-responsive">
        <table class="table text-start align-middle table-bordered table-hover mb-0" id="table">
            <thead>
                <tr class="text-dark center-align" id="tbc">
<!--                     <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll"></th> -->
                    <th scope="col">No.</th>
                    <th scope="col">내역</th>
                    <th scope="col">금액</th>
                    <th scope="col">지출일자</th>
                </tr>
            </thead>
            <tbody id="tby">
            	<c:forEach var="saleVO" items="${saleInfoVOList}" varStatus="stat">
                        <tr class="oepnDetailModal"
                        	data-cate-no="${saleVO.cateNo}" 
                        	data-category-name="${saleVO.categoryName}" 
                        	data-total-expense="${saleVO.totalExpense}" 
                        	data-budget-no="${saleVO.budgetNo}" 
						    data-expno="${saleVO.expNo}" 
						    data-expname="${saleVO.categoryName}" 
						    data-expqty="${saleVO.expQty}" 
						    data-expprice="${saleVO.expPrice}" 
						    data-expobj="${saleVO.expObj}" 
						    data-expdate="<fmt:formatDate value='${saleVO.expDate}' pattern='yyyy-MM-dd'/>"
						    style="cursor:pointer;">
                            <td style="text-align: center;">${saleVO.rnum}</td>
                        	<td style="text-align: center;">${saleVO.categoryName}</td>
                            <td style="text-align: right;"><fmt:formatNumber pattern="#,###">${saleVO.totalExpense}</fmt:formatNumber>원</td>
                            <td style="text-align: center;"><fmt:formatDate value="${saleVO.expDate}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="tdModal" id="contractDetailModal" tabindex="-1" aria-labelledby="contractDetailModalLabel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contractDetailModalLabel">지출 상세 내역</h5>
            </div>
            <div class="modal-body">
	                <table class="table table-bordered">
		            	<thead>
	                        <tr>
	                            <th>No.</th>
	                            <th>지출 목록</th>
	                            <th>수량</th>
	                            <th>지출액</th>
	                            <th>지출일자</th>
	                        </tr>
	                    </thead>
                        <tbody id="contractDetailModalBody">
						</tbody>
                </table>
            </div>
            <div class="modal-footer">
            	<h2 style="color:red;" id="h2Sum"></h2>
            	<button type="button" class="btn btn-primary" id="btn-pay-ready">결제</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- ///// content 끝 ///// -->

<script>
/* EXPENSE 테이블을 위한 전역 변수
 EXP_NO(자동증가), CATE_NO, EXP_OBJ, EXP_QTY, EXP_REASON, BUDGET_NO, EXP_PRICE, EXP_DATE
 */
let expNo;
let cateNo;
let expObj;
let expQty;
let expReason;
let budgetNo;
let expPrice;
let expDate;
 
$(function() {
	
	//카카오페이 Ready 시작*****
	$("#btn-pay-ready").click(function(e) {
         // 아래 데이터 외에도 필요한 데이터를 원하는 대로 담고, Controller에서 @RequestBody로 받으면 됨
         let data = {
             "name":expReason,    // 카카오페이에 보낼 대표 상품명
             "totalPrice":expPrice, // 총 결제금액
             "expNo":expNo,
	         "cateNo":cateNo,
	         "expObj":expReason,
	         "expQty":expQty,
	         "expReason":expReason,
	         "budgetNo":budgetNo,
	         "expPrice":expPrice,
	         "expDate":expDate
         };
         
         console.log("btn-pay-ready->data : ", data);
       
         $.ajax({
             type: 'POST',
             url: '/order/pay/ready',
             data: JSON.stringify(data),
             contentType: 'application/json',
             success: function(response) {
                 location.href = response.next_redirect_pc_url;
             }
         });
     });
	//카카오페이 Ready 끝*****
	
	function getList(page, keyword) {
	    $.ajax({
	        url: '/cash/budgetList',
	        type: 'GET',
	        data: { page: page, keyword: keyword },
	        success: function (response) {
	            $('#tby').html(response);
	        },
	        error: function (error) {
	            console.error('Error fetching list:', error);
	        }
	    });
	}

	// 처음 데이터 호출
	//getList("1", "");

// 	$("#btnSearch").on("click", function(event) {
// 	    event.preventDefault();
// 	    const keyword = $("input[name='keyword']").val();
// 	    getList("1", keyword);
// 	});

	//*******
	$(document).on('click', '.oepnDetailModal', function() {
		
		console.log("모달 열렸나 화깅: " );
		// 전역변수 준비하기
		cateNo  = $(this).data("cateNo");
		let categoryName  = $(this).data("categoryName");
		let totalExpense  = $(this).data("totalExpense");
		budgetNo  = $(this).data("budgetNo");
		
		expNo = $(this).data('expno');
		const expName = $(this).data('expname');
		expQty = $(this).data('expqty');
// 		const expPrice = $(this).data('expprice');
		expDate = $(this).data('expdate');
		expObj = $(this).data('expObj')
		
		expReason = $(this).data("categoryName");
		expPrice = 0;
		
		let data = {
			"cateNo":cateNo,
			"categoryName":categoryName,
			"totalExpense":totalExpense,
			"budgetNo":budgetNo,
			"expNo":expNo,
			"expName":expName,
			"expQty":expQty,
			"expPrice":expPrice,
			"expDate":expDate,
			"expObj":expObj
		};
		
		console.log("data : ", data);
		
		//<tr class="oepnDetailModal" data-cateno="3" data-categoryname="식비" data-totalexpense="4880000" 
		//data-budgetno="1" data-expno="0" data-expname="" data-expqty="0" data-expprice="0" data-expobj="" 
		//data-expdate="2024-01-05">
		$.ajax({
			url:"/cash/budgetDetailList",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result : ", result);
				console.log("result.length : ", result.length);
				
				let str = "";
				let expDate = "";
				let expPriceSum = 0;
				let expQtySum = 0;
				
				//result : List<ExpenseVO>
				/* $.each(result,function(idx,expenseVO){
					expDate = expenseVO.expDate;
					expDate = expDate.substr(0,10);
					//누적 금액!!
					expPriceSum = expPriceSum + (expenseVO.expQty * expenseVO.expPrice);
					//누적 수량!!
					expQtySum = expQtySum + expenseVO.expQty;
					
					str += "<tr>";
					str += "<td>"+(idx+1)+"</td>";
					str += "<td>"+expenseVO.expObj+"</td>";
					str += "<td>"+expenseVO.expQty+"</td>";
					str += "<td>"+expenseVO.expPrice+"</td>";
					str += "<td>"+expDate+"</td>";
					str += "</tr>";
				}); */
				
				for(let idx=0;idx<result.length;idx++){
					expenseVO = result[idx];
// 				$.each(result,function(idx,expenseVO){
					expDate = expenseVO.expDate;
					expDate = expDate.substr(0,10);
					//누적 금액!!
					expPriceSum = expPriceSum + (expenseVO.expQty * expenseVO.expPrice);
					//누적 수량!!
					expQtySum = expQtySum + expenseVO.expQty;
					
					str += "<tr>";
					str += "<td>"+(idx+1)+"</td>";
					str += "<td>"+expenseVO.expObj+"</td>";
					str += "<td>"+expenseVO.expQty+"</td>";
					str += "<td>"+expenseVO.expPrice+"</td>";
					str += "<td>"+expDate+"</td>";
					str += "</tr>";
				}
// 				});
				console.log('expPriceSum:', expPriceSum);
		        console.log('expQtySum:', expQtySum);
		        console.log('str:', str);
				
				expPrice = expPriceSum;
				expQty = expQtySum;
				$("#h2Sum").html(expPriceSum);
				$("#contractDetailModalBody").html(str);
				
				
				
			    // 모달 띄우기
			   // $('#contractDetailModal').modal();
				let modal = document.getElementById("contractDetailModal");
				console.log('modal:', modal);
				console.log('modal.style.display:', modal.style.display);
				modal.style.display = "block";
			    
			}
		}); 
 	});
	
// 	document.getElementById(".closeModal").addEventListener("click", function () {
	$(document).on('click','#closeModal', function () {
	    // Bootstrap 메서드로 모달 닫기
	    $("#contractDetailModal").modal("hide");
	});

	
        //페이지 클릭 처리
        //class="clsPagingArea" 는 여러개 (오브젝트 배열)
        //정적 : $.(".clsPagingArea").on("click", function(){
        //동적 :
    $(document).on("click", ".clsPagingArea", function () {
        const currentPage = $(this).data("currentPage");
        const keyword = $(this).data("keyword");
        getList(currentPage, keyword);
    });
        
    document.addEventListener('DOMContentLoaded', function () {
        const modalLinks = document.querySelectorAll('.oepnDetailModal');

        modalLinks.forEach(link => {
            link.addEventListener('click', function () {
                const expNo = this.getAttribute('data-expno');

                fetch(`/cash/getSaleDetail?expNo=${expNo}`)
                    .then(response => response.json())
                    .then(data => {
                        const modalTableBody = document.querySelector('#contractDetailModal tbody');
                        modalTableBody.innerHTML = '';

                        data.forEach(detail => {
                            const row = `
                                <tr>
                                    <td>\${detail.expObj}</td>
                                    <td>\${detail.expQty}</td>
                                    <td>\${detail.expPrice}</td>
                                    <td>\${new Date(detail.expDate).toLocaleDateString()}</td>
                                </tr>
                            `;
                            modalTableBody.insertAdjacentHTML('beforeend', row);
                        });
                    })
                    .catch(error => console.error('Error fetching modal data:', error));
            });
        });
    });
});
//현재 URL 가져오기
const currentPath = window.location.pathname;

// 모든 탭 요소 가져오기
const navLinks = document.querySelectorAll('.nav-link');

// 현재 경로와 href가 일치하는 탭에 active 클래스 추가
navLinks.forEach(link => {
    if (link.getAttribute('href') === currentPath) {
        link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
    }
});
</script>
<%@ include file="../include/footer.jsp" %>   
	