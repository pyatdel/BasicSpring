<%@ page language="java" contentType="text/html; charset=UTF-8"%>
 <%@ page import="java.util.*" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
.boardSub {
display: block !important;
height: auto !important;
}
</style> 
 
 <!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
 <sec:authentication property="principal" var="user"/>
 
 <!-- AdminLTE CSS -->
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminlte/dist/css/adminlte.min.css" />
 
 <%@ include file="../include/header.jsp" %>
 <!-- content 시작 -->
 <div class="card">
     <!-- 게시물 헤더 -->
     <div class="card-header">
         <div class="d-flex justify-content-between align-items-center">
             <div>
			    <h3 class="card-title">[${boardVO.boardTypeVO.bodTypeName} 게시판] ${boardVO.bodTitle}</h3>
			</div>
             <div>
                 <button type="button" class="btn btn-danger" 
                     data-toggle="modal" 
                     data-target="#modalReport"
                     onclick="reportPost('${boardVO.bodNo}')">
                     <i class="fas fa-exclamation-circle"></i> 게시글 신고
                 </button>
                 <div class="btn-group ml-2">
                     <button type="button" class="btn btn-tool dropdown-toggle" data-toggle="dropdown">
                         <i class="fas fa-ellipsis-v"></i>
                     </button>
                     <div class="dropdown-menu dropdown-menu-right">
                         <a class="dropdown-item" href="#" id="editDropdown">수정</a>
 						<a class="dropdown-item text-danger" href="#" id="deleteDropdown">삭제</a>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 
     <!-- 게시물 정보 -->
     <div class="card-header bg-light py-2">
         <div class="d-flex justify-content-between align-items-center">
             <div>
                 <span class="text-muted mr-2">작성자: ${boardVO.bodWriter}</span>
                 <span class="text-muted">
                     작성일: <fmt:formatDate value="${boardVO.bodCreDate}" pattern="yyyy-MM-dd HH:mm"/>
                 </span>
                 <c:if test="${boardVO.bodCreDate != boardVO.bodCreDate}">
                     <span class="text-muted ml-2">
                         수정일: <fmt:formatDate value="${boardVO.bodModiDate}" pattern="yyyy-MM-dd HH:mm"/>
                     </span>
                 </c:if>
             </div>
             <div>
                 <span class="text-muted">
                     <i class="far fa-eye"></i> ${boardVO.bodHit}
                 </span>
             </div>
         </div>
     </div>
 
     <!-- 게시물 본문 -->
     <form id="boardFrm" action="/board/updatePost" method="post">
         <input type="hidden" name="bodNo" value="${boardVO.bodNo}" />
         <div class="card-body">
             <div class="post-content mb-4">
                 <textarea class="form-control" id="bodCont" name="bodCont" 
                     rows="10" readonly>${boardVO.bodCont}</textarea>
             </div>
 
             <!-- 첨부파일 -->
             <div class="attachments">
                 <h6 class="font-weight-bold mb-2">
                     <i class="fas fa-paperclip"></i> 첨부파일
                 </h6>
                 <div class="list-group">
                     <c:forEach var="file" items="${attachments}">
                         <div class="list-group-item">
                             <div class="d-flex justify-content-between align-items-center">
                                 <div>
                                     <i class="far fa-file-pdf text-danger mr-2"></i>
                                     <a href="${file.filePath}" target="_blank">
                                         ${file.fileName}
                                     </a>
                                 </div>
                                 <span class="text-muted small">${file.fileSize}</span>
                             </div>
                         </div>
                     </c:forEach>
                 </div>
             </div>
         </div>
 
         <!-- 버튼 영역 -->
 		<div class="card-footer">
 		    <!-- 일반모드 버튼 -->
 		    <div id="div1" class="d-flex justify-content-between">
 		        <div>
 		            <a href="/board/list" class="btn btn-secondary">목록</a>
 		        </div>
 		    </div>
 		    <!-- 수정모드 버튼 -->
 		    <div id="div2" class="d-flex justify-content-end" style="display: none !important;">
 		        <button type="submit" class="btn btn-primary mr-2" style="float: right">확인</button>
 		        <a href="/board/detail/${boardVO.bodNo}" class="btn btn-secondary" style="float: right">취소</a>
 		    </div>
 		</div>
     </form>
 </div>
 
 <!-- 댓글 섹션 -->
 <div class="card mt-4">
     <div class="card-header">
         <h5 class="card-title">
             <i class="far fa-comments"></i> 댓글
         </h5>
     
        <c:choose>
            <c:when test="${boardVO.boardTypeVO.bodTypeNo == 1}">
                <div class="alert alert-secondary mb-0">
                    공지사항에는 댓글을 작성할 수 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <!-- 기존 댓글 작성 폼 -->
                <form id="bodReplyFrm" action="/board/createReplyPost" method="post">
                    <input type="hidden" name="bodNo" value="${boardVO.bodNo}" />
                    <input type="hidden" name="empNo" value="${user.member.empNo}" />
                    <div class="input-group">
                        <input type="text" id="bodReCont" name="bodReCont" 
                            class="form-control" placeholder="댓글을 입력하세요" required />
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-primary">댓글 등록</button>
                        </div>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
     </div>
 
     <!-- 댓글 목록 -->
     <div class="card-body" id="replyList">
         <!-- 댓글 목록이 AJAX로 로드됨 -->
     </div>
 
     <!-- 댓글 페이징 -->
     <div class="card-footer clearfix" id="replyPagingArea">
         <!-- 페이징 영역이 AJAX로 로드됨 -->
     </div>
 </div>
 
 <!-- 댓글 수정 모달 -->
 <div class="modal fade" id="modalReplyUpdate">
     <div class="modal-dialog">
         <div class="modal-content">
             <div class="modal-header">
                 <h4 class="modal-title">댓글 수정</h4>
                 <button type="button" class="close" data-dismiss="modal">&times;</button>
             </div>
             <div class="modal-body">
                 <input type="hidden" id="modalIdx" />
                 <input type="text" class="form-control" id="modalReplyContent" />
             </div>
             <div class="modal-footer">
                 <button type="button" id="btnModalUpdate" class="btn btn-primary">수정</button>
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
             </div>
         </div>
     </div>
 </div>
 
 <!-- 신고 모달 -->
 <div class="modal fade" id="modalReport">
     <div class="modal-dialog">
         <div class="modal-content">
             <div class="modal-header">
                 <h4 class="modal-title">신고하기</h4>
                 <button type="button" class="close" data-dismiss="modal">&times;</button>
             </div>
             <div class="modal-body">
                 <input type="hidden" id="reportIdx" name="bodNo" />
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
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
             </div>
         </div>
     </div>
 </div>
 
 <style>
 .card {
     margin: 20px;
     box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);
 }
 .comment-avatar {
     width: 40px;
     height: 40px;
     background-color: #e9ecef;
     border-radius: 50%;
     display: flex;
     align-items: center;
     justify-content: center;
     font-weight: bold;
     color: #495057;
 }
 .post-content {
     min-height: 200px;
     line-height: 1.6;
 }
 .comment {
     border-bottom: 1px solid #dee2e6;
     padding-bottom: 1rem;
 }
 .comment:last-child {
     border-bottom: none;
 }
 .btn-tool {
     padding: .25rem .5rem;
 }
 .reply-indent {
     margin-left: 40px;
 }
 </style>
 
 <script type="text/javascript">
 function formatDate(dateStr) {
	    if (!dateStr) return "";
	    
	    const date = new Date(dateStr);
	    const year = date.getFullYear();
	    const month = String(date.getMonth() + 1).padStart(2, '0');
	    const day = String(date.getDate()).padStart(2, '0');
	    const hours = String(date.getHours()).padStart(2, '0');
	    const minutes = String(date.getMinutes()).padStart(2, '0');
	    
	    return `${year}-${month}-${day} ${hours}:${minutes}`;
	}
 
 function nvl(expr1, expr2) {
     if (expr1 === undefined || expr1 == null || expr1 == "") {
         expr1 = expr2;
     }
     return expr1;
 }
 
 // 페이징 데이터를 포함한 댓글 목록 조회
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
         	console.log("응답 데이터 전체:", articlePage);
             console.log("댓글 목록:", articlePage.content);
             
             if(articlePage.content) {
                 articlePage.content.forEach(reply => {
                     console.log("개별 댓글:", reply);
                 });
             }
 
             let str = "";
             articlePage.content.forEach(reply => {
                 str += '<div class="post clearfix" style="margin-left:' + (reply.bodLvl * 50) + 'px;" data-lvl="' + reply.bodLvl + '">' +
                     '<div class="user-block">' +
                         '<div class="comment-avatar">' + 
                             (reply.bodReWriter ? reply.bodReWriter.charAt(0) : '?') +
                         '</div>' +
                         '<span class="username">' +
                             '<a href="#">' + (reply.bodReWriter || '익명') + '</a>' +
                         '</span>' +
                         '<span class="description">' + reply.bodReDate + '</span>' +
                     '</div>' +
                     '<p class="mb-0">' +
                     '<span id="spanReplyContent' + reply.bodIdx + '">';
                 
                 // 대댓글인 경우
                 if(reply.bodLvl > 1) {
                     str += '<span class="text-primary">@' + (reply.bodParentReWriter || '익명') + '</span>' +
                           '<span class="ml-2">' + reply.bodReCont + '</span>';
                 } else {
                     str += reply.bodReCont;
                 }
                 
                 str += '</span>' +
                     '<span class="spnReplyUpdate float-right ml-2" data-bod-idx="' + reply.bodIdx + 
                     '" data-content="' + reply.bodReCont + '" data-toggle="modal" data-target="#modalReplyUpdate">' +
                     '수정' +
                     '</span>' +
                     '<span class="spnReplyDelete float-right ml-2" data-bod-idx="' + reply.bodIdx + '">' +
                     '삭제' +
                     '</span>' +
                     '<span class="spnReplyReport float-right" data-bod-idx="' + reply.bodIdx + 
                     '" data-toggle="modal" data-target="#modalReport">' +
                     '신고' +
                     '</span>' +
                     '</p>' +
                     '<div class="input-group input-group-sm mt-2">' +
                         '<input type="text" id="txt' + reply.bodIdx + '" class="form-control form-control-sm" placeholder="대댓글 입력">' +
                         '<div class="input-group-append">' +
                             '<button type="button" data-parent-idx="' + reply.bodIdx + '" class="btn btn-danger clsReplyBtn">대댓글입력</button>' +
                         '</div>' +
                     '</div>' +
                 '</div>';
             });
 
             $("#replyList").html(str);
             $("#replyPagingArea").html(articlePage.pagingArea);
         }
     });
 }
 
 // <script type="text/javascript">
 //   CKEDITOR.replace("bodCont");
 </script>
 
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
 
 //formatDate 함수 
 function formatDate(dateStr) {
     if (!dateStr) return "";
     try {
         const date = new Date(dateStr);
         
         const year = date.getFullYear();
         const month = String(date.getMonth() + 1).padStart(2, '0');
         const day = String(date.getDate()).padStart(2, '0');
         const hours = String(date.getHours()).padStart(2, '0');
         const minutes = String(date.getMinutes()).padStart(2, '0');
         
         return year + "-" + month + "-" + day + " " + hours + ":" + minutes;
     } catch (e) {
         console.error("날짜 변환 중 오류:", e);
         return dateStr;
     }
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
 	                if(articlePage.content && articlePage.content.length > 0) {
 	                    articlePage.content.forEach(reply => {
 	                        // 댓글 HTML 생성
 	                        str += '<div class="post clearfix" style="margin-left:' + (reply.bodLvl * 50) + 'px;">' +
 	                            '<div class="user-block">' +
 	                            '<div class="comment-avatar">' + 
 	                            (reply.bodReWriter ? reply.bodReWriter.charAt(0) : '?') +
 	                            '</div>' +
 	                            '<span class="username">' +
 	                            '<a href="#">' + (reply.bodReWriter || '익명') + '</a>' +
 	                            '</span>' +
 	                            '<span class="description">' + formatDate(reply.bodReDate) + '</span>' +
 	                            '</div>' +
 	                            '<p class="mb-0">' +
 	                            '<span id="spanReplyContent' + reply.bodIdx + '">';
 	                        
 	                        // 대댓글인 경우
 	                        if(reply.bodLvl > 1) {
 	                            str += '<span class="text-primary">@' + (reply.bodParentReWriter || '익명') + '</span>' +
 	                                  '<span class="ml-2">' + reply.bodReCont + '</span>';
 	                        } else {
 	                            str += reply.bodReCont;
 	                        }
 	                        
 	                        str += '</span>' +
 	                            '<span class="spnReplyUpdate float-right ml-2" data-bod-idx="' + reply.bodIdx + 
 	                            '" data-content="' + reply.bodReCont + '" data-toggle="modal" data-target="#modalReplyUpdate">' +
 	                            '<i class="fas fa-edit"></i>' +
 	                            '</span>' +
 	                            '<span class="spnReplyDelete float-right ml-2" data-bod-idx="' + reply.bodIdx + '">' +
 	                            '<i class="fas fa-trash"></i>' +
 	                            '</span>' +
 	                            '<span class="spnReplyReport float-right" data-bod-idx="' + reply.bodIdx + 
 	                            '" data-toggle="modal" data-target="#modalReport">' +
 	                            '<i class="fas fa-exclamation-circle"></i>' +
 	                            '</span>' +
 	                            '</p>' +
 	                            '<div class="input-group input-group-sm mt-2">' +
 	                            '<input type="text" id="txt' + reply.bodIdx + '" class="form-control" placeholder="대댓글 입력">' +
 	                            '<div class="input-group-append">' +
 	                            '<button type="button" data-parent-idx="' + reply.bodIdx + 
 	                            '" class="btn btn-danger clsReplyBtn">대댓글입력</button>' +
 	                            '</div>' +
 	                            '</div>' +
 	                            '</div>';
 	                    });
 	                } else {
 	                    str = '<div class="text-center p-3">등록된 댓글이 없습니다.</div>';
 	                }
 
 	                $("#replyList").html(str);
 	                if(articlePage.pagingArea) {
 	                    $("#replyPagingArea").html(articlePage.pagingArea);
 	                }
 	            },
 	            error: function(xhr, status, error) {
 	                console.error("댓글 로딩 중 에러 발생:", error);
 	                $("#replyList").html('<div class="text-center p-3 text-danger">댓글을 불러오는데 실패했습니다.</div>');
 	            }
 	        });
 	    }
 
 	    $(function(){
	    	
	    	let empNo = "${user.member.empNo}";
	        let bodTypeNo = "${boardVO.boardTypeVO.bodTypeName}";
	        
	        // 공지사항이고 empNo가 3보다 큰 경우(일반 사용자) 수정/삭제 버튼을 숨김
	        if(bodTypeNo === "공지사항" && empNo > 3) {
	            $(".btn-group").hide();  // 수정/삭제 버튼 그룹 전체를 숨김
	        }
	        
	        if(bodTypeNo === "QnA" && empNo > 3) {
	            $(".btn-group").hide();  // 수정/삭제 버튼 그룹 전체를 숨김
	        }
	        
 	        // 초기 페이지 로드 시 첫 페이지의 댓글 목록을 가져옴
 	        const bodNo = "${boardVO.bodNo}";
 	        getReList("1", bodNo);
 	        
 	        // 페이징 영역 클릭 이벤트 처리
 	        $(document).on("click", ".clsPagingArea", function(){
 	            let currentPage = $(this).data("currentPage");
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
             	/*
                 alert("신고가 접수되었습니다.");
                 $("#btnCancel").click();
                 $("#repReason").val("");
                 $("#repCont").val("");
                 */
             	alert("신고가 접수되었습니다.");
                 $("#modalReport button[data-dismiss='modal']").click();
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
 	           
 	           fetch(`/board/deleteReplyPost/\${bodIdx}`,{
 	               method:"POST",
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
 	           bodParentIdx: parentIdx        
 	           /* bodReWriter: "${boardVO.bodWriter}",
 	           empNo: "${user.member.empNo}" */
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
 	                   txtInput.val('');  // 입력창 초기화
 	                   getReList("1", bodNo);
 	                   
 	               }
 	           }
 	       });
 	   });
 	 
 	 //게시글 수정 모드
 	   /* $("#edit").on("click",function(){
 	       $("#div1").css("display","none");
 	       $("#div2").css("display","block");
 	       $(".form-control").removeAttr("readonly");
 // 	       CKEDITOR.instances['bodCont'].setReadOnly(false);
 	       $("#boardFrm").attr("action","/board/updatePost");
 	       $("#bodWriter").prop("readonly", true);
 	   }); */
 	 
 	   $("#editDropdown").on("click",function(){
 	       $("#div1").css("display","none");
 	       $("#div2").css("display","block");
 	       $(".form-control").removeAttr("readonly");
 // 	       CKEDITOR.instances['bodCont'].setReadOnly(false);
 	       $("#boardFrm").attr("action","/board/updatePost");
 	       $("#bodWriter").prop("readonly", true);
 	   });
 	   
 	   
 	   $("#deleteDropdown").on("click",function(){
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
 
  <!-- ///// footer 시작 ///// -->
  <jsp:include page="../include/footer.jsp"></jsp:include>
  <!-- ///// footer 끝 ///// -->