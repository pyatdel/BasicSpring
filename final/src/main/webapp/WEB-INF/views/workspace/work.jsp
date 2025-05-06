<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
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
.workMenu {
color:#3676EB !important;

}


* {
	margin: 0 ; 
	padding: 0 ; 
}
ul li {
margin:0;
padding:0 ; 
list-style: none;

}

.projcon {
	display: flex;
	flex-wrap: wrap; /* 자식 요소들이 한 줄에 배치될 수 있도록 설정 */
	width: 100%;
	height: 30vh; /* 부모 요소의 높이를 설정 */
	margin: 0 auto;
	justify-content: center; /* 수평 가운데 정렬 */
	background-color: rgb(255, 254, 229);
}

.projcon>div {
	    width: 40%;
    height: 14vh;
	margin: 10px; /* 요소 간에 간격을 추가 */
	border-radius: 10px;
	background-color:#e7efef;
}
/* .projcon>div:nth-of-type(1) {
background-color: #e6ebe8;
}
.projcon>div:nth-of-type(2) {
background-color: #f7efe1;
}
.projcon>div:nth-of-type(3) {
background-color: #dfecf1;
}
.projcon>div:nth-of-type(4) {
background-color: rgb(231 232 243);
} */

h5, h6, h {
	padding-top: 10px;
	font-weight: normal !important;
	display: block !important;
	width: 100%;
}
h3{
	font-weight: normal !important;

}
h5{
height: 50px;
padding:15px;
}
.projcon {
	
}

.container-w {
	display: flex;
	width: 100%;
	flex-wrap: wrap;
	justify-content: center;
}

.container-w>div {
	width: 48%;
	height: 40vh;
	background-color :white;
	margin: 10px;
	border-radius: 20px;
	     box-shadow:0 2px 10px rgb(0 0 0 / 58%);
}

.workcont {
	max-width: 1400px;
	margin: 0 auto;
	margin-top:2%;
}
.dateheader{
display: flex;
margin-left: 15px;
    display: flex
;
    margin-left: 15px;
    justify-content: space-between;
    align-items: center;


}
.pjwmn{
display: flex;
width: 100%;
justify-content: space-around;
background-color: #dbdbdb;
color:black;
height: 40px;
    align-items: center;
}
.table{
text-align: center;
}

