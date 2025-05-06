<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.text.NumberFormat" %>

<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">





<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<jsp:include page="../include/preScript.jsp"></jsp:include>
<style>
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
	justify-content: space-between;
}

#scbar {
	height: 40px !important;
}

#scbar2 {
	font-size: 13px !important;
	height: 40px !important;
	width:70px !important;
		background-color: 3069CE !important;
		border:none !important;
}
.scb{
margin-left:auto !important;
width: 20%;
}
.cona{
color: white !important;
}
.conbtn{
background-color: 3069CE !important;
border:none !important; }
td >a{
color:3069CE !important;
}
.contlist{
font-weight:normal;}
.maxwidth{
max-width: 95%;
margin: 0 auto !important;}
.table{
margin-top:1%;}
.bg-transparent{
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
	max-width: 95%;
	margin: 0 auto !important;
}

.table {
	margin-top: 1%;
	border-color:  #FCFCFC !important;
}

.bg-transparent {
	height: 40px !important;
}
.taxindate{
display: flex;
justify-content: flex-end;
align-items: center;
width:900px;
}
.taxincontain{
border-radius: 10px;

}
.datebtn{
text-align: center;
display:flex;
width: 100px;
 justify-content: center;
 align-items: center;
 height: 48px;



}
.databtn > button { 
margin: 0 !important;
}

.taxlist{

border: 1px solid #c4c4c4 !important;
}
.taxlist{
text-align: center;}
.flex{
display: flex;
}
.flexchid{
margin-left:30% !important; 
 justify-content: center;   /* 자식 요소들을 수평으로 가운데 정렬 */
  align-items: center;       /* 자식 요소들을 수직으로 가운데 정렬 */

}
.contb{
display: flex;
justify-content: flex-end;
}
input{
height: 35px !important;

}
.taxspan{
margin-right:1%;
margin-left:1%;
}
tr th td {
text-align: center;

}
#tbb{

text-align: center;

}
.contractNm{
text-align: left !important;

}
.contractHeader{
display: flex;
align-items: center;

}
select{
outline: none !important;
border:none !important;
background-color:#f1f1f1; 
padding:3px;
border-radius:10px;
margin-left: 30px !important;
width: 100px;
}
.contractPrice{
margin-right:10px !important;
text-align: right;
}

.widflex{

width: 90%;
margin: 0 auto;
}
.contsucc{
display: flex;
    flex-wrap: wrap;
    width: 40%;
}
.contsucc > div{
width:200px;
height: 100px;
background-color: #F6F6F6;
margin:10px;
border-radius: 10px;
}
.contsucc > div>div{
text-align: center;
align-content: center;
vertical-align: middle;  
}
.firstcont{
display: flex;
justify-content: space-between;
align-items: center;

}
.gantcont{
margin-top:4%;

}
.expditcontainer{

height:30vh; 
}
#myChart{
height:250px !important ;

}
.Totaltbd{
/* border-color: black !important; */


}
</style>

<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
<div class="maxwidth">
<div class="expditcontainer">
	<div class="bg-light rounded widflex">
			<h3 class=" contlist">계약 목록</h3>
		<div class="firstcont">
				<h6>년도</h6>
				<h6>년도</h6>
			<div class="contsucc">
				<div>
					<div>진행중 프로젝트</div>
					<div>22건</div>
				</div>
				<div></div>
				<div>
					<div>진행중 프로젝트</div>
					<div>22건</div>
				</div>
				<div></div>
			</div> 
			
			<div class="bg-light rounded h-100 p-4">
                            <table class="table table-striped">
                                <thead class="Totaltbd">
                                    <tr>
                                        <th scope="col">년도</th>
                                        <th scope="col">체결</th>
                                        <th scope="col">진행중</th>
                                        <th scope="col">완료</th>
                                    </tr>
                                </thead>
                                <tbody class="Totaltbd">
                                    <tr>
                                        <th scope="row">2024</th>
                                        <td>55</td>
                                        <td>22</td>
                                        <td>555</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2024</th>
                                        <td>55</td>
                                        <td>22</td>
                                        <td>555</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2024</th>
                                        <td>55</td>
                                        <td>22</td>
                                        <td>555</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
			<div style="width:700px;">
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
				<div class="contractHeader">
					<select name="languages" id="lang">
					<i class="fas fa-file"></i> 
					  <option value="javascript">계약일자 </option>
					  <option value="php">최신순</option>
					  <option value="java">오래된순</option>
				 </select> 
		</div>
	<div class="taxindate">
				<span class="taxspan">계약코드</span>
				<input type="number" name="contractNo" class="updtcon" placeholder="ex : 20240101+001" value="">
				<span class="taxspan contractNm">계약명</span>
				<input type="text" name="contractNm" class="updtcon" placeholder="계약명" value="">
				<span class="taxspan">거래처명</span>
				<input type="text" name="entName" class="updtcon cdate">
			<div class="datebtn">
							<button type="button" id="edit" class="btn btn-primary conbtn">조회하기</button>
						</div>
		
		</div>
