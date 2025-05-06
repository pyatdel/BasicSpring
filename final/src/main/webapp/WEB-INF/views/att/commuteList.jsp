<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<title>출퇴근 내역</title>
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

.commuteList{
	background-color : #ffffff;
	align-items : center;
	justify-content: center;
	margin-left : 50px;
	width: 90%;
	
}
.col-center{
	text-align: center;   /* 수평 중앙 정렬 */
  	vertical-align: middle;  /* 수직 중앙 정렬 */
}
#tbhd{
	display:flex;
	margin : 5px;
	padding: 5px;
	width: 90%;
}

.taxindate{
display: flex;
justify-content: flex-start;
align-items: center;
margin: 10px;
}

.flex{
display: flex;
 justify-content: center;   /* 자식 요소들을 수평으로 가운데 정렬 */ 
/*   align-items: center;  
 */
}
.flexchid{
margin-left:30% !important; 
  justify-content: center;   /* 자식 요소들을 수평으로 가운데 정렬 */ 
   align-items: center;       /* 자식 요소들을 수직으로 가운데 정렬 */ 

}

.green-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: green;
    margin-right: 5px;
}

.red-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: red;
    margin-right: 5px;
}

.default-dot {
    background-color: gray;
    border-radius: 50%;
    display: inline-block;
    width: 10px;
    height: 10px;
}

.dashboard {
  display: flex;
/*   grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));  */
  gap: 20px;
  padding: 20px;
  margin: 10px;
  max-width: 1500px;
  background-color: #fff;
  justify-content : center;
  justify-items : center;
}

.info-card {
  background-color: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 20px;
  width: 200px;
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

.hdFlex{
display: flex;
align-items: center;
}
.attSub {
display: block !important;
height: auto !important;
}
</style>
  </head>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>
	
<div class="commuteList rounded h-100 p-4 ">
		<div class="hdFlex">
			<h3 class=" contlist">근태 관리</h3>
			<h5 class=" contlist"> &nbsp;> 출퇴근 내역</h5>
		</div>
		<div>
		<div class="dashboard">
		<div class="info-card">
			<h2>평균 출근시간</h2>
			<p>09:15</p>
		</div>
		<div class="info-card">
			<h2>평균 퇴근시간</h2>
			<p>18:30</p>
		</div>
		<div class="info-card">
		    <h2>일평균 근무 시간</h2>
		    <p>8시간 15분</p>
	  	</div>
	  	<div class="info-card">
		    <h2>누적 초과근무 시간</h2>
		    <p>60시간</p>
	  	</div>
	  	</div>
		
		<div class="taxindate">
              <input type="text" name="keyword" id="keyword" value="${param.keyword}" class="" placeholder="검색어 입력">
                <button type="button" class="btn btn-default" id="btnSearch">
                  <i class="fas fa-search"></i>
                </button>
         </div>
         </div>

		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col" class="col-center">순번</th>
						<th scope="col" class="col-center">일자</th>
						<th scope="col" class="col-center">출근시간</th>
						<th scope="col" class="col-center">퇴근시간</th>
						<th scope="col" class="col-center">근무시간</th>
						<th scope="col" class="col-center">지각여부</th>
						<th scope="col" class="col-center">상태</th>
						<th scope="col" class="col-center">비고</th>
					</tr>
				</thead>
				
				<tbody id="tby">
				</tbody>
			</table>
		</div>
		<div class="flex">
			<div class="" id="divPagingArea">
				${articlePage.pagingArea}
			</div>
		</div>   
		<jsp:include page="../include/footer.jsp"></jsp:include>
		
	</div>
	
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
	
<script type="text/javascript">
	function selectCommuteList(currentPage,keyword){
		let data = {
			"currentPage": currentPage,
			"keyword" : keyword
		};
		console.log("data:" ,data);
		
		$.ajax({
			url:"/att/commuteListAjax",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			type: "POST",
			datatype : "json",
			success:function (articlePage){
				console.log("articlePage:",articlePage);
				console.log("articlePage:",articlePage.content);
				let str = "";
				$.each(articlePage.content, function (idx,AttManagerVO){
					// 점의 색상 결정
					str += `<tr>
								<td class="col-center">\${AttManagerVO.rnum}</td>
								<td class="col-center">\${AttManagerVO.attDate}</td>
								<td class="col-center">\${AttManagerVO.attInTimeStr}</td>
								<td class="col-center">\${AttManagerVO.attOutTimeStr}</td>
								<td class="col-center">\${AttManagerVO.attWorkTimeStr}</td>
								<td class="col-center">\${AttManagerVO.perception}
									<span class="\${AttManagerVO.dotClass}"></span>
								</td>
								<td class="col-center">\${AttManagerVO.attendanceName}</td>
								<td class="col-center">\${AttManagerVO.reason}</td>
						   </tr>`;
				});
				$("#tby").html(str);
				// 페이징 블록처리
				$("#divPagingArea").html(articlePage.pagingArea);
			}
		})
	}
	
	
	$(document).on("click",".clsPagingArea",function(){
		// 클릭한 것은 하나
		// <a .. data-current-page="1" data-keyword=""... class="page-link clsPagingArea">2</a>
		let currentPage = $(this).data("currentPage");//2
		let keyword = $(this).data("keyword");
		
		console.log("페이지클릭 처리 -> currentPage : "+ currentPage);
		console.log("페이지클릭 처리 -> keyword : " +keyword);
		
		// 회원 목록 호출
		selectCommuteList(currentPage,keyword);
	});
	
	 $(function() {
		 // Enter 키 이벤트
		 $("input[name='keyword']").on("keypress",function(event){
			 if(event.key === 'Enter' || event.keyCode === 13){
				 event.preventDefault();
				 $("#btnSearch").click();
			 }
		 })
	        // 페이지 로드 시 바로 비동기 요청을 통해 데이터를 가져옵니다.
	        selectCommuteList("1","");

	        // 검색어 입력 시 비동기 요청
	        $("#btnSearch").on("click", function() {
	            let keyword = $("input[name='keyword']").val().trim();
	            selectCommuteList("1",keyword);
	            
	            // 검색어 입력 필드 초기화
	            $("input[name='keyword']").val('');
	        });
	    });
</script>
	
 </html>
	<!-- 메인 컨텐츠 영역 끝 -->