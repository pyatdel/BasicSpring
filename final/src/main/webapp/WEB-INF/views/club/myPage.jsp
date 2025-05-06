<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->


<%@ include file="../include/header.jsp" %>


<title>연차 및 휴가 관리</title>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery, Popper.js, Bootstrap JS  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>

<div class="community-create-wrapper">
   <div class="container-fluid">
       <div class="card panel panel-default">
           <div class="card-body panel-body" style="background-color: #fef7f1; color: black;">
               <div class="d-flex justify-content-between align-items-center clearfix">
                   <div class="float-left pull-left">
                       <h2 class="mb-0">${clubVO.clubName}
                       <c:if test="${memberRole.roleNo == 1 || memberRole.roleNo == 2}"> 
						    <span class="badge badge-primary label label-primary">
						        <c:if test="${clubVO.clubSec == 1}">공개</c:if>
						        <c:if test="${clubVO.clubSec == 2}">비공개</c:if>
						    </span>
						</c:if>
                       </h2>
                   </div>
                   <c:if test="${memberRole.roleNo == 1 || memberRole.roleNo == 2}">
				    <div class="float-right pull-right">
				        <button class="btn btn-outline-secondary btn-lg manage-btn" onclick="location.href='/community/club/manage/${clubVO.clubNo}'" style="background-color: #FFFFFF; color: black;">
				            <i class="fas fa-cog fa-fw"></i> 관리
				        </button>
				    </div>
				</c:if>
               </div>
               <p class="text-muted mt-3">${clubVO.clubDesc}</p>
               <div class="text-muted">
                   <span class="mr-3 mr-15"><i class="fas fa-user fa-fw"></i> 마스터: ${clubVO.employeeVO.empName}</span>
                   <span class="mr-3 mr-15"><i class="fas fa-users fa-fw"></i> 멤버: ${clubVO.nowMember}/${clubVO.maxMember}명</span>
                   <span><i class="fas fa-calendar fa-fw"></i> 개설일: <fmt:formatDate value="${clubVO.clubCreDate}" pattern="yyyy.MM.dd"/></span>
               </div>
           </div>
       </div>

       <div class="row">
		    <div class="col-md-8">
		    <!-- 채팅 섹션 -->
		    <div class="card chat-card" style="background-color: #d9dafc; color: black;">
		        <div class="card-body chat-card-body p-0" style="background-color: #fef7f1; color: black;">
		            <div class="chat-header p-3 border-bottom">
		                <h4 class="card-title mb-0">
		                    <i class="fas fa-comments text-primary"></i> 
		                    이야기방
		                </h4>
		            </div>
		            <div id="id_chatwin" class="chat-messages"></div>
		            <div class="chat-input-container" style="background-color: #fef7f1; color: black;">
		                <div class="input-group">
		                    <input type="text" id="id_message" class="form-control" 
		                        placeholder="메시지를 입력하세요">
		                    <div class="input-group-append">
		                        <button class="btn btn-primary" id="id_send">
		                            <i class="fas fa-paper-plane"></i>
		                        </button>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
        <!-- 게시판 섹션 -->
        <div class="card mb-4">
            <div class="card-body" style="background-color: #fef7f1; color: black;">
                <div class="d-flex justify-content-between mb-3">
                    <h4 class="card-title">게시판</h4>
                </div>
                <div class="board-list">
                    <a href="#" class="list-group-item list-group-item-action active" onclick="location.href='/community/club/${clubVO.clubNo}/free'">
                        <i class="fas fa-comments me-2"></i>
                        자유게시판
                        <span class="badge bg-light text-dark float-end">25</span>
                    </a>
                    <a href="#" class="list-group-item list-group-item-action active" onclick="location.href='/community/club/${clubVO.clubNo}/notice'" style="background-color: #278986; color: white;">
					    <i class="fas fa-bullhorn me-2"></i>
					    공지사항
					    <span class="badge bg-light text-dark float-end">3</span>
					</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="location.href='/community/club/${clubVO.clubNo}/photo'" style="background-color: #d4edeb; color: black;">
                        <i class="fas fa-image me-2"></i>
                        사진게시판
                        <span class="badge badge-secondary float-right">12</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- 자유게시판 섹션  
        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
		    <h4 class="card-title">자유게시판</h4>
		    <button class="btn btn-primary btn-sm" onclick="location.href='/community/club/${clubVO.clubNo}/bForm'">글쓰기</button>
		</div>
                <div class="list-group">
                    <div class="list-group-item list-group-item-warning">
                        <h4 class="list-group-item-heading">${clubVO.clubName}</h4>
                        <p class="list-group-item-text">
                            <small class="text-muted">
                                ${clubVO.communityVO.comWriter} | <fmt:formatDate value="${clubVO.communityVO.comCreDate}" pattern="yyyy.MM.dd"/> |
                                <i class="fas fa-eye"></i> ${clubVO.clubHit} |
                                <i class="fas fa-comment"></i> 0
                            </small>
                        </p>
                    </div>
                </div>
            </div>
        </div> -->
    </div>

    <div class="col-md-4">
        <!-- 멤버 관리 섹션 -->
        <div class="card">
            <div class="card-body" style="background-color: #fef7f1; color: black;">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3 class="mb-0">멤버 목록</h3>
                    <span class="badge badge-primary" data-toggle="tooltip" title="새로운 가입 신청">
                        <i class="fas fa-bell fa-fw"></i> ${fn:length(clubVO.joinRequestList)}
                    </span>
                </div>

                <!-- 탭 네비게이션 -->
                <ul class="nav nav-tabs" id="memberTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="members-tab" data-toggle="tab" href="#members" role="tab">
                            회원 목록 <span class="badge badge-secondary">${clubVO.nowMember}</span>
                        </a>
                    </li>
                    <c:if test="${memberRole.roleNo == 1 || memberRole.roleNo == 2}">
                    <li class="nav-item">
                        <a class="nav-link" id="pending-tab" data-toggle="tab" href="#pending" role="tab">
                            가입 신청 <span class="badge badge-primary">${fn:length(clubVO.joinRequestList)}</span>
                        </a>
                    </li>
                    </c:if>
                </ul>

                <!-- 탭 컨텐츠 -->
                <div class="tab-content mt-3" id="memberTabContent">
                    <!-- 회원 목록 탭 -->
                    <div class="tab-pane fade show active" id="members" role="tabpanel">
                        <!-- 마스터 표시 -->
                        <div class="card bg-light">
                            <div class="card-body">
                                <h4 class="text-muted">마스터 (1)</h4>
                                <div class="media">
                                    <div class="media-left mr-3">
                                        <c:choose>
                                            <c:when test="${not empty clubVO.employeeVO.empProfile}">
                                                <img src="${clubVO.employeeVO.empProfile}" class="rounded-circle" style="width: 32px; height: 32px;">
                                            </c:when>
                                            <c:otherwise>
                                                 <img src="/resources/upload/images/profile-default.png" class="rounded-circle" style="width: 32px; height: 32px;">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="media-body">
                                        <h4 class="media-heading">${clubVO.employeeVO.empName}</h4>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 일반 회원 목록 -->
                        <div class="card bg-light mt-3">
                            <div class="card-body">
                                <h4 class="text-muted">회원 (${fn:length(clubVO.memberList)})</h4>
                                <c:forEach var="member" items="${clubVO.memberList}">
                                    <c:if test="${member.empNo != clubVO.empNo}">
                                        <div class="media mt-3">
                                            <div class="media-left mr-3">
                                                <c:choose>
                                                    <c:when test="${not empty member.employeeVO.empProfile}">
                                                        <img src="${member.employeeVO.empProfile}" class="rounded-circle" style="width: 32px; height: 32px;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/resources/upload/images/profile-default.png" class="rounded-circle" style="width: 32px; height: 32px;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="media-body">
                                                <h4 class="media-heading">
                                                    ${member.employeeVO.empName}
                                                    <small class="text-muted">
                                                        <c:choose>
                                                            <c:when test="${member.memState == 1}">
                                                                <span class="badge badge-success">활동중</span>
                                                            </c:when>
                                                            <c:when test="${member.memState == 2}">
                                                                <span class="badge badge-warning">휴면</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-secondary">탈퇴</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </small>
                                                </h4>
                                                <p class="mb-0">
                                                    가입일: <fmt:formatDate value="${member.joinDate}" pattern="yyyy.MM.dd"/>
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- 가입 신청 목록 탭 -->
                    <div class="tab-pane fade" id="pending" role="tabpanel">
                        <div class="card bg-light">
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty clubVO.joinRequestList}">
                                        <c:forEach var="pending" items="${clubVO.joinRequestList}">
                                            <div class="media mt-3 border-bottom pb-3 pending-item" 
                                                style="cursor: pointer;"
                                                data-req-id="${pending.reqNo}">
                                                <div class="media-left mr-3">
                                                    <img src="${not empty pending.employeeVO.empProfile ? pending.employeeVO.empProfile : '/resources/upload/images/profile-default.png'}" 
                                                        class="rounded-circle" style="width: 32px; height: 32px;">
                                                </div>
                                                <div class="media-body">
                                                    <h4 class="media-heading d-flex justify-content-between">
                                                        ${pending.employeeVO.empName}
                                                        <small class="text-muted">
                                                            신청일: <fmt:formatDate value="${pending.reqDate}" pattern="yyyy.MM.dd"/>
                                                        </small>
                                                    </h4>
                                                    <div class="btn-group" role="group">
                                                        <form action="/community/club/updateRequest" method="post" style="display: inline;">
                                                            <input type="hidden" name="reqNo" value="${pending.reqNo}">
                                                            <input type="hidden" name="reqState" value="2">
                                                            <input type="hidden" name="clubNo" value="${clubVO.clubNo}">
                                                            <input type="hidden" name="empNo" value="${pending.empNo}">
                                                            <button type="submit" class="btn btn-success btn-sm">
                                                                <i class="fas fa-check"></i> 승인
                                                            </button> 
                                                        </form>
                                                        
                                                        <form action="/community/club/updateRequest" method="post" style="display: inline;">
                                                            <input type="hidden" name="reqNo" value="${pending.reqNo}">
                                                            <input type="hidden" name="reqState" value="3">
                                                            <input type="hidden" name="clubNo" value="${clubVO.clubNo}">
                                                            <input type="hidden" name="empNo" value="${pending.empNo}">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                <i class="fas fa-times"></i> 거절
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-muted p-3">
                                            <i class="fas fa-info-circle fa-fw"></i> 새로운 가입 신청이 없습니다.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 가입 버튼 (미가입 회원인 경우만 표시) -->
                <c:if test="${empty memberRole}">
                    <div class="mt-3">
                        <button type="button" class="btn btn-primary btn-lg btn-block" onclick="showJoinModal()">
                            <i class="fas fa-users fa-fw"></i> 가입하기
                        </button>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
		
