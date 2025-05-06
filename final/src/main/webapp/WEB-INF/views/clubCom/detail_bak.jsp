<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">


<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

   <div class="card card-primary">
      <div class="card-header">
        <h3 class="card-title">${boardVO.boardTypeVO.bodTypeName}</h3>
        <button type="button" class="btn btn-danger float-right" 
		    data-toggle="modal" 
		    data-target="#modalReport"
		    onclick="reportPost('${boardVO.bodNo}')">
		    <i class="fas fa-exclamation-circle"></i> 게시글 신고
		</button>
      </div>
      <!-- /.card-header -->
      <!-- form start -->
      
      <p>${boardVO}</p>
      <p>${boardTypeVO}</p>
      <form id="boardFrm" action="/board/updatePost" method="post">
      	 <input type="text" name="bodNo" value="${boardVO.bodNo}" hidden />
        <div class="card-body">
          <div class="form-group">
            <label for="bodTitle">제목</label>
            <input type="text" class="form-control" 
            	id="bodTitle" name="bodTitle" value="${boardVO.bodTitle}" placeholder="제목" readonly />
          </div>
          <div class="form-group">
            <label for="bodWriter">작성자</label>
            <input type="text" class="form-control" 
            	id="bodWriter" name="bodWriter" value="${boardVO.bodWriter}" placeholder="작성자" readonly />
          </div>
          <div class="form-group">
            <label for="bodCont">내용</label>
            <textarea rows="3" cols="30" class="form-control" 
            	id="bodCont" name="bodCont" placeholder="내용" readonly>${boardVO.bodCont}</textarea>
          </div>
          <div class="form-group">
            <label for="saveLocate">첨부이미지</label>
            
            	<c:forEach var="fileDetailVO" items="${boardVO.fileGroupVO.fileDetailVOList}" varStatus="stat">
                   <div class="col-sm-3">
                     <img class="img-fluid mb-3" src="${fileDetailVO.fileSaveLocate}" alt="Photo">
                   </div>
            	</c:forEach>
              <!-- 반복 끝 -->
          </div>
        </div>
        <!-- /.card-body -->
        <!-- 일반모드 시작 -->
        <div id="div1" class="card-footer justify-content-between">
          <div class="float-left">
              <button type="button" id="edit"  
   	           	class="btn btn-primary">수정</button>
              <button type="button" id="delete"  
   	           	class="btn btn-primary">삭제</button>
          </div>
          <div class="float-right">
              <a href="/board/list" 
              	class="btn btn-primary">목록</a>
          </div>
        </div>
        <!-- 일반모드 끝 -->
        <!-- 수정모드 시작 -->
        <div id="div2" class="card-footer" style="display:none;">
          <button type="submit" class="btn btn-primary">
              	확인
          </button>
          <a href="/board/detail/${boardVO.bodNo}" class="btn btn-success">
              	취소
          </a>
        </div>
        <!-- 수정모드 끝 -->
      </form>
    </div>
    <hr />
     <!-- /// 댓글 카드 시작 /// -->
     <div class="card">
     	<!-- ///댓글 등록 영역 시작 /// -->
     	<div class="card-header">
     	
     	<form id="bodReplyFrm" class="form-horizontal" action="/board/createReplyPost" method="post">
   		  <input type="hidden" name="bodNo" value="${boardVO.bodNo}" />
   		  <input type="hidden" name="bodWriter" value="${boardVO.bodWriter}" />
   		  <div class="input-group input-group-sm mb-0">                
   		    <input type="text" id="bodReCont" name="bodReCont" 
   		    		class="form-control form-control-sm" 
   		    		placeholder="댓글내용" required />
   		    <div class="input-group-append">
   		      <button type="submit" class="btn btn-danger">댓글등록</button>
   		    </div>
   		  </div>
   		</form>
     	</div>
     	<!-- ///댓글 등록 영역 끝 /// -->
     	<!-- ///댓글 목록 영역 시작 /// -->
     	<div class="card-body">
		    <p>${boardReplyVOList}</p>
		    <div id="replyList">
		    <c:forEach var="boardReplyVO" items="${boardReplyVOList}">
		       <div class="post clearfix" style="margin-left:${boardReplyVO.bodLvl * 50}px;" 
		            data-lvl="${boardReplyVO.bodLvl}">
		           <div class="user-block">
		               <img class="img-circle img-bordered-sm" src="/resources/images/default-profile.png" alt="User Image">
		               <span class="username">
		                   <a href="#">${empty boardReplyVO.bodReWriter ? '익명' : boardReplyVO.bodReWriter}</a>
		               </span>
		               <span class="description">
		                   <fmt:formatDate value="${boardReplyVO.bodReDate}" pattern="yyyy-MM-dd" /> 
		               </span>
		           </div>
		           <p>
					    <span id="spanReplyContent${boardReplyVO.bodIdx}">
					        <c:choose>
					            <c:when test="${boardReplyVO.bodLvl > 1}">
					                <span class="text-primary">@${empty boardReplyVO.bodParentReWriter ? '익명' : boardReplyVO.bodParentReWriter}</span>
					                <span class="ml-2">${boardReplyVO.bodReCont}</span>
					            </c:when>
					            <c:otherwise>
					                <!-- 일반 댓글인 경우 -->
					                ${boardReplyVO.bodReCont}
					            </c:otherwise>
					        </c:choose>
					    </span>
					    
					    <span class="spnReplyUpdate"
						    data-bod-idx="${boardReplyVO.bodIdx}"
						    data-content="${boardReplyVO.bodReCont}"
						    data-toggle="modal"
						    data-target="#modalReplyUpdate"
						    style="cursor:pointer;">
						    <i class="fas fa-edit"></i>
						</span>
					    <span class="spnReplyDelete"
					        data-bod-idx="${boardReplyVO.bodIdx}"
					        style="cursor:pointer; margin-left: 5px; color: #007bff;">
					        <i class="fas fa-trash"></i>
					    </span>
		               <span class="spnReplyUpdate"...></span>
			           <!-- 신고 버튼 추가 -->
			           <span class="spnReplyReport"
			               data-bod-idx="${boardReplyVO.bodIdx}" 
			               data-writer="${boardReplyVO.bodReWriter}"
			               data-content="${boardReplyVO.bodReCont}"
			               data-toggle="modal"
    					   data-target="#modalReport"
			               style="cursor:pointer; margin-left: 5px; color: #dc3545;">
			               <i class="fas fa-exclamation-circle"></i>
			           </span>
			       </p>
			
			       <div class="input-group input-group-sm mb-0">
			           <input type="text" id="txt${boardReplyVO.bodIdx}" 
			               class="form-control form-control-sm" 
			               placeholder="대댓글 입력" />
			           <div class="input-group-append">
			               <button type="button" 
			                   data-mem-id="${boardVO.bodWriter}" 
			                   data-parent-idx="${boardReplyVO.bodIdx}"  
			                   class="btn btn-danger clsReplyBtn">대댓글입력</button>
			           </div>
			       </div>
			   </div>
			</c:forEach>
			</div>
     	<!-- 댓글 페이징 영역 추가 -->
		    <div class="card-footer clearfix" id="replyPagingArea">
		        
		    </div>
		</div>
     	<!-- ///댓글 목록 영역 끝 /// -->
     </div>    
     <!-- /// 댓글 카드 끝 /// -->
     </section>
     
     <!-- 댓글 수정 모달 -->
     <div class="modal fade" id="modalReplyUpdate">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">댓글수정</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="modalReplyBody">
            <input type="hidden" id="modalIdx" />
            <input type="text" class="form-control form-control-sm" id="modalReplyContent" />
        </p>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="btnModalUpdate" class="btn btn-primary">댓글 변경</button>
      </div>
    </div>
  </div>
