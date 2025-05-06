<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<title>지출 관리</title>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
  
<style>

.p-4 {
    padding: 3rem !important;
}
#tbc {
background-color: #3069CE;
color: white !important;
width: 90%;
border-radius: 10% !important;

}
.center-align{
	text-align: center !important;

}
.chart-container {
    margin: 0 auto;
    padding: 20px;
}

.table {
    margin: 0 auto;
    max-width: 95%;
}
.chart-container {
    margin: 0 auto; /* 가로 중앙 정렬 */
    padding: 10px;
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 가로 가운데 정렬 */
    align-items: center; /* 세로 가운데 정렬 */
    max-width: 90%; /* 너비 조정 */
    height: 400px; /* 필요에 따라 높이 설정 */
}

h4 {
	margin-top: 50px !important;
}

#creBtn {
	background-color: 3069CE;
	color: white !important;
}

.chart-buttons {
        text-align: center;
        margin-bottom: 20px;
    }
    .chart-buttons button {
        margin: 0 10px;
        padding: 10px 20px;
        font-size: 16px;
        background-color: #3069CE;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .chart-buttons button:hover {
        background-color: #2554a3;
    }
    .right-align-container {
    display: flex;
    justify-content: flex-end; /* 가로 오른쪽 정렬 */
}

.modal {
    display: none;
    z-index: 1050 !important;
}
.modal-backdrop {
    z-index: 1040 !important;
}
.cashSub{
display: block !important;
height: auto !important;
}
</style>


<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- ///// content 시작 ///// -->

<h4>지출 관리</h4>
<hr/>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>



<!-- ///// content 시작 ///// -->
<div class="bg-light text-center rounded p-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
        <h6 class="mb-0"></h6>
    </div>
    <div class="d-flex justify-content-between mb-3" id="right-align">
    <div class="right-align">
            <a href="/cash/cashCreate" class="btn btn-outline-link m-2">등록</a>
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
<div class="modal fade" id="contractDetailModal" tabindex="-1" aria-labelledby="contractDetailModalLabel" >
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contractDetailModalLabel">지출 상세 내역</h5>
                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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

<!-- 모달 끝 -->
<!-- 페이지네이션 -->
<%-- 		<center> --%>
<!-- 			<div class="row justify-content-center" id="divPagingArea"> -->
<%-- 				${articlePage.pagingArea}</div> --%>
<%-- 		</center> --%>
		
		
<div class="chart-buttons">
    <button onclick="updateChart('monthly')">월별 지출액</button>
    <button onclick="updateChart('category')">카테고리별 지출액</button>
</div>
		
<div class="chart-container">
	 <canvas id="barChart"></canvas>
</div>

 <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
<script type="text/javascript">

var ctx1 = document.getElementById('barChart').getContext('2d');

//카테고리별 데이터 (기본값)
var categoryLabels = ["교통비", "비품", "사업비", "식비", "예비비", "운영비", "인건비"];
var categoryData = [300000, 150000, 2000000, 500000, 700000, 2000000, 1540000];

//월별 데이터 (선택용)
var expLabels = [
 <c:forEach items="${expenseVOList}" var="saleVO" varStatus="loop">
     "<fmt:formatDate value="${saleVO.expDate}" pattern="yyyy년 MM월" />"<c:if test="${!loop.last}">,</c:if>
 </c:forEach>
];

var totalContracts = [
 <c:forEach items="${expenseVOList}" var="saleVO" varStatus="loop">
     ${saleVO.totalExpense}<c:if test="${!loop.last}">,</c:if>
 </c:forEach>
];

//기본 차트를 '카테고리별 지출액'으로 설정
var barChart = new Chart(ctx1, {
 type: 'bar',
 data: {
     labels: categoryLabels, // 카테고리별 라벨
     datasets: [{
         label: 'Category Expense', // 기본값을 '카테고리별 지출액'으로 설정
         data: categoryData, // 카테고리별 데이터
         backgroundColor: '#3069CE',
         borderColor: '#3069CE',
         borderWidth: 1
     }]
 },
 options: {
     indexAxis: 'x',
     responsive: true,
     plugins: {
         title: {
             display: true,
             text: '카테고리별 지출액', // 기본값을 '카테고리별 지출액'으로 설정
             font: {
                 size: 20,
                 weight: 'bold'
             },
             padding: {
                 top: 10,
                 bottom: 30
             }
         }
     },
     scales: {
         y: {
             beginAtZero: true,
             ticks: {
                 callback: function(value) {
                     return value + "원"; // 축 레이블에 '원' 추가
                 }
             }
         }
     }
 }
});

//버튼 클릭 시 그래프 업데이트
function updateChart(type) {
 if (type === 'monthly') {
     barChart.data.labels = expLabels;
     barChart.data.datasets[0].data = totalContracts;
     barChart.data.datasets[0].label = 'Monthly Expense';
     barChart.options.plugins.title.text = '월별 지출액';
 } else if (type === 'category') {
     barChart.data.labels = categoryLabels;
     barChart.data.datasets[0].data = categoryData;
     barChart.data.datasets[0].label = 'Category Expense';
     barChart.options.plugins.title.text = '카테고리별 지출액';
 }
 barChart.update(); // 그래프 갱신
}

</script>


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
				/*$.each(result,function(idx,expenseVO){
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
					str += "<td>" + Number(expenseVO.expPrice).toLocaleString() + "원</td>";

					str += "<td>"+expDate+"</td>";
					str += "</tr>";
				}
// 				});
				console.log('expPriceSum:', expPriceSum);
		        console.log('expQtySum:', expQtySum);
		        console.log('str:', str);
				
				expPrice = expPriceSum;
				expQty = expQtySum;
				// 총액 표시 업데이트
				$("#h2Sum").html(Number(expPriceSum).toLocaleString() + "원");
				$("#contractDetailModalBody").html(str);
				
				
			    // 모달 띄우기
			    $("#contractDetailModal").modal("show");
			   // $('#contractDetailModal').modal();
// 				let modal = document.getElementById("contractDetailModal");
// 				console.log('modal:', modal);
// 				console.log('modal.style.display:', modal.style.display);
// 				modal.style.display = "block";
			    
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

</script>
	