</div>
</div>
</div>

<!-- 가입신청 모달 -->
		<div class="modal fade" id="joinRequestModal" tabindex="-1" role="dialog" aria-labelledby="joinRequestModalLabel">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="joinRequestModalLabel">동호회 가입신청</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                <div class="form-group">
		                    <label for="reqCont">가입신청 메시지</label>
		                    <textarea id="reqCont" class="form-control" rows="4" placeholder="가입 신청 메시지를 입력해주세요."></textarea>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnModalCancel">취소</button>
		                <button type="button" class="btn btn-primary" onclick="submitJoinRequest()">신청하기</button>
		            </div>
		        </div>
		    </div>
		</div>
	</div>


<!-- 가입신청 상세 모달 -->
<div class="modal fade" id="requestDetailModal" tabindex="-1" role="dialog" aria-labelledby="requestDetailModalLabel" aria-hidden="true">
   <div class="modal-dialog" role="document">
       <div class="modal-content">
           <div class="modal-header">
               <h5 class="modal-title" id="requestDetailModalLabel">가입신청</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                   <span aria-hidden="true">&times;</span>
               </button>
           </div>
           <div class="modal-body">
               <div class="media mb-3">
                   <div class="media-left mr-3">
                       <img id="modalEmpProfile" src="" class="rounded-circle" style="width: 48px; height: 48px;">
                   </div>
                   <div class="media-body">
                       <h4 class="media-heading" id="modalEmpName"></h4>
                       <small class="text-muted">신청일: <span id="modalReqDate"></span></small>
                   </div>
               </div>
               <div class="form-group">
                   <label class="font-weight-bold">신청 메시지</label>
                   <div class="p-3 bg-light rounded" id="modalReqCont" style="white-space: pre-line;"></div>
               </div>
           </div>
           <div class="modal-footer">
               <form action="/community/club/updateRequest" method="post" class="mr-2">
                   <input type="hidden" id="modalReqNo" name="reqNo" value="">
                   <input type="hidden" name="reqState" value="2">
                   <input type="hidden" id="modalClubNo" name="clubNo" value="">
                   <input type="hidden" id="modalEmpNo" name="empNo" value="">
                   <button type="submit" class="btn btn-success">
                       <i class="fas fa-check"></i> 승인
                   </button>
               </form>
               <form action="/community/club/updateRequest" method="post">
				    <input type="hidden" id="modalReqNo2" name="reqNo" value="">
				    <input type="hidden" name="reqState" value="3">
				    <input type="hidden" id="modalClubNo2" name="clubNo" value="">
				    <input type="hidden" id="modalEmpNo2" name="empNo" value="">
				    <button type="submit" class="btn btn-danger">
				        <i class="fas fa-times"></i> 거절
                   </button>
               </form>
           </div>
       </div>
   </div>
   