.todocon{
width: 100%;
height:30vh;
text-align: left;
border-top: 1px solid gray;
/* border-bottom: 1px solid gray; */
padding: 20px;
margin-top:25px;
}
.todoend{
text-align: right;

}
.listActive{

}
.dateab{
position: absolute;
margin:40px;
right: 0;
    top: 13%;
}
.tododate{
text-align: center;
font-size: 15px;

}
.datacont{
display: flex;
    justify-content: flex-end;
}
.todotime{
text-align: center;
font-size: 34px;
margin-left: 20px;

}
.content-area{


}
h6{
padding:10px;

}
.tflex{
display: flex;
flex-direction: column;
}
.projcnt{
text-align: right;

}
h2{

font-weight: normal !important;
padding:20px;
color:#41424e !important;

}
.pj{
background-color: white !important;

}
.projNav{
display: flex
;
    margin: 0 !important;
    padding: 0 !important;
    justify-content: space-around;
    border: 1px solid gray;
    border-radius: 5px;
    height: 40px;
    align-items: center;
}
.projNav > li {
display:flex;
   height: 40px;
border-right: 1px solid gray;
width: 100%;
text-align: center;
margin:0 auto;
justify-content: center;
align-items: center;
    background-color: #e7efef;



}
.projNav > li:nth-of-type(1):hover{

background-color: #009CFF !important;
color:white;
      border-radius: 5px 0 0 5px; /* 왼쪽 위, 아래 둥글게 */
}
.projNav > li:nth-of-type(3):hover{

background-color: #009CFF !important;
      color:white;
      border-radius:  0 5px 5px 0 ; /* 왼쪽 위, 아래 둥글게 */
}
.projNav > li:nth-of-type(2):hover{
      color:white;

background-color: #009CFF !important;
}
.ulFlex{
list-style: none;
    display: flex;
    justify-content: space-between;
    padding: 0;
    width: 90%;
    margin: 0 auto;

}
.liDate{
    margin-left: 43%;

}
.liMagin{
margin:20px 10px 10px 10px;

}
.ulDisplay{
display: none;
}
.ulDisplay.active{

display: block;
}
.nav.active{


background-color: #009CFF !important;
color:white;
}
.fa-3x {
font-size: 2em !important;
padding-right:10px;
}
.table{
text-align: center;
}
tbody:hover{
background-color: #f1f1f1;

}
.telft{
text-align: left;
font-weight:bold;
cursor: pointer;
width: 200px;
}
.fa-solid{
padding:10px;
color:green;
font-size: 1.5em;
}
.fa-file-pdf{

color:#db5353;
}
.fa-file-zipper{
color:orange;
}
.icon{
color:#009CFF !important;
font-size: 1.5em;
margin-right: 18px;
}
.iconc{
margin-right: 28px;

}
.iconh{
margin-right: 26px;

}
.fa-download{
color:gray;

}
.fileHeader{
display: flex;
justify-content: space-between;

}
.projproTitle{
display: flex;
    width: 100%;
    margin-left:20px;
    justify-content: space-between;
        align-items: center;

}
.h6{
text-align: right !important;
padding-right: 10%;
color: #009CFF !important;
font-weight: bold !important;
cursor: pointer;
}
.a{
font-weight: bold !important;
color:#575656;

}
.dateFlex{
display: flex
;
    align-content: center;
    align-items: center;
    margin-right: 30px;
    color: black !important;

}
tr {
    height: 40px;
    border: white !important;
    width: 100%;
    vertical-align: middle;
    
    }
    .mgmodal {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) !important; /* 화면 중앙 정렬 */
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
        z-index: 9999;

}
#modalOn{

font-weight:bold;
cursor: pointer;

}
.workSubMenu{

display: block !important;
height: auto !important;

}
</style>
</head>

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->


<div class="workcont">
<div class="dateheader">
	<h3>업무 대시보드 &nbsp;
	</h3>
	<div class="dateFlex">
	    <div class="tododate">
        <span id="current-date">
            <%
            // 서버에서 현재 날짜 출력
            Date currentDate = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("EEEE dd MMMM yyyy", Locale.ENGLISH);
            String formattedDate = formatter.format(currentDate);
            out.println(formattedDate);
            %>
        </span>
    </div>
    <div class="todotime">
        <span id="current-time">
            <%
            // 서버에서 현재 시간 출력
            SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss", Locale.ENGLISH);
            String formattedDate2 = formatter2.format(currentDate);
            out.println(formattedDate2);
            %>
        </span>
    </div>
	</div>