</div>

     <!-- 신고 모달 -->
     <div class="modal fade" id="modalReport">
         <div class="modal-dialog">
             <div class="modal-content">
                 <div class="modal-header">
				    <h4 class="modal-title">댓글 신고</h4>
				    <button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
                 <div class="modal-body">
                     <input type="text" id="reportIdx" name="bodNo" />
                     <div class="form-group">
                         <label for="repReason">신고 사유</label>
                         <select class="form-control" id="repReason" name="repReason">
                             <option value="">선택하세요</option>
                             <option value="욕설/비방">욕설/비방</option>
                             <option value="광고/스팸">광고/스팸</option>
                             <option value="불법정보">불법정보</option>
                             <option value="음란성">음란성</option>
                             <option value="기타">기타</option>
                         </select>
                     </div>
                     <div class="form-group">
                         <label for="repCont">상세내용</label>
                         <textarea class="form-control" id="repCont" name="repCont" 
                             rows="3" placeholder="상세 내용을 입력해주세요"></textarea>
                     </div>
                 </div>
                 <div class="modal-footer">
				    <button type="button" id="btnReport" class="btn btn-danger">신고하기</button>
				    <button type="button" id="btnCancel" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
             </div>
         </div>
     </div>
     
 <!-- ///// footer 시작 ///// -->
 <jsp:include page="../include/footer.jsp"></jsp:include>
 <!-- ///// footer 끝 ///// -->