</div>

		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col">순번</th>
						<th scope="col">계약일자</th>
						<th scope="col " class="">계약명</th>
						<th scope="col" >계약금액</th>
						<th scope="col">계약상태</th>
						<th scope="col">거래처명</th>
						<th scope="col">계약담당자</th>
					</tr>
				</thead>
				<tbody id="tby">
					<c:forEach var="contractMasterVO" items="${articlePage.content}"
						varStatus="stat">
						<tr>
							<th scope="row">${contractMasterVO.rnum}</th>
							<td>${contractMasterVO.fromDatec}</td>
							<td class="contractNm"><a  href="/contract/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&contractNo=${contractMasterVO.contractNo}">${contractMasterVO.contractNm}</a></td>
							<td class="price contractPrice" onclick="priceSet()" >
							    <fmt:formatNumber value="${contractMasterVO.contractPrice}" pattern="#,###" />
							</td>
							<c:choose>
								    <c:when test="${contractMasterVO.state == '0'}">
										<td>계약완료</td>
								    </c:when>
								    <c:when test="${contractMasterVO.state == '1'}">
										<td>진행중</td>
								    </c:when>
								    <c:when test="${contractMasterVO.state == '2'}">
										<td>완료</td>
								    </c:when>
								     <c:otherwise>
									        <!-- 둘 다 false일 때 실행되는 코드 -->
									       
											<td>완료</td>
									    </c:otherwise>
							</c:choose>
							<td>${contractMasterVO.entName}</td>
							<td>${contractMasterVO.empName}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<p>${contractMasterVo }</p>
		<center class="flex">
		<button type="button" id="edit" class="btn btn-primary m-2 conbtn"><a href="/contract/create" class="cona">계약등록</a></button>
			<div class="row flexchid" id="divPagingArea">
				${articlePage.pagingArea}</div>
		</center>
	</div>
</div>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script type="text/javascript">
	const ctx = document.querySelector('#myChart');

	// chart.js가 잘 만들어진 이유, 왼쪽에 변수로 받으면, 설정 내용을 받아올 수 있음 
	const chChart = new Chart(ctx, {
		type : 'bar', // bar,line,pie,doughnut,radar 일반적..., 항상 생각..!
		data : {
			labels : [ '1월', '2월', '3월', '4월', '5월', '6월','7월','8월','9월','10월','11월','12월' ],
			datasets : [ {
				label : '전년도 매출 ',
				data : [ 12, 19, 3, 5, 2, 3 ,10,20,10,10,10,30],
				borderWidth : 1,
				backgroundColor : '#3069CE'
			}
			// {
			//     label: '올해 매출',
			//     data: [22, 29, 33, 51, 12, 13],
			//     borderWidth: 1
			// }

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
	   google.charts.load('current', {'packages':['gantt']});
	    google.charts.setOnLoadCallback(drawChart);

	    function daysToMilliseconds(days) {
	      return days * 24 * 60 * 60 * 1000;
	    }

	    function drawChart() {

	      var data = new google.visualization.DataTable();
	      data.addColumn('string', 'Task ID');
	      data.addColumn('string', 'Task Name');
	      data.addColumn('date', 'Start Date');
	      data.addColumn('date', 'End Date');
	      data.addColumn('number', 'Duration');
	      data.addColumn('number', 'Percent Complete');
	      data.addColumn('string', 'Dependencies');

	      data.addRows([
	        ['Research', 'Find sources',
	         new Date(2015, 0, 1), new Date(2015, 0, 5), null,  100,  null],
	        ['Write', 'Write paper',
	         null, new Date(2015, 0, 9), daysToMilliseconds(3), 25, 'Research,Outline'],
	        ['Cite', 'Create bibliography',
	         null, new Date(2015, 0, 7), daysToMilliseconds(1), 20, 'Research'],
	        ['Complete', 'Hand in paper',
	         null, new Date(2015, 0, 10), daysToMilliseconds(1), 0, 'Cite,Write'],
	        ['Outline', 'Outline paper',
	         null, new Date(2015, 0, 6), daysToMilliseconds(1), 100, 'Research']
	      ]);

	      var options = {
	        height: 275
	      };

	      var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

	      chart.draw(data, options);
	    }
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
		      console.log("articlePage:", articlePage);
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
		            <td>${contractMasterVO.entName}</td>
		            <td><a href="/contract/detail?currentPage=${data.currentPage}&keyword=${data.keyword}&contractNo=${contractMasterVO.contractNo}">${contractMasterVO.contractNm}</a></td>
		            <td>${contractMasterVO.contractPrice}</td>
		            <td>${contractStateText}</td>
		            <td>${contractMasterVO.fromDate}</td>
		            <td>${contractMasterVO.empName}</td>
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
		  console.log(inputValue);  // 확인
		}

		$(function () {
		  $("#edit").on("click", function () {
		    let entName = $("input[name='entName']").val();
		    let contractNm = $("input[name='contractNm']").val();
		    let contractNo = parseInt($("input[name='contractNo']").val(), 10);
		    
		    selectLprodList(contractNo, entName, contractNm);
		  });
		});

	
	
	</script>

	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
	<%@ include file="../include/footer.jsp"%>

	<!-- 메인 컨텐츠 영역 끝 -->