<style>
.body {
   font-size: 18px;
   line-height: 1.6;
   color: #333;
}

/* 전체 래퍼에 높이 설정 */
.community-create-wrapper {
    min-height: 100vh;
    position: relative;
    overflow: visible;
    
}

/* 컨테이너에도 높이 설정 */
.container-fluid {
    position: relative;
    overflow: visible;
}

/* row 높이 설정 */
.row {
   position: relative;
}

/* 채팅창 컨테이너 설정 */
.col-md-8 {
    height: 100%;
    overflow-y: auto;
    padding-right: 15px;
    padding-left: 15px;
}

/* 채팅창 자체 설정 */
.chat-card {
    position: sticky;
    top: 20px;
    width: 100%;
    height: 600px;
    z-index: 10;
    margin-bottom: 2rem;
    background: white;
    border-radius: 0.5rem;
    box-shadow: 0 2px 4px rgba(0,0,0,.05);
}

/* 타이포그래피 */
h2 { 
   font-size: 36px;
   font-weight: 600;
   margin-bottom: 1rem;
}

h3 { 
   font-size: 28px;
   font-weight: 500;
   margin-bottom: 1rem;
}

h4 {
   font-size: 22px;
   font-weight: 500;
}

h4.media-heading {
   font-size: 20px;
   margin-bottom: 0.5rem;
}

