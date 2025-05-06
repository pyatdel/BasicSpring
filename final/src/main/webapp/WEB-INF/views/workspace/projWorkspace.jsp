<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
.workList{
color:#3676EB !important;
font-weight: bold;

}
.workSubMenu{

display: block !important;
height: auto !important;

}
.workMenu {
color:#3676EB !important;
font-weight: bold;
}
.myWork {
	width: 90%;
height: 45vh;
margin: 0 auto;
border-radius: 20px !important; /* border-radius 확인 */
margin-top: 1%;
box-shadow:5px 5px 10px #000000a6;
overflow: visible; /* 부모 요소 overflow 확인 */
}

.file {
	overflow-y: hidden !important;
}

.deptWork {
	width: 90%;
	height: 45vh;
	margin: 0 auto;
	border-radius: 20px;
	margin-top: 1%;
	box-shadow: 5px 5px 10px #000000a6;
}

.state1 {
	width: 53px;
    height: 32px;
	background-color:#4db17e ;
	border-radius: 5px;
	text-align: center;
	color: white;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-content: center;
	align-items: center;
	margin: 10px;
	font-size: 14px;
}

.state0 {
	width: 53px;
    height: 32px;
	background-color:#48aff1;
	border-radius: 5px;
	text-align: center;
	color: white;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-content: center;
	align-items: center;
	margin: 10px;
	font-size: 15px !important;
}

.state2 {
	width: 53px;
    height: 32px;
	background-color:#f98b56;
	border-radius: 5px;
	text-align: center;
	color:white;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-content: center;
	align-items: center;
	margin: 10px;
	font-size: 15px !important;
}

.state3 {
	width: 53px;
    height: 32px;
	background-color:#ef6760;
	border-radius: 5px;
	text-align: center;
	color:white;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-content: center;
	align-items: center;
	margin: 10px;
	font-size: 15px;
}

.telft {
	display: flex;
	justify-content: center;
}

tr {
	height: 20px;
	border:#f7f7f700 !important;
	
	width: 100%;
	vertical-align: middle;
}

.table {
	text-align: center;
}

.a {
	font-weight: bold;
	color: #555353;
}

.flexcont {
	max-width: 1900px;
}

h3 {
	margin: 2% 0 2% 5% !important;
	font-weight: normal !important;
}

.headerFlex {
	display: flex
;
    align-items: center;
    justify-content: space-between;
    width: 93%;
    margin: 0 auto;
        margin-top: 1.4%;
    margin-bottom: 2%;

}
.fileBt3 {
	height: 10px !important;
	margin-right: 20% !important;
}

.tbHeader {
	font-weight: inherit;
	text-align: center;
	margin:30px;
}

.tbFlex {
	display: flex;
	align-items: center;
	margin-bottom: 1%;
}

#workBt {
height: 50px !important;
    border-radius: 10px;
    outline: none !important;
    border: none !important;
    background-color:#48aff1 !important;
    color: #f5f5f5;
    margin-right: 7% !important;
    width: 200px;
    /* font-weight: bold;*/
}

.rounded {
	overflow-y: auto;
}

.pagination {
	display: flex;
	padding-left: 0;
	list-style: none;
	justify-content: center;
}




.delmodal {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 30px;
	font-weight: bold;
	color: #333;
	cursor: pointer;
	z-index: 9999;
}

#modalOn {
	font-weight: bold;
	cursor: pointer;
}

.insertWork {
	display: flex;
	flex-direction: column;
	height: 50vh;
}
.insertWork2{
	display: flex;
	flex-direction: column;
	height: 60vh;

}

.flexHalf {
	display: flex;
}

.dateFlex {
	display: flex;
	align-content: center;
	align-items: center;
}

input ,textarea{
	outline: none !important;
	height: 35px;
	border-radius: 5px;
	border: 1px solid #898b95;
	margin: 0;
	display: flex;
	justify-content: flex-start;
	width: 100%;
}
textarea{
height:100px !important;
}
select {
	width: 100% !important;
}

textarea {
	resize: vertical;
	display: flex;
	justify-content: flex-start;
	background-color: white !important;
}

