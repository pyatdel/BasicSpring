<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    

<style>
.tbc {
	background-color: #009CFF;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

.commuteList{
	background-color : #ffffff;
}


body {
  font-family: 'Arial', sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f9f9f9;
  color: #333;
}

header {
  background-color: #0056b3;
  color: white;
  padding: 10px 20px;
  text-align: center;
  font-size: 24px;
  font-weight: bold;
}

main {
  padding: 20px;
  display: flex;
  justify-content: space-between;
  gap: 20px;
}

footer {
  background-color: #0056b3;
  color: white;
  text-align: center;
  padding: 10px;
  position: fixed;
  width: 100%;
  bottom: 0;
}


.form-container {
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  max-width: 400px;
  margin: auto;
}

.form-container h2 {
  margin-bottom: 15px;
  color: #3069CE;
}

.form-container input,
.form-container select,
.form-container button {
  width: 100%;
  padding: 10px;
  margin: 10px 0;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 16px;
}

.form-container button {
  background-color: #3069CE;
  color: white;
  font-weight: bold;
  cursor: pointer;
}

.form-container button:hover {
  background-color: #004599;
}


.table-container {
  width: 100%;
  overflow-x: auto;
}

.reservation-table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
  font-size: 16px;
  text-align: left;
}

.reservation-table thead tr {
  background-color: #3069CE;
  color: white;
}

.reservation-table th,
.reservation-table td {
  padding: 10px 15px;
  border: 1px solid #ddd;
}

.reservation-table tbody tr:nth-child(even) {
  background-color: #f2f2f2;
}

.reservation-table tbody tr:hover {
  background-color: #ddd;
}


.alert {
  padding: 15px;
  margin: 20px 0;
  border-radius: 5px;
  font-size: 16px;
  text-align: center;
}

.alert-success {
  background-color: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.alert-error {
  background-color: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}


.timeline-container {
  margin: 20px auto;
  max-width: 600px;
  text-align: center;
}

#timeline {
  display: grid;
  grid-template-columns: repeat(4, 1fr); /* 시간 블록을 4열로 나열 */
  gap: 5px;
  margin-top: 10px;
}

.time-block {
  padding: 10px;
  border: 1px solid #ddd;
  background-color: #f9f9f9;
  cursor: pointer;
  user-select: none; /* 텍스트 선택 방지 */
}

.time-block.selected {
  background-color: #278986;
  color: white;
  font-weight: bold;
}

.btn {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #278986;
  color: white;
  border: none;
  cursor: pointer;
}

.btn:hover {
  background-color: #45a049;
}

