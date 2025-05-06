<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
	<title>연차 및 휴가 관리</title>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->

<style>
.tbc {
	background-color: #3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.dashboard {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  padding: 20px;
  max-width: 1000px;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.7);
}

.info-card {
  background-color: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.7);
  transition: transform 0.3s, box-shadow 0.3s;
}

.info-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.7);
}

.info-card h2 {
  font-size: 18px;
  color: #333;
  margin-bottom: 10px;
}

.info-card p {
  font-size: 24px;
  font-weight: bold;
  color: #555;
}

.flex{
display: flex;
 justify-content: center;   /* 자식 요소들을 수평으로 가운데 정렬 */ 
/*   align-items: center;   */
}
.flexchid{
margin-left:30% !important; 
  justify-content: center;   /* 자식 요소들을 수평으로 가운데 정렬 */ 
   align-items: center;       /* 자식 요소들을 수직으로 가운데 정렬 */ 

}

.mgmodal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 화면 중앙 정렬 */
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    width: 400px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
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

.cona{
color: white;
}


.mgmodal h3 {
    margin-bottom: 15px;
}

.mgmodal form {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.conbtn{
background-color: 3069CE !important;
border:none !important; 
}

.col-center{
	text-align: center;   /* 수평 중앙 정렬 */
  	vertical-align: middle;  /* 수직 중앙 정렬 */
}

.commuteList{
	background-color : #ffffff;
	align-items : center;
	justify-content: center;
	margin-left : 50px;
	width: 90%;
}

.hdFlex{
display: flex;
align-items: center;
}
.tbb{
	margin : 10px;
}
#edit{
	justify-content: flex-end;
}

.row{
	max-width: 1580px;
	justify-content: space-between;
}
.attSub {
display: block !important;
height: auto !important;
}

.bluBt{
background-color: #3676EB;
color:white;
outline: none;
border:none;
width: 90px;
height:36px; 
border-radius: 5px;
margin:10px;

}

.mgModal,.mgModal2 {
    display: none; /* 처음에는 보이지 않음 */
    position: fixed;
    z-index: 1; /* 화면에서 가장 위에 위치 */
    left: 0;
    top: 0;
    
    width: 100%;
    height: 100%;
    overflow: auto; /* 내용이 많으면 스크롤 */
    background-color: rgb(165 165 165 / 88%); /* 어두운 배경 */
    animation: fadeIn 0.3s ease-in-out; /* 애니메이션 */
    
}
/* 모달 내용 영역 */
.mgModalBox ,.mgModalBox2 {
position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.95) !important;
    background: #ffffff;
    border-radius: 15px; /* 더 큰 둥근 모서리 */
    box-shadow: 8px 11px 3px 0px rgb(0 0 0 / 31%); /* 입체적인 그림자 */
    animation: zoomIn 0.3s ease-out;
    width: 700px;
    
}

/* 모달 제목 영역 */
.mgModalHeader {
    padding-bottom: 10px; /* 제목과 선 사이의 간격 */
    border-bottom: 2px solid #ddd; /* 제목 아래에 얇은 선 추가 */
    margin-bottom: 20px; /* 선과 내용 사이 간격 */
    height: 70px;
    background-color: #424446;
        border-radius: 15px 15px 0 0;
}

/* 모달 닫기 버튼 */
.close-btn {
    color: #ffffff;
    float: right;
    font-size: 28px;
    font-weight: bold;
    transition: color 0.3s ease;
}

.close-btn:hover,
.close-btn:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}


</style>
 </head>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