<script type="text/javascript">
//   CKEDITOR.replace("bodCont");
</script>
<!-- jQuery -->
<script type="text/javascript" src="/js/jquery.min.js"></script>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- CKEditor -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
//신고 처리 함수 (게시글)
function reportPost(bodNo){
	$("#reportIdx").val("0");
}

function nvl(expr1, expr2) {
    if (expr1 === undefined || expr1 == null || expr1 == "") {
        expr1 = expr2;
    }
    return expr1;
}
	//페이징 데이터를 포함한 댓글 목록 조회
	function getReList(currentPage, bodNo) {
	    let data = {
	    		"currentPage": nvl(currentPage, "1"),
	    		"keyword": "", 
	    	    "bodNo": bodNo
	    };
	    
			console.log("요청 데이터:", data);
	    
		    $.ajax({
		        url: "/board/detailAjax",
		        contentType: "application/json;charset=utf-8",
		        data: JSON.stringify(data),
		        type: "post",
		        dataType: "json",
		        success: function(articlePage) {
		        	console.log("응답 데이터:", articlePage);
		
		            let str = "";
		            articlePage.content.forEach(reply => {
		                str += '<div class="post clearfix" style="margin-left:' + (reply.bodLvl * 50) + 'px;" data-lvl="' + reply.bodLvl + '">' +
		                    '<div class="user-block">' +
		                        '<img class="img-circle img-bordered-sm" src="/resources/images/default-profile.png" alt="User Image">' +
		                        '<span class="username">' +
		                            '<a href="#">' + (reply.bodReWriter || '익명') + '</a>' +
		                        '</span>' +
		                        '<span class="description">' + reply.bodReDate + '</span>' +
		                    '</div>' +
		                    '<p>' +
		                    '<span id="spanReplyContent' + reply.bodIdx + '">';
		                
		                // 대댓글인 경우
		                if(reply.bodLvl > 1) {
		                    str += '<span class="text-primary">@' + (reply.bodParentReWriter || '익명') + '</span>' +
		                          '<span class="ml-2">' + reply.bodReCont + '</span>';
		                } else {
		                    str += reply.bodReCont;
		                }
		                
		                str += '</span>' +
		                    '<span class="spnReplyUpdate" data-bod-idx="' + reply.bodIdx + '" data-content="' + reply.bodReCont + '" data-toggle="modal" data-target="#modalReplyUpdate" style="cursor:pointer;">' +
		                        '<i class="fas fa-edit"></i>' +
		                    '</span>' +
		                    '<span class="spnReplyDelete" data-bod-idx="' + reply.bodIdx + '" style="cursor:pointer; margin-left: 5px; color: #007bff;">' +
		                        '<i class="fas fa-trash"></i>' +
		                    '</span>' +
		                    '<span class="spnReplyReport" data-bod-idx="' + reply.bodIdx + '" data-toggle="modal" data-target="#modalReport" style="cursor:pointer; margin-left: 5px; color: #dc3545;">' +
		                        '<i class="fas fa-exclamation-circle"></i>' +
		                    '</span>' +
		                    '</p>' +
		                    '<div class="input-group input-group-sm mb-0">' +
		                        '<input type="text" id="txt' + reply.bodIdx + '" class="form-control form-control-sm" placeholder="대댓글 입력">' +
		                        '<div class="input-group-append">' +
		                            '<button type="button" data-parent-idx="' + reply.bodIdx + '" class="btn btn-danger clsReplyBtn">대댓글입력</button>' +
		                        '</div>' +
		                    '</div>' +
		                '</div>';
		            });
		
		            $("#replyList").html(str);
		            console.log("페이징 영역:", articlePage.pagingArea);
		            $("#replyPagingArea").html(articlePage.pagingArea);
		        }
		    });
		}
		
		$(function(){
		    // 초기 페이지 로드 시 첫 페이지의 댓글 목록을 가져옴
		    const bodNo = "${boardVO.bodNo}";  // 현재 게시글 번호
		    getReList("1", bodNo);
		    
		    // 페이징 영역 클릭 이벤트 처리
		    $(document).on("click", ".clsPagingArea", function(){
		    	let currentPage = $(this).data("currentPage");
		        
		        console.log("페이지 클릭 처리->currentPage : " + currentPage);
		        console.log("게시글 번호->bodNo : " + bodNo);
		        
		        getReList(currentPage, bodNo);
		    });
		
		});
	