.list-group-item-heading {
   font-size: 20px;
   font-weight: 500;
}

/* 카드/패널 스타일 */
.card, .panel {
   margin-bottom: 2rem;
   background-color: #fff;
   border: 1px solid rgba(0,0,0,.125);
   border-radius: .5rem;
   box-shadow: 0 2px 4px rgba(0,0,0,.05);
}

.card-body, .panel-body {
   padding: 2rem !important;
}

/* 탭 네비게이션 스타일 */
.nav-tabs {
   border-bottom: 2px solid #dee2e6;
}

.nav-tabs .nav-item {
   margin-bottom: -2px;
}

.nav-tabs .nav-link {
   padding: 1rem 1.5rem;
   border: none;
   color: #495057;
   font-weight: 500;
   font-size: 18px;
   border-bottom: 2px solid transparent;
}

.nav-tabs .nav-link:hover {
   border-color: transparent;
   color: #0d6efd;
}

.nav-tabs .nav-link.active {
   color: #0d6efd;
   background-color: transparent;
   border-bottom: 2px solid #0d6efd;
}

.nav-tabs .badge {
   margin-left: 0.5rem;
   font-size: 14px;
   vertical-align: middle;
}

.chat-card-body {
    height: 100%;
    display: flex;
    flex-direction: column;
    position: relative;
    overflow: hidden;
}