<div class="commuteList rounded h-100 p-4 ">
		<div class="hdFlex">
			<h3 class=" contlist">근태 관리</h3>
			<h5 class=" contlist"> &nbsp;> 연차 및 휴가 관리</h5>
		</div>
		<div class="row g-4">
        <div class="col-sm-6 col-xl-3">
           <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
               <i class="fa fa-chart-line fa-3x text-primary"></i>
               <div class="ms-3">
                   <p class="mb-2">남은 연차 개수</p>
                   <span id="getEmpAnnual"></span>
               </div>
           </div>
           </div>
        </div>
        
        <div class="row">
		    <div class="col-sm-6 col-xl-3">
		        <select id="yearSelector" class="form-select col-sm-6 col-xl-3">
		            <option value="" disabled selected>연도 선택</option>
		            <!-- 연도 목록은 JavaScript로 동적으로 추가 -->
		        </select>
		    </div>
		    <button type="button" id="edit" class="bluBt conbtn">휴가 신청</button>
		</div>
		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col" class="col-center">순번</th>
						<th scope="col" class="col-center" style="display:none;">empNo</th>
						<th scope="col" class="col-center">신청인</th>
						<th scope="col" class="col-center">신청종류</th>
						<th scope="col" class="col-center">제목</th>
						<th scope="col" class="col-center">내용</th>
						<th scope="col" class="col-center">연차 일수</th>
						<th scope="col" class="col-center">연차 시작일</th>
						<th scope="col" class="col-center">연차 종료일</th>
						<th scope="col" class="col-center">신청 상태</th>
					</tr>
				</thead>
				<tbody id="tby">
				</tbody>
			</table>
		</div>
		<div class="modal_bgrd" id= "modalBackground"  style="display: none; ">
            <div class="mgmodal">
								<div class="delmodal" id="closeModal">&times;</div>
								<h3>휴가신청</h3>
								<hr/>
								<form id="vacationForm">
									<label for="type">휴가 종류</label>
									<select id="attendanceCode" required>
										<option value = "" disabled selected>휴가 종류를 선택하세요</option>
									</select>
									<input type="text" id="empNo" value="${userInfo.empNo}" style="display:none;"/>
									<input type="text" id="annTotal" value="" style="display:none;"/>
									<input type="text" id="annTitle" placeholder="제목" required/>
									<input type="text" id="annContent" placeholder="내용" required/>
									<label for="annStartDate">시작일</label>
									<input type="datetime-local" id="annStartDate" required/>
									<label for="annEndDate">종료일</label>
									<input type="datetime-local" id="annEndDate" required />
									
									<button type="submit" class="btn btn-primary m-2 conbtn" id="annualSignUp">신청하기</button>
								</form>
            </div>
		</div>
		
		<div class="flex">
			<div class="" id="divPagingArea">
 				${articlePage.pagingArea} 
			</div>
		</div>
		<%@ include file="../include/footer.jsp"%>
	
	</div>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript">

axios.get('/att/getEmpAnnual')
	.then(response =>{
		const empAnnual = response.data.empAnnual;
		document.getElementById('getEmpAnnual').textContent = `\${empAnnual}/15`;
	})
	.catch(error =>{
		console.error("Error fetching annual data:",error);
	});
function populateYearSelector(){
	const yearSelector = document.getElementById('yearSelector');
	const currentYear = new Date().getFullYear();
	const startYear = currentYear - 5;
	
	for(let year = startYear; year <= currentYear; year++){
		const option = document.createElement("option");
		option.value = year;
		option.textContent = year;
		yearSelector.appendChild(option);
	}
}

populateYearSelector();