</div>
	<div class="container-w">
		<div class="projcon">
			<h5>내 부서 프로젝트 진행 상황</h5>
	<!-- 
			<div class="tflex">
				<h6>받은 프로젝트</h6>
				<h2 class="projcnt">2건</h2>
			</div>
			<div class="tflex">
				<h6 >진행중인 프로젝트</h6>
				<h2 class="projcnt">4건</h2>
			</div>
			<div class="tflex">
				<h6>완료된 프로젝트</h6>
				<h2 class="projcnt">12건</h2>
			</div>
			<div class="tflex">
				<h6>총 프로젝트</h6>
				<h2 class="projcnt">18건</h2>
			</div>
		-->
		</div> 
		<div class="">
			<span class="projproTitle">
					<h5>담당중인 업무</h5>
					<h6 class="h6" onclick="location.href='/work/projWorkspace'">더보기</h6>
				</span>
		<ul class="projNav">
			<li class="projBtn nav active" data-nav="expected">
				예정된 업무</li>
			<li class="projBtn nav " data-nav="inprogress">
				진행중 업무</li>
			<li class="projBtn nav " data-nav="delay">
				지연된 업무</li>
		</ul>
		<ul class="ulDisplay active expectedWork" id="expected" data-id="expectedWork">
		</ul>
		<ul class="ulDisplay inprogressWork" id="inprogress"  data-id="inprogressWork">
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>리스크 관리 및 문제 해결</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>시스템 성능 개선 및 버그 수정</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
		
		</ul>
		<ul class="ulDisplay delayWork" id="delay" data-id="delayWork">
		</ul>
		</div>
		<div class="">
		<span class="projproTitle">
					<h5>개인 파일함</h5>
					<h6 class="h6" onclick="location.href='/file/list'" >더보기</h6>
				</span>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row"><input type="checkbox"></th>
                                        <td class="telft" ><i class="fa-solid fa-file-excel"></i>엑셀.xlsx</td>
                                        <td>이칠이</td>
                                        <td>2025-01-03 09:22 </td>
                                        <td>10MB</td>
                                        <td><i class="fa-solid fa-download"></i></td>
                                    </tr>
                                </tbody>
                            </table>
		</div>
		<div class="">
			<span class="projproTitle">
					<h5>TO-DO-LIST</h5>
					<h6 class="h6" onclick="location.href='/todo/list'" >더보기</h6>
				</span>
				<div class="">
		<ul class="projNav">
			<li class="todoBtn tab active" data-nav="">
				할일</li>
			<li class="todoBtn tab " data-nav="">
				완료된 일</li>
		</ul>
		<ul class=" active" id="">
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>프로젝트 일정 및 리소스 관리</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>팀원 간 업무 분배 및 조정</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
		
		</ul>
		<ul class="" id="">
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>리스크 관리 및 문제 해결</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
			<li class="liMagin"> 
				<ul class="ulFlex">
					<li>시스템 성능 개선 및 버그 수정</li>
					<li class="liDate">2025-01-30</li>
				
				</ul> 
			</li>
		
		</ul>
		</div>
		</div>
	</div>
<div class="modal_bgrd"  style="display: none; ">
								<div class="mgmodal">
									<div class="delmodal" onclick="delModal()">&times;</div>
								</div>
								</div>
								 <jsp:include page="../include/footer.jsp"></jsp:include>

</div>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">

let subMenu = document.querySelector(".workSubMenu")
console.log(subMenu)
subMenu.style.display = 'block !important'; 
getProjTotal()
const currentPage = 1;  
	            const keyword = ''; 
