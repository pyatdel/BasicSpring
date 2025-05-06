<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    

<!-- 
../ : views폴더(부모)
 -->

<!-- <meta charset="utf-8">
<title>직원 급여 등록</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="img/favicon.ico" rel="icon">

Google Web Fonts
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">





Icon Font Stylesheet
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

Libraries Stylesheet
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" /> -->


<!-- 왼쪽  -->
<style>
.row>* {
	flex-shrink: 0;
	margin: 2%;
	width: 60% !important;
	max-width: 100%;
	padding-right: calc(var(--bs-gutter-x)/2);
	padding-left: calc(var(--bs-gutter-x)/2);
	margin-top: var(--bs-gutter-y)
}
.right{
width: 30% !important;
}
.mgmodal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 화면 중앙 정렬 */
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    width: 800px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    z-index: 1000;
    height: 100%;
    overflow: hidden; /* 모달 외부의 스크롤 방지 */
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
    top: 10px;
    right: 10px;
    font-size: 30px;
    font-weight: bold;
    color: #333;
    cursor: pointer;

} 
thead {
  background-color: #3676EB; 
  color: white;         
}
#divPagingArea .page-item.active .page-link {
  color: white;           /* 활성화된 페이지 글자 색상 */
  background-color:  #3676EB; /* 활성화된 페이지 배경색 */
  border-color:  #3676EB;    /* 테두리 색상 */
}
#divPagingArea .page-link:hover {
  color: white;           /* 호버 시 글자 색상 */
  background-color:  #3676EB; /* 호버 시 배경색 */
  border-color:  #3676EB;     /* 호버 시 테두리 색상 */
}
#divPagingArea .page-link {
  color: black;          /* 링크 글자 색상 */
  background-color: white; /* 링크 배경색 */
  border: 1px solid gray; /* 테두리 색상 */
}
#searchInput{
width:200px;
height: 30px;
position: relative;
}
.input-group{
display: flex;
width: 300px !important;
height:30px;
align-items: center;
}
.fa-search{
font-size: 1rem;

}
#btnSearch{
position: absolute;

    right: 0;
    top: 0.1%;
}
</style>
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->

<div class="row g-4">
	<div class="bg-light rounded h-100 p-4">
		 <div class="hdFlex">
            <h3 class=" contlist">급여관리</h3>
		</div>
		<!-- 검색시작  -->
         <div class="input-group input-group-sm" style="width: 300px;">
         	<input type="text" id="searchInput" name="keyword" value=""
         		class="form-control float-right" placeholder="검색어 입력"/> 
         	<div class="input-group-append">
         		<button type="button" id="btnSeach" class="btn btn-default">
         			<i class="fas fa-search"></i>
         		</button>
         	</div>	
         </div>
         <!-- 검색 끝  -->
         <form id="yearMonthForm" method="get" action="/employeeSalary/salaryList"  style="margin: 10px;">
		    <!-- 연도 선택 -->
		    <label for="yearSelector" id="yearSelector">연도:</label>
		    <select id="year" name="year">
		        <c:forEach var="year" begin="2024" end="2025">
	            	<option value="${year}" <c:if test="${year1 eq year}">selected="selected"</c:if> 
                	<c:if test="${empty year1 && year == 2025}">selected="selected"</c:if>>${year}</option>
		        </c:forEach>
		    </select>
		
		    <!-- 월 선택 -->
		    <label for="monthSelector" id="">월:</label>
		    <select id="month" name="month">
		        <c:forEach var="month" begin="1" end="12" >
	            	<option value="${month}" <c:if test="${month1 eq month || currentMonth == month}">selected="selected"</c:if>>${month}월</option>
		        </c:forEach>
		    </select>    
		    
		    <!-- 일괄지급 -->
		    <button class="btn btn-outline-dark m-2" id="prev" style="float: right;" type="button" onclick="">급여 지급</button>
		    <!-- 검색 버튼 -->
