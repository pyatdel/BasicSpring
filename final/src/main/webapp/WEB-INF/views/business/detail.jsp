<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
<!-- 라이브러리 include  -->

<style>
.content{
    margin-left: 0 !important;
    width: 100% !important;
}
.container-fluid{
    margin: 0 auto !important; 
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

#edit, #delete, #okay {
	background-color: 3069CE !important;
	border-color : 3069CE !important;
}

#btnPost {
    margin-left: 10px;  /* 원하는 간격 크기 */
    background-color: 3069CE !important;
	border-color : 3069CE !important;
	color : white !important;
}
.businessSub {
display: block !important;
height: auto !important;
}
</style>
<%@ include file="../include/header.jsp" %>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var="memberVO" />
</sec:authorize>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<%@ include file="../include/sidebar.jsp" %>

<section class="content">
  <div class="container-fluid" style="padding: 20px;">
    <!-- ///// content 시작 ///// -->
<!--     <div class="card shadow-sm" style="margin-top: 20px;"> -->
      <div class="card-header bg-primary text-white" id="tby">
        <h3 class="card-title">고객 정보</h3>
      </div>

      <!-- /.card-header -->
      <!-- form start -->    
      <form id="frm" action="/business/updatePost" method="post">
        <div class="card-body">
          <div class="form-group">
            <label for="entNo" class="font-weight-bold">기업번호</label>
            <input type="text" class="form-control rounded" id="entNo" name="entNo" value="${custInfoVO.entNo}" readonly placeholder="기업번호" />
          </div>
          <div class="form-group">
            <label for="entName" class="font-weight-bold">기업명</label>
            <input type="text" class="form-control rounded" id="entName" name="entName" value="${custInfoVO.entName}" readonly placeholder="기업명" />
          </div>
          <div class="form-group">
            <label for="entTel" class="font-weight-bold">연락망</label>
            <input type="text" class="form-control rounded" id="entTel" name="entTel" value="${custInfoVO.entTel}" readonly placeholder="기업 전화번호" />
          </div>
          <div class="form-group">
		    <label for="roadAdd" class="font-weight-bold">우편번호</label>
			    <div class="input-group">
			        <input type="text" class="form-control rounded" id="roadAdd" name="roadAdd" value="${custInfoVO.roadAdd}" placeholder="우편번호" readonly>
			        <div class="input-group-append">
			            <button type="button" id="btnPost" class="btn btn-info" disabled onclick="searchAddress()">주소 검색</button>
			        </div>
			    </div>
			</div>		
			<div class="form-group">
			    <label for="detailAdd" class="font-weight-bold">도로명주소</label>
			    <input type="text" class="form-control rounded" id="detailAdd" name="detailAdd" value="${custInfoVO.detailAdd}" placeholder="도로명주소" readonly>
			</div>

          <div class="form-group">
            <label for="repName" class="font-weight-bold">대표명</label>
            <input type="text" class="form-control rounded" id="repName" name="repName" value="${custInfoVO.repName}" readonly placeholder="대표명" />
          </div>
          <div class="form-group">
            <label for="entType" class="font-weight-bold">업체종목</label>
            <input type="text" class="form-control rounded" id="entType" name="entType" value="${custInfoVO.entType}" readonly placeholder="업체종목" />
          </div>
          <div class="form-group">
            <label for="entRegDate" class="font-weight-bold">등록일자</label>
            <input type="date" class="form-control rounded" id="entRegDate" name="entRegDate" 
            	value='<fmt:formatDate value="${custInfoVO.entRegDate}" pattern="yyyy-MM-dd" />'
            	 readonly placeholder="등록일자" />
          </div>
          <div class="form-group">
            <label for="entCust" class="font-weight-bold">담당직원</label>
            <input type="text" class="form-control rounded" id="entCust" name="entCust" value="${custInfoVO.entCust}" readonly placeholder="담당직원" />
          </div>
        </div>

          <div class="card-footer" id="cardfooter">
          	<!-- 일반모드 시작 -->
	        <span id="spn1" class="justify-between">
		        <p style="float:left;">
		          <button type="button" id="edit"  
				          	class="btn btn-primary btn-user" 
				          	style="float:left;">수정</button>&nbsp;
		          <button type="button" id="delete"  
		                	class="btn btn-primary btn-user">삭제</button>
		         </p>
		         <p style="float:right;">
		          <a href="/business/infoList" class="btn btn-success btn-user">
		              	목록
		          </a>
		         </p>
	        </span>
	        <!-- 일반모드 끝 -->
	        <!-- 수정모드 시작 -->
	        <span id="spn2" class="justify-between" style="display:none;">
	         <span style="float:left;">
		         <button type="submit" class="btn btn-primary btn-user" id="okay">
		             	확인
		         </button>
	         </span>
	         <span style="float:right;">
		         <a href="/business/detail?entNo=${param.entNo}" 
		         	class="btn btn-success btn-user">
		             	취소
		         </a>
	         </span>
	        </span>
	        <!-- 수정모드 끝 -->
          </div>

      </form>
