<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
<title>알림 리스트</title>
   <jsp:include page="./include/library.jsp"></jsp:include>
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



</style>

<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="./include/header.jsp"%>

<div class="commuteList rounded h-100 p-4 ">
<h3>전체 알림</h3>
		<div class="table-responsive ">
			<table class="table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col" class="col-center">순번</th>
						<th scope="col" class="col-center" style="display:none;">empNo</th>
						<th scope="col" class="col-center">보낸이</th>
						<th scope="col" class="col-center">알림 종류</th>
						<th scope="col" class="col-center">알림 내용</th>
						<th scope="col" class="col-center">읽음 여부</th>
						<th scope="col" class="col-center">생성 시간</th>
					</tr>
				</thead>
				<tbody id="tby">
				</tbody>
			</table>
		</div>
		
		<div class="flex">
			<div class="row flexchid" id="divPagingArea">
				${articlePage.pagingArea}
			</div>
		</div> 
	</div>
	<%@ include file="./include/footer.jsp"%>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript">
function alarmList(currentPage,keyword){
	let data = {
		"currentPage": currentPage,
		"keyword" : keyword
	};
	console.log("data:" ,data);
	
	$.ajax({
		url:"/alarmListAjax",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type: "POST",
		datatype : "json",
		success:function (articlePage){
			console.log("articlePage:",articlePage);
			console.log("articlePage:",articlePage.content);
			let str = "";
			$.each(articlePage.content, function (idx,AlarmVO){
				// 점의 색상 결정
				str += `<tr>
							<td class="col-center">\${AlarmVO.rnum}</td>
							<td class="col-center">\${AlarmVO.empName}</td>
							<td class="col-center">\${AlarmVO.alarmType}</td>
							<td class="col-center">\${AlarmVO.alarmMessage}</td>
							<td class="col-center">\${AlarmVO.alarmStatus}</td>
							<td class="col-center">\${AlarmVO.createdAt}</td>
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
	alarmList(currentPage,keyword);
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
        alarmList("1","");

        // 검색어 입력 시 비동기 요청
        $("#btnSearch").on("click", function() {
            let keyword = $("input[name='keyword']").val().trim();
            alarmList("1",keyword);
            
            // 검색어 입력 필드 초기화
            $("input[name='keyword']").val('');
        });
    });
</script>
	