function setDefaultDateTime(){
	const now = new Date();
	
	// 현재 날짜
	const year = now.getFullYear();
	const month = String(now.getMonth() +1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
	const day = String (now.getDate()).padStart(2,'0'); // 날짜 두 자릿수로 맞추기
	
	// 기본 시간을 설정 (startDate는 오전 9시, endDate는 오후 6시)
	const startTime = `${year}-${month}-${day}T09:00`; //오전 9시
	const endTime = `${year}-${month}-${day}T18:00`; // 오후 6시
	
	document.getElementById('startDate').value = startTime;
	document.getElementById('endDate').value = endTime;
	
	const currentDate = `${year}-${month}-${day}`;
	document.getElementById('startDate').setAttribute('min',currentDate); // 최소값 설정
}

// 페이지 로드 시 기본값 설정
window.onload = function(){
	setDefaultDateTime();
};


document.getElementById('annStartDate').addEventListener('change',function(){
	document.getElementById('annEndDate').setAttribute('min', this.value);
});

function nvl(expr1, expr2) {
	   if (expr1 === undefined || expr1 == null || expr1 == "") {
	      expr1 = expr2;
	   }
	   return expr1;
	}

	// document/ready
	// 동일 jsp에서 1회작성
	function getList(currentPage,keyword,year){
		let data = {
				"currentPage" : nvl(currentPage,"1"),
				"keyword" : nvl(keyword,""),
				"year" : nvl(year,"")
		};
		console.log("data :",data);
	$.ajax({
		url: "/att/annualList",
		contentType: "application/json;charset=utf-8",
		data :	JSON.stringify(data),
		type :	"POST",
		dataType : "json",
		success: function(articlePage){
			console.log("articlePage : ",articlePage);
			console.log("articlePage.content:",articlePage.content);

			let str = "";
			$.each(articlePage.content, function (idx, AnnualVOList){
				str +=`
					<tr>
						<td class="col-center">\${AnnualVOList.rnum}</td>
						<td class="col-center" style="display:none;">\${AnnualVOList.empNo}</td>
						<td class="col-center">\${AnnualVOList.empName}</td>
						<td class="col-center">\${AnnualVOList.attendanceName}</td>
						<td class="col-center">\${AnnualVOList.annTitle}</td>
						<td class="col-center">\${AnnualVOList.annContent}</td>
						<td class="col-center">\${AnnualVOList.annTotal}</td>
						<td class="col-center">\${AnnualVOList.annStartDate}</td>
						<td class="col-center">\${AnnualVOList.annEndDate}</td>
						<td class="col-center">\${AnnualVOList.appStatusName}</td>
					</tr>`;
			});
			
			
			$("#tby").html(str);
			
			$("#divPagingArea").html(articlePage.pagingArea || "");
		},
		error: function (xhr, status, error){
			console.log("ERROR:", error);
		}
	});
}
	
	$(document).ready(function(){
		getList("1","","");
		
		
		// 연도 선택 시 데이터 필터링
		$("#yearSelector").on("change",function(){
			const selectedYear = $(this).val();
			console.log("선택된 연도:", selectedYear);
			getList("1", "", selectedYear);
		});
		
		// 페이지 클릭 처리
		// class="clsPagingArea" : 여러개(오브젝트 배열)
		$(document).on("click",".clsPagingArea",function(){
			// 클릭한 것은 하나
			event.preventDefault(); // 기본 동작 방지
			// <a .. data-current-page="1" data-keyword=""... class="page-link clsPagingArea">2</a>
			let currentPage = $(this).data("currentPage");//2
			let keyword = $(this).data("keyword");
			let selectedYear = $("#yearSelector").val();
			
			console.log("페이지클릭 처리 -> currentPage : "+ currentPage);
			console.log("페이지클릭 처리 -> keyword : " +keyword);
			
			// 회원 목록 호출
			getList(currentPage,keyword,selectedYear);
		});
	});
	
	
		const modalBackground = $(`#modalBackground`);
		const closeModalButton = $(`#closeModal`);
		const openModalButton = $(`#edit`);
	
	$(document).ready(function () {
		
		openModalButton.on('click', function (event){
			event.preventDefault();
			modalBackground.css('display','block');
		});
		closeModalButton.on('click',function (){
			modalBackground.css('display','none');
		});
		
		modalBackground.on('click',function(event){
			if($(event.target).is (modalBackground)){
				modalBackground.css('display','none');
			}
		});
	});
	
	
	
	document.addEventListener('DOMContentLoaded',function(){
		
	const selectElement = document.getElementById('attendanceCode');
	
	axios.get('/att/attendanceCode')
	.then(response =>{
		const data = response.data;
		console.log("data=>{}",data);
		
		data.forEach(item =>{
			const option = document.createElement('option');
			option.value = item.attendanceCode;
			option.textContent = item.attendanceName;
			selectElement.appendChild(option);
		});
		console.log("data=>{}",data);
		
	})
	.catch(error =>{
		console.log("Error fetching data:", error);
	});
	
	
	// 휴가 버튼 클릭시
	document.getElementById('annualSignUp').addEventListener('click', function(event){
		event.preventDefault();
		
		const empNo = document.getElementById('empNo').value;
		console.log("empNo",empNo);
		const attendanceCode = document.getElementById('attendanceCode').value;
		console.log("attendanceCode",attendanceCode);
		const annTitle = document.getElementById('annTitle').value;
		console.log("annTitle",annTitle);
		const annContent = document.getElementById('annContent').value;
		console.log("annContent",annContent);
		const annStartDate = document.getElementById('annStartDate').value;
		console.log("annStartDate",annStartDate);
		const annEndDate = document.getElementById('annEndDate').value;
		console.log("annEndDate",annEndDate);
		
		const startDate = new Date(annStartDate);
		const endDate = new Date(annEndDate);
		const timeDifference = endDate - startDate;
		const annTotal = timeDifference / (1000 * 3600 * 24);
		console.log("annTotal",annTotal);
			console.log("webSocket 대문자 {}",WebSocket);
// 			console.log("webSocket 소문자 {}",webSocket);
		// 필수 필드확인 빈값이 없으면 서버로 전송
		if(empNo && attendanceCode && annTitle && annContent && annStartDate && annEndDate){
		axios.post('/att/annualSignUp',{
			empNo : empNo,
			annTotal : annTotal,
			attendanceCode: attendanceCode,
			annTitle : annTitle,
			annContent : annContent,
			annStartDate : annStartDate,
			annEndDate : annEndDate
		})
		.then(response =>{
			console.log("Insert Success : ",response.data);
			alert('휴가 신청이 완료 되었습니다.');
// 			console.log("webSocket 소문자 {}",webSocket);
// 			console.log("webSocket 대문자 {}",WebSocket);
// 				WebSocket을 통해 승인자에게 알림 전송
// 	            if (webSocket && webSocket.readyState === WebSocket.OPEN) {
// 	                const message = `\${empNo}님이 휴가 신청을 했습니다.`;
// 	                webSocket.send(message);
// 	                console.log("WebSocket 메시지 전송:", message);
// 	            } else {
// 	                console.error("WebSocket이 연결되지 않았습니다.");
// 	            }
				
				// 신청 후 모달을 닫는 코드
	            modalBackground.css('display','none');
			})
			.catch(error =>{
			console.error("Insert Faild :",error);
			alert('휴가 신청 중 문제가 발생했습니다.');
			});
		}else{
			console.log("필수 필드가 누락되었습니다.");
			alert("모든 필드를 입력해 주세요");
		}
	});
});
</script>
	</html>
