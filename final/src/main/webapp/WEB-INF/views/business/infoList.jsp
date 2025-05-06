<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
<title>영업 관리</title>
    
  
<style>
.nav-tabs .nav-link{
color: black !important;
}

.nav-tabs .nav-link.active, .nav-tabs .nav-item.show .nav-link{

color:#3069CE !important;

}
	.center-align{
		text-align: center;
	}
	

/* th 배경색과 글자색 변경 */
#tbc th {
    background-color: #3069CE; /* 원하는 배경색 */
    color: white; /* 원하는 글자색 */
    text-align: center; /* 텍스트 가운데 정렬 */
/*     width: 90%; */
}

/* 테이블 테두리 제거 */
.table-bordered {
    border: none;
}

.table-bordered th,
.table-bordered td {
    border: none;
}

.tbl{
	width:80% !important;
}
	
	
	.tbc {
	background-color: 3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
	}
	.page-link {
    position: relative;
    display: inline-block;
    color: #2c3e50;
    border-radius: 24px;
    text-decoration: none;
    font-size: 1.2rem;
    font-weight: bold;
    padding: 8px 16px 10px;
    margin-left:10px;
    margin-right:10px;
}

    .flex {
        display: flex;
        justify-content: center;  /* 수평 중앙 정렬 */
        align-items: center;      /* 수직 중앙 정렬 */
        width: 100%;
        height: 100%;
    }

    .flexchid {
        display: inline-block;
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
    

    /* 페이지네이션 버튼 스타일 */
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
    .nav-link.active {
    color: black !important; /* 텍스트 색상 */
    background-color: #F3F6F9 !important; /* 배경색 */
    border-color: #dee2e6 !important; /* 테두리 색상 */
}

#btn10, #btn11 {
	border:none !important;
}
.businessSub {
display: block !important;
height: auto !important;
}

#contractTable tbody tr {
    height: 50px; /* 행 높이 조정 */
}

#contractTable td, 
#contractTable th {
    padding: 12px 8px; /* 셀 안쪽 여백 조정 */
}
 #contractTable th, 
    #contractTable td {
        border-color: #e0e0e0; 
    }

</style>
	 </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->
	



<!-- ///// content 시작 ///// -->
<div class="bg-light text-center rounded p-4" >
        <h3 class="mb-0"></h3>
         	<div class="nav nav-tabs custom-tabs mb-4">
<!-- 			    <a class="nav-link" href="/business/custManage" data-type="customer">고객 정보</a> -->
			    <a class="nav-link" href="/business/infoList" data-type="sales">영업 관리</a>
	    		<a class="nav-link" href="/business/busAct" data-type="Act">영업 활동</a>			
	    		<a class="nav-link" href="/business/busChance" data-type="Chance">영업 기회</a>    
<!-- 			    <a class="nav-link" href="/business/busStat" data-type="stat">영업 통계</a> -->
			</div>
 <div class="table-container" id="container">
    <div class="d-flex justify-content-between mb-3"  id="tbl">
        <!-- 검색란 -->
        <form class="d-flex align-items-center gap-2" method="get" action="/business/infoList">
		    <!-- 검색 입력 필드 -->
		    <div class="input-group input-group-sm" style="width: 200px;">
		        <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="검색어 입력"/>
		
<!-- 		        <button type="submit" id="btnSearch" class="btn btn-outline-secondary"> -->
		            <i class="fas fa-search" style="padding-left:10px;"></i>
<!-- 		        </button> -->
		    </div>
		</form>
        <div>
<!--             <a href="/business/create" class="btn btn-primary m-2" id="btnCreate">등록</a> -->
        </div>
    </div>
    <div class="table-responsive">
        <table class="table text-start align-middle table-bordered table-hover mb-0" id="contractTable">
            <thead>
                <tr class="text-dark center-align" id="tbc">
<!--                     <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll"></th> -->
                    <th scope="col">고객사명</th>
                    <th scope="col">계약건수</th>
                    <th scope="col">사업유형</th>
                    <th scope="col">거래상태</th>
                    <th scope="col" style="cursor: pointer;" onclick="sortTableByDate()" id="btn10">등록일자 ▽</th>
                    <th scope="col" style="cursor: pointer;" onclick="sortTableByAmount()" id="btn11">계약 총 금액 ▽</th>
                    <th scope="col">비고</th>
                </tr>
            </thead>
            <tbody id="tby"></tbody>
        </table>
    </div>
</div>

</div>
<!-- 페이지네이션 -->
		<div id="divPagingContainer" style="display: flex; align-items: center; width: 100%; padding-top: 20px;">
    <!-- 페이징을 가운데 정렬 -->
    <div style="flex: 1; display: flex; justify-content: center;">
        <div id="divPagingArea" class="pagination">
            ${articlePage.pagingArea}
        </div>
    </div>

    <!-- 등록 버튼을 오른쪽으로 정렬 -->
    <div style="display: flex; justify-content: flex-end; width: 150px;">
    <a href="/business/create" class="btn btn-primary bluBt" style="text-decoration: none; color: white;">
        등록
    </a>
</div></div>

   <jsp:include page="../include/footer.jsp"></jsp:include>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script type="text/javascript">

