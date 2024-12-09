<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 
../ : views폴더(부모)
 -->
<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

<!-- Main content -->
<section class="content">
  <div class="container-fluid">
<!-- ///////////////////////////////// content 시작 //////////////////////////////// -->

<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">상품 분류 검색</h3>
				<div class="card-tools">
					<!-- lprodGu, lprodNm이 검색 대상 -->
					<div class="input-group input-group-sm" 
						style="width: 150px;float:right;">
						<input type="text" name="keyword" id="keyword"
							class="form-control float-right" placeholder="Search" />
						<div class="input-group-append">
							<button type="button" id="btnSearch" class="btn btn-default">
								<i class="fas fa-search"></i>
							</button>
						</div>
					</div>
					<div class="input-group input-group-sm" 
						style="width: 150px;float:right;">
						<button type="button" 
						 data-toggle="modal" data-target="#modalAdd"
						 id="btnInsert" ${disabled} 						 
						  class="btn btn-block btn-outline-primary btn-sm">
						상품분류 추가</button>
					</div>
				</div>
			</div>

			<div class="card-body table-responsive p-0">
				<table class="table table-hover text-nowrap">
					<thead>
						<tr>
							<th>상품분류 아이디</th>
							<th>상품분류 코드</th>
							<th>상품분류 명</th>
						</tr>
					</thead>
					<tbody id="prodTbody">
					<!-- jstl의 forEach를 사용하여 List<LprodVO>를 출력해보자
					model.addAttribute("lprodVOList", lprodVOList)
					model.addAttribute("articlePage", articlePage)
					articlePage.content : List<LprodVO>
					
					stat.count : 1,2,3,...
					stat.index : 0,1,2,..
					 -->
					 	<c:forEach var="prodVO" items="${articlePage.content}" varStatus="stat">
					 		<tr>
					 			<td>
					 			<!-- param : currentPage=5&keyword= -->
					 			<a href="/prod/detail?currentPage=${param.currentPage}&keyword=${param.keyword}&prodId=${
					 			prodVO.prodId}">
					 				${prodVO.prodId}
					 			</a>
					 			</td>
					 			<td>${prodVO.prodLgu}</td>
					 			<td>${prodVO.prodName}</td>
					 		</tr>
					 	</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="card-footer" id="divPagingArea">
				<center>
					${articlePage.pagingArea}
				</center>
			</div>			
		</div>
	</div>
</div> 


    
<!-- ///////////////////////////////// content 끝 ///////////////////////////////// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->

<!-- /// 상품분류 등록 모달 시작 /// -->
<div class="modal fade" id="modalAdd">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">상품 분류 등록</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<!--  /// 내용 시작 /// -->
        <form>
          <div class="card-body">
            <div class="form-group">
              <label for="prodLgu">상품 분류 코드</label>
              <input type="text" class="form-control"
              	 id="prodLgu" placeholder="상품 분류 코드" maxlength="4" />
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">상품 분류 명</label>
              <input type="text" class="form-control" 
              	id="prodName" placeholder="상품 분류 명" />
            </div>
          </div>
        </form>
        <!--  /// 내용 끝 /// -->
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="btnRegist" class="btn btn-primary">등록</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /// 상품분류 등록 모달 끝 /// -->

<script type="text/javascript">
//상품분류 목록
//selectLprodList(keyword);
function selectProdList(keyword){
	
	let data = {
	  "currentPage":"1",
	  "keyword":keyword
	};
	
	console.log("data : ", data);
	
	//아작나써유..(피)씨다타써
	$.ajax({
		url:"/prod/listAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		success:function(result){
			console.log("result : ", result);
			
			//result : ArticlePage<ProdVO> 
			//result.content : List<ProdVO>
			//ProdVO : <tr>...</tr>
			//ProdVO : <tr>...</tr>
			//ProdVO : <tr>...</tr>
			//...
			let str = "";
			$.each(result.content,function(idx,prodVO){
				str += "<tr>";
				str += 		"<td>"+prodVO.prodId+"</td>";
				str += 		"<td>"+prodVO.prodLgu+"</td>";
				str += 		"<td>"+prodVO.prodName+"</td>";
				str += "</tr>";
			});
			
			//<tbody id="lprodTbody">내용</tbody>
			//부모요소.append(자식요소) : 부모의 마지막 자식 요소로 추가(누적)
			//부모요소.html(자식요소) : 부모의 자식 요소를 덮어씀(새로고침)
			//객체.append : 누적, .html : 새로고침, innerHTML : J/S
			$("#prodTbody").html(str);
			
			//페이징 블록 처리
			$("#divPagingArea").html("<center>"+result.pagingArea+"</center>");
			
			//모달 닫기
			$("#modalAdd").modal("hide");
		}
	});
	
}