.important {
	display: flex;
}

.btFlex {
	display: flex;
	justify-content: flex-end;
}

.btFlex>button {
	margin: 10px;
}

.dateFlex {
	display: flex;
}
/* 전체 진행 바의 컨테이너 */
.progress-container {
	width: 100%; /* 전체 너비 */
	background-color: #e0e0e0; /* 배경색 (어두운 회색) */
	border-radius: 30px; /* 둥근 모서리 */
	height: 25px; /* 진행 바 높이 */
	box-shadow: inset 0 0 8px rgba(0, 0, 0, 0.3); /* 안쪽 그림자 */
	overflow: hidden; /* 넘치는 내용 숨김 */
	position: relative;
}

/* 진행 바 */
.progress-bar {
	height: 100%;
	background: #4db17e !important; /* 그라데이션 효과 */
	position: relative;
	border-radius: 30px;
	text-align: center; /* 텍스트 중앙 정렬 */
	line-height: 30px; /* 텍스트 세로 중앙 정렬 */
	color: white; /* 텍스트 색상 */
	font-weight: bold; /* 텍스트 두껍게 */
	font-size: 14px; /* 글씨 크기 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* 바 그림자 */
	transition: width 1s ease-out; /* 진행 바가 부드럽게 확장되도록 애니메이션 */
	position: relative;
}

/* 진행률 텍스트 표시 */
.progress-bar::after {
	content: attr(data-progress); /* data-progress 속성 값 표시 */
	position: absolute;
	top: 10;
	left: 50%;
	transform: translateX(-50%); /* 텍스트 중앙 정렬 */
	font-size: 16px; /* 텍스트 크기 */
	font-weight: bold; /* 텍스트 두껍게 */
	color: #fff; /* 텍스트 색상 */
}

.progressBox {
	width: 700px;
}

.trleft {
	font-weight: bold;
	color: #4d4949;
	text-align: left;
	cursor: pointer;
}

.searchText {
	width: 200px;
	height: 40px;
	border: 1px solid gray;
	caret-color: #66afe9;
}

.col-md-7 {
	width: 100% !important;
	display: flex !important;
	justify-content: center !important;
}

.searchInput {
	outline: none !important;
	border: 1px solid #c1c1c1 !important;
	padding: 8px;
	border-radius: 5px;
	caret-color: #66afe9;
	width: 260px;
}

.searchInput:focus {
	border-color: #66afe9; /* 포커스 시 테두리 색상 변경 */
	box-shadow: 0 0 5px rgba(102, 175, 233, .6); /* 포커스 시 그림자 효과 */
}

.searchText {
	width: 500px; /* 너비 설정 */
	padding: 10px; /* 안쪽 여백 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 4px; /* 테두리 둥글게 */
	font-size: 16px; /* 폰트 크기 */
	outline: none; /* 클릭 시 테두리 강조 없애기 */
	box-sizing: border-box; /* 패딩이 포함된 전체 너비 계산 */
	min-height: 10px; /* 최소 높이 설정 */
	word-wrap: break-word; /* 단어가 길면 줄 바꿈 */
	caret-color: #66afe9; /* 커서 색상 설정 */
	cursor: text; /* 마우스 커서를 텍스트 커서로 설정 */
}

.searchText:focus {
	border-color: #66afe9; /* 포커스 시 테두리 색상 변경 */
	box-shadow: 0 0 5px rgba(102, 175, 233, .6); /* 포커스 시 그림자 효과 */
}

.fa-magnifying-glass {
	position: absolute;
	right: 1%;
	cursor: pointer;
	color: gray;
	font-size: 1.1rem;
	top: 27% !important;
}