#id_chatwin {
    flex: 1;
    overflow-y: auto;
    max-height: calc(100% - 110px);
}

.chat-input-container {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: white;
    padding: 1rem;
    border-top: 1px solid #dee2e6;
    border-bottom-left-radius: 0.5rem;
    border-bottom-right-radius: 0.5rem;
}

.chat-input-group {
    display: flex;
    gap: 0.5rem;
}

.chat-message {
    padding: 0.5rem 1rem;
    margin: 0.25rem 0;
    border-radius: 1rem;
    max-width: 80%;
}

.chat-message.system-message {
    color: #6c757d;
    font-style: italic;
    text-align: center;
    width: 100%;
    max-width: 100%;
    background-color: #e9ecef;
    padding: 0.25rem 1rem;
    margin: 0.5rem 0;
    border-radius: 0.5rem;
}

/* 탭 콘텐츠 스타일 */
.tab-content {
   padding-top: 1.5rem;
}

.tab-pane {
   padding: 0.5rem;
}

/* 버튼 스타일 */
.btn {
   padding: 10px 20px;
   font-size: 18px;
   border-radius: 0.35rem;
   font-weight: 500;
   transition: all 0.2s ease-in-out;
}

.btn-lg {
   padding: 12px 24px;
   font-size: 20px;
}

.btn-sm {
   padding: 6px 12px;
   font-size: 16px;
}

.btn-primary {
   background-color: #0d6efd;
   border-color: #0d6efd;
}

.btn-primary:hover {
   background-color: #0b5ed7;
   border-color: #0a58ca;
}

.btn-success {
   background-color: #198754;
   border-color: #198754;
}

.btn-danger {
   background-color: #dc3545;
   border-color: #dc3545;
}

/* 리스트 그룹 스타일 */
.list-group-item {
   padding: 1.25rem 1.5rem;
   border: 1px solid rgba(0,0,0,.125);
   margin-bottom: -1px;
   font-size: 18px;
}

.list-group-item:first-child {
   border-top-left-radius: 0.35rem;
   border-top-right-radius: 0.35rem;
}

.list-group-item:last-child {
   border-bottom-left-radius: 0.35rem;
   border-bottom-right-radius: 0.35rem;
}

/* 뱃지 스타일 */
.badge {
   font-size: 90%;
   padding: 0.4em 0.8em;
   font-weight: 500;
   border-radius: 0.35rem;
}

/* 미디어 객체 스타일 */
.media {
   align-items: center;
   padding: 1rem 0;
}

.media:not(:last-child) {
   border-bottom: 1px solid #dee2e6;
}

.media img {
   width: 48px !important;
   height: 48px !important;
}

.media-body {
   margin-left: 1rem;
}

.media-heading {
   display: flex;
   justify-content: space-between;
   align-items: center;
}

/* 가입 신청 관련 스타일 */
.pending-member {
   background-color: #f8f9fa;
   border-radius: 0.5rem;
   margin-bottom: 1rem;
}

.btn-group {
   margin-top: 0.5rem;
}

/* 채팅 관련 스타일 */
#id_chatwin {
   border-radius: 0.5rem;
}

#id_chatwin::-webkit-scrollbar {
   width: 6px;
}