<!-- 		    <button class="btn btn-outline-dark m-2" type="button" onclick="loadSalariesByYearMonth()" id="loadSalariesByYearMonth">조회</button> -->
		    <button class="btn btn-outline-dark m-2" type="button" id="loadSalariesByYearMonth">조회</button>
		</form>
		<div class="pagination">
	</div>
		<table class="table text-center">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">사원번호</th>
					<th scope="col">사원명</th>
					<th scope="col">직급</th>
					<th scope="col">부서</th>
					<th scope="col">실수령액</th>
				</tr>
			</thead>
			<tbody id="tby">
			 <c:forEach var="employeeSalaryVO" items="${salaryVOList}" varStatus="stat">
				<tr>
					<td>${employeeSalaryVO.rnum}</td>
					<!--비동기 -> onclick="loadEmployeeDetails('${employeeSalaryVO.empId}')"  -->
					<td style="cursor:pointer;"  onclick="loadEmployeeDetails('${employeeSalaryVO.empId}')">
<%-- 					<a href="/employeeSalary/salaryList?empId=${employeeSalaryVO.empId}"> --%>
 					${employeeSalaryVO.empId} 
<!-- 					</a>					 -->
					</td>
					<td>${employeeSalaryVO.empName}</td>
					<%-- <td>${employeeSalaryVO.residentNumber1}-${employeeSalaryVO.residentNumber2}</td> --%>
					<td>${employeeSalaryVO.postName}</td>
					<td>${employeeSalaryVO.deptName}</td>
					<td><fmt:formatNumber value="${employeeSalaryVO.afterTax}" pattern="#,###" /></td>
				</tr>  
			</c:forEach>
			</tbody>
		</table>
		<!-- 페이징 처리 번호 보이게 -->
          <div class="" id="divPagingArea" style="width: 30%; margin: 0 auto;">
			<div class="dataTables_info" id="example2_info" role="status" aria-live="polite"></div>
              	<center>
					${articlePage.pagingArea} 
                 </center>
          </div>
	</div>



	<!-- 오른쪽  -->
	<div class="right">
	<div class="bg-light rounded h-100 p-4 shadow-sm">
		 <h5 class="mb-4 text-center font-weight-bold" style="color:#3676EB;" >급여 정보 입력</h5>
		
		<form id="salaryForm" method="get" action="/employeeSalary/salaryList">
		
			<div class="mb-3">
				<label for="papago" class="form-label">급여 등록일</label> 
			    <input type="date" class="form-control" id="papago" aria-describedby="papago" value="">
			</div>
		
			<div class="mb-3" hidden>
			    <label for="empNo" class="form-label">사원프라이머키</label> 
			    <input type="text" class="form-control" id="empNo" aria-describedby="empNo" value="${select.empNo}">
			</div>
			<div class="mb-3">
				<label for="empId" class="form-label">사원번호</label> 
				<input type="text" class="form-control"
					id="empId" aria-describedby="empId" value="${select.empId}" />
			</div>
			<div class="mb-3">
				<label for="empName" class="form-label">이름</label> 
				<input type="text" class="form-control"
					id="empName" aria-describedby="empName" value="${select.empName}">
			</div>
			<div class="mb-3">
				<label for="salary" class="form-label">기본급</label> 
				<input type="text" class="form-control"
					id="salary" aria-describedby="salary" value="${select.salary}" placeholder="기본급 입력하세요">
			</div>
			<div class="mb-3">
				<label for="foodExpense" class="form-label">식대</label> 
				<input type="text" class="form-control"
					id="foodExpense" aria-describedby="foodExpense" value="${select.foodExpense}" placeholder="식비를 입력하세요">
			</div>
			<div class="mb-3">
				<label for="addedHours" class="form-label">추가수당비</label> 
				<input type="text" class="form-control"
					id="addedHours" aria-describedby="addedHours" value="${select.addedHours}" placeholder="추가수당비 입력하세요">
			</div>
			<div class="mb-3">
				<label for="incomeTax" class="form-label">소득세(%)</label> 
				<input type="text" class="form-control"
					id="incomeTax" aria-describedby="incomeTax" value="${select.incomeTax}" placeholder="세율을 입력하세요">
			</div>
			<div class="mb-3">
				<label for="salaryIncomeTax" class="form-label">소득세</label> 
				<input type="text" class="form-control"
					id="salaryIncomeTax" aria-describedby="salaryIncomeTax" value="${select.salaryIncomeTax}" placeholder="0">
			</div>
			<div class="mb-3">
				<label for="healthInsurance" class="form-label">건강보험(%)</label> 
				<input type="text" class="form-control"
					id="healthInsurance" aria-describedby="healthInsurance" value="${select.healthInsurance}" placeholder="세율을 입력하세요">
			</div>
			<div class="mb-3">
				<label for="salaryHealthInsurance" class="form-label">건강보험</label> 
				<input type="text" class="form-control"
					id="salaryHealthInsurance" aria-describedby="salaryHealthInsurance" value="${select.salaryHealthInsurance}" placeholder="0">
			</div>
			<div class="mb-3">
				<label for="nationalPension" class="form-label">국민연금(%)</label> 
				<input type="text" class="form-control"
					id="nationalPension" aria-describedby="nationalPension" value="${select.nationalPension}" placeholder="세율을 입력하세요">
			</div>
			<div class="mb-3">
				<label for="salaryNationalPension" class="form-label">국민연금</label> 
				<input type="text" class="form-control"
					id="salaryNationalPension" aria-describedby="salaryNationalPension" value="${select.salaryNationalPension}" placeholder="0">
			</div>
			
			<div class="result">
			<div class="mb-3">
				<label for="insurance " class="form-label">공제합계</label> 
				<input type="text" class="form-control"
					id="insurance" aria-describedby="insurance" value="${select.insurance}" placeholder="0">
			</div>
				<div class="mb-3">
					<label for="afterTax " class="form-label">실수령액</label> 
					<input type="text" class="form-control"
						id="afterTax" aria-describedby="afterTax" value="${select.afterTax}" placeholder="0">
				</div>
				<div class="mb-3">
					<label for="salaryTotal" class="form-label">급여합계</label> 
					<input type="text" class="form-control"
						id="salaryTotal" aria-describedby="salaryTotal" value="" placeholder="0">
				</div>
			</div>
			
		</form>
			<button type="button" class="btn btn-outline-secondary m-2" id="calculateBtn" style="float: left;">계산하기</button>
			<button type="button" class="btn btn-outline-danger m-2" onclick="clearForm()" style="float: right;">취소</button>
			<button type="button" class="btn btn-outline-primary m-2" id="btnSubmit" style="float: right;" disabled>등록</button>
		</div>
	</div>
