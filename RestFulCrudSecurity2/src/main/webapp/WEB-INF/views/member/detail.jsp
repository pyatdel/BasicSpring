<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
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
    
    <div class="card card-primary">
        <div class="card-header">
          <h3 class="card-title">회원 상세</h3>
        </div>
        <!-- /.card-header -->
        <!-- form start 
        model.addAttribute("memberVO", memberVO);
        -->
        <form id="frm" action="/member/updatePost" method="post">
          <div class="card-body">
            <div class="form-group">
              <label for="memId">회원 아이디</label>
              <input type="text" class="form-control" id="memId" 
              		name="memId" value="${memberVO.memId}" 
              		readonly placeholder="회원 아이디" />
            </div>
            <div class="form-group">
              <label for="memPass">비밀번호</label>
              <input type="text" class="form-control" id="memPass" 
              		name="memPass" value="${memberVO.memPass}" 
              		readonly placeholder="비밀번호" />
            </div>
            <div class="form-group">
              <label for="memName">성명</label>
              <input type="text" class="form-control" id="memName" 
              		name="memName" value="${memberVO.memName}" 
              		readonly placeholder="성명" />
            </div>
            <div class="form-group">
              <label for="memZip">우편번호</label>
              <input type="text" class="form-control col-md-5" id="memZip" 
              		name="memZip" value="${memberVO.memZip}" 
              		readonly placeholder="우편번호" />
              <button type="button" id="btnPost" 
              		class="btn btn-block btn-info col-md-2"
              		disabled>우편번호검색</button>
            </div>
            <div class="form-group">
              <label for="memAdd1">주소1</label>
              <input type="text" class="form-control" id="memAdd1" 
              		name="memAdd1" value="${memberVO.memAdd1}" 
              		readonly placeholder="주소1" />
            </div>
            <div class="form-group">
              <label for="memAdd2">주소2</label>
              <input type="text" class="form-control" id="memAdd2" 
              		name="memAdd2" value="${memberVO.memAdd2}" 
              		readonly placeholder="주소2" />
            </div>
            <!-- memberVO 객체 안에 fileGroupVO가 있을 때 -->
            <c:if test="${memberVO.fileGroupVO!=null}">
	            <div class="form-group">
	            	<!-- model.addAttribute("memberVO", memberVO) 
	            	memberVO.fileGroupVO.fileDetailVOList : List<FileDetailVO>
	            	-->
	            	<div class="row mb-3">
		            	  <c:forEach var="fileDetailVO" items="${memberVO.fileGroupVO.fileDetailVOList}" varStatus="stat">
		            	  	  <c:choose>
		            	  	  	  <c:when test="${fileDetailVO.fileSn==1}">
					            	  <!-- 왼쪽 영역 시작 FileDetailVO(fileSn=1 -->
					                    <div class="col-sm-6" style="justify-content:between;display:flex;">
					                    	<div><img class="img-fluid imgFileSaveLocate" style="cursor:pointer;" 
					                    		data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
					                    						  src="${fileDetailVO.fileSaveLocate}" 
					                    						  alt="${fileDetailVO.fileOriginalName}" title="${fileDetailVO.fileOriginalName}" /></div>
					                    	<div class="divModalImg"
					                    	 data-file-original-name="${fileDetailVO.fileOriginalName}"
					                    	 data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
					                    	 style="cursor:pointer;" data-toggle="modal" data-target="#modalImgShow">
					                    		<i class="fas fa-book mr-1"></i>
					                    	</div>
					                    </div>
					                  <!-- 왼쪽 영역 끝 -->
				                  </c:when>
				                  <c:when test="${fileDetailVO.fileSn==2}">
				                  	<div class="col-sm-6">
				                  		<div><img class="img-fluid col-sm-4 mb-3 imgFileSaveLocate" style="float:left;cursor:pointer;" 
				                          data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
				                          				  src="${fileDetailVO.fileSaveLocate}" 
				                          				  alt="${fileDetailVO.fileOriginalName}" title="${fileDetailVO.fileOriginalName}"  /></div>
				                        <div class="divModalImg" 
				                        	 data-file-original-name="${fileDetailVO.fileOriginalName}"
					                    	 data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
				                        	style="margin-right:5px;cursor:pointer;" data-toggle="modal" data-target="#modalImgShow">
				                        	<i class="fas fa-book mr-1"></i>
				                        </div>
				                  </c:when>
				                  <c:when test="${fileDetailVO.fileSn!=1}">
					                  <!-- 오른쪽 영역 시작 FileDetailVO(fileSn=2, FileDetailVO(fileSn=3.. -->
				                        <div><img class="img-fluid col-sm-4 mb-3 imgFileSaveLocate" style="float:left;cursor:pointer;" 
				                          data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
				                          				  src="${fileDetailVO.fileSaveLocate}" 
				                          				  alt="${fileDetailVO.fileOriginalName}" title="${fileDetailVO.fileOriginalName}"  /></div>
				                        <div class="divModalImg" 
				                        	 data-file-original-name="${fileDetailVO.fileOriginalName}"
					                    	 data-file-save-locate="${fileDetailVO.fileSaveLocate}" 
				                        	style="margin-right:5px;cursor:pointer;" data-toggle="modal" data-target="#modalImgShow">
				                        	<i class="fas fa-book mr-1"></i>
				                        </div>
					                  <!-- 오른쪽 영역 끝 -->
				                  </c:when>
			                  </c:choose>
		                  </c:forEach>
	                  	</div>
	                </div>
	                <!-- end row -->
	            </div>
            </c:if>
          </div>
          <!-- /.card-body -->

          <div class="card-footer">
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
		          <a href="/member/list" class="btn btn-success btn-user">
		              	목록
		          </a>
		         </p>
	        </span>
	        <!-- 일반모드 끝 -->
	        <!-- 수정모드 시작 -->
	        <span id="spn2" class="justify-between" style="display:none;">
	         <span style="float:left;">
		         <button type="submit" class="btn btn-primary btn-user">
		             	확인
		         </button>
	         </span>
	         <span style="float:right;">
		         <a href="/member/detail?memId=${param.memId}" 
		         	class="btn btn-success btn-user">
		             	취소
		         </a>
	         </span>
	        </span>
	        <!-- 수정모드 끝 -->
          </div>
        </form>
      </div>
      <hr />
      <!-- /// 댓글 카드 시작 /// -->
      <div class="card">
      	<!-- ///댓글 등록 영역 시작 /// -->
      	<div class="card-header">
      		<!-- 
      		요청URI : /member/createReplyPost
      		요청파라미터 : request{memId=u001,replyContent=댓글내용}
      		요청방식 : post
      		 -->
      		<form id="frm" class="form-horizontal" 
      			action="/member/createReplyPost" method="post">
      		  <input type="text" name="memId" value="${memberVO.memId}" />
              <div class="input-group input-group-sm mb-0">                
                <input type="text" id="replyContent" name="replyContent"  
                    class="form-control form-control-sm" 
                	placeholder="댓글내용"
                	required />
                <div class="input-group-append">
                  <button type="submit" class="btn btn-danger">댓글등록</button>
                </div>
              </div>
            </form>
      	</div>
      	<!-- ///댓글 등록 영역 끝 /// -->
      	<!-- ///댓글 목록 영역 시작 /// -->
      	<div class="card-body">
      		<!-- 
      		model.addAttribute("memberReplyVOList", memberReplyVOList);
      		 -->
      		 <sec:authorize access="isAuthenticated()">
      		 	<sec:authentication property="principal.member" var="memberVO" />
      		 </sec:authorize>
      		<c:forEach var="memberReplyVO" items="${memberReplyVOList}">
	      		<div class="post clearfix" style="margin-left:${memberReplyVO.lvl * 50}px;">
	              <div class="user-block">
	                <img class="img-circle img-bordered-sm" src="${memberReplyVO.fileSaveLocate}" alt="User Image">
	                <span class="username">
	                  <a href="#">${memberReplyVO.memName}</a>
	                  <a href="#" class="float-right btn-tool"><i class="fas fa-times"></i></a>
	                </span>
	                <span class="description">Sent you a message - 
	                	<fmt:formatDate value="${memberReplyVO.replyRegdate}" pattern="yyyy-MM-dd" /> 
	                </span>
	              </div>
	              <!-- /.user-block -->
	              <p>
	                <span id="spanReplyContent${memberReplyVO.idx}">
	                ${memberReplyVO.replyContent}
	                <br /> 글 작성 아이디 : ${memberReplyVO.userId}
	                <!-- JAVA변수/객체/컬렉션->JSTL변수에 담을 수 있음->JSTL변수는 EL로 다룰 수 있음 -->
	                <br />로그인 한 아이디 : ${memberVO.memId}
	                </span>
	                <!-- /// 로그인 시 수정/삭제 아이콘이 보이도록 함 시작 /// -->
	                <sec:authorize access="isAuthenticated()">
	                <!-- 글 작성자와 로그인한 회원이 같을 때만 수정 / 삭제 아이콘이 보이게 함 -->
	                <c:if test="${memberReplyVO.userId==memberVO.memId}">
		              	<span class="spnReplyUpdate" data-reply-content="${memberReplyVO.replyContent}" 
		              		data-idx="${memberReplyVO.idx}" data-toggle="modal" 
		              		data-target="#modalReplyUpdate"
		              		style="cursor:pointer;"><i class="far fa-file-alt mr-1"></i></span>
		              	<span class="spnReplyDelete" 
		              		data-idx="${memberReplyVO.idx}" style="cursor:pointer;" 
		              	><i class="fas fa-trash-alt"></i></span>
		              	</c:if>
	              	</sec:authorize>
	              	<!-- /// 로그인 시 수정/삭제 아이콘이 보이도록 함 끝 /// -->
	              </p>
	
	                <div class="input-group input-group-sm mb-0">
	                  <input type="text" id="txt${memberReplyVO.idx}" 
	                  	class="form-control form-control-sm" placeholder="대댓글 입력" />
	                  <div class="input-group-append">
	                    <!-- request{memId=u001,parentIdx=8,replyContent=대댓글내용} 
	                    parentIdx : 부모글의 idx
	                    -->
	                    <button type="button" data-mem-id="${memberVO.memId}" 
	                    	data-parent-idx="${memberReplyVO.idx}"  
	                    class="btn btn-danger clsReplyBtn">대댓글입력</button>
	                  </div>
	                </div>
	            </div>
            </c:forEach>
      	</div>
      	<!-- ///댓글 목록 영역 끝 /// -->
      </div>    
      <!-- /// 댓글 카드 끝 /// -->
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>


<div class="modal fade" id="modalImgShow">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="modalImgName"></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="modalImgBody"></p>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<div class="modal fade" id="modalReplyUpdate">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">댓글보기</h4>
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
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- /.content -->

<script type="text/javascript">
$(function(){
	//댓글 삭제
	$(document).on("click",".spnReplyDelete",function(){
		//data-idx
		let idx = $(this).data("idx");
		console.log("idx : " + idx);
		
		let data = {
			"idx":idx
		}
		console.log("data : ", data);
		
		//1. MEMBER_REPLY 테이블의 REPLY_STATUS 컬럼의 값을 0으로 update
		/*
		fetch() 메서드를 통해 수정 API로 /member/updatePostAjax/9 요청 URI을 PUT 요청 방식으로 요청함.
			요청을 보낼 때 headers에 요청 형식을 지정하고, body에 HTML에 입력한 데이터를 JSON 형식으로
			바꿔 보냄. 요청이 완료되면 then() 메서드로 마무리 작업을 함
			
		요청URI : /member/updatePostAjax/9
		경로변수 : idx
		요청파라미터 : JSONstring{"idx":9}
		요청방식 : PUT
		*/
		fetch(`/member/updatePostAjax/\${idx}`,{
			method:"PUT",
			headers:{
				"Content-Type":"application/json",
			},
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
			
			//2. <div class="post clearfix".. 엘리먼트 remove()
			$(this).parent().parent().remove();
		});
		
	});
	
	//댓글 수정
	$(document).on("click",".spnReplyUpdate",function(){
		//data-reply-content
// 		let replyContent = $(this).data("replyContent");
		let replyContent = $(this).prev().html();
		//data-idx
		let idx = $(this).data("idx");
		
		//JSON Object
		let data = {
			"replyContent":replyContent,
			"idx":idx
		}
		//data{"replyContent":"네네","idx":9}
		console.log("data : ", data);
		
		//<span id="spanReplyContent10">ㄴㅇㅁㄹ22355</span>
		// => 
		//data-reply-content="ㄴㅇㅁㄹ22355"
		
		
		//모달 영역의 텍스트 엘리먼트의 값으로 내용을 미리 등록해줌
		$("#modalIdx").val(idx);
		$("#modalReplyContent").val(replyContent);
		
	});
	
	//댓글 수정 실행
	$("#btnModalUpdate").on("click",function(){
		let idx = $("#modalIdx").val();
		let replyContent = $("#modalReplyContent").val();
		
		let data = {
			"idx":idx,
			"replyContent":replyContent
		};
		//data{"idx":9,"replyContent":"네네"}
		console.log("data : ", data);
		
		/*
		요청URI : /member/updateReplyPostAjax
		요청파라미터 : JSONstring{"replyContent":"네네","idx":9}
		요청방식 : post
		*/
		//1.JSON.stringify(data) -> 골뱅이RequestBody
		$.ajax({
			url:"/member/updateReplyPostAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			success:function(result){
				//result : MemberReplyVO
				console.log("result : ", result);
				
				//수정된 내용으로 처리
				$("#spanReplyContent"+idx).html(result.replyContent);
				//모달 닫기
				$("#modalReplyUpdate").modal("hide");
			}
		});
		
		//2.data				-> x
// 		$.ajax({
// 			url:"/member/updateReplyPostAjax",
// 			data:data,
// 			type:"post",
// 			success:function(result){
// 				console.log("result : ", result);
// 			}
// 		});
	});
	
	//대댓글 입력
	$(document).on("click",".clsReplyBtn",function(){
		//data-mem-id="u001"
		let memId = $(this).data("memId");
		//data-parent-idx="7"
		let parentIdx = $(this).data("parentIdx");
		//<input type="text" id="txt7"..
		let replyContent = $("#txt"+parentIdx).val();
		
		//request{memId=u001,parentIdx=8,replyContent=대댓글내용}
		//JSON Object
		let data = {
			"memId":memId,
			"parentIdx":parentIdx,
			"replyContent":replyContent
		};
		console.log("data : ", data);
		
		//아작나써유..(피씨)다타써
		$.ajax({
			url:"/member/createReplyPostAjax",
			data:data,
			type:"post",
			success:function(result){
				console.log("result : ", result);
				
				location.href="/member/detail?memId="+memId;
			}
		});
	});
	
	//이미지 크게 보기
	$(document).on("click",".divModalImg",function(){
		//data-file-original-name
		//data-file-save-locate
		let fileOriginalName = $(this).data("fileOriginalName");
		let fileSaveLocation = $(this).data("fileSaveLocate");
		
		console.log("fileOriginalName : " + fileOriginalName);
		console.log("fileSaveLocation : " + fileSaveLocation);
		
		//모달에 반영
		$("#modalImgName").html(fileOriginalName);
		
		//fileSaveLocation : 웹경로(/resources/upload/2024...jpg)
		let str = "<img src='"+fileSaveLocation+"' style='width:100%;' />";
		$("#modalImgBody").html(str);
	});
	
	//파일 다운로드
	/*
	<img class="img-fluid imgFileSaveLocate" 
		data-file-save-locate="/resources/upload/2024/12/02/9c16c1b5-1123-4697-afd4-7869d264d54e_NorthKorea.jpg" 
		src="/resources/upload/2024/12/02/9c16c1b5-1123-4697-afd4-7869d264d54e_NorthKorea.jpg" alt="Photo">
	*/
	$(document).on("click",".imgFileSaveLocate",function(){
		//imgFileSaveLocate 클래스 속성을 갖고있는 요소들이 많은데 그 중 클릭한 바로 그 엘리먼트
		let fileSaveLocate = $(this).data("fileSaveLocate");// /resources/upload...
		console.log("fileSaveLocate : " + fileSaveLocate);
		
		location.href="/download?fileName="+fileSaveLocate;
		
		return;
	});
	
	//회원 삭제
	$("#delete").on("click",function(){
		//DELETE FROM MEMBER WHERE MEM_ID = 'z001';
		//1) MEMBER 테이블의 기본키인 memId값이 필요함
		let memId = $("#memId").val();
	
		//2) JSON Object
		let data = {
			"memId":memId
		};
		
		console.log("data : ", data);
		
		//3) 아작나써유..(피)씨다타써
		/*
		요청URI : /member/deletePostAjax
		요청파라미터 : JSONString{"memId":"a001"}
		요청방식 : delete
		
		리턴 : 1) 1 : 삭제 성공 2) 0 : 삭제 실패
		*/
		$.ajax({
			url:"/member/deletePostAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"delete",
			dataType:"text",
			success:function(result){
				//delete 성공 : 1, delete 실패 : 0
				console.log("result : ", result);
			
				if(result==1){//성공
					var Toast = Swal.mixin({
					      toast: true,
					      position: 'top-end',
					      showConfirmButton: false,
					      timer: 3000
					    });
					
					Toast.fire({
						icon:'success',
						title:'삭제되었습니다'
					});
					
					//4) /member/list로 3초 후에 이동
// 					setTimeout(function(){
// 						location.href="/member/list";
// 					},3000);
					setTimeout(()=>location.href="/member/list",3000);
				}else{//실패
					//5) sweetalert2를 통해 "삭제가 되지 않았습니다"
					//success, error, warning, info, question
					var Toast = Swal.mixin({
					      toast: true,
					      position: 'top-end',
					      showConfirmButton: false,
					      timer: 3000
					    });
					
					Toast.fire({
						icon:'warning',
						title:'삭제가 되지 않았습니다'
					});
				}
			},
			error:function(xhr,status,error){
				//xhr : responseEntity에 담아서 보낸 응답 메시지
				//status : 응답코드
				//error : 오류정보
// 				console.log("xhr : ", xhr);
// 				console.log("status : ", status);
// 				console.log("error : ", error);
				
				var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 3000
				    });
				
				Toast.fire({
					icon:'error',
					title:'오류가 발생했습니다.'
				});
			}
		});//end ajax
	});//end delete
	
	//다음 우편번호 검색
	$("#btnPost").on("click",function(){
		console.log("우편번호 검색!");
		new daum.Postcode({
			//다음 창에서 검색이 완료되어 클릭하면 콜백함수에 의해 
			//	결과 데이터(JSON string)가 data 객체로 들어옴
			oncomplete:function(data){
				//data{"zonecode":"12345","address":"대전 중구","buildingName":"123-67"}
				$("#memZip").val(data.zonecode);
				$("#memAdd1").val(data.address);
				$("#memAdd2").val(data.buildingName);
			}
		}).open();
	});
	
	//수정버튼 클릭 -> 수정모드로 전환
	$("#edit").on("click",function(){
		$("#spn1").css("display","none");
		$("#spn2").css("display","block");
		//입력란 활성화
		$(".form-control").removeAttr("readonly");
		
		$("#frm").attr("action","/member/updatePost");
		$("#frm").attr("method","post");
		
		$("#memId").attr("readonly",true);
		
		//우편번호 검색 활성화
		$("#btnPost").removeAttr("disabled");
	});
});
</script> 


<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