#id_chatwin::-webkit-scrollbar-thumb {
   background-color: rgba(255,255,255,0.2);
   border-radius: 3px;
}

.chat-message {
   margin: 5px 0;
   word-break: break-word;
}

.system-message {
   color: #00ff00;
   font-style: italic;
}

/* 반응형 스타일 */
@media (max-width: 768px) {
   body {
       font-size: 16px;
   }

   .btn {
       padding: 8px 16px;
       font-size: 16px;
   }
   
    .panel-body {
       padding: 1.5rem !important;
   }

   h2 {
       font-size: 30px;
   }

   h3 {
       font-size: 24px;
   }

   .nav-tabs .nav-link {
       padding: 0.75rem 1rem;
       font-size: 16px;
   }

   .media img {
       width: 40px !important;
       height: 40px !important;
   }
}

/* 유틸리티 클래스 */
.margin-bottom-15 { margin-bottom: 1.5rem !important; }
.margin-top-10 { margin-top: 1rem !important; }
.mr-15 { margin-right: 1.5rem !important; }
.mt-3 { margin-top: 1rem !important; }
.mb-0 { margin-bottom: 0 !important; }
.mb-3 { margin-bottom: 1rem !important; }

/* FontAwesome 아이콘 스타일 */
.fas {
   margin-right: 0.5rem;
}
</style>

