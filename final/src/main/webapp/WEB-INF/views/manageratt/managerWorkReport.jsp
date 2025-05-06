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
    
	
	
	<title>근무 리포트</title>




<style>
.tbc {
	background-color: 3069CE;
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
  margin-left : 40px;
  width : 1000px;
  justify-content: center;
  justify-items: center;
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


.ag-charts-canvas-container{
	
	margin :10px;
	margin-left : 10px;
	padding : 10px;
	
}
.mnattSub{
display: block !important;
height: auto !important;
}
</style>
<!-- 메인 컨텐츠 영역 시작 --> 
<%-- <p>${contractMasterVOList}</p> --%> 
<!-- 헤더 include  -->
   <jsp:include page="../include/managerHeader.jsp"></jsp:include>
<!-- 헤더 include  -->
<!-- 메인 컨텐츠 영역 시작 --> 

		<div class="info-card">
			<h2>부서별 평균 출퇴근시간</h2>
			<div style="width:600px;height:400px;border:2px solid black">
			<label for="deptSelect">부서 선택:</label>
		    <select id="deptSelect">
		        <option value="all">전체</option>
		    </select>
		        <canvas id="attendanceChart" style="display: block;"></canvas> <!-- 부서 차트 캔버스 -->
        		<canvas id="employeeChart" style="display: none;"></canvas> <!-- 직원 차트 캔버스 (처음엔 숨겨짐) -->
    		</div>
		</div>
<!-- 		<div class="info-card"> -->
<!-- 		    <h2>부서별 일평균 근무 시간</h2> -->
<!-- 		    <p></p> -->
<!-- 		    <div style="width:600px;height:400px;border:2px solid black"> -->
<!-- 		        차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
<%-- 		        <canvas id="myChart2"></canvas> --%>
<!--     		</div> -->
<!-- 	  	</div> -->
<!-- 	  	<div class="info-card"> -->
<!-- 		    <h2>누적 초과근무 시간</h2> -->
<!-- 		    <p></p> -->
<!-- 		    <div style="width:600px;height:400px;border:2px solid black"> -->
<!-- 		        차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
<%-- 		        <canvas id="myChart3"></canvas> --%>
<!--     		</div> -->
    		
 <jsp:include page="../include/managerFooter.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  
 
	  	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="/dash/js/main.js"></script>
	<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    let deptLabels = [];
    let deptInTimes = [];
    let deptOutTimes = [];
    let deptData = [];
    let employeeChartInstance = null;
    
 	// 시간 (분)을 HH:MM 형식으로 변환하는 함수
    function convertToTime(hours){
    	let hour = Math.floor(hours);
    	let minute = Math.round((hours - hour) *60);
    	return `\${String(hour).padStart(2,'0')}시\${String(minute).padStart(2,'0')}분`;
    }

    // 부서별 평균 출퇴근 시간 가져오기
    axios.get("/manageratt/deptAvg")
    .then(response => {
    	const data = response.data;
    	deptData = data;
    	console.log("deptData:{}",deptData);
    	console.log("data:{}",data);
    	data.forEach(dept => {
    		deptLabels.push(dept.DEPT_NAME);
    		// 시간 문자열을 숫자로 변환 (HH:MM 형식)
            let inTime = dept.AVG_ATT_IN_TIME.split(':');
            let outTime = dept.AVG_ATT_OUT_TIME.split(':');
            
            // 시간을 숫자로 변환 (예: 08:45 -> 8.75)
            let inTimeInHours = parseInt(inTime[0]) + parseInt(inTime[1]) / 60;
            let outTimeInHours = parseInt(outTime[0]) + parseInt(outTime[1]) / 60;
            
            deptInTimes.push(inTimeInHours);
            deptOutTimes.push(outTimeInHours);
    		$("#deptSelect").append(`<option value ="\${dept.DEPT_NO}">\${dept.DEPT_NAME}</option>`);
    	});
    	renderDeptChart();
    })
    .catch(error => {
    	console.error("Error fetching department data:".error);
    });

    function renderDeptChart() {
        let ctx = document.getElementById('attendanceChart').getContext('2d');
        
     	// 기존 차트가 있으면 파괴
        if(employeeChartInstance){
        	employeeChartInstance.destroy();
        }
        
        console.log("deptInTimes {}",deptInTimes);
        employeeChartInstance = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: deptLabels,
                datasets: [
                    {
                        label: '평균 출근 시간',
                        data: deptInTimes,
                        backgroundColor: 'rgba(75, 192, 192, 0.5)',
                    },
                    {
                        label: '평균 퇴근 시간',
                        data: deptOutTimes,
                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: false
                    }
                },
                plugins:{
	                tooltip: {
	                	callbacks: {
	                		label: function (tooltipItem){
	                			let minutes = tooltipItem.raw;
	                			return convertToTime(minutes); 
	                		}
	                	}
	                }
                }
            }
        });
    }
    
   
    function renderEmployeeChart(employeeData) {
    	let ctx = document.getElementById('employeeChart').getContext('2d');
    	// 기존 차트가 있으면 파괴
        if(employeeChartInstance){
        	employeeChartInstance.destroy();
        }
    	
        let empLabels = [];
        let empInTimes = [];
        let empOutTimes = [];

        $.each(employeeData, function (index, emp) {
            empLabels.push(emp.EMP_NAME);
            
         	// 시간 문자열을 숫자로 변환 (HH:MM 형식)
            let inTime = emp.AVG_ATT_IN_TIME.split(':');
            let outTime = emp.AVG_ATT_OUT_TIME.split(':');
            
            // 시간을 숫자로 변환 (예: 08:45 -> 8.75)
            let inTimeInHours = parseInt(inTime[0]) + parseInt(inTime[1]) / 60;
            let outTimeInHours = parseInt(outTime[0]) + parseInt(outTime[1]) / 60;
            
            empInTimes.push(inTimeInHours);
            empOutTimes.push(outTimeInHours);
        });

        // 새 차트 생성
        employeeChartInstance = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: empLabels,
                datasets: [
                    {
                        label: '평균 출근 시간',
                        data: empInTimes,
                        backgroundColor: 'rgba(75, 192, 192, 0.5)',
                    },
                    {
                        label: '평균 퇴근 시간',
                        data: empOutTimes,
                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                    }
                ]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: false
                    }
                },
                plugins:{
	                tooltip: {
	                	callbacks: {
	                		label: function (tooltipItem){
	                			let minutes = tooltipItem.raw;
	                			return convertToTime(minutes); 
	                		}
	                	}
	                }
                }
            }
        });
    }

    // 부서 선택 시 직원별 데이터 가져오기
    $("#deptSelect").change(function () {
        let selectedDept = $(this).val();
        if (selectedDept === "all") {
        	// 부서 차트 보이게 하고 직원 차트 숨기기
            $("#attendanceChart").show();
            $("#employeeChart").hide();
            renderDeptChart();  // 전체 부서 차트 그리기
        } else {
        	
        	// 직원 차트 보이게 하고 부서 차트 숨기기
            $("#attendanceChart").hide();
            $("#employeeChart").show();
            
            axios.get(`/manageratt/employeesAvg?deptNo=\${selectedDept}`)
            	.then(response => {
            		console.log("response.date {}",response.data);
                	renderEmployeeChart(response.data); 
            	})
            	.catch(error => {
            		console.log("Error fetching employee data : ", error);
            	});
        }
    });
});


</script>
    

	<!-- 메인 컨텐츠 영역 끝 -->