<!--     </div> -->
    <!-- ///// content 끝 ///// -->
  </div>
</section>

<!-- 지도 표시 영역 -->
<div id="map" style="width:100%; height:400px;"></div>

<!-- 카카오 지도 API 스크립트 -->
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=64a194e42b0ee87daf03e2a98eeac46a"></script> -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

// 주소 검색 함수
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("detailAdd").value = data.address; // 도로명 주소
            document.getElementById("roadAdd").value = data.zonecode; // 우편번호
        }
    }).open();
}

// 수정버튼 클릭 시
$("#edit").on("click", function() {
    // 수정 영역 가려짐
    $("#spn1").css("display", "none");
    // 일반 영역 보임
    $("#spn2").css("display", "block");

    // 입력란 활성화
    $(".form-control").removeAttr("readonly");
    $(".form-control").removeAttr("disabled");

    $("#entNo").attr("readonly", true);
    $("#btnPost").prop("disabled", false);
});

// 확인 버튼 클릭 시
$("#edit2").on("click", function() {
    // 수정 영역 가려짐
    $("#spn1").css("display", "block");
    // 일반 영역 보임
    $("#spn2").css("display", "none");

    // 입력란 비활성화
    $(".form-control").attr("readonly", true);
    $(".form-control").attr("disabled", true);

    $("#entNo").attr("readonly", true);

    // 폼 데이터 수집
    let entNo = $("#entNo").val();
    let entName = $("#entName").val();
    let entTel = $("#entTel").val();
    let roadAdd = $("#roadAdd").val();
    let detailAdd = $("#detailAdd").val();
    let repName = $("#repName").val();
    let entType = $("#entType").val();
    let entRegDate = $("#entRegDate").val();
    let entCust = $("#entCust").val();

    let data = {
        "entNo": entNo,
        "entName": entName,
        "entTel": entTel,
        "roadAdd": roadAdd,
        "detailAdd": detailAdd,
        "repName": repName,
        "entType": entType,
        "entRegDate": entRegDate,
        "entCust": entCust
    };

    // AJAX를 통해 데이터 전송
    $.ajax({
        url: "/business/updatePostAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "put",
        dataType: "text",
        success: function(result) {
            if (result == 1) {
                location.href = "/business/detail?entNo=" + entNo;
            }
        }
    });
});

// 삭제 버튼 클릭 시
$("#delete").on("click", function() {
    let entNo = $("#entNo").val();
    let data = {
        "entNo": entNo
    };

    console.log("삭제 data : ", data);

    // AJAX를 통해 삭제 요청
    $.ajax({
        url: "/business/deletePostAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "delete",
        dataType: "text",
        success: function(result) {
            if (result == 1) {
                location.href = "/business/infoList";
            } else {
                alert("삭제 실패");
            }
        }
    });
});

// 우편번호 검색 버튼 클릭 시
$("#btnPost").on("click",function(){
    console.log("우편번호 검색!");
    new daum.Postcode({
        oncomplete:function(data){
            // data{"zonecode":"12345","address":"대전 중구","buildingName":"123-67"}
            $("#roadAdd").val(data.zonecode);
            $("#detailAdd").val(data.address);
        }
    }).open();
});

</script>


<%@ include file="../include/footer.jsp" %>