.col-center{
	text-align: center;   /* 수평 중앙 정렬 */
  	vertical-align: middle;  /* 수직 중앙 정렬 */
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
.tbc {
	background-color: #3069CE;
	color: white;
	width: 90%;
	border-radius: 10% !important;
}

</style>
  </head>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<%@ include file="../include/header.jsp"%>


<div class="commuteList rounded h-100 p-4 maxwidth">
<main>
<div class="form-container">
  <h2>회의실 예약</h2>
  <div class="timeline-container">
  
  
</div>
  <form id="reservationForm">
    <label for="roomName">회의실 이름</label>
    <select id="roomName" required>
      <option value="A">A회의실</option>
      <option value="B">B회의실</option>
      <option value="C">C회의실</option>
    </select>

    <label for="date">예약 날짜</label>
    <input type="date" id="date" required>
    
    <div id="timeline">
    <!-- 각 시간 블록 -->
    <div class="time-block" data-time="09:00">09:00</div>
    <div class="time-block" data-time="10:00">10:00</div>
    <div class="time-block" data-time="11:00">11:00</div>
    <div class="time-block" data-time="12:00">12:00</div>
    <div class="time-block" data-time="13:00">13:00</div>
    <div class="time-block" data-time="14:00">14:00</div>
    <div class="time-block" data-time="15:00">15:00</div>
    <div class="time-block" data-time="16:00">16:00</div>
    <div class="time-block" data-time="17:00">17:00</div>
    <div class="time-block" data-time="18:00">18:00</div>
    <div class="time-block" data-time="19:00">19:00</div>
    <div class="time-block" data-time="20:00">20:00</div>
    <div class="time-block" data-time="21:00">21:00</div>
    <div class="time-block" data-time="22:00">22:00</div>
    <div class="time-block" data-time="23:00">23:00</div>
    <!-- 더 많은 시간 블록 추가 -->
  </div>

<!--     <label for="startTime">시작 시간</label> -->
<!--     <input type="time" id="startTime" required> -->

<!--     <label for="endTime">종료 시간</label> -->
<!--     <input type="time" id="endTime" required> -->

    <button id="submitReservation" class="btn">예약하기</button>
  </form>
</div>

  <div class="table-container ">
			<table class="reservation-table" id="tbb">
				<thead class="thc">
					<tr class="tbc">
						<th scope="col" class="col-center">회의실 번호</th>
						<th scope="col" class="col-center">예약 일자</th>
						<th scope="col" class="col-center">시작 시간</th>
						<th scope="col" class="col-center">종료 시간</th>
						<th scope="col" class="col-center">상태</th>
					</tr>
				</thead>
				
				<tbody id="tby">
				</tbody>
			</table>
		<div class="flex">
			<div class="" id="divPagingArea">
				${articlePage.pagingArea}
			</div>
		</div> 
		</div>
		
</main>
	<%@ include file="../include/footer.jsp"%>
</div>
<!-- <div class="commuteList rounded h-100 p-4 maxwidth"> -->
<!-- 		<div id="tbhd"> -->
<!-- 			<h3 class=" contlist">회의실 예약</h3> -->
<!-- 		</div> -->
<!-- 	</div> -->

	
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	  const timeline = document.getElementById('timeline');
	  let isDragging = false;
	  let selectedBlocks = [];

	  // 드래그 시작
	  timeline.addEventListener('mousedown', (e) => {
	    if (e.target.classList.contains('time-block')) {
	      isDragging = true;
	      toggleSelection(e.target);
	    }
	  });

	  // 드래그 중
	  timeline.addEventListener('mouseover', (e) => {
	    if (isDragging && e.target.classList.contains('time-block')) {
	      toggleSelection(e.target);
	    }
	  });

	  // 드래그 종료
	  document.addEventListener('mouseup', () => {
	    isDragging = false;
	  });

	  // 예약 버튼 클릭
	  document.getElementById('submitReservation').addEventListener('click', () => {
	    if (selectedBlocks.length === 0) {
	      alert('시간을 선택해주세요!');
	      return;
	    }

	    // 선택한 시간 데이터 생성
	    const selectedTimes = selectedBlocks.map(block => block.dataset.time);
	    const startTime = selectedTimes[0];
	    const endTime = selectedTimes[selectedTimes.length - 1];

	    function meetingRoomList(currentPage,keyword){
			let data = {
				"currentPage": currentPage,
				"keyword" : keyword
			};
			console.log("data:" ,data);
			
			$.ajax({
				url:"/schedule/meetingRoomListAjax",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type: "POST",
				datatype : "json",
				success:function (articlePage){
					console.log("articlePage:",articlePage);
					console.log("articlePage:",articlePage.content);
					let str = "";
					$.each(articlePage.content, function (idx,MeetingRoomVO){
						// 점의 색상 결정
						str += `<tr>
									<td class="col-center">\${MeetingRoomVO.rnum}</td>
									<td class="col-center">\${MeetingRoomVO.attDate}</td>
									<td class="col-center">\${MeetingRoomVO.attInTimeStr}</td>
									<td class="col-center">\${MeetingRoomVO.attOutTimeStr}</td>
									<td class="col-center">\${MeetingRoomVO.attWorkTimeStr}</td>
									<td class="col-center">\${MeetingRoomVO.perception}
										<span class="\${AttManagerVO.dotClass}"></span>
									</td>
									<td class="col-center">\${MeetingRoomVO.attendanceName}</td>
									<td class="col-center">\${MeetingRoomVO.reason}</td>
							   </tr>`;
					});
					$("#tby").html(str);
					// 페이징 블록처리
					$("#divPagingArea").html(articlePage.pagingArea);
				}
			})
		}
	    
	    
	    
	    document.getElementById('submitReservation').addEventListener('click', () => {
	        if (selectedBlocks.length === 0) {
	            alert('시간을 선택해주세요!');
	            return;
	        }

	        // 선택한 시간 데이터 가져오기
	        const selectedTimes = selectedBlocks.map(block => block.dataset.time);
	        const startTime = selectedTimes[0];
	        const endTime = selectedTimes[selectedTimes.length - 1];

	        const reservationData = {
	            roomName: document.getElementById('roomName').value,  // 회의실 이름
	            date: document.getElementById('date').value,          // 예약 날짜
	            startTime: startTime,                                 // 시작 시간
	            endTime: endTime                                      // 종료 시간
	        };

	        console.log("예약 데이터:", reservationData);

	        // 서버에 데이터 전송 (Ajax 요청)
	        $.ajax({
	            url: "/schedule/meetingRoomReserve",  // 예약 INSERT를 처리할 엔드포인트
	            type: "POST",
	            contentType: "application/json;charset=utf-8",
	            data: JSON.stringify(reservationData),
	            success: function(response) {
	                alert("회의실 예약이 완료되었습니다!");
	                meetingRoomList("1", "");  // 리스트 다시 불러오기
	            },
	            error: function(xhr, status, error) {
	                alert("예약 중 오류가 발생했습니다.");
	                console.error(error);
	            }
	        });
	    });
		
		
		$(document).on("click",".clsPagingArea",function(){
			// 클릭한 것은 하나
			// <a .. data-current-page="1" data-keyword=""... class="page-link clsPagingArea">2</a>
			let currentPage = $(this).data("currentPage");//2
			let keyword = $(this).data("keyword");
			
			console.log("페이지클릭 처리 -> currentPage : "+ currentPage);
			console.log("페이지클릭 처리 -> keyword : " +keyword);
			
			// 회원 목록 호출
			meetingRoomList(currentPage,keyword);
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
		        meetingRoomList("1","");

		        // 검색어 입력 시 비동기 요청
		        $("#btnSearch").on("click", function() {
		            let keyword = $("input[name='keyword']").val().trim();
		            meetingRoomList("1",keyword);
		            
		            // 검색어 입력 필드 초기화
		            $("input[name='keyword']").val('');
		        });
		    });

	  // 선택 상태 토글 함수
	  function toggleSelection(block) {
	    block.classList.toggle('selected');
	    if (block.classList.contains('selected')) {
	      selectedBlocks.push(block);
	    } else {
	      selectedBlocks = selectedBlocks.filter(b => b !== block);
	    }
	    selectedBlocks.sort((a, b) => a.dataset.time.localeCompare(b.dataset.time));
	  }
	});
});
</script>
	
	
 </html>
	<!-- 메인 컨텐츠 영역 끝 -->