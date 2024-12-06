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
    <!-- ///// content 시작 ///// -->
    
    <h3>회원목록</h3>
    
    
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">회원목록</h3>

            <div class="card-tools">
               <!-- /// 검색 시작 
              action 생략 : /member/list
              method 생략 : get
              요청파라미터 : keyword=개똥이 (왜냐하면 검색 후 currentPage는 1로 초기화)
              /// -->
              <div class="input-group input-group-sm" style="width: 150px;">
                <input type="text" name="keyword" value="${param.keyword}"
                   class="form-control float-right" placeholder="검색어 입력" />

                <div class="input-group-append">
                  <button type="button" id="btnSearch" class="btn btn-default">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </div>
              <!-- /// 검색 끝 /// -->
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body table-responsive p-0">
          	<!-- 성명으로 오름차순 정렬 -->
            <table class="table table-hover text-nowrap">
              <thead>
                <tr>
                  <th>순번</th>
                  <th>회원아이디</th>
                  <th>성명</th>
                  <th>이동전화</th>
                  <th>Email</th>
                  <th>직업</th>
                  <th>생일</th>
                </tr>
              </thead>
              <tbody id="tby">
              
              </tbody>
            </table>
          </div>
          <!-- /.card-body -->
          <!-- /.card-footer 시작 -->
          <div class="card-footer" id="divPagingArea"></div>
          <!-- /.card-footer 끝 -->
        </div>
        <!-- /.card -->
      </div>
      <div class="col-12" style="justify-content:right;display:flex;">
      	<a href="/member/create" class="btn btn-primary">등록</a>
      </div>
    </div>
    
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>

<script type="text/javascript">
// 전역변수, 전역함수
/**
==는 Equal Operator이고,  ===는 Strict Equal Operator이다. 
==는 a == b 라고 할때, a와 b의 값이 같은지를 비교해서, 같으면 true, 다르면 
	false라고 한다.(값만 같으면 true이다.)
===는 Strict, 즉 엄격한 Equal Operator로써, "엄격하게" 같음을 비교할 때 사용하는 연산자이다. 
===는 a === b 라고 할때, 값과 값의 종류(Data Type)가 모두 같은지를 비교해서, 
	같으면 true, 다르면 false라고 한다.
 
 * NVL: expr1 값이 null(undefined) 또는 공백인 경우 expr2 값을 반환, 그렇지 않으면 expr1 값 반환
 * @return expr1
 */
function nvl(expr1, expr2) {
   if (expr1 === undefined || expr1 == null || expr1 == "") {
      expr1 = expr2;
   }
   return expr1;
}

// 목록 가져오는 함수
function getList(currentPage,keyword){
	let data = {
			  "currentPage":nvl(currentPage,"1"),
			  "keyword":nvl(keyword,"")
			};
			
	console.log("data : ", data);
	
	// 회원 목록
	// 아작나써유 (피)씨다타써
	$.ajax({
		url:"/member/listAjax",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"POST",
		dataType:"json",
		success:function(articlePage){
			console.log("articlePage : ", articlePage);
			//		articlePage.content : :List<MemberVO>
			console.log("articlePage.content : ", articlePage.content);
			
			let str = "";
			$.each(articlePage.content,function(idx,memberVO){
			str += `<tr>
            <td>\${memberVO.rnum}</td>
            <td>\${memberVO.memId}</td>
            <td><a href="/member/detail?memId=\${memberVO.memId}">\${memberVO.memName}</a></td>
            <td>`+nvl(memberVO.memHp,"")+`</td>
            <td>`+nvl(memberVO.memMail,"")+`</td>
            <td>`+nvl(memberVO.memJob,"")+`</td>
            <td>\${memberVO.memBirStr}</td>
          </tr>`;
				
			}); // end each
			
			// 엘리먼트.append() : 누적 / 엘리먼트.html() : 새로고침
			$("#tby").html(str);
			
			// 페이징 처리
			$("#divPagingArea").html(articlePage.pagingArea);
		}
	});
} // end getList()

// document.ready
// 동일 jsp에서 1회 작성
$(function(){
	//최초 회원 목록 호출
	   getList("1","");
	
	// 검색 처리
	$("#btnSearch").on("click",function(){
		let keyword = $("input[name='keyword']").val();
		console.log("keyword : " + keyword);
		
		// 전역 함수 호출
		getList("1",keyword);
	});
	
	   
	   //페이지 클릭 처리
	   //class="clsPagingArea" : 여러개(오브젝트 배열)
	   //정적 요소 : 달러(".clsPagingArea").on("click",function(){
	   //동적 요소 : 
	   $(document).on("click",".clsPagingArea",function(){
	      //클릭한 것은 하나
	      //<a .. data-current-page="2" data-keyword="".. class="page-link clsPagingArea">2</a>
	      let currentPage = $(this).data("currentPage");//2
	      let keyword = $(this).data("keyword");//""
	      
	      console.log("페이지 클릭 처리->currentPage : " + currentPage);
	      console.log("페이지 클릭 처리->keyword : " + keyword);
	      
	      //회원 목록 호출
	      getList(currentPage,keyword);
	   });
});
</script>

<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


