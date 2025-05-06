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
.btnd {
	margin-left: 0 !important;
}

.contb {
	width: 50% !important;
}

input {
	margin: 0;
	font-family: inherit;
	font-size: inherit;
	line-height: inherit;
	border: none ;
	width: 600px;
	outline: none !important;
}

tr {
	width: 100px !important;
}

.btn {
	background-color: 3069CE !important;
	border-color: 3069CE !important;
}

.cdate {
	width: 85px !important;
}

.contcon {
	margin-top: 3% !important;
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
.table{
border-color:#665757 !important;

}
#contractNm{
width: 900px !important;


}

</style>
<!-- 메인 컨텐츠 영역 시작 -->
<%@ include file="../include/header.jsp"%>
<form class="form-horizontal" id="form" action="/contract/create"
	method="post" enctype="multipart/form-data">
	<div class="bg-light rounded h-100 contcon">
		<h6 class="mb-4">계약상세</h6>
		<table class="table table-bordered">
			<tbody class="contb">
				<tr>
					<th scope="row">1</th>
					<td>계약 번호</td>
					<td><input type="number" class="updtcon" name="contractNo"
						value="${contViewVO.contractNo}" readonly></td>
				</tr>
				<tr>
					<th scope="row">2</th>
					<td>계약명</td>
					<td><input type="text" id="myInput contractNm" name="contractNm" class="updtcon"
						value="${contViewVO.contractNm}" readonly></td>
				</tr>
				<tr>
					<th scope="row">3</th>
					<td>거래처명</td>
					<td><input type="text" id="myInput" name="entName" class="updtcon"
						value="${contViewVO.entName}" readonly></td>
				</tr>
				<tr>
					<th scope="row">4</th>
					<td>거래처연락처</td>
					<td><input type="text" id="myInput" name="entTel" class="updtcon"
						value="${contViewVO.entTel}" readonly></td>
				</tr>
				<tr>
					<th scope="row">5</th>
					<td>거래처 계약담당자</td>
					<td><input id="updtcon myInput" name="entCust"
						value="${contViewVO.entCust}" readonly></td>
				</tr>
				<tr>
					<th scope="row">6</th>
					<td>계약 상태</td>
					<td><input value="${contViewVO.stateDesc}" name="stateDesc"
						class="updtcon" readonly /></td>
				</tr>
				<tr>
					<th scope="row">7</th>
					<td>계약 금액</td>
					<td><input type="text" name="contractPrice"
						value="${contViewVO.contractPrice}" id="contractPrice" class="updtcon" readonly>
						</td>
				</tr>
				<tr>
					<th scope="row">8</th>
					<td>계약기간</td>
					<td><input type="text" value="${contViewVO.fromDate}"
						class="updtcon cdate" readonly> - <input class="cdate"
						type="text" value="${contViewVO.toDate}"></td>
				</tr>
				<tr>
					<th scope="row">9</th>
					<td>계약타입</td>
					<td><input type="text" name="contractType"
						value="${contViewVO.contractType}" class="updtcon" readonly></td>
				</tr>
				<tr>
					<th scope="row">11</th>
					<td>회사계약담당자</td>
					<td><input type="text" name="empName"
						value="${contViewVO.empName}" class="updtcon" readonly></td>
				</tr>
				<tr>
					<th scope="row">9</th>
					<td>계약 승인일</td>
					<td><input type="text" name="approvalDate"
						value="${contViewVO.approvalDate}" class="updtcon" readonly></td>
				</tr>
				<tr>
					<th scope="row">9</th>
					<td>계약 승인자</td>
					<td><input type="text" name="approvalEmp"
						value="${contViewVO.approvalEmp}" class="updtcon" readonly></td>
				</tr>
				<tr>
					<th scope="row">12</th>
					<td>계약 메모</td>
					<td><textarea rows="3" cols="40" class="updtcon" readonly>${contractMasterVO.entMemo}</textarea></td>
				</tr>
				<c:if test="${contViewVO.fileGroupVO!=null}">
					<div class="form-group">
						<!-- model.addAttribute("memberVO", memberVO) 
	            	memberVO.fileGroupVO.fileDetailVOList : List<FileDetailVO>
	            	-->
						<div class="row mb-3">
							<c:forEach var="fileDetailVO"
								items="${contViewVO.fileGroupVO.fileDetailVOList}"
								varStatus="stat">
								<!-- 왼쪽 영역 시작 FileDetailVO(fileSn=1 -->
								<tr>
							<th scope="row">12</th>
							<td>계약서</td>
							<td>
							<button type="button" id="prev" class="btn btn-primary m-2">미리보기</button>
							<button type="button" id="down" class="btn btn-primary m-2">다운로드</button>
							</td>
							</tr>
								<div class="modal_bgrd"  style="display: none; ">
								<div class="mgmodal">
									<div class="delmodal">&times;</div>
									<div class="mdimg">
										<img class="img-fluid imgFileSaveLocate"
											style="cursor: pointer;" src="${fileDetailVO.fileSaveLocate}" 
											data-file-original-name="${fileDetailVO.fileOriginalName}"
					                    	 data-file-save-locate="${fileDetailVO.fileSaveLocate}" />
									</div>
								</div>
								</div>
								<!-- 왼쪽 영역 끝 -->

							</c:forEach>
						</div>
					</div>
					<!-- end row -->
				</c:if>


			</tbody>
		</table>
</form>
<span id="spn1" class="justify-between" style="display: block;">
	<span style="float: left;">
		<button type="button" id="edit" class="btn btn-primary m-2">수정</button>
		<button type="button" id="delete" class="btn btn-primary m-2">삭제</button>
</span> <span style="float: right;"> <a href="/contract/list"
		class="btn btn-success btn-user"> 목록 </a>
</span>
</span>
<span id="spn2" class="justify-between" style="display: none;"> <span
	style="float: left;">
		<button type="submit" class="btn btn-primary btn-user">확인</button>
</span> <span style="float: right;"> <a
		href="/contract/detail?contractNo=${param.contractNo}"
		class="btn btn-success btn-user"> 취소 </a>
</span>
</span>
<div class="btnd"></div>
<%--        <p>${contViewVO}</p> --%>
</div>
<%@ include file="../include/footer.jsp"%>
</div>

<script>



	$(function() {
		var inputValue = $('#contractPrice').val(); // 입력 필드의 값 가져오기

		// 문자열을 숫자(Number)로 변환하고 쉼표 추가
		inputValue = Number(inputValue).toLocaleString();

		// 쉼표가 추가된 값을 다시 입력 필드에 설정
		$('#contractPrice').val(inputValue);
		
		
		$("#prev").on("click",function(){
			$(".modal_bgrd").css("display","block");
			
			
		})
		$(".delmodal").on("click",function(){
			$(".modal_bgrd").css("display","none");
			
			
		})
		
		/* 	$(document).on("click",".imgFileSaveLocate",function(){
		//imgFileSaveLocate 클래스 속성을 갖고있는 요소들이 많은데 그 중 클릭한 바로 그 엘리먼트
		let fileSaveLocate = $(this).data("fileSaveLocate");// /resources/upload...
		console.log("fileSaveLocate : " + fileSaveLocate);
		
		location.href="/download?fileName="+fileSaveLocate;
		
		return;
	}); */
	
		$("#down").on("click",function(){
		//imgFileSaveLocate 클래스 속성을 갖고있는 요소들이 많은데 그 중 클릭한 바로 그 엘리먼트
		let fileSaveLocate = $(".imgFileSaveLocate").data("fileSaveLocate");// /resources/upload...
		console.log("fileSaveLocate : " + fileSaveLocate);
		
		location.href="/download?fileName="+fileSaveLocate;
// 		location.href=fileSaveLocate;
		
		return;
	}); 
		
		$("#updtcon").attr("readonly", true);

		
		$("#edit").on("click", function() {
			$("#spn1").css("display", "none")
			$("#spn2").css("display", "block")
			
			$(".updtcon").css("border", "1px solid gray")
			$(".updtcon").removeAttr("readonly")

			$("#form").attr("action", "/contract/update")
			$("#form").attr("method", "post")
			$("#myInput").css('border', '2px solid #3498db !important');
			
		})
		
      /* $('#editButton').click(function() {
        
        if (isEditing) {
          // 수정 모드일 때 border를 숨김
          $input.css('border', 'none');
        } else {
          // 수정 모드가 아닐 때 border를 보이게 함
        }
        */
		$("#delete").on("click", function() {
			$("#form").attr("action", "/contract/delete")

			let result = confirm("삭제하시겠습니까?")

			if (result > 0) {
				$("#form").submit()

			} else {
				alert("삭제 취소되었습니다")

			}

		})

	})
</script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 메인 컨텐츠 영역 끝 -->