.searchBar {
	position: relative;
	text-align: center;
	display: flex;
	width: 40%;
	justify-content: flex-end;
}
select {
	    outline: none !important;
    border: 1px solid #c1c0c0 !important;
    background-color: #ffffff;
    padding: 10px;
    border-radius: 10px !important;
    width: 340px !important;
}
td > select {
	outline: none !important;
	border: 1px solid #898b95 !important;
	background-color: #fff !important;
	padding: 10px;
	border-radius: 10px;
	width: 100% !important;
}
input[type="date"] {
            font-family: Arial, sans-serif; /* 폰트 */
            font-size: 16px; /* 텍스트 크기 */
            color: #333; /* 텍스트 색상 */
            border: 1px solid #898b95; /* 테두리 스타일 */
            padding: 8px; /* 여백 */
            border-radius: 5px; /* 테두리 둥글기 */
        }

        /* 포커스 시 스타일 */
        input[type="date"]:focus {
            outline: none; /* 포커스 시 기본 테두리 제거 */
            border-color: #66afe9; /* 포커스 색상 변경 */
            background-color: #e8f5ff; /* 포커스 시 배경색 변경 */
        }
        td{
        text-align: left;
        }
        .inputTitle{
        	font-weight: bold;
        	text-align: left !important;
        	color:black;
        
        }
        .workInsert{
        	font-size: 1.4rem !important;
		    color: #ffffff;
		    
        
        }
        td{
        text-align: center;
        }
        
        .insertWork2 input {
        background-color:#f7f7f700 !important;
        border :  #f5f5f5 !important;
        color:black;
        
        }
        textarea{
        border :#c3c3c3 1px solid !important;
        
        }
        .workHalf{
        display: flex;
        width: 100%;
        
        }
        .workHalf>div{
        width:49%;
        
        }
        #endDated{
        	color:#ef6760 !important;
        	font-weight: bold;
        }
        .workCate{
        	    width: 100px !important;
    height: 40px;
    font-size: 14px !important;
    padding: 0 !important;
    padding-left: 10px !important;
    /* display: flex
; */
    /* text-align: center; */
    align-content: center;
        
        }
        .projCate{
        
        	display: flex;
        }
        #projectSelect{
        	margin-right:2%;
        	width:  350px !important;
        }
         /* 기본 모달 배경 */
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

/* 버튼 스타일 */
button {
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    background-color: #4CAF50;
    color: white;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}

button:hover {
    background-color: #3b3b3b;
}

/* 모달 열기 버튼 */
.open-modal-btn {
    padding: 12px 25px;
    font-size: 16px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.open-modal-btn:hover {
    background-color: #2980b9;
}

/* 애니메이션 효과 */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes zoomIn {
    from {
        transform: scale(0.9);
    }
    to {
    }
}

.customBox{
	    width: 100%;
    height: 40vh;
    background-color: #ebebeb63;
    position: absolute;
    bottom: 0;
    /* left: 50%; */
    border-top: 1px solid #e5e5e5;
    z-index: -1;

} 
.deleteBt ,.createWorkBt{
	border-radius: 10px;
	background-color: #4db17e;

}
.delBt{
	border-radius: 10px;
	background-color: #ef6760;
	
}
.mdheaderFlex{
    display: flex
;
    align-items: center;
    align-content: center;
    justify-content: space-between;
    width: 90%;
    margin: 0 auto;
    padding-top:2% !important;

}

        /* select 박스를 숨기고, custom 스타일을 넣을 공간 */
        select {
            appearance: none; /* 기본 드롭다운 제거 */
            -webkit-appearance: none; /* Safari에서도 드롭다운 제거 */
            -moz-appearance: none; /* Firefox에서도 드롭다운 제거 */
            width: 100%;
            padding: 12px 20px;
            border-radius: 8px;
            background-color: #ffffff;
            border: 2px solid #ddd;
            font-size: 16px;
            color: #333;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 3px 3px 2px rgb(0 0 0 / 13%);
        }

        select:focus {
            outline: none;
        }
		
        /* 커스텀 드롭다운 화살표 */
        .projCate::after {
            content: '▼'; /* 아래 화살표 */
    font-size: 16px;
    position: relative;
    top: 40%;
    right: 49%;
    transform: translateY(25%);
    color: #aaa;
    pointer-events: none;
    /* left: 30%; */
    z-index: 999;
        }

        /* 옵션 스타일 */
        option {
            padding: 10px;
            background-color: #fff;
            color: #333;
            font-size: 16px;
            border: none;
        }

        option:hover {
            background-color: #f1f1f1;
        }
        #allows{	
        position: relative
        ;
        height: 25px;
        right: 1.2%;
        
        }
.page-item.active .page-link {
    z-index: 0 !important;
    color: #fff;
    background-color:#48aff1 !important;
    border-color: #009CFF;
</style>
  </head>
<%@ include file="../include/header.jsp"%>
<div class="flexcont">
	<div class=" headerFlex">
	<div style="width:400px; display:flex; align-items: center;">
		<h3>업무 목록</h3>
		<div> <a href="/work/workDash" 
			style="color:#7d7d7d; 
			font-weight:bold;
		    font-weight: bold;
		    font-weight: normal;
		    font-size: 1.1rem;
		    margin-left: 20px;"> 
		    < Back</a></div>
	</div>
		
		<div class="projCate">
		
		<select id="projectSelect" name="proj_no" onchange="projChange()">
			<option value="" disabled selected>프로젝트 선택</option>
			<c:forEach var="project" items="${projVOList}">
				<!-- projNo와 projName만 출력 -->
				<option value="${project.projNo}">${project.projName}</option>
			</c:forEach>
		</select>


		<button type="button" id="workBt" class="fileBt3" onclick="modalOn()">
			업무 등록하기</button>
		</div>
		

	</div>
	<div class="myWork">
		<div class="" id="account">
			<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
		<div class="fileHeader"></div>
			<div class="tbFlex">
				<h5 class="tbHeader">내 업무 목록</h5>
				<select class="workCate">
					<option>우선순위</option>
					<option>낮음</option>
					<option>보통</option>
					<option>높음</option>
					<option>긴급</option>
				</select>
				<i class="fa-solid fa-sort-down" id="allows"></i>
			</div>
			<table class="table table-borderless">
				<thead>
					<tr>
						<th scope="col">No</th>
						<th scope="col">우선순위</th>
						<th scope="col">업무명</th>
						<th scope="col">시작일</th>
						<th scope="col">종료일</th>
						<th scope="col">진행률</th>
					</tr>
				</thead>
				<tbody id="mytbody" class="trflex">
				</tbody>
			</table>
			<div class="row justify-content-center" id="divPagingArea"></div>
		</div>



	</div>
	<div class="deptWork">
		<div class="" id="account">
			<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
			<div class="fileHeader"></div>
			<div class="tbFlex">
				<h5 class="tbHeader">부서 업무 목록</h5>
				<select class="workCate">
					<option>우선순위</option>
					<option>낮음</option>
					<option>보통</option>
					<option>높음</option>
					<option>긴급</option>
				</select>
				<i class="fa-solid fa-sort-down" id="allows"></i>
			</div>
			<table class="table table-borderless">
				<thead>
					<tr>
						<th scope="col">No</th>
						<th scope="col">우선순위</th>
						<th scope="col">업무명</th>
						<th scope="col">담당자</th>
						<th scope="col">시작일</th>
						<th scope="col">종료일</th>
						<th scope="col">진행률</th>
					</tr>
				</thead>
				<tbody id="depttbdy" class="trflex">
				</tbody>
			</table>
			<div class="row justify-content-center" id="divPagingArea2"></div>
		</div>



	</div>
	<!--
	task 

task_type(프로젝트 업무)   , start_date , end_date , task_status(0:요청 1:진행 2:완료) , persent , emp_no 
, proj_no , important(0:긴급 , 1:보통)  , task_no
	
	  -->
	<div id="myModal" class="mgModal">
    <!-- 모달 내용 -->
    <div class="mgModalBox">
        <div class="mgModalHeader">
					<div class="mdheaderFlex">
					<h6 class="workInsert">업무 등록하기</h6>
      				  <span class="close-btn" onclick="closeModal()">&times;</span>
        		</div>
        </div>
        <div class="modal-body">
            <div class="insertWork2">
				<div class=" contcon">
					<table class="table cmcrtb table-bordered">
				<form class="form-horizontal" id="form" name="form" action="/work/createWork" method="post">						
						<tbody class="contb">
							<!-- <input type="hidden" class="updtcon" name="entNo"> -->

							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>업무명</td>
								<td><input type="text" id="taskType" name="taskType" placeholder="업무명" ></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>업무 메모</td>
								<td><textarea rows="5" cols="40" name="taskMemo" id="taskMemo"></textarea></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>프로젝트</td>
								<td><select id="projectSelect2" name="projNo" onchange="">
										<!-- JSTL을 사용하여 projList를 동적으로 표시 -->
										<c:forEach var="project" items="${projVOList}">
											<!-- projNo와 projName만 출력 -->
											<option value="${project.projNo}">${project.projName}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>업무 기간</td>
								<td class="dateFlex"><input type="date" id="startDate" name="startDate"
									class="updtcon cdate" > ㅡ <input class="cdate"
									name="endDate" id="endDate" type="date"></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>업무상태</td>
								<td><select class="form-control" id="taskSatus"
									name="taskSatus">
										<option value="0">요청</option>
										<option value="1">진행</option>
										<option value="2">완료</option>
								</select>
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>업무 진행률</td>
								<td><select class="form-control" id="percent"
									name="percent">
										<option value="10">10%</option>
										<option value="20">20%</option>
										<option value="30">30%</option>
										<option value="40">40%</option>
										<option value="50">50%</option>
										<option value="60">60%</option>
										<option value="70">70%</option>
										<option value="80">80%</option>
										<option value="90">90%</option>
										<option value="100">100%</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle"><code>*</code>우선순위</td>
								<td>
										<select class="form-control" id="important"
									name="important">
										<option value="0">낮음</option>
										<option value="1">보통</option>
										<option value="2">높음</option>
										<option value="3">긴급</option>
								</select>
								</td>
							</tr>

						</tbody>
					</table>
				</div>
			</div>
        </div>
       	<div class="btFlex">
				<button type="button" class="createWorkBt" onclick="createWork()">등록</button>
				<button type="button" class="delBt" onclick="delModal()">취소</button>
			</div>
			</form>
    </div>
</div>
	<div id="myModal2" class="mgModal2">
    <!-- 모달 내용 -->
    <div class="mgModalBox2">
        <div class="mgModalHeader">
        		<div class="mdheaderFlex">
					<h6 class="workInsert">업무 상세보기</h6>
      				  <span class="close-btn" onclick="closeModal()">&times;</span>
        		</div>
        </div>
        <div class="modal-body">
            <div class="insertWork2">
				<div class=" contcon">
					<table class="table cmcrtb table-bordered">
						<tbody class="contb">
						<div class="workHalf">
						<div>
							<!-- <input type="hidden" class="updtcon" name="entNo"> -->

							<tr>
								<th scope="row"></th>
								<td class="inputTitle">업무명</td>
								<td><input type="text" id="taskTypeD" name="taskType2" placeholder="업무명" disabled></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">업무 설명</td>
								<td><textarea rows="5" cols="40" name="taskMemo" id="taskMemoD" disabled></textarea></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">업무 담당자</td>
								<td><input  type="text"  name="empNameD" id="empNameD" disabled /></td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">프로젝트명</td>
								<td><select id="projectSelect3" name="projNo" onchange="" style="display:none"disabled="disabled">
										<!-- JSTL을 사용하여 projList를 동적으로 표시 -->
										<c:forEach var="project"  items="${projVOList}">
											<!-- projNo와 projName만 출력 -->
											<option value="${project.projNo}" id="projNameD">${project.projName}</option>
										</c:forEach>
								</select>
								<input type="text" id="projNameDD" disabled>
								</td>
							</tr>
								<tr>
								<th scope="row"></th>
								<td class="inputTitle">프로젝트 내용 </td>
								<td>
									<textarea row="2" col="20" type="text" id="contractNo" disabled></textarea>
								</td>
							</tr>
							</div>
							<div>
							
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">시작 기한</td>
								<td class="dateFlex">
									<input type="text" id="startDateD" disabled> -
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">완료 기한</td>
								<td class="dateFlex" class="endDated">
									<input type="text" id="endDateD" disabled> -
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">업무상태</td>
								<td>
									<input type="text" id="taskStatusD" disabled>
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">업무 진행률</td>
								<td>
									<input type="text" id="percentD" disabled>
								</td>
							</tr>
							<tr>
								<th scope="row"></th>
								<td class="inputTitle">우선순위</td>
								<td><div id="importantD" disabled></div>
										
								</td>
							</tr>
	</div>
						</div>

						</tbody>
					</table>
				</div>
			</div>
			
        </div>
        <div class="customBox"></div>
        <div class="modal-footer">
            	<div class="btFlex">
				<!-- <button type="button" class="updateBt" onclick="">수정</button> -->
				<button type="button" class="deleteBt" onclick="">삭제</button>
				<button type="button" class="delBt" onclick="closeModal()">취소</button>
			</div>
        </div>
    </div>
</div>
	<jsp:include page="../include/footer.jsp"></jsp:include>
	
</div>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>

myWorkList()
deptWorkList()
function detailWork(taskNo){
	console.log("taskNo 체킁 졸리다 배부르다 ",taskNo)
	 
	let url = "/work/workDetail";
	let data = {
			taskNo :taskNo
	}
	
	let taskType = document.querySelector("#taskTypeD")
	let taskMemo = document.querySelector("#taskMemoD")
	let contractNo = document.querySelector("#contractNo")
	let projName = document.querySelector("#projNameDD")
	let  startDate= document.querySelector("#startDateD")
	let  endDate= document.querySelector("#endDateD")
	let  taskStatus = document.querySelector("#taskStatusD")
	let  percent = document.querySelector("#percentD")
	let  important = document.querySelector("#importantD")
	let  empNameD = document.querySelector("#empNameD")
	axios.post(url,data)
	.then(function(res){
		console.log("res체체체킁" , res)	
		let data =  res.data
	    let importantBt = "";
		let importantText = ""; 
		let statusText = ""
	    if (data.important === 0) {
	    			importantBt = 'state0';
	    			importantText += "낮음"
	                 
	             } else if (data.important === 1) {
	            	 importantBt = 'state1';
	            	 importantText = "보통"
	             }else if (data.important === 2) {
	            	 importantBt = 'state2';
	            	 importantText = "높음"
	             }  
	             else if (data.important === 3) {
	            	 importantBt = 'state3';
	            	 importantText = "긴급"
	             }
			    if (data.taskStatus === '0') {
	    			statusText += "요청"
	                 
	             } else if (data.taskStatus === '1') {
	            	 statusText = "진행중"
	             }else if (data.taskStatus === '2') {
	            	 statusText = "완룐"
	             } 
	    let projNameVal = data.projName
	    
	    console.log(projNameVal)
		taskType.value=data.taskType
		startDate.value=data.startDate
		endDate.value=data.endDate
		taskStatus.value=statusText
		percent.value=data.percent+"%"
		taskType.value=data.taskType
		important.innerHTML=importantText
		important.classList.add(importantBt); 
	    projName.value =projNameVal
	    taskMemo.value= data.taskMemo
	    contractNo.value= data.projContent
	    empNameD.value = data.empName
	    modalOn2()
		console.log(taskStatus,statusText)
	}).catch(function(error){
		console.err("에러났다")
	})
	
	
	
	
}


// 업무 등록
 function createWork(){
	let projectSelect = document.getElementById("projectSelect2");
    let projValue = projectSelect.value;
	let taskSatus = document.getElementById("taskSatus");
    let taskSatusValue = taskSatus.value;
	let percent = document.getElementById("percent");
    let percentValue = percent.value;
	let important = document.getElementById("important");
    let importantValue = important.value;
	let startDate = document.getElementById("startDate").value;
	let endDate = document.getElementById("endDate").value;
	let taskType = document.getElementById("taskType").value;
	let taskMemo = document.getElementById("taskMemo").value;
    console.log("projValue",projValue,taskSatusValue,percentValue,importantValue,startDate)

    let data ={
    	taskType:taskType,
    	startDate:startDate,
    	endDate:endDate,
    	taskStatus:taskSatusValue,
    	percent:percentValue,
    	projNo:projValue,
    	important:importantValue,
    	taskMemo:taskMemo
    }
    
    let projNo = percentValue;
    console.log("data",data)
    let url = "/work/createWork";
    axios.post(url,data)
	.then(function(res){
		console.log("체ㅡㅋ응",res.config.data)
		alert("등록이 되었습니다.")
		
		location.href="/work/projWorkspace"
	}).catch(function(error){
		console.err("에러났다")
	})
	
	
	
}
function projChange(){
	 let projNo = document.getElementById('projectSelect').value;
	    
	    if (projNo === "") {
	        alert("프로젝트를 선택해주세요.");
	        return;
	    }

	    let currentPage = 1;  // 페이지 번호 (예시)
	    let keyword = "";     // 검색어 (예시)
		console.log("projNo체킁" ,projNo)
		deptWorkList(currentPage, keyword, projNo);
	    myWorkList(currentPage, keyword, projNo);
	
	
}


function myWorkList(currentPage,keyword,projNo){
		console.log("projNo체킁 (2)" ,projNo)
	let data = {
		     currentPage: currentPage,
	         keyword: keyword ,
	         projNo : projNo
	         
	       
	 	}
	let url = "/work/proj"
	axios.post(url,data)
	.then(function(res){
		console.log("체ㅡㅋ응",res)
		let content = res.data.content;
	 	
		let mytbody = document.querySelector("#mytbody");
		let str = ""
			 for(let i =0; i<content.length; i++){
					let list = content[i]
					let stateClass = 'state1';
					let taskStatus = "";
					let startDate = new Date(list.startDate);
					let endDate = new Date(list.endDate);
			        let fmtStartDate = startDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });
			        let fmtEndDate = endDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });
					 if (list.important === 0) {
		                 iconClass = 'state0';
		                 taskStatus = "낮음"
		                 
		             } else if (list.important === 1) {
		                 iconClass = 'state1';
		                 taskStatus = "보통"
		             }else if (list.important === 2) {
		                 iconClass = 'state2';
		                 taskStatus = "높음"
		             }  
		             else if (list.important === 3) {
		                 iconClass = 'state3';
		                 taskStatus = "긴급"
		             }
					
			
			console.log("체킁 리스트" , list)
				let taskNo = list.taskNo ;
				console.log("태넘 체킁",taskNo ) 
				
				str +=`	
				<tr >
                    <th scope="row">1</th>
                    <td class="telft" ><div class="\${iconClass}">\${taskStatus}</div></td>
                    <td class="trleft"  onclick="detailWork(\${taskNo})">\${list.taskType}</td>
                    <td>\${fmtStartDate}</td>
                    <td>\${fmtEndDate}</td>
                    <td  class="progressBox">
                    <div class="progress-container">
                    <div class="progress-bar" style="width: \${list.percent}%;" data-progress="\${list.percent}%"></div>
                  </div>
                    
                    
                    </td>
                </tr>
		`
			
		}
		
		mytbody.innerHTML = str
		 document.getElementById("divPagingArea").innerHTML = res.data.pagingArea;
		paging2(currentPage, keyword)
		console.log("에스티알체킁" ,str1)
	}).catch(function(error){
		
	})
	
	
	
	
	
	
}
function deptWorkList(currentPage,keyword,projNo){
	console.log("projNo체킁(dept)",projNo)
	let data = {
		     currentPage: currentPage,
	         keyword: keyword,
	         projNo : projNo
	 	}

	console.log("함수내부 currentPage 체킁" ,currentPage )
	console.log("함수내부 data 체킁" ,data )
	let url = "/work/deptList"
	axios.post(url,data)
	.then(function(res){
		console.log("deptList 체킁 ",res)
		let content = res.data.content;
		
		 let depttbody = document.querySelector("#depttbdy");
		let str = "" 
		 for(let i =0; i<content.length; i++){
			let list = content[i]
			let stateClass = 'state1';
			let taskStatus = "";
			let startDate = new Date(list.startDate);
			let endDate = new Date(list.endDate);
	        let fmtStartDate = startDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });
	        let fmtEndDate = endDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });
			 if (list.important === 0) {
                 iconClass = 'state0';
                 taskStatus = "낮음"
                 
             } else if (list.important === 1) {
                 iconClass = 'state1';
                 taskStatus = "보통"
             }else if (list.important === 2) {
                 iconClass = 'state2';
                 taskStatus = "높음"
             }  
             else if (list.important === 3) {
                 iconClass = 'state3';
                 taskStatus = "긴급"
             }
			 let taskNo = list.taskNo ;
				console.log("태넘 체킁",taskNo ) 
				
			
			console.log("체킁 리스트" , list)
				str +=`	
				<tr >
                    <th scope="row">1</th>
                    <td class="telft" ><div class="\${iconClass}">\${taskStatus}</div></td>
                    <td class="trleft" onclick="detailWork(\${taskNo})">\${list.taskType}</td>
                    <td>\${list.empName}</td>
                    <td>\${fmtStartDate}</td>
                    <td>\${fmtEndDate}</td>
                    <td class="progressBox">
                    <div class="progress-container">
                    <div class="progress-bar" style="width: \${list.percent}%;" data-progress="\${list.percent}%"></div>
                  </div>
                    
                    
                    </td>
                </tr>
		`
				
				
				
			
		} 
		depttbody.innerHTML = str
		 document.getElementById("divPagingArea2").innerHTML = res.data.pagingArea;
		paging(currentPage, keyword)
		
		
		console.log("에스티알체킁" ,str1)
	}).catch(function(error){
		
	})
	
	let div2 = document.getElementById("divPagingArea2");
	function paging(currentPage, keyword){
		  
		console.log("currentPage 체킁" ,currentPage )  
		  div2.addEventListener('click', function() {
		      // 클릭된 요소가 .clsPagingArea 클래스를 가진 <a> 태그인 경우
		      if (event.target && event.target.classList.contains('clsPagingArea')) {
		          // data-current-page와 data-keyword 값 가져오기
		          let currentPage = event.target.getAttribute('data-current-page');
		          let keyword = event.target.getAttribute('data-keyword');
		          
		          // 콘솔 로그로 값 확인
		          // console.log("currentPage :" + currentPage);
		          // console.log("keyword :" + keyword);
				 
		          // 해당 페이지의 리스트 불러오기		          
		         deptWorkList(currentPage,keyword,projNo)
		      }
		  });
	  }
	
	function paging2(currentPage, keyword){
		console.log("currentPage 체킁" ,currentPage )  
		  document.addEventListener('click', function() {
		      // 클릭된 요소가 .clsPagingArea 클래스를 가진 <a> 태그인 경우
		      if (event.target && event.target.classList.contains('clsPagingArea')) {
		          // data-current-page와 data-keyword 값 가져오기
		          let currentPage = event.target.getAttribute('data-current-page');
		          let keyword = event.target.getAttribute('data-keyword');
		          
		          // 콘솔 로그로 값 확인
		          // console.log("currentPage :" + currentPage);
		          // console.log("keyword :" + keyword);
				 
		          // 해당 페이지의 리스트 불러오기		          
		         myWorkList(currentPage,keyword,projNo)
		      }
		  });
		
		
		
	}
	
}
//모달 열기
	 function modalOn() {
    document.getElementById('myModal').style.display = 'block';
};
	 function modalOn2() {
    document.getElementById('myModal2').style.display = 'block';
};

// 모달 닫기
function closeModal() {
    document.getElementById('myModal').style.display = 'none';
    document.getElementById('myModal2').style.display = 'none';
}

// 모달 배경 클릭 시 닫기
window.onclick = function(event) {
    if (event.target === document.getElementById('myModal')) {
        closeModal();
    }
    if (event.target === document.getElementById('myModal2')) {
        closeModal();
    }
}

// ESC 키를 눌렀을 때 모달 닫기
window.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        closeModal(); // ESC 키가 눌리면 모달 닫기
    }
});

function setProgress(progress) {
	  const progressBar = document.querySelector('.progress-bar');
	  progressBar.style.width = progress + '%';  // 진행 바의 너비 설정
	  progressBar.setAttribute('data-progress', progress + '%');  // 진행률 텍스트 업데이트
	}

	// 예시: 진행률을 60%로 설정

</script>

 </html>
<!-- 메인 컨텐츠 영역 끝 -->