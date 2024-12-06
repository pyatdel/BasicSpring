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
    <!-- model.addAttribute("boardVOList", boardVOList); -->
<%--     <p>${boardVOList}</p>  --%>
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">게시글 목록</h3>
            <div class="card-tools">
              <div class="input-group input-group-sm" style="width: 150px;">
                <input type="text" name="table_search" class="form-control float-right" placeholder="Search">

                <div class="input-group-append">
                  <button type="submit" class="btn btn-default">
                    <i class="fas fa-search"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
              <thead>
                <tr>
                  <th>순번</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일시</th>
                  <th>조회수</th>
                </tr>
              </thead>
              <tbody>
              	<!-- 
				forEach 태그? 배열(String[], int[][]), Collection(List, Set) 또는 
				Map(HashTable, HashMap, SortedMap)에 저장되어 있는 값들을 
				순차적으로 처리할 때 사용함. 자바의 for, do~while을 대신해서 사용함
				var : 변수
				items : 아이템(배열, Collection, Map)
				varStatus : 루프 정보를 담은 객체 활용
					- index : 루프 실행 시 현재 인덱스(0부터 시작)
					- count : 실행 회수(1부터 시작. 보통 행번호 출력)
				BoardVO(rnum=3, boNo=3, boTitle=제목3, boWriter=작성자3, 
					boContent=내용3, boDate=24/11/12, boHit=0)
					
				model.addAttribute("articlePage",..
				articlePage.content => List<BoardeVO>
				 -->
                <c:forEach var="boardVO" items="${articlePage.content}" varStatus="stat">
	                <tr>
	                  <td>${boardVO.rnum}</td>
	                  <td><a href="/board/detail/${boardVO.boNo}">${boardVO.boTitle}</a></td>
	                  <td>${boardVO.boWriter}</td>
	                  <td>${boardVO.boDate}</td>
	                  <td>${boardVO.boHit}</td>
	                </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <!-- /.card-body -->
        </div>
        <div class="justify-content-between">
       		<div class="float-left">
       			<a href="/board/form" class="btn btn-sm btn-primary">새글등록</a>
       		</div>
       	</div>
        <!-- ///페이징 시작 /// -->
        <!-- EL태그 정리 
			== : eq(equal)
			!= : ne(not equal)
			<  : lt(less than)
			>  : gt(greater than)
			<= : le(less equal)
			>= : ge(greater equal)
		 -->
        <div class="row">
        	<div class="col-sm-12 col-md-5">
        		<div class="dataTables_info" id="example2_info" role="status" aria-live="polite">Showing 1 to 10 of 57 entries</div>
        	</div>
        	<div class="col-sm-12 col-md-7">
        		<div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
        			<ul class="pagination">
        				<li class="paginate_button page-item previous
        					<c:if test='${articlePage.startPage lt 6}'>disabled</c:if>
        				" id="example2_previous"><a href="/board/list?keyword=&currentPage=${articlePage.startPage-5}" aria-controls="example2" data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
        				<c:forEach var="pNo" begin="${articlePage.startPage}" 
        					end="${articlePage.endPage}">
        					<li class="paginate_button page-item"><a href="/board/list?keyword=&currentPage=${pNo}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a></li>
        				</c:forEach>
        				<li class="paginate_button page-item next
        					<c:if test='${articlePage.endPage ge articlePage.totalPages}'>disabled</c:if>
        				" id="example2_next"><a href="/board/list?keyword=&currentPage=${articlePage.startPage+5}" aria-controls="example2" data-dt-idx="7" tabindex="0" class="page-link">Next</a></li>
        			</ul>
        		</div>
        	</div>
        </div>
        <!-- ///페이징 끝 /// -->
        <!-- /.card -->
      </div>
    </div>   
    <!-- ///// content 끝 ///// -->
  </div><!-- /.container-fluid -->
</section>
<!-- /.content -->
    
<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  