$(function(){
	console.log("개똥이");
	
	//검색
	$("#btnSearch").on("click",function(){
// 		let keyword = $("#keyword").val();
		//<input type="text" name="keyword"...
		//태그+name로 접근
		let keyword = $("input[name='keyword']").val();
		console.log("keyword : " + keyword);
		
		//비동기 목록
		selectProdList(keyword);//도서
	});
	
	//상품 분류 추가
	$("#btnRegist").on("click",function(){
		//상품분류코드
		let prodLgu = $("#prodLgu").val();
		//상품분류명
		let prodName = $("#prodName").val();
		
		//validation(유효성 검증)
		//1. 상품분류 코드는 P로 시작. 4글자
		//+ : 1이상(필수)
		//* : 0이상(선택)
		let regExpProdGu = /^P[0-9]+$/; 
		if(!regExpProdGu.test(prodLgu)){
			console.log("상품분류코드는 P로 시작하여 4자여야 합니다.")
			$("#prodLgu").select();
			return; //함수 종료
		}
		
		let prodGuLength = prodLgu.length;
		if(prodGuLength<4){
			console.log("상품분류코드는 4자여야 합니다.");
			$("#prodLgu").select();
			return; //함수 종료
		}
			
		//2. 상품분류명은 null이면 안 됨
		let prodNmLength = prodName.length;
		if(prodNmLength<1){
			console.log("상품분류명은 필수입력요소입니다.")
			$("#prodName").select();
			return; //함수 종료
		}
		
		//JSON오브젝트
		let data = {
			"prodLgu":prodLgu,
			"prodName":prodName
		};
		
		//{"lprodGu": "P201","lprodNm": "도서류"}
		console.log("data : ", data);
		
		//아작나써유..(피)씨다타써
		//JSON.stringify(data) : JSONObject->serialize->JSONString
		//contentType : 
		//dataType : 
		$.ajax({
			url:"/prod/createPostAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			type:"POST",
			success:function(result){
				//JSONString->deserialize->Object
				//{"lprodId":283,"lprodGu":"G001","lprodNm":"개똥이",
				//"fileGroupNo":0,"uploadFile":null,"fileGroupVO":null}
				console.log("result : ", result);
				
				//상품분류목록 함수를 호출(검색어 없음)
				selectProdList("");
			}
		});
	});
});
</script>
<!-- 
	<p>JSON은 JavaScript Object Notation의 약자.</p>
	<p>JSON은 텍스트에 기반을 둔 데이터 저장 및 교환을 위한 구문임</p>
	<p>JSON은 자바스크립트 객체 표기법으로 작성된 텍스트임</p>
	<p>JSON은 브라우저와 서버 간에 데이터를 교환할 때 데이터는 텍스트일 뿐임</p>
	<p>모든 자바스크립트 객체를 JSON으로 변환하고 JSON을 서버로 보낼 수 있음</p>
	<p>서버에서 받은 JSON을 자바스크립트 객체로 변환할 수 있음</p>
	client -> server (string 형식으로 전달)
	server -> client (string 형식으로 전달)
	string으로 받아온 데이터를 다시 Object로 변환하여 브라우저에 표기!
	object -> string 으로 변환하는 방식을 serialize 라고 한다!
	string -> object로 다시 변환하는 방식을 deserialize라고 함!
 -->
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  