function formatDate(date) {
    let year = date.getFullYear();
    let month = date.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
    let day = date.getDate();

    // 월과 일이 10보다 작으면 앞에 0을 추가하여 두 자리로 맞추기
    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }

    return year + '-' + month + '-' + day;
};

//날짜 형식 정렬
function sortTableByDate() {
    let table = document.getElementById("contractTable");
    let tbody = table.querySelector("tbody"); // tbody 선택
    let rows = Array.from(table.rows).slice(1);
    let ascending = table.dataset.sortOrder !== "asc";
    table.dataset.sortOrder = ascending ? "asc" : "desc";

    rows.sort((a, b) => {
        let dateA = new Date(a.cells[4].textContent.trim());
        let dateB = new Date(b.cells[4].textContent.trim());

        return ascending ? dateA - dateB : dateB - dateA;
    });

    tbody.append(...rows);
}

// 계약금액 정렬
function sortTableByAmount() {
    let table = document.getElementById("contractTable");
    let tbody = table.querySelector("tbody"); // tbody 선택
    let rows = Array.from(table.rows).slice(1);
    let ascending = table.dataset.sortOrder !== "asc";
    table.dataset.sortOrder = ascending ? "asc" : "desc";

    rows.sort((a, b) => {
        let priceA = parseInt(a.cells[5].textContent.replace(/[^0-9]/g, ''));
        let priceB = parseInt(b.cells[5].textContent.replace(/[^0-9]/g, ''));

        return ascending ? priceA - priceB : priceB - priceA;
    });

    tbody.append(...rows);
}
	
//null값 처리하깅
function nvl(expr1, expr2) {
   if (expr1 === undefined || expr1 == null || expr1 == "") {
      expr1 = expr2;
   }
   return expr1;
}



//회원 목록 가져오기
function getList(currentPage, keyword) {
	let data = {
			  "currentPage":nvl(currentPage,"1"),
			  "keyword":nvl(keyword,"")
			};
	console.log("data : ",data);
	
	
	$.ajax({
		url:"/business/listAjax",
		contentType:"application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType:"json",
		success:function(result) {
			console.log("result : ",result);
			console.log("result.content : ",result.content);
			
			let str = "";
			$.each(result.content,function(idx, CustInfoVO){
			str += `<tr>
	            <td style="text-align: center;"><a href="/business/detail?entNo=\${CustInfoVO.entNo}">\${CustInfoVO.entName}</a></td>
	            <td style="text-align: center;">`+nvl(CustInfoVO.businessCount,"")+`</td>
	            <td style="text-align: center;">`+nvl(CustInfoVO.entType,"")+`</td>
	            <td style="text-align: center;">`+nvl(CustInfoVO.businessState,"")+`</td>
	            <td style="text-align: center;">`+formatDate(new Date(CustInfoVO.entRegDate))+`</td>
	            <td style="text-align: right;">`+formatCurrency(CustInfoVO.contractPrice)+`</td>
	            <td style="text-align: center;">`+nvl(CustInfoVO.cancelContent,"")+`</td>
	        </tr>`;
			});
			
			
			// 숫자를 천단위로 포맷하고 '원'을 붙이는 함수
			function formatCurrency(value) {
			  if (!value || isNaN(value)) return "0원"; // 값이 없거나 숫자가 아니면 기본값
			  return new Intl.NumberFormat("ko-KR").format(value) + "원";
			}

			// nvl 함수 (기본값 처리)
			function nvl(value, defaultValue) {
			  return value != null && value !== "" ? value : defaultValue;
			}
			//.append(): 누적 / .html(): 새로고침(덮어쓰기)
			$("#tby").html(str);
			
			//페이징 처리
			$("#divPagingArea").html(result.pagingArea);
		}
	})
} // end getList

//document.ready
//동일 jsp 에서 1회 작성
$(function() {
	//최초 회원 목록 호출
	getList("1", "");
	
	
	$("#btnSearch").on("click", function() {
		//<input type="text" name="keyword"
		let keyword = $("#keyword").val();		
// 		let keyword = $("input[name='keyword']").val();
// 		let keyword = $("#krd").val();
		console.log("keyword : " + keyword);
		
		//전역 함수 호출
		getList("1",keyword);
		
	});
	// 엔터 키 이벤트 처리
    $("#keyword").on("keypress", function(e) {
        if (e.keyCode === 13) {  // 엔터 키
            e.preventDefault();
            $("#btnSearch").click();
        }
    });
	
	//페이지 클릭 처리
	//class="clsPagingArea" 는 여러개 (오브젝트 배열)
	//정적 : $.(".clsPagingArea").on("click", function(){
	//동적 :
	$(document).on("click", ".clsPagingArea", function () {
		//클릭한 것은 하나
		let currentPage = $(this).data("currentPage");
		let keyword = $(this).data("keyword");
		
		console.log("currentPage:", currentPage);
		
		//회원 목록 호출
		getList(currentPage, keyword);
	});
	
	// 현재 URL 가져오기
    const currentPath = window.location.pathname;

    // 모든 탭 요소 가져오기
    const navLinks = document.querySelectorAll('.nav-link');

    // 현재 경로와 href가 일치하는 탭에 active 클래스 추가
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active'); // Bootstrap의 기본 스타일을 활용
        }
    });
});
	

</script>
</html>

	