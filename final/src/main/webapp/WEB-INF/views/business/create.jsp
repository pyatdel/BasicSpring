<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  



<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
   


<style>

 
.bluBt{
background-color: #3676EB;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}

.greenBt{
background-color: #278986;
color:white;
outline: none;
border:none;
width: 130px;
height:36px; 
border-radius: 5px;

}


#tby {
	background-color : white !important;
}

#cardfooter {
	background-color : white !important;
}

.form-group {
	margin-top: 12px;
    display: flex;
    flex-direction: column;
    gap: 6px;  /* 원하는 간격 크기 */
}

#btnSubmit{
		background-color: 3069CE !important;
	border-color : 3069CE !important;
}
#btnPost,#btnIdDupChk {
    margin-left: 10px;  /* 원하는 간격 크기 */
    background-color: 3069CE !important;
	border-color : 3069CE !important;
	color : white !important;
}

.card-header, .card-footer {
	background-color : white !important;
}
.businessSub {
display: block !important;
height: auto !important;
}
</style>



<%@ include file="../include/header.jsp" %>



<!-- <div class="card card-primary"> -->
        <div class="card-header" >
          <h3 class="card-title">고객 등록</h3>
        </div>
        <!-- /.card-header -->

      <form id="frm" action="/business/createPost" method="post">
        <div class="card-body">
        
          <div class="form-group">
            <label for="entNo" class="font-weight-bold">기업번호</label>
            	<div class="input-group">
		            <input type="number" class="form-control rounded" id="entNo" name="entNo" value=""placeholder="기업번호" />
		            <div class="input-group-append">
		            	<button type="button" id="btnIdDupChk" class="btn btn-primary bluBt">기업번호 중복 체크</button>
		            </div>	
            	</div>
          </div>
          
          <div class="form-group">
            <label for="entName" class="font-weight-bold">기업명</label>
            <input type="text" class="form-control rounded" id="entName" name="entName" value="" placeholder="기업명" />
          </div>
          <div class="form-group">
            <label for="entTel" class="font-weight-bold">연락망</label>
            <input type="text" class="form-control rounded" id="entTel" name="entTel" value="" placeholder="기업 전화번호" />
          </div>
          
          <div class="form-group">
		    <label for="roadAdd" class="font-weight-bold">우편번호</label>
			    <div class="input-group">
			        <input type="text" class="form-control rounded" id="roadAdd" name="roadAdd" value="" placeholder="우편번호" />
			        <div class="input-group-append">
			            <button type="button" id="btnPost" class="btn btn-primary bluBt" onclick="searchAddress()">주소 검색</button>
			        </div>
			    </div>
			</div>		
			
			<div class="form-group">
			    <label for="detailAdd" class="font-weight-bold">도로명주소</label>
			    <input type="text" class="form-control rounded" id="detailAdd" name="detailAdd" value="" placeholder="도로명주소">
			</div>

          <div class="form-group">
            <label for="repName" class="font-weight-bold">대표명</label>
            <input type="text" class="form-control rounded" id="repName" name="repName" value=""  placeholder="대표명" />
          </div>
          <div class="form-group">
            <label for="entType" class="font-weight-bold">업체종목</label>
            <input type="text" class="form-control rounded" id="entType" name="entType" value=""  placeholder="업체종목" />
          </div>
          <div class="form-group">
			    <label for="entRegDate" class="font-weight-bold">등록일자</label>
			    <input type="date" class="form-control rounded" id="entRegDate" name="entRegDate" 
			        value="<fmt:formatDate value='${custInfoVO.entRegDate}' pattern='yyyy-MM-dd' />"
			        placeholder="등록일자" />
			</div>
          <div class="form-group">
            <label for="entCust" class="font-weight-bold">담당직원</label>
            <input type="text" class="form-control rounded" id="entCust" name="entCust" value="" placeholder="담당직원" />
          </div>
        </div>
          <!-- /.card-body -->

          <div class="card-footer">
	        <span id="spn1" class="justify-between">
		        <p style="float:right;">
		          <button type="submit" id="btnSubmit"  
		          	class="btn btn-primary bluBt" 
		          	style="float:left;">등록</button>&nbsp;
		         </p>
		         <p style="float:left;">
		          <a href="/business/infoList" class="btn btn-primary greenBt">
		              	목록
		          </a>
		         </p>
	        </span>
          </div>
        </form>
<%@ include file="../include/footer.jsp" %>   
<!--       </div> -->
    
    <!-- ///// content 끝 ///// -->

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("detailAdd").value = data.address; // 도로명 주소
            document.getElementById("roadAdd").value = data.zonecode; // 우편번호
        }
    }).open();
}
$(function(){
	// 아이디 중복 체크
	$("#btnIdDupChk").on("click", function() {
		// 달러.trim() : 양쪽 공백 제거
		let entNo = $.trim($("#entNo").val());
		console.log("entNo : " + entNo);

		if (entNo == "") {
			// success, error, warning, info, question
			var Toast = Swal.mixin({
				toast: true,
				position: 'top-end',
				showConfirmButton: false,
				timer: 3000
			});

			Toast.fire({
				icon: 'warning',
				title: '기업번호를 입력해주세요'
			});

			$("#entNo").focus();

			return;
		}

		// JSON 오브젝트
		let data = {
			"entNo": entNo
		};

		console.log("data : ", data);

		$.ajax({
			url: "/business/idDupChk",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(data),
			type: "post",
			dataType: "text",
			success: function(result) {
				// result => 1) 1 : 중복됨 2) 0 : 중복안됨
				console.log("result : ", result);

				if (result == 1) { // 중복됨
					var Toast = Swal.mixin({
						toast: true,
						position: 'top-end',
						showConfirmButton: false,
						timer: 3000
					});

					Toast.fire({
						icon: 'warning',
						title: '기업번호가 중복되었습니다.'
					});

					$("#entNo").focus();
					// 등록 버튼 비활성
					$("#btnSubmit").attr("disabled", true);
				} else { // 중복안됨
					var Toast = Swal.mixin({
						toast: true,
						position: 'top-end',
						showConfirmButton: false,
						timer: 3000
					});

					Toast.fire({
						icon: 'success',
						title: '사용가능한 기업번호입니다.'
					});
					// 등록 버튼 활성
					$("#btnSubmit").removeAttr("disabled");
				}
			}
		});
	});

	// 숫자만 입력 가능하도록 이벤트 리스너 추가
	document.getElementById("entNo").addEventListener("keypress", function(e) {
		if (!/[0-9]/.test(e.key)) {
			e.preventDefault(); // 숫자가 아닌 입력을 차단
		}
	});
});
</script>

</html>
	