//신고 처리 함수 (댓글)
function handleReport(data) {
	console.log("handleReport->data : ", data);
	/*
	   data{"bodNo": "4","bodIdx": "19","repType": 2,"repCont": "ㅁㅁㅁ","repReason": "욕설/비방"}
   */
    if(!$("#repReason").val()) {
        alert("신고 사유를 선택해주세요.");
        return false;
    }
    
    $.ajax({
        url: "/board/reportReplyPost",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        success: function(result){
            if(result > 0) {
                alert("신고가 접수되었습니다.");
                $("#btnCancel").click();
                $("#repReason").val("");
                $("#repCont").val("");
            }
        }
    });
}

$(function(){
	
	   //댓글/대댓글 삭제
	   $(document).on("click",".spnReplyDelete",function(){
	       let bodIdx = $(this).data("bodIdx");
	       console.log("bodIdx : " + bodIdx);
	       
	       if(confirm("댓글을 삭제하시겠습니까?")) {
	           let data = {"bodIdx":bodIdx};
	           console.log("data : ", data);
	           
	           fetch(`/board/updatePostAjax/\${bodIdx}`,{
	               method:"PUT",
	               headers:{"Content-Type":"application/json"},
	               body:JSON.stringify(data)
	           })
	           .then(()=>{
	               var Toast = Swal.mixin({
	                   toast: true,
	                   position: 'top-end',
	                   showConfirmButton: false,
	                   timer: 3000
	               });
	               
	               Toast.fire({
	                   icon:'success',
	                   title:'삭제 성공!'
	               });
	               
	               $(this).closest(".post").remove();
	           });
	       }
	   });
	   
	   //댓글/대댓글 수정
	   $(document).on("click",".spnReplyUpdate",function(){
		    let bodIdx = $(this).data("bodIdx");
		    let bodReCont = $(this).data("content");
		    
		    $("#modalIdx").val(bodIdx);
		    $("#modalReplyContent").val(bodReCont);
		});
	   
	   // 댓글 수정 실행
	   $("#btnModalUpdate").on("click",function(){
	       let bodIdx = $("#modalIdx").val();
	       let bodReCont = $("#modalReplyContent").val();
	       
	       // 댓글 수정 
	       if(!bodReCont.trim()) {
	           alert("댓글 내용을 입력해주세요.");
	           $("#modalReplyContent").focus();
	           return;
	       }
	       
	       let data = {
	           "bodIdx":bodIdx,
	           "bodReCont":bodReCont
	       };
	       console.log("data : ", data);
	       
	       $.ajax({
	           url:"/board/updateReplyPostAjax",
	           contentType:"application/json;charset=utf-8",
	           data:JSON.stringify(data),
	           type:"post",
	           dataType:"json",
	           success:function(result){
	               console.log("result : ", result);
	               $("#spanReplyContent"+bodIdx).html(result.bodReCont);
	               $("#modalReplyUpdate").modal("hide");
	           }
	       });
	   });
	   
	 //대댓글 작성
	   $(document).on("click", ".clsReplyBtn", function(){
	       let parentIdx = $(this).data("parent-idx");
	       let txtInput = $("#txt" + parentIdx);
	       let content = txtInput.val();
	       let bodNo = "${boardVO.bodNo}";
	       
	       if(!content) {
	           alert("대댓글 내용을 입력해주세요.");
	           return;
	       }
	       
	       let data = {
	           bodNo: bodNo,                    
	           bodReCont: content,              
	           bodParentIdx: parentIdx,        
	           bodReWriter: "${boardVO.bodWriter}" 
	       };
	       
	       console.log("전송할 데이터:", data);
	       
	       $.ajax({
	           url: "/board/createReplyPostAjax",
	           contentType: "application/json;charset=utf-8",
	           data: JSON.stringify(data),
	           type: "post",
	           success: function(result){
	               if(result > 0) {
	                   alert("대댓글이 등록되었습니다.");
	                   
	               }
	           }
	       });
	   });
	 
	 //게시글 수정 모드
	   $("#edit").on("click",function(){
	       $("#div1").css("display","none");
	       $("#div2").css("display","block");
	       $(".form-control").removeAttr("readonly");
// 	       CKEDITOR.instances['bodCont'].setReadOnly(false);
	       $("#boardfrm").attr("action","/board/updatePost");
	       $("#bodWriter").prop("readonly", true);
	   });
	   
	   //게시글 삭제
	   $("#delete").on("click",function(){
	       $("#boardFrm").attr("action","/board/deletePost");
	       
	       let result = confirm("삭제하시겠습니까?");
	       
	       if(result>0){
	           $("#boardFrm").submit();
	       }else{
	           alert("삭제가 취소되었습니다.");
	       }
	   });
	   
	   //1. 댓글/대댓글 신고
	   /*
	   <span class="spnReplyReport" data-bod-idx="17" data-writer="늪고래" data-content="123" 
	   	data-toggle="modal" data-target="#modalReport" <- 이 자체로 모달이 show
	   	style="cursor:pointer; margin-left: 5px; color: #dc3545;">
           <i class="fas fa-exclamation-circle"></i>
       </span>
	   */
	   $(document).on("click", ".spnReplyReport", function(){
		   let bodIdx = $(this).data("bod-idx");
		   
		   console.log("bodIdx before:", bodIdx);
		   
		   //2. text에 내용이 들어감
	       $("#reportIdx").val(bodIdx);
	   });
	   
	   //3. 단독으로 구성하자
	   $("#btnReport").on("click", function(){
		   //4. text에 들어가있는 값을 꺼냄
		   let bodNo = $("input[name='bodNo']").val();	//게시판번호
		   let bodIdx = $("#reportIdx").val();	//게시판댓글번호
		   let repCont = $("#repCont").val();	//신고내용
		   let repReason = $("#repReason").val();//신고 사유
		   let repType;
		   
		   //repType : 1과 2
		   if(bodIdx=="0"){
			   repType = "1";
		   }else{
			   repType = "2";
		   }
		   
		   // 2 : 댓글 신고
           let data = {
               "bodNo":bodNo,
               "bodIdx":bodIdx,
               "repType":repType,
               "repCont":repCont,
               "repReason":repReason
           };
           
		   /*
		   data{"bodNo": "4","bodIdx": "19","repType": 2,"repCont": "ㅁㅁㅁ","repReason": "욕설/비방"}
		   */
           console.log("전송할 data:", data);  // 이 줄 추가
           
           //bodIdx type: string
           console.log("bodIdx type:", typeof bodIdx);  // 이 줄도 추가
           
           handleReport(data);
       });
	   
});//end 달러function
	   
	   

    
	
</script>

</html>