</div>	


<!-- 모달 --> 	
          <div class="modal_bgrd" style="display: none;">
			    <div class="mgmodal">
			    <input value = "${employeeSalaryVO.empId}" hidden>
			    	 <div class="main-content" style="overflow-y: scroll; height: 80%; ">
			    	 	 <div class="select-box">
			    	 	 <div class="bg-light rounded h-100 p-4" >
			    	 	 <div class="mb-3">
							<label for="expDate" class="form-label">지급일</label> 
						    <input type="date" class="form-control" id="expDate" aria-describedby="expDate" value="">
						</div>
                            <table class="table" >
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">이름</th>
											<th scope="col">직급</th>
											<th scope="col">부서</th>
											<th scope="col">기본금</th>
											<th scope="col">식비</th>
											<th scope="col">추가수당비</th>
											<th scope="col">실수령액</th>
											<th scope="col" onclick="toggleSelectAll(this)">전체선택</th>
										</tr>
									</thead>
									<tbody id="modalTby">
									<%-- <c:forEach var="employeeSalaryVO" items="${modalList}" varStatus="stat">
										<tr>
											<td>${employeeSalaryVO.rnum}</td>
											<td>${employeeSalaryVO.deptName}</td>
											<td>${employeeSalaryVO.employeeCount}</td>
											<td>${employeeSalaryVO.salary}</td>
											<td>${employeeSalaryVO.foodExpense}</td>
											<td>${employeeSalaryVO.addedHours}</td>
											<td><input type="checkbox" class="employeeCheckbox" name="employeeCheckbox" value="${employeeSalaryVO.deptNo}"></td>
										</tr>
									</c:forEach>	  --%>
									</tbody>
								</table>
				         	
		                	<!-- 페이징 처리 번호 보이게 -->
					       <%--    <div class="card-footer" id="modalDivPagingArea" style="width: 30%; margin: 0 auto;">
								 <div class="dataTables_info" id="modalPagingArea" role="status" aria-live="polite"></div>
					              	<center id="centerPagingArea">
										
					                 </center>
					          	</div>   --%>
                        	</div>
		                 </div>
					</div>
						<div class="apvbtn">
	                		<button type="button" id="insertmodal" class="btn btn-primary">일괄 지급</button>
	                		<button type="button" id="delmodal" class="btn btn-secondary" data-bs-dismiss="modal_bgrd">닫기</button>
	                	</div>
                 </div>

 <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
