<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.text.NumberFormat"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
  
<!-- 여기 style css 들어가야해요  -->
<style>
.sidebar a{
    padding: 15px;
    
}
.menu-text{
	padding-left: 10px;
}
.tbc {
	background-color: #3069CE;
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
	justify-content: space-between;
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
	    width: 1980px;
	margin: 0 auto !important;
}

.table {
	margin-top: 1%;
}

.bg-transparent {
	height: 40px !important;
}

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
	max-width: 100%;
	margin: 0 auto !important;
}

.table {
	margin-top: 1%;
	border-color: #FCFCFC !important;
}

.bg-transparent {
	height: 40px !important;
}

.taxindate {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	width: 1000px;
}

.taxincontain {
	border-radius: 10px;
}

.datebtn {
	text-align: center;
	display: flex;
	width: 100px;
	justify-content: center;
	align-items: center;
	height: 48px;
}

.databtn>button {
	margin: 0 !important;
}

.taxlist {
	border: 1px solid #c4c4c4 !important;
}

.taxlist {
	text-align: center;
}

.bluBt{
background-color: #3069CE;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;
margin-left:5px;

}
.flex {
	display: flex;
}
.paging2 {
	display: flex !important;
}

.flexchid {
	margin-left: 30% !important;
	justify-content: center; /* 자식 요소들을 수평으로 가운데 정렬 */
	align-items: center; /* 자식 요소들을 수직으로 가운데 정렬 */
}

.contb {
	display: flex;
	justify-content: flex-end;
}

input {
	height: 35px !important;
}

.taxspan {
	margin-right: 1%;
	margin-left: 1%;
}

tr th td {
	text-align: center;
}

#tbb {
	text-align: center;
}

.contractNm {
	text-align: left !important;
}

.contractHeader {
	display: flex;
	align-items: center;
}

select {
	outline: none !important;
	border: none !important;
	background-color: #f1f1f1;
	padding: 3px;
	border-radius: 10px;
	margin-left: 30px !important;
	width: 100px;
}

.contractPrice {
	margin-right: 10px !important;
	text-align: right !important;
}
.sumTable{
text-align: center;
}

.widflex {
	width: 90%;
	margin: 0 auto;
	height: 40vh;
}

.contsucc {
	display: flex;
	flex-wrap: wrap;
	width: 33%;
}

.contsucc>div {
	width: 29%;
	height: 130px;
	background-color: #F6F6F6;
	margin: 10px;
	border-radius: 10px;
	box-shadow: 3px 3px 3px #bdbdc7;
	padding-top: 8%;
}

.contsucc>div>div {
	text-align: center;
	align-content: center;
	vertical-align: middle;
}

.firstcont {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.gantcont {
	margin-top: 4%;
}

.expditcontainer {
	height: 40vh;
}

#myChart {
	height: 300px !important;
}

.Totaltbd {
	/* border-color: black !important; */
	
}

#myChart2 {
	height: 337px !important;
	width: 337px !important;
}

.sumHeader {
	font-size: 18px;
	font-weight: bold;
}

.sumNav {
	display: flex;
	justify-content: space-between;
	width: 21%;
}

.dumNav>h5 {
	padding-right: 10px;
}

.sumTable {
	
}

.sth, .stb, .str {
	border-color: gray !important;
	border-style: solid;
	border-width: 0;
}

.page-item>a {
	color: #3069CE !important;
}

.next>a, .previous>a {
	color: #0660ff !important;
}

.page-item.active>a {
	color: white !important;
}
.fa-solid {
font-size: 20px;
cursor: pointer;
}
.flexdiv{
display: flex;

}
thead{
height: 20px !important;
border-bottom: none !important;

}
i{
margin:0;}