myWorkList(currentPage,keyword)
$(document).ready(function() {
    // 탭 클릭 시 동작
    $('.nav').click(function(e) {
        e.preventDefault();
        // 탭 전환 로직
    });
});
$('.nav').click(function() {
    // 탭 활성화 상태 변경
    $('.nav').removeClass('active');
    $(this).addClass('active');
    
    // 컨텐츠 전환
    const navId = $(this).data('nav');  // data-nav 값을 가져옴
    $('.ulDisplay').removeClass('active');  // 모든 파일을 비활성화
    $('#' + navId).addClass('active');  // 해당 콘텐츠만 활성화
});


	function getProjTotal(){
		
		
		axios.get("/work/projTotal").then(function(res){
			
			console.log("response",res)
			
			let content = res.data;
			let str=""
			
			
			str += `
				<span class="projproTitle">
					<h5>부서 프로젝트 진행 상황</h5>
					<h6 class="h6" onclick="window.open('http://localhost:7921/gantt','new','scrollbars=yes, resizable=no width=1700 height=900,top=40',left=200);return false">더보기</h6>
				</span>
				<div class="tflex">
					<h6>요청 프로젝트</h6>
					<h2 class="projcnt">\${content.concluded}건</h2>
				</div>
				<div class="tflex">
					<h6 >진행중인 프로젝트</h6>
					<h2 class="projcnt">\${content.inprogress}건</h2>
				</div>
				<div class="tflex">
					<h6>완료된 프로젝트</h6>
					<h2 class="projcnt">\${content.completed}건</h2>
				</div>
				<div class="tflex">
					<h6>총 프로젝트</h6>
					<h2 class="projcnt">\${content.total}건</h2>
				</div>
			
			
			`
			
			let div = document.querySelector(".projcon");
			
			div.innerHTML = str
			
		
		})
	.catch(function(error) {
        console.error('Error:', error);  // 에러 로그 출력
    });
	        
}
	function myWorkList(currentPage,keyword){
		let data = {
   		     currentPage: currentPage,
   	         keyword: keyword
  	 	}
		let url = "/work/proj"
		axios.post(url,data)
		.then(function(res){
			console.log("체ㅡㅋ응",res)
			let content = res.data.content;
			
			let expectedWork = document.querySelector(".expectedWork");
			let inprogressWork = document.querySelector(".inprogressWork");
			let delayWork = document.querySelector(".delayWork");
			let str1 = ""
			let str2 = ""
			let str3 = ""
			for(let i =0; i<content.length; i++){
				let list = content[i]
				
				console.log("체킁 리스트" , list)
				
				
				
				if(list.taskStatus == "0"){
					str1 +=`	
					<li class="liMagin" > 
						<ul class="ulFlex">
						<li id="modalOn" onclick="modalOn()">\${list.taskType}</li>
						<li class="liDate">2025-01-30</li>
					
					</ul> 
				</li>
			`
				}
				if(list.taskStatus == "1"){
					str2 +=`	
					<li class="liMagin" > 
						<ul class="ulFlex">
						<li id="modalOn" onclick="modalOn()">\${list.taskType}</li>
						<li class="liDate">2025-01-30</li>
					
					</ul> 
				</li>
			`
					
					
					
				}
				if(list.taskStatus == "2"){
					str3 +=`	
					<li class="liMagin" > 
						<ul class="ulFlex">
						<li id="modalOn" onclick="modalOn()">\${list.taskType}</li>
						<li class="liDate">2025-01-30</li>
					
					</ul> 
				</li>
			`
					
					
					
				}
				
			}
			console.log("expectedWork" ,expectedWork)
			
			expectedWork.innerHTML = str1
			inprogressWork.innerHTML = str2
			delayWork.innerHTML = str3
			
			console.log("에스티알체킁" ,str1)
			
		}).catch(function(error){
			
		})
		
		
		
		
		
		
	}
    // JavaScript로 실시간으로 시계 업데이트
    function updateClock() {
        var now = new Date(); // 현재 시간 가져오기

        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();

        // 시간 형식 (HH:mm:ss)
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        seconds = seconds < 10 ? '0' + seconds : seconds;

        var timeString = hours + ':' + minutes + ':' + seconds;

        // 시간 표시
        document.getElementById("current-time").innerHTML = timeString;

        // 날짜 형식 (EEEE dd MMMM yyyy)
        var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        var dateString = now.toLocaleDateString('en-US', options); // 날짜 형식 지정

        // 날짜 표시
        document.getElementById("current-date").innerHTML = dateString;
    }

    // 페이지가 로드된 후 시계를 업데이트 시작
    window.onload = function() {
        updateClock();
        setInterval(updateClock, 1000); // 1초마다 updateClock 호출
    };
    function modalOn(){
	    let mgmodal = document.querySelector(".mgmodal")
    	let modal = document.querySelector("#modalOn");
    	let modalBgrd = document.querySelector(".modal_bgrd")
    	let str = ""
    	modalBgrd.style.display='block';
    	console.log("모달안의 res" , res)
    	str += `
    		<div class="delmodal" onclick="delModal()">&times;</div>
    		<div>dfdfdfds</div>
    	
    	
    	
    	` 
    	mgmodal.innerHTML = str	
    	console.log("str" , str)
    	console.log("res" ,)
    	
    	
    }
    function delModal(){
    	let del = document.querySelector(".delmodal");
    	let modalBgrd = document.querySelector(".modal_bgrd")
    	modalBgrd.style.display='none';
    	
    	
    	
    }
 
		
</script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