<script>
$(document).ready(function() {
    // 모달 요소 존재 확인
    console.log("Document ready 실행됨");
    console.log("Join Modal Element:", $('#joinRequestModal').length);
    console.log("Request Detail Modal Element:", $('#requestDetailModal').length);
    
    
    // 가입 신청 데이터 저장
    const pendingRequests = {};
    
    <c:forEach var="pending" items="${clubVO.joinRequestList}">
        pendingRequests['${pending.reqNo}'] = {
            reqNo: '${pending.reqNo}',
            empNo: '${pending.empNo}',
            clubNo: '${clubVO.clubNo}',
            empName: '${pending.employeeVO.empName}',
            empProfile: '${not empty pending.employeeVO.empProfile ? pending.employeeVO.empProfile : "/resources/upload/images/profile-default.png"}',
            reqDate: '<fmt:formatDate value="${pending.reqDate}" pattern="yyyy.MM.dd"/>',
            reqCont: `${pending.reqCont}`
        };
    </c:forEach>

    console.log("초기 pendingRequests:", pendingRequests);

    // 툴팁 초기화
    $('[data-toggle="tooltip"]').tooltip();

    // 가입하기 버튼 클릭 함수
    window.showJoinModal = function() {
        console.log("가입하기 버튼 클릭됨");
        $('#joinRequestModal').modal('show');
    }

    // 가입 신청 제출
    window.submitJoinRequest = function() {
        console.log("가입신청 제출 함수 실행");
        const reqCont = $('#reqCont').val().trim();
        console.log("입력된 메시지:", reqCont);
        
        if(!reqCont) {
            alert('가입신청 메시지를 입력해주세요.');
            return;
        }
        
        $.ajax({
            url: '/community/club/clubRequest',
            type: 'POST',
            data: {
                clubNo: '${clubVO.clubNo}',
                empNo: '<sec:authentication property="principal.member.empNo"/>',
                reqCont: reqCont
            },
            success: function(res) {
                console.log("가입신청 응답:", res);
                alert('가입신청이 완료되었습니다.');
                $('#joinRequestModal').modal('hide');
                location.reload();
            },
            error: function(xhr, status, error) {
                console.log("에러 발생:", {xhr, status, error});
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    }

    // 가입 신청 상세
	$('.pending-item').on('click', function(e) {
    if ($(e.target).closest('.btn-group').length) return;
    
    const reqId = $(this).data('req-id');
    const requestData = pendingRequests[reqId];
    if (!requestData) return;

    const $modal = $('#requestDetailModal');

    $('#modalEmpName').text(requestData.empName);
    $('#modalEmpProfile').attr('src', requestData.empProfile);
    $('#modalReqDate').text(requestData.reqDate);
    $('#modalReqCont').text(requestData.reqCont);

    $('#modalReqNo, #modalReqNo2').val(requestData.reqNo);
    $('#modalClubNo, #modalClubNo2').val(requestData.clubNo);
    $('#modalEmpNo, #modalEmpNo2').val(requestData.empNo);

    $modal.on('shown.bs.modal', function() {
        $(this).find('[autofocus]').focus();
    });

    $modal.modal('show');
});

    // 채팅 관련 코드
    const c_alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const f_ranID = () => {
        let ranID = "";
        for(let i=1; i< (Math.ceil(Math.random()*5)+4); i++){
            ranID += c_alpha[Math.floor(Math.random()*c_alpha.length)];
        }
        return ranID;
    }

    let webSocket;
    let myId = f_ranID();
    const c_chatWin = document.querySelector("#id_chatwin");
    const c_message = document.querySelector("#id_message");        
    const c_send = document.querySelector("#id_send");

    function connect() {
        webSocket = new SockJS("/chat");
        webSocket.onopen = function() {
            console.log("WebSocket 연결됨");
            fOpen();
        };
        webSocket.onmessage = fMessage;
        webSocket.onerror = function(error) {
            console.error("WebSocket Error:", error);
            alert("연결에 문제가 발생했습니다. 재연결을 시도합니다.");
            setTimeout(connect, 5000);
        };
        webSocket.onclose = function() {
            console.log("WebSocket 연결 종료");
        };
    }

    function fOpen() {
        let chatMessage = {
            sender: myId,
            message: "입장했습니다.",
            type: "ENTER"
        };
        webSocket.send(JSON.stringify(chatMessage));
    }

    function send() {
        if(!c_message.value.trim()) return;
        
        if (webSocket && webSocket.readyState === WebSocket.OPEN) {
            let chatMessage = {
                sender: myId,
                message: c_message.value,
                type: "CHAT"
            };
            webSocket.send(JSON.stringify(chatMessage));
            c_message.value = "";
        } else {
            console.log("WebSocket is not open. Current state:", webSocket ? webSocket.readyState : "no websocket");
            connect();
        }
    }

    function fMessage(e) {
        const msg = JSON.parse(e.data);
        const msgElement = document.createElement('div');
        msgElement.className = 'chat-message';
        
        let displayText = '';
        if (msg.type === "ENTER") {
            msgElement.classList.add('system-message');
            displayText = msg.sender + "님이 입장했습니다.";
        } else if (msg.type === "LEAVE") {
            msgElement.classList.add('system-message');
            displayText = msg.sender + "님이 퇴장했습니다.";
        } else if (msg.type === "CHAT") {
            displayText = msg.sender + ": " + msg.message;
        }
        
        msgElement.textContent = displayText;
        c_chatWin.appendChild(msgElement);
        c_chatWin.scrollTop = c_chatWin.scrollHeight;
    }

    function disconnect() {
        if(webSocket && webSocket.readyState === WebSocket.OPEN) {
            let chatMessage = {
                sender: myId,
                message: "퇴장했습니다.",
                type: "LEAVE"
            };
            webSocket.send(JSON.stringify(chatMessage));
            webSocket.close();
        }
    }

    // 이벤트 리스너 등록
    if (c_send) {
        c_send.addEventListener("click", send);
        c_message.addEventListener("keypress", (event) => {
            if(event.keyCode === 13) send();
        });
    }

    // 페이지 언로드 시 연결 종료
    window.addEventListener('beforeunload', disconnect);

    // 초기 연결 시작
    console.log("채팅 연결 시도");
    connect();
});
</script>

<%@ include file="../include/footer.jsp" %>

<button type="submit" class="btn btn-danger">
                       <i class="fas fa-times"></i> 거절
                   </button>

<button type="submit" class="btn btn-success">
                       <i class="fas fa-check"></i> 승인
                   </button>