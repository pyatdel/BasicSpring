<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<!-- ///// sidebar 시작 ///// -->
<jsp:include page="../include/mangerSidebar.jsp"></jsp:include>
<!-- ///// sidebar 끝 ///// -->

<!-- 왼쪽  -->
<style>
.row>* {
	flex-shrink: 0;
	margin: 2%;
	width: 40% !important;
	max-width: 100%;
	padding-right: calc(var(--bs-gutter-x)/2);
	padding-left: calc(var(--bs-gutter-x)/2);
	margin-top: var(--bs-gutter-y)
}
thead {
  background-color: blanchedalmond; /* 연두색 배경 */
  color: white;           /* 흰색 텍스트 */
}
#divPagingArea .page-item.active .page-link {
  color: white;           /* 활성화된 페이지 글자 색상 */
  background-color: coral; /* 활성화된 페이지 배경색 */
  border-color: coral;    /* 테두리 색상 */
}
#divPagingArea .page-link:hover {
  color: white;           /* 호버 시 글자 색상 */
  background-color: coral; /* 호버 시 배경색 */
  border-color: coral;     /* 호버 시 테두리 색상 */
}
#divPagingArea .page-link {
  color: black;          /* 링크 글자 색상 */
  background-color: white; /* 링크 배경색 */
  border: 1px solid gray; /* 테두리 색상 */
}
</style>

<div class="row g-4">
	<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4">직원 급여 등록</h6>
		<%-- <p>${employeeVO}</p> --%>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">사원번호</th>
					<th scope="col">사원명</th>
					<th scope="col">주민번호</th>
					<th scope="col">직급</th>
					<th scope="col">부서</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="employeeVO" items="${salaryVOList}" varStatus="stat">
				<tr>
					<th>${employeeVO.rnum}</th>
					<td onclick="loadEmployeeDetails('${employeeVO.empId}')"  style="cursor:pointer;" >
					<%-- <a href="/employeeSalary/salaryList?empId=${employeeVO.empId}"> --%>
					${employeeVO.empId}
					<!-- </a> -->
					</td>
					<td>${employeeVO.empName}</td>
					<td>${employeeVO.residentNumber1}-${employeeVO.residentNumber1}</td>
					<td>${employeeVO.postName}</td>
					<td>${employeeVO.deptName}</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
	</div>

	<!-- 오른쪽  -->
	<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4" id=""></h6>
		<form id="monthSelectorForm">
		    <label for="monthSelector">날짜 : </label>
		    <select id="yearSelector" name="year" onchange="loadSalaryForYear)">
		        <option value="" id="year">연 선택</option>
		    </select>
		    <select id="monthSelector" name="month" onchange="loadSalaryForMonth()">
		        <option value="" id="month">for(i>=1){
		        									}</option>
		    </select>
		</form>

		<form id="salaryForm" method="post" action="/updateSalary">
			<div class="mb-3">
				<label for="empId" class="form-label">사원번호</label> 
				<input type="text" class="form-control"
					id="empId" aria-describedby="empId" value="${employeeVO.empId}">
			</div>
			<div class="mb-3">
				<label for="empName" class="form-label">이름</label> 
				<input type="text" class="form-control"
					id="empName" aria-describedby="empName" value="${employeeVO.empName}">
			</div>
			<div class="mb-3">
				<label for="salary" class="form-label">기본급</label> 
				<input type="text" class="form-control"
					id="salary" aria-describedby="salary" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="foodExpense" class="form-label">식대</label> 
				<input type="text" class="form-control"
					id="foodExpense" aria-describedby="foodExpense" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="salaryIncomeTax" class="form-label">소득세</label> 
				<input type="text" class="form-control"
					id="salaryIncomeTax" aria-describedby="salaryIncomeTax" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="salaryHealthInsurance" class="form-label">건강보험</label> 
				<input type="text" class="form-control"
					id="salaryHealthInsurance" aria-describedby="salaryHealthInsurance" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="salaryNationalPension" class="form-label">국민연금</label> 
				<input type="text" class="form-control"
					id="salaryNationalPension" aria-describedby="salaryNationalPension" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="insurance " class="form-label">공제합계</label> 
				<input type="text" class="form-control"
					id="insurance" aria-describedby="insurance" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="difference " class="form-label">차인지급액</label> 
				<input type="text" class="form-control"
					id="difference" aria-describedby="difference" value="${employeeSalaryVO.empName}">
			</div>
			<div class="mb-3">
				<label for="salaryTotal" class="form-label">급여합계</label> 
				<input type="text" class="form-control"
					id="salaryTotal" aria-describedby="salaryTotal" value="${employeeSalaryVO.empName}">
			</div>
			
			<button type="button" class="btn btn-primary">등록</button>
			<button type="button" class="btn btn-secondary" onclick="clearForm()">취소</button>
		</form>
	</div>
</div>

<script>
	// 사원에 따라 급여 불러오기
	function loadEmployeeDetails(empId){
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
				$('#empId').val(response.empId);
				$('#empName').val(response.empName);
				$('#salary').val(response.salaryVOList[0].salary);
				$('#foodExpense').val(response.salaryVOList[0].foodExpense);
				$('#salaryIncomeTax').val(response.salaryVOList[0].salaryIncomeTax);
				$('#salaryHealthInsurance').val(response.salaryVOList[0].salaryHealthInsurance);
				$('#salaryNationalPension').val(response.salaryVOList[0].salaryNationalPension);
				$('#insurance').val(response.salaryVOList[0].insurance);
				$('#difference').val(response.salaryVOList[0].difference);
				$('#salaryTotal').val(response.salaryVOList[0].salaryTotal);
			},
			error: function(xhr,status,error){
				alert('사원 정보를 불러오는 데 실패했습니다.');
			}

		});
		
	}

	// 폼 초기화(취소 버튼 클릭 시)
	function clearForm(){
		$('#salaryForm')[0].reset(); // 폼 초기화
	}


</script>



       <script src="/dash/lib/easing/easing.min.js"></script>
    <script src="/dash/lib/waypoints/waypoints.min.js"></script>
    <script src="/dash/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="/dash/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
    <!-- Template Javascript -->
    <script src="/dash/js/main.js"></script>
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->