<script type="text/javascript">
		


		function toggleSelectAll(headerCell) {
		    // 전체 체크박스 선택/해제
		    const checkboxes = document.querySelectorAll('input[name="employeeCheckbox"]');
		    const allChecked = [...checkboxes].every(checkbox => checkbox.checked);
		
		    checkboxes.forEach(checkbox => {
		        checkbox.checked = !allChecked;
		    });
		
		    // 스타일을 변경해 클릭 가능한 UI를 더 명확하게 설정
		    headerCell.style.cursor = 'pointer';
		}

		
	//급여 계산기 함수(왼쪽)
	function calculateSalary() {
	    // 현재 입력된 값을 가져옵니다.
	    let salary = $('#salary').val();
	    salary = salary.replaceAll(",","");
	    salary = salary.replaceAll(" ","");
	    salary = salary.replaceAll("원","");
	    salary = parseFloat(salary);
	    
	    foodExpense = $('#foodExpense').val();
	    foodExpense = foodExpense.replaceAll(",","");
	    foodExpense = foodExpense.replaceAll(" ","");
	    foodExpense = foodExpense.replaceAll("원","");
	    foodExpense = parseFloat(foodExpense);
	    
	    let incomeTax = parseFloat($('#incomeTax').val());
	    let healthInsurance = parseFloat($('#healthInsurance').val());
	    let nationalPension = parseFloat($('#nationalPension').val());
	    
	    // 세금 항목 계산 (예시: 실제 계산 공식에 맞게 조정)
	    let salaryIncomeTax = (incomeTax / 100) * salary;  // 소득세 계산 예시
	    let salaryHealthInsurance = (healthInsurance / 100) * salary;  // 건강보험
	    let salaryNationalPension = (nationalPension / 100) * salary;  // 국민연금
	
	    // 급여 계산
	    let insurance = salaryIncomeTax + salaryHealthInsurance + salaryNationalPension;
	    let salaryTotal = salary + foodExpense;  // 차감 전 급여
	    let afterTax = salaryTotal - insurance;  // 차감 후 급여
	
	    // 계산된 값을 화면에 출력
	    $('#salaryIncomeTax').val(salaryTotal.toFixed());
	    $('#salaryHealthInsurance').val(salaryHealthInsurance.toFixed());
	    $('#salaryNationalPension').val(salaryNationalPension.toFixed());
	    $('#insurance').val(insurance.toFixed());
	    $('#afterTax').val(afterTax.toFixed());
	    $('#salaryTotal').val(salaryTotal.toFixed());
	}//end calculateSalary

	
	
	// 사원에 따라 급여 불러오기(왼쪽)
	function loadEmployeeDetails(empId,empNo){
		let data={empId:empId};
		console.log("화긴!", data);
		
		$.ajax({
			url: '/employeeSalary/salaryPost',// 해당 사원 정보 가져오기
			type: 'post',
			data:JSON.stringify(data),
			contentType:"application/json",
			dataType:"json",
			success : function(response){
				console.log("response : ", response);
				
				// 사원 정보 채우기
				$('#papago').val(response.salaryVOList[0].papago);
				$('#empId').val(response.empId);
				$('#empName').val(response.empName);
				$('#salary').val(formatCurrency(response.salaryVOList[0].salary));
				$('#foodExpense').val(formatCurrency(response.salaryVOList[0].foodExpense));
				$('#addedHours').val(formatCurrency(response.salaryVOList[0].addedHours));
				$('#incomeTax').val(formatCurrency2(response.salaryVOList[0].incomeTax));
				$('#healthInsurance').val(formatCurrency2(response.salaryVOList[0].healthInsurance));
				$('#nationalPension').val(formatCurrency2(response.salaryVOList[0].nationalPension));
				$('#salaryIncomeTax').val(formatCurrency(response.salaryVOList[0].salaryIncomeTax));
				$('#salaryHealthInsurance').val(formatCurrency(response.salaryVOList[0].salaryHealthInsurance));
				$('#salaryNationalPension').val(formatCurrency(response.salaryVOList[0].salaryNationalPension));
				$('#insurance').val(formatCurrency(response.salaryVOList[0].insurance));
				$('#afterTax').val(formatCurrency(response.salaryVOList[0].afterTax));
				$('#salaryTotal').val(formatCurrency(response.salaryVOList[0].salaryTotal));
				
				//사원 선택 시 오른쪽 영역의 지급연월일 란에 자동 선택됨 시작 ///
				let yy = $("#year").val();
				let mm = "0" + $("#month").val();
				mme = mm.slice(-2);
				let strDay = yy + "-" + mm + "-"+ "01";
				console.log("strDay : ", strDay);
				
				$("#papago").val(strDay);
				//사원 선택 시 오른쪽 영역의 지급연월일 란에 자동 선택됨 끝 ///
				
				$("#btnSubmit").attr("disabled",true);
			},
			error: function(xhr,status,error){
				alert('사원 정보를 불러오는 데 실패했습니다.');
			}

		});//end ajax
	} //사원에 따라 급여 불러오기 end function

	// 폼 초기화(취소 버튼 클릭 시)
	function clearForm(){
		$('#salaryForm')[0].reset(); // 폼 초기화
		
		$("#btnSubmit").attr("disabled",true);
	}

	// 급여 포맷 함수 (소수점 및 원화 표기)
	function formatCurrency(amount) {
		return amount.toLocaleString('ko-KR', {
		}) + " 원";  // '원' 추가
	}
	
	function formatCurrency2(amount) {
		return amount.toLocaleString('ko-KR', {
			minimumFractionDigits: 1  // 소수점 1자리
		}) + " %";  // '%' 추가
	}

	//이벤트 모음
	$(function(){
		let empId=$("#empId").val();
		console.log("체킁!", {empId:empId});
		
		// 급여등록버튼
		$("#btnSubmit").on("click",function(){
			console.log("급여 등록 비동기 처리")
		
			//가상 폼 SALARY_NO, SALARY, EMP_NO, FOOD_EXPENSE, PAPAGO
			let formData2 = new FormData();
			let salary = $("#salary").val();
			let empId = $("#empId").val();
			let foodExpense = $("#foodExpense").val();
			let papago = $("#papago").val();
			let afterTax = $("#afterTax").val();
			let addedHours = $("#addedHours").val();
			console.log("salary:", salary, "empId:", empId, "foodExpense:", foodExpense, "papago:",papago,"afterTax",afterTax,"addedHours",addedHours);
			
			/*
			private int salary;
			private int foodExpense;
			*/
//				{"salary": "3,000,000 원","empId": "20241224004","foodExpense": "200,000 원","papago": "2024-12-24"}
			
			salary = salary.replaceAll(",","");
			salary = salary.replaceAll("원","");
			salary = salary.replaceAll(" ","");
			
			foodExpense = foodExpense.replaceAll(",","");
			foodExpense = foodExpense.replaceAll("원","");
			foodExpense = foodExpense.replaceAll(" ","");
			
			afterTax = afterTax.replaceAll(",","");
			afterTax = afterTax.replaceAll("원","");
			afterTax = afterTax.replaceAll(" ","");
			
			addedHours = addedHours.replaceAll(",","");
			addedHours = addedHours.replaceAll("원","");
			addedHours = addedHours.replaceAll(" ","");
			
			let papagoArr = papago.split("-");//2025	01	01
			
			let test = {
				"salary":salary,
				"empId":empId,
				"foodExpense":foodExpense,
				"papago":papago,
				"afterTax":afterTax,
				"addedHours":addedHours,
				"year":papagoArr[0],
				"month":papagoArr[1]
			};
			/*
			{"salary": "3000000","empId": "20241224004","foodExpense": "200000","papago": "2024-12-24"}
			*/
			console.log("test : ", test);
			
			//ajax 요청을 비동기적으로 서버에 전송
			formData2.append("salary",salary);
			formData2.append("empId",empId);
			formData2.append("foodExpense",foodExpense);
			formData2.append("papago",papago);
			formData2.append("afterTax",afterTax);
			formData2.append("addedHours",addedHours);
			formData2.append("year",papagoArr[0]);
			formData2.append("month",papagoArr[1]);
			
	        console.log("formData2(등록버튼 클릭 시) : ", formData2);

	        if (papago.length == 0) {
				alert("지급년월일을 선택해주세요.");
				return;
			}
	        
			$.ajax({
				url:"/employeeSalary/salaryCreate",
				processData:false,
				contentType:false,
				data:formData2,
				type:"post",
				dataType:"text",
				success:function(result){
					//1 : 등록 성공, 0 : 등록 실패
					console.log("restult : ", result);
					
					// 올바른 방식
					let year = document.getElementById("year").value;  // yearSelect는 select 요소의 ID
					let month = document.getElementById("month").value; // monthSelect는 select 요소의 ID
			
					//등록
					if(result==1){
						location.href="/employeeSalary/salaryList?year=" + year + "&month=" + month;
					}else{
						alert("중복되었습니다.");
					}
				},
				error: function(xhr, status, error){
					console.error("AJAX 요청 실패 등록 실패: ", error);
				}
			})
		});//end 급여등록버튼
			
		
		// 급여 계산 버튼에 이벤트 추가
		$('#calculateBtn').click(function() {			
			calculateSalary();
			$("#btnSubmit").removeAttr("disabled");
		});//end 급여 계산 버튼
		
		
		
	});//end 달러function
	
	
	
	
	//모달
	$(function(){
		$("#insertmodal").on("click",function(){
			console.log("일괄 등록 비동기 처리")
			

			//1.가상 폼
			let formData = new FormData();
			
			// 2. 체크박스로 선택된 직원들의 empId를 배열에 담기
			let modalEmpIds = [];
			
			/* $(".employeeCheckbox:checked").each(function(){
				let empId = $(this).val();// 체크된 항목의 empId 값
				console.log("empId:", empId);
				modalEmpIds.push(empId);//배열에추가
			}); */

			$(".employeeCheckbox:checked").each(function(){
				let empId = $(this).val();// 체크된 항목의 empId 값
				modalEmpIds.push(empId);//배열에추가
				console.log("modalEmpIds:", modalEmpIds);
			});
			// 배열이 비어있는지 확인
			if (modalEmpIds.length == 0) {
				alert("직원을 선택해주세요.");
				return;
			}

			console.log("화긴 modalEmpIds!",modalEmpIds);
			
				// 지급일, 기타 데이터 추가
		        let expDate = $("#expDate").val(); // 지급일 (예: input의 id가 expDate)
		        if (!expDate) {
		            alert("지급일을 입력해주세요.");
		            return;
		        }

				// 데이터 담기
				let data = {
					"empId" : modalEmpIds,
					"expDate" : expDate,
					"year":$("#year").val(),
					"month":$("#month").val()
				}
		        console.log("으어으어data:", data);
			
				 /* modalEmpIds.forEach((empId) => {
				//<input type="text" name="empIds" value="a001"..
			    formData.append("empIds",  empId);
				formData.append("expDate", expDate);  // 지급일에 선택한 날짜 */
		        /* formData.append("afterTax", afterTax); */  // 예시: afterTax 값
		       /*  formData.append("year", $("#year").val());
		        formData.append("month", $("#month").val());
			});   */
				
		        //확인
			 	// formData.forEach((value, key) => {
			    // 	console.log("FormData key modal: 체킨", key, "FormData value:", value);
				// });  
			 	 $.ajax({
			            url: "/employeeSalary/modalSalary",  // 서버의 매핑된 URL
			            type: "POST",
			            data: JSON.stringify(data),
			            contentType: "application/json",  // 자동으로 multipart/form-data로 설정
			            // processData: false,  // 데이터가 문자열로 처리되지 않도록
			            success: function(response) {
			                console.log("응답:", response);
			                if (response > 0) {
			                    alert("일괄 등록이 완료되었습니다.");
			                } else {
			                    alert("등록에 실패했습니다.");
			                }
			            },
			            error: function(xhr, status, error) {
			                console.error("AJAX 에러:", error);
			                alert("오류가 발생했습니다.");
			            }
			            
			        });
			
		})
	})
	
	
	$(function(){
		//급여지급 버튼 클릭
	    $("#prev").on("click",function(){
	    	console.log($("#prev").length);
	       $(".modal_bgrd").css("display","block");
	       
	       let currentPage = $(this).data("currentPage");
	       let keyword = $(this).data("keyword");
	       //비동기 목록
			modalList(currentPage,keyword);
	       
		 	// 모달 닫기 버튼 클릭 시 모달 닫기
		    $("#delmodal").on("click", function() {
		    $(".modal_bgrd").css("display", "none"); // 모달 숨기기
	    });
	
	});	 
	$(document).on("click",".clsPagingArea",function(){
		let currentPage = $(this).data("currentPage");
		let keyword = $(this).data("keyword");
		
		console.log("currentPage",currentPage);
		console.log("keyword : "+keyword);
		
		modalList(currentPage,keyword);
		
		})	
	});
	
	 function loadSalariesByYearMonth() {
	 	
	    // 연도와 월 값 가져오기
	    const year = document.getElementById("year").value;
	    const month = document.getElementById("month").value;

	    console.log("선택된 연도:", year);
	    console.log("선택된 월:", month);

	    // GET 요청으로 서버에 전달
	    const url = `/employeeSalary/salaryList?year=\${year}&month=\${month}`;
	    console.log("URL",url);
		window.location.href = url;
	} 
 
	  //모달 리스트 검색 페이징 처리
		function modalList(currentPage, keyword){
			//사원 선택 시 오른쪽 영역의 지급연월일 란에 자동 선택됨 시작 ///
			let yy = $("#year").val();
			let mm = "0" + $("#month").val();
			mme = mm.slice(-2);
			let strDay = yy + "-" + mm + "-"+ "01";
			console.log("strDay : ", strDay);
			//사원 선택 시 오른쪽 영역의 지급연월일 란에 자동 선택됨 끝 ///
			
			$("#btnSubmit").attr("disabled",true);
		  
	 		//매개변수를 반영 //빈 문자열 처리
	 		let data = {
	 		 "keyword" : keyword,
	 		 "year":yy,
	 		 "month":mm
	 		};
	 		
	 		console.log("modat data : ", data);
	 	
	 		//아작나써유..(피)씨다타써
		 	$.ajax({
		 		url: "/employeeSalary/modalListPost",
		 		contentType:"application/json;charset=utf-8",
		 		data:JSON.stringify(data),
		 		type:"post",
		 		dataType:"json",
		 		success:function(resp){
		 			console.log("resp : ",resp);
		 			
		 			
		 			let str = "";
		 			$.each(resp,function(idx, employeeSalaryVO){
		 				str += `<tr>
							<td>\${employeeSalaryVO.rnum}</td>
							<td>\${employeeSalaryVO.empName}</td>
							<td>\${employeeSalaryVO.postName}</td>
							<td>\${employeeSalaryVO.deptName}</td>
							<td>\${employeeSalaryVO.salary}</td>
							<td>\${employeeSalaryVO.foodExpense}</td>
							<td>\${employeeSalaryVO.addedHours}</td>
							<td>\${employeeSalaryVO.afterTax}</td>
							<td><input type="checkbox" class="employeeCheckbox" name="employeeCheckbox" value="\${employeeSalaryVO.empId}"></td>
						</tr>`;
		 			});	
		 			// console.log("modal str : ", str);
		 			
		 			$("#modalTby").html(str);
		 			
					
					
		 		}
		 		
		 	});//end ajax
		 	
	 	} 
 
	  //직원 목록 조회(왼쪽)
		function selectEmployeeList(currentPage, keyword){
	 		//매개변수를 반영
	 		let data = {
	 		 "currentPage" : currentPage,
	 		 "keyword" : keyword //빈 문자열 처리
	 		};
	 		
	 		console.log("data : ", data);
	 	
	 		//아작나써유..(피)씨다타써
		 	$.ajax({
		 		url: "/employeeSalary/salaryListPost",
		 		contentType:"application/json;charset=utf-8",
		 		data:JSON.stringify(data),
		 		type:"post",
		 		dataType:"json",
		 		success:function(articlePage){
		 			console.log("articlePage : ",articlePage);
		 			const maskedResidentNumber = 
		 				`\${employeeSalaryVO.residentNumber1}-\${employeeSalaryVO.residentNumber2[0]}******`;
		 			let str = "";
		 			$.each(articlePage.content,function(idx, employeeSalaryVO){
		 				str += `<tr>
					 			<td>\${employeeSalaryVO.rnum}</td>
								<td style="cursor:pointer;"  onclick="loadEmployeeDetails('\${employeeSalaryVO.empId}')">
								\${employeeSalaryVO.empId}</td>
								<td>\${employeeSalaryVO.empName}</td>
								<td>\${employeeSalaryVO.postName}</td>
								<td>\${employeeSalaryVO.deptName}</td>
								<td>\${employeeSalaryVO.afterTax}</td>
							</tr>`;
		 			});	
		 			console.log("str : ", str);
		 			
		 			$("#tby").html(str);
		 			
		 			//페이징 블록 처리
					$("#divPagingArea").html(articlePage.pagingArea);
					
					
		 		}
		 		
		 	});//end ajax
		 	
	 	} 
	 	
	 	$(function(){
	 		$("#loadSalariesByYearMonth").on("click",function(){
	 			//해당 연월의 직원 급여 조회 함수 호출
	 			loadSalariesByYearMonth();
	 		});
	 		
// 	 		selectEmployeeList("1","");
	 		console.log("개똥이");
	 		
	 		//페이지 블록에서 특정 페이지 클릭 시 처리
	 		//동적으로 만들어진 요소를 클릭 시 이렇게 쓰자
	 		$(document).on("click",".clsPagingArea",function(){
	 			//<a href="#" data-current-page="1" data-keyword="대리" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link clsPagingArea">1</a>
	 			let currentPage = $(this).data("currentPage");//2
	 			let keyword = $(this).data("keyword");//대리
	 			console.log("currentPage : ", currentPage);
	 			console.log("keyword : ", keyword);
	 			
	 			selectEmployeeList(currentPage, keyword);
	 		});
	 	
	 		//검색 처리
			   $("#btnSeach").on("click",function(){
				   let keyword = $("input[name='keyword']").val();
				   console.log("keyword : "+keyword);
				   
				 //전역 함수 호출
				   selectEmployeeList("1",keyword);
			   });
			// 엔터 키 입력 시 검색 처리
			    $("input[name='keyword']").on("keydown", function(e) {
			        if (e.key === "Enter") {  // Enter 키가 눌렸을 때
			            let keyword = $(this).val();
			            console.log("검색어 : " + keyword);
			            selectEmployeeList("1",keyword);  // 검색 실행
			        }
		    	});   
	 		
	 		//1. 페이지 로딩 시 함수 호출(처음)
// 	 		selectEmployeeList(1, "");
	 	
	 	});
		 
	
</script>



       <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
<!-- ///// footer 시작 ///// -->

<!-- ///// footer 끝 ///// -->