.contListSub{
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
.hdFlex{
display: flex;
align-items:center;
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

.greenBt{
background-color: #278986 !important;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

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
.sortBt{
color: white;

}
.maxwidth{
margin-top:3% !important;


}
</style>
  </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

<!-- 여기 내용 들어가야해요  -->
<div class="maxwidth">
	<div class="expditcontainer">
		<div class="bg-light rounded widflex">
		<div class="hdFlex">
			<h3 class=" contlist ">계약관리</h3>
			<h5 class=" contlist"> &nbsp;> 계약서 목록</h5>
		</div>
			<div class="sumNav"></div>
			<div class="firstcont">
				<div class="contsucc">
<!-- 					<div>
						<div>전체계약</div>
						<div></div>
					</div>
					<div>
						<div>체결완료</div>
						<div></div>
					</div>
					<div>
						<div>진행중</div>
						<div></div>
					</div>
					<div>
						<div>완료</div>
						<div></div>
					</div>
					<div>
						<div>취소</div>
						<div></div>
					</div>
					<div>
						<div>매출</div>
						<div></div>
					</div> -->
				</div>
				<div style="">
					<canvas id="myChart2"></canvas>
				</div>
				<div>
					<canvas id="myChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	<%-- 	<p>${contractMasterVOList}</p>
	<p>${contractMasterVO}</p> --%>
	<%-- <p>${articlePage}</p> --%>
	<div class="bg-light rounded h-100 p-4 maxwidth">
		<div id="tbhd">
		    <!-- 정렬 버튼 -->
		    <!-- <i class="fa-solid fa-caret-down" id="sortDate" onclick="toggleSort('date')" data-sort-direction="ASC"></i> -->
		    
<!--    <div class="flexdiv">계약금액
   &nbsp;
        <div id="sortPriceAsc" onclick="changeSort('price', 'ASC')">오름차순</div>
        &nbsp;
        <div id="sortPriceDesc" onclick="changeSort('price', 'DESC')">내림차순</div>
        &nbsp;
        날짜&nbsp;
        <div id="sortDateAsc" onclick="changeSort('date', 'ASC')">오름차순</div>
        &nbsp;
        <div id="sortDateDesc" onclick="changeSort('date', 'DESC')">내림차순</div>
    </div> 
		 -->
			<div class="contractHeader">
				<select name="contractStatus" id="contractStatus" onchange="applyContractStateFilter()">
					<i class="fas fa-file"></i>
					<option value="0">계약상태 </option>
					<option value="1">계약체결</option>
					<option value="2">진행중</option>
					<option value="3">취소</option>
					<option value="4">보류</option>
				</select>
			</div>
			<div class="taxindate">
				<span class="taxspan">계약코드 </span> 
				<input type="number"
					name="contractNo" class="updtcon" placeholder="계약코드"
					value=""> <span class="taxspan contractNm">계약명</span> <input
					type="text" name="contractNm" class="updtcon" placeholder="계약명"
					value=""> <span class="taxspan">거래처명</span> <input
					type="text" name="entName" class="updtcon cdate" placeholder="거래처명"> 
				<div class="datebtn">
					<button type="button" id="edit" class="bluBt">조회하기</button>
				</div>

			</div>
		</div>

		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col">No</th>
						<th scope="col">계약코드</th>
						<th scope="col" style="display:flex;">계약일자 
						<!-- <i class="bi bi-caret-down-fill sortBt" id="sortDate" onclick="toggleSort('date')" data-sort-direction="ASC"></i>
						<i class="fa-solid fa-caret-down"   onclick="changeSort('date', 'ASC')" data-sort-direction="ASC"></i> -->
						<i class="fa-solid fa-caret-up sortBt" style="display:none;" onclick="changeSort('price', 'DESC')"></i> 
						
						 </th>
						<th scope="col " class="">계약명</th>
						<th scope="col">계약금액
						<i class="fa-solid fa-caret-down sortBt" onclick="toggleSort('price')" id="sortPrice"></i>
						</th>
						<th scope="col">계약상태</th>
						<th scope="col">거래처명</th>
					</tr>
				</thead>
				<tbody id="tby">
					<c:forEach var="contractMasterVO" items="${articlePage.content}"
						varStatus="stat">
						<tr>
							<th scope="row">${contractMasterVO.rnum}</th>
							<td>${contractMasterVO.contractNo}</td>
							<td>${contractMasterVO.fromDatec}</td>
							<td class="contractNm"><a
								href="/contract/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&contractNo=${contractMasterVO.contractNo}">${contractMasterVO.contractNm}</a></td>
							<td class="price contractPrice" onclick=""><fmt:formatNumber
									value="${contractMasterVO.contractPrice}" pattern="#,###" /></td>
							<c:choose>
								<c:when test="${contractMasterVO.state == '0'}">
									<td>계약체결</td>
								</c:when>
								<c:when test="${contractMasterVO.state == '1'}">
									<td>진행중</td>
								</c:when>
								<c:when test="${contractMasterVO.state == '2'}">
									<td>완료</td>
								</c:when>
								<c:when test="${contractMasterVO.state == '3'}">
									<td>취소</td>
								</c:when>
								<c:when test="${contractMasterVO.state == '4'}">
									<td>보류</td>
								</c:when>
								<c:otherwise>
									<!-- 둘 다 false일 때 실행되는 코드 -->

									<td>?</td>
								</c:otherwise>
							</c:choose>
							<td>${contractMasterVO.entName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<p>${contractMasterVo }</p>
		<center class="flex paging1">
			<button type="button" id="edit" class=" greenBt conbtn">
				<a href="/contract/create" class="greenBt "class="cona">계약등록</a>
			</button>
			<div class="row flexchid" id="divPagingArea">
				${articlePage.pagingArea}</div>
		</center>
		<center class="flex paging2" >
			<button type="button" id="edit2" class="btn btn-primary m-2 conbtn" style="display: none;">
				<a href="/contract/create" class="cona"  >계약등록</a>
			</button>
			<div class="row flexchid page2 paging2"  id="divPagingArea2"  >
			</div>
		</center>
	</div>
   <jsp:include page="../include/footer.jsp"></jsp:include>
</div>



<script type="text/javascript">
	// 리스트 정렬 시작
	// 전역변수
	
	
	let currentPage = 1; // 초기 페이지 값
	let sort = 'price'; // 기본 정렬 기준
	let direction = "DESC"; // 기본 정렬 방향
	let state = "";

	// 정렬별로 페이지 change
	function changePage(newPage, direction,state) {
	    // 페이지가 1 이하로 내려가지 않도록 처리
		    
	    if (newPage < 1) return;
		
    	// newPage를 currentPage에 담기  
    	currentPage = newPage;
    	
    	
	    document.querySelector(".clsPagingArea").innerText = currentPage; // 현재 페이지 표시
		//console.log("1번째 콜백함수(direction) : " , direction)
		//console.log("1번째 콜백함수(currentPage) : " , currentPage)
		//console.log("1번째 콜백함수(newPage) : " , newPage)
		console.log("1번째 콜백함수(contractState) : " , state)
		
	    // 페이지 변경 시 데이터를 새로 요청
	    changeSort(sort,direction,currentPage,state);
	}
	
	// 정렬 change 함수 
	function changeSort(sort,direction,currentPage,state){
		let sortURL = `http://localhost:8020/contract/listAjaxSort`
		
		currentPage = currentPage || 1;
		console.log("2번째 콜백함수(currentPage)",currentPage)
		console.log("2번째 콜백함수(sort)",sort)
		console.log("2번째 콜백함수(contractState)",state)
		console.log("2번째 콜백함수(direction)",direction)
		 
		let data = {
				currentPage: currentPage,
				sort: sort,
				direction:direction,
				state: state 
		}
		console.log("정렬데이터(data) : ", data);
		
		axios.post(sortURL,data)
	       .then(articlePage => {
	    	   console.log("데이터 넘어왔냐 ??" ,articlePage)
	    	   console.log("데이터 넘어왔냐 ??" ,data)
	    	   //console.log("데이터 넘어왔냐 ??" ,articlePage.data.content.length)
	
	    	   
	    	      if (articlePage.data.content.length === 0 && currentPage > 1) {
                currentPage = 1;
                // 재요청하여 첫 페이지 데이터 불러오기
                changeSort(sort, direction, currentPage, state);
                return;
            }
	    	    // 출력할 HTML 내용
	            let str = "";
	    	    
	    	    // 기존 동기 방식 리스트의 페이징 박스 none
	            let pag = document.querySelector(".paging2");
	            let pag2 = document.querySelector(".paging1");
	            let createButton = document.querySelector("#edit2")
	            pag.style.display = 'block'
	            pag2.style.display = 'none'
            	createButton.style.display='block'
	           
            	
            	// content에 있는 각 contractMasterVO를 for문으로 순회
	            for (let i = 0; i < articlePage.data.content.length; i++) {
	                const contractMasterVO = articlePage.data.content[i]; // 현재 contractMasterVO
	    	  
	                // price 가격 쉼표 포맷팅
	                let inputValue = contractMasterVO.contractPrice;
	    	    	inputValue = Number(inputValue); 
				  	inputValue = inputValue.toLocaleString();
				  	
					//console.log(inputValue);  // 확인
					
				  
				   // state 상태 함수로 처리 해 오셈  
	               let contractStateText = getContractStateText(contractMasterVO.state);

				  
				  // 테이블의 각 행 HTML 추가
	                str += `
	                    <tr>
	                        <th>\${contractMasterVO.rnum}</th>
	                        <td>\${contractMasterVO.contractNo}</td>
	                        <td>\${contractMasterVO.fromDatec}</td>
	                        <td class="contractNm"><a href="/contract/detail?currentPage=\${contractMasterVO.currentPage}&keyword=\${contractMasterVO.keyword}&contractNo=\${contractMasterVO.contractNo}">\${contractMasterVO.contractNm}</a></td>
	                        <td class="price contractPrice">\${inputValue}</td>
	                        <td>\${contractStateText}</td>
	                        <td>\${contractMasterVO.entName}</td>
	                    </tr>
	                `;
	                console.log("contractStateText 화긴" , contractStateText)
	            }

	            // #tby 내용에 str 넣기
	            document.getElementById("tby").innerHTML = str;
	            
	            let paging = document.querySelector(".page2");
	            paging.innerHTML = articlePage.data.pagingArea;
				
	            const pagingButtons = document.querySelectorAll('.clsPagingArea');
	            pagingButtons.forEach(button => {
	                button.addEventListener('click', function() {
	                    const newPage = parseInt(this.getAttribute('data-current-page'));  // 페이지 번호 가져오기
	                    changePage(newPage, direction,state);  // 페이지 변경
	                });
	            });
	            // 정렬 버튼 업데이트  
	        	updateSortButtonIcon()
	        })
	        .catch(error => {
	            console.error("데이터 로딩 실패", error);
	        });
		 
		
		
		
		
	}
	// 계약 상태 처리 
	function getContractStateText(state) {
	    switch (state) {
	        case '0': return "계약완료";
	        case '1': return "계약체결";
	        case '2': return "진행중";
	        case '3': return "취소";
	        case '4': return "보류";
	        default: return "알 수 없음";
	    }
	}
	// 정렬 기준을 변경하는 함수 (가격/날짜)
	function toggleSort(type) {
	    if (sort === type) {
	        direction = direction === 'ASC' ? 'DESC' : 'ASC';  // 같은 기준이면 방향만 변경
	    } else {
	        sort = type;
	        direction = 'ASC';  // 다른 기준이면 방향을 ASC로 설정
	    }
	    changeSort(sort, direction, currentPage , state);  // 정렬을 변경하는 함수 호출
	}

	// 정렬 버튼 아이콘 업데이트 함수
	function updateSortButtonIcon() {
	    const priceButton = document.getElementById('sortPrice');
	    const dateButton = document.getElementById('sortDate');

	    // 아이콘 초기화
	    priceButton.classList.remove('fa-caret-up', 'fa-caret-down');
	    dateButton.classList.remove('fa-caret-up', 'fa-caret-down');

	    // 가격 버튼 아이콘 업데이트
	    if (sort === 'price') {
	        priceButton.classList.add(direction === 'ASC' ? 'fa-caret-up' : 'fa-caret-down');
	    } else {
	        priceButton.classList.add('fa-caret-down');  // 기본 상태
	    }

	    // 날짜 버튼 아이콘 업데이트
	    if (sort === 'date') {
	        dateButton.classList.add(direction === 'ASC' ? 'fa-caret-up' : 'fa-caret-down');
	    } else {
	        dateButton.classList.add('fa-caret-down');  // 기본 상태
	    }
	}
	function applyContractStateFilter() {
	    const state = document.getElementById('contractStatus').value;
	    console.log("state 벨류 가져오기" , state)
	    changeSort(sort, direction, currentPage, state);  // 계약 상태 필터링을 추가한 호출
	}

	
	
	
	
	// 차트 시작
	const ctx = document.querySelector('#myChart').getContext('2d');
	const ctx2 = document.querySelector('#myChart2');
	const chChart2 = new Chart(ctx2, {
		type : 'doughnut', // bar,line,pie,doughnut,radar 일반적..., 항상 생각..!
		data:{
		labels: [
		    '2024',
		    '2025',
		    '전체'
		  ],
		  datasets: [{
		    label: '계약 매출 ',
		    data: [],
		    backgroundColor: [
		      'rgb(54, 162, 235)',
		      '#278986 ',
		      '#3069CE'
		    ],
		    hoverOffset: 10
		  },{label: '계약 건수 ',
			    data: [300, 50, 100],
			    backgroundColor: [
			      'rgb(54, 162, 235)',
			      '#278986',
			      '#3069CE' /*  'rgb(255, 205, 86)' ,#51B772 */
			    ],
			    hoverOffset: 10
			  
			}
		  
		  ]
		},
		options : {
			indexAxis : 'x',
			scales : {
				x : {
					beginAtZero : true
				}
			}
		}
	}); 
const myChart = new Chart(ctx, {
    type: 'line', // 기본 차트 유형을 선 차트로 설정
    data: {
        datasets: [{
            label: '매출', // 첫 번째 데이터셋 (선 차트)
            data: [],
            fill: false, // 선 아래 영역을 채우지 않음
            borderColor: '#51B772', // 선 색상
            backgroundColor: '#51B772', // 막대 색상 #FFCB3E
            borderWidth: 1,
            tension: 0.1,
            yAxisID: 'y1', // 첫 번째 y축
        }, {
            label: '계약 매출', // 두 번째 데이터셋 (첫 번째 막대 차트)
            data: [],
            type: 'bar', // 첫 번째 막대 차트로 설정
            backgroundColor: '#3069CE', // 막대 색상
            borderColor: '#3069CE', // 막대 경계 색상
            borderWidth: 1,
            yAxisID: 'y1', // 첫 번째 y축
        }, {
            label: '계약 건수', // 세 번째 데이터셋 (두 번째 막대 차트)
            data: [],
            type: 'bar', // 두 번째 막대 차트로 설정
            backgroundColor: '#278986', // 두 번째 막대 색상
            borderColor: '#278986', // 두 번째 막대 경계 색상
            borderWidth: 1,
            yAxisID: 'y2', // 두 번째 y축
        }]
    },
    options: {
        scales: {
            x: {
                type: 'time', // x축을 시간 축으로 설정
                time: {
                    unit: 'month', // x축 단위를 월로 설정
                    tooltipFormat: 'yyyy-MM-dd', // 툴팁 날짜 포맷을 'YYYY-MM-DD' 형식으로 수정
                    displayFormats: {
                        month: 'MM월' // x축 레이블을 'YYYY년 MM월' 형식으로 표시
                    }
                },
                title: {
                    display: true,
                    text: '월'
                }
            },
            y1: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: '매출 / 계약 매출'
                },
                position: 'left', // 첫 번째 y축은 왼쪽에 배치
            },
            y2: {
                beginAtZero: true,
                title: {
                    display: true,
                    text: '계약 건수'
                },
                position: 'right', // 두 번째 y축은 오른쪽에 배치
                grid: {
                    drawOnChartArea: false, // 두 번째 y축의 그리드 라인은 표시하지 않음
                }
            }
        },
        plugins: {
            tooltip: {
                enabled: true,  // 툴팁을 활성화
                mode: 'index',  // 툴팁이 모든 데이터셋에 대해 표시되도록 설정 (기본값은 'nearest')
                intersect: false,  // 마우스가 데이터 포인트를 가리킬 때만 툴팁을 표시하도록 설정
                position: 'nearest',  // 툴팁이 가장 가까운 데이터 포인트에 위치하도록 설정
            }
        }
    }
});


	function nvl(expr1, expr2) {
		  if (expr1 === undefined || expr1 == null || expr1 == "") {
		    expr1 = expr2;
		  }
		  return expr1;
		}

		function selectLprodList(contractNo, entName, contractNm) {
		  let data = {
		    "currentPage": "1",
		    "contractNo": contractNo,
		    "entName": entName,
		    "contractNm": contractNm
		  };

		  $.ajax({
		    url: "/contract/listAjax",
		    contentType: "application/json;charset=utf-8",
		    data: JSON.stringify(data),
		    type: "POST",
		    dataType: "json",
		    success: function (articlePage) {
		      //console.log("articlePage:", articlePage);
		      let str = "";
		      $.each(articlePage.content, function (idx, contractMasterVO) {
		        let contractStateText = "";
		        if (contractMasterVO.state === '0') {
		          contractStateText = "계약완료";
		        } else if (contractMasterVO.state === '1') {
		          contractStateText = "진행중";
		        } else if (contractMasterVO.state === '2') {
		          contractStateText = "완료";
		        } else {
		          contractStateText = "완료";  // 기본값
		        }

		        str += `
		          <tr>
		            <th>${contractMasterVO.rnum}</th>
		            <td>${contractMasterVO.contractNo}</td>
		            <td>${contractMasterVO.entName}</td>
		            <td><a href="/contract/detail?currentPage=${data.currentPage}&keyword=${data.keyword}&contractNo=${contractMasterVO.contractNo}">${contractMasterVO.contractNm}</a></td>
		            <td>${contractMasterVO.contractPrice}</td>
		            <td>${contractStateText}</td>
		            <td>${contractMasterVO.fromDate}</td>
		          </tr>
		        `;
		      });
		      $("#tby").html(str);
		      $("#divPagingArea").html(articlePage.pagingArea);
		    }
		  });
		}
		function priceSet() {
		  var inputValue = document.querySelector('.price').value;  // .val()을 .value로 수정
		  inputValue = inputValue.toLocaleString();  // 숫자 포맷 처리
		  //console.log(inputValue);  // 확인
		}

		$(function () {
		  $("#edit").on("click", function () {
		    let entName = $("input[name='entName']").val();
		    let contractNm = $("input[name='contractNm']").val();
		    let contractNo = parseInt($("input[name='contractNo']").val(), 10);
		    
		    selectLprodList(contractNo, entName, contractNm);
		  });
		});
	const chartURL = "http://localhost:8020/contract/chartdata";
	
	 axios.get(chartURL)
       .then(res => {
           let chartdata = res.data;  // 서버에서 응답 받은 업데이트된 todo
           /* console.log("가져왔니"  ,chartdata); */

           
           const filteredData2024 = chartdata.filter(chartdata => chartdata.year === 2024);
           // 화면에서 상태 변경 반영
           let Pricedata = []
           let ContractData= []
	            for(i=0; i<chartdata.length; i++){
	 	           if(chartdata[i].year == 2024){
		            let month = chartdata[i].month;
	                let totalPrice = chartdata[i].totalPrice
	                let contractCount = chartdata[i].totalContracts
		            
	                Pricedata.push({ x: month + '-01', y:totalPrice })
	                ContractData.push({ x: month + '-01', y:contractCount })
	                }
	 	           
           }
           // 차트 데이터 갱신
           myChart.data.datasets[0].data = Pricedata;
           myChart.data.datasets[1].data = Pricedata;
           myChart.data.datasets[2].data = ContractData;

           // 차트 업데이트
           myChart.update();
       })
       .catch(err => {
           console.log("상태 업데이트 실패", err);
       });
	 
	 const chartYearURL = "http://localhost:8020/contract/yeardata";
	 axios.get(chartYearURL)
       .then(res => {
           let yeardata = res.data;  // 서버에서 응답 받은 업데이트된 todo
           //console.log("가져왔니"  ,yeardata);

			 // 연도별 매출/계약건수 total 빈배열 선언
			 let yearPricedata = [];
		     let yearContractCnt = [] 
		     
			 // 연도별 매출/계약건수 filter
			 let fourData = yeardata.find(yeardata => yeardata.years === '2024');
			 let fiveData = yeardata.find(yeardata => yeardata.years === '2025');
			 let totalData =yeardata.find(yeardata => yeardata.years === 'TOTAL');
	
			 // 연도별 매출 데이터 추가 else 0으로 표시
			 yearPricedata.push(fourData ? fourData.yearPrice : 0);
			 yearPricedata.push(fiveData ? fiveData.yearPrice : 0);
			 yearPricedata.push(totalData.yearPrice);
			 
			 // 연도별 계약건수 데이터 추가 else 0으로 표시
			 yearContractCnt.push(fourData ? fourData.yearContracts : 0);
			 yearContractCnt.push(fiveData ? fiveData.yearContracts : 0);
			 yearContractCnt.push(totalData.yearContracts);
			 
			//console.log(yearPricedata)
			//console.log(fiveData)
			
             // 차트 데이터 갱신
           chChart2.data.datasets[0].data = yearPricedata;
           chChart2.data.datasets[1].data = yearContractCnt;

           // 차트 업데이트
           chChart2.update();
       const div = document.querySelector(".contsucc")
      	 
  	    		 let tblStr = `
  	    			<table class="table table-bordered sumTable">
						<thead class="sth">
							<tr>
								<th scope="col">년도</th>
								<th scope="col">총계약</th>
								<th scope="col">체결</th>
								<th scope="col">진행중</th>
								<th scope="col">완료</th>
								<th scope="col">취소</th>
								<th scope="col">매출</th>
							</tr>
				</thead>
  	    		 
  	    	 	`
      	  for(let i =0; i<yeardata.length;i++){
  	    	 let data = yeardata[i]; 
  	     	 let price = data.yearPrice.toLocaleString();
  	     	 console.log(price)
  	     	 
  	     		tblStr += `
  	     		<tbody class="stb">
					<tr class="str">
						<th scope="row">\${data.years}</th>
						<td >\${data.yearContracts}건</td>
						<td>\${data.contractConcluded}건</td>
						<td>\${data.contractInprogress}건</td>
						<td>\${data.contractCompleted}건</td>
						<td>\${data.contractCancellation}건</td>
						<td class="contractPrice">\${price}
						</td>
						</tr>
  	     		
  	     		`
  	    		 
  	     	 }
  					div.innerHTML = tblStr;
        })
       .catch(err => {
           console.log("상태 업데이트 실패", err);
       });
	</script>

 </html>