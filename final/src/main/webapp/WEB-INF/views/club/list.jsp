<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->

<style>
/* 기본 레이아웃 */
.community-wrapper {
   padding: 30px;
   background: #f8f9fa;
   min-height: calc(100vh - 60px);
}

/* 헤더 영역 */
.community-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   margin-bottom: 25px;
}

.main-title {
   font-size: 24px;
   font-weight: 600;
   color: #333;
}

.create-btn {
   padding: 8px 16px;
   background: #007bff;
   color: white;
   border: none;
   border-radius: 4px;
   cursor: pointer;
   font-size: 14px;
}

.create-btn:hover {
   background: #0056b3;
}

/* 탭 메뉴 */
.community-tabs {
   display: flex;
   border-bottom: 1px solid #dee2e6;
   margin-bottom: 20px;
}

.tab {
   padding: 12px 24px;
   cursor: pointer;
   color: #495057;
   font-weight: 500;
}

.tab.active {
   color: #007bff;
   border-bottom: 2px solid #007bff;
}

/* 리스트 영역 */
.community-list {
   display: flex;
   flex-direction: column;
   gap: 15px;
}

.tab-content {
   margin-top: 20px;
}

.tab-pane {
   display: none;
}

.tab-pane.active {
   display: block;
}

/* 검색 및 필터 */
.filter-section {
   background: white;
   padding: 15px;
   border-radius: 8px;
   margin-bottom: 20px;
   display: flex;
   gap: 15px;
   align-items: center;
}

.search-box {
   position: relative;
   flex: 1;
}

.search-input {
   width: 100%;
   padding: 8px 35px 8px 15px;
   border: 1px solid #dee2e6;
   border-radius: 4px;
   font-size: 14px;
}

.search-icon {
   position: absolute;
   right: 12px;
   top: 50%;
   transform: translateY(-50%);
   color: #adb5bd;
}

.filter-select {
   padding: 8px;
   border: 1px solid #dee2e6;
   border-radius: 4px;
   font-size: 14px;
   color: #495057;
}

/* 커뮤니티 아이템 */
.community-item {
   display: flex;
   justify-content: space-between;
   align-items: center;
   padding: 20px;
   background: white;
   border-radius: 8px;
   box-shadow: 0 2px 4px rgba(0,0,0,0.05);
   cursor: pointer;
   transition: background-color 0.3s ease;
}

.community-item:hover {
   background-color: #f0f0f0;
   box-shadow: 0 4px 6px rgba(0,0,0,0.05);
}

.item-left {
   display: flex;
   align-items: center;
   gap: 20px;
}

.community-icon {
   width: 48px;
   height: 48px;
   background: #e9ecef;
   border-radius: 8px;
   display: flex;
   align-items: center;
   justify-content: center;
   color: #6c757d;
}

.community-info {
   display: flex;
   flex-direction: column;
   gap: 5px;
}

.community-title {
   font-size: 16px;
   font-weight: 600;
   color: #212529;
   display: flex;
   align-items: center;
   gap: 8px;
}

.community-desc {
   font-size: 14px;
   color: #6c757d;
}

.community-sub {
   font-size: 12px;
   color: #adb5bd;
   display: flex;
   gap: 15px;
}

/* 모달 스타일 */
.modal {
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: rgba(0,0,0,0.5);
   display: none;
   align-items: center;
   justify-content: center;
   z-index: 1000;
}

.modal-content {
   background: white;
   width: 100%;
   max-width: 500px;
   border-radius: 8px;
   box-shadow: 0 2px 10px rgba(0,0,0,0.1);
   padding: 20px;
}

.modal-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   border-bottom: 1px solid #dee2e6;
   padding-bottom: 10px;
   margin-bottom: 15px;
}

.modal-header h2, .modal-header h3 {
   margin: 0;
   font-size: 18px;
}

.close-btn, .close {
   color: #6c757d;
   font-size: 24px;
   font-weight: bold;
   cursor: pointer;
   transition: all 0.2s ease;
}



.close-btn:hover, .close:hover {
   color: #5a6268;
}

ㅇ
.modal-body {
   padding: 20px 0;
}

/* 모달 정보 스타일 */
.modal-info-group {
   display: flex;
   flex-direction: column;
   gap: 15px;
}

.modal-info-item {
   display: flex;
   flex-direction: column;
   gap: 5px;
}

.modal-info-item strong {
   color: #495057;
   font-size: 14px;
}

.modal-description {
   margin: 5px 0;
   color: #666;
   line-height: 1.5;
}

.modal-info-item span {
   color: #333;
   font-size: 14px;
}

/* 모달 */
.modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #dee2e6;
}

.submit-btn {
    display: inline-block;
    min-width: 80px;
}

/* 폼 스타일 */
.form-group {
   margin-bottom: 20px;
}

.form-group label {
   display: block;
   margin-bottom: 8px;
   font-weight: 500;
}

.form-input {
   width: 100%;
   padding: 8px;
   border: 1px solid #dee2e6;
   border-radius: 4px;
   resize: vertical;
}

/* 버튼 스타일 통합 */
.enter-btn, .join-btn, .cancel-btn, .submit-btn, .btn-close, .btn-enter {
   padding: 8px 16px;
   border-radius: 4px;
   font-size: 14px;
   cursor: pointer;
   font-weight: 500;
   transition: all 0.2s ease;
}

.enter-btn, .cancel-btn, .btn-close {
   background: white;
   border: 1px solid #6c757d;
   color: #6c757d;
}

.enter-btn:hover, .cancel-btn:hover, .btn-close:hover {
   background: #f8f9fa;
   color: #5a6268;
}

.join-btn, .submit-btn, .btn-enter {
   background: #007bff;
   border: 1px solid #007bff;
   color: white;
}

.join-btn:hover, .submit-btn:hover, .btn-enter:hover {
   background: #0056b3;
   border-color: #0056b3;
}

.enter-btn.disabled {
   background: #e9ecef;
   border-color: #dee2e6;
   color: #6c757d;
   cursor: not-allowed;
}

/* 뱃지 스타일 */
.pending-badge, .popular-badge, .new-badge {
   font-size: 12px;
   padding: 2px 8px;
   border-radius: 12px;
}

.pending-badge, .popular-badge {
   background: #ffd43b;
   color: #495057;
}

.new-badge {
   background: #51cf66;
   color: white;
}

/* 페이지네이션 */
.pagination {
   display: flex;
   justify-content: center;
   gap: 5px;
   margin-top: 30px;
}

.page-btn {
   width: 36px;
   height: 36px;
   display: flex;
   align-items: center;
   justify-content: center;
   border: 1px solid #dee2e6;
   background: white;
   border-radius: 4px;
   cursor: pointer;
   color: #495057;
}

.page-btn:hover {
   background: #f8f9fa;
}

.page-btn.active {
   background: #007bff;
   color: white;
   border-color: #007bff;
}

/* 버튼 호버 예외처리 */
.community-item .enter-btn:hover,
.community-item .join-btn:hover {
   opacity: 0.9;
}
</style>
</head>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>


<!-- 커뮤니티 메인 컨텐츠 시작 -->
<div class="community-wrapper">
    <!-- 상단 영역 -->
    <div class="community-header">
        <h2 class="main-title">동호회</h2>
        <button type="button" class="create-btn" onclick="location.href='/community/club/form'">
            <i class="fas fa-plus"></i> 동호회 개설
        </button>
    </div>

    <!-- 탭 메뉴 -->
    <div class="community-tabs">
        <div class="tab active" data-tab="my-communities">내 동호회</div>
        <div class="tab" data-tab="all-communities">전체 동호회</div>
    </div>

    <!-- 탭 컨텐츠 영역 -->
    <div class="tab-content">
        <!-- 내 커뮤니티 탭 -->
        <div class="community-list tab-pane active" id="my-communities">
            <c:forEach var="club" items="${myClubs}">
                <!-- 커뮤니티 아이템 -->
                <div class="community-item">
                    <div class="item-left">
                        <div class="community-icon">
                        	<img src="${club.fileSaveLocate}" style="width:40px;height:40px;" />
                        </div>
                        <div class="community-info">
                            <div class="community-title">
                                ${club.clubName}
                                <i class="fas fa-lock"></i>
                            </div>
                            <div class="community-desc">${club.clubDesc}</div>
                            <div class="community-sub"
							     data-club-cre-mem="${club.clubCreMem}"
							     data-club-cre-date="${club.clubCreDate}"
							     data-max-member="${club.maxMember}"
							     data-club-sec="${club.clubSec}"
							     data-join-way="${club.joinWay}">
							    멤버 ${club.nowMember}명
							</div>
                        </div>
                    </div>
                    <button class="enter-btn" onclick="location.href='/community/club/myPage/${club.clubNo}'">입장하기</button>
                </div>
            </c:forEach>
        </div>

        <!-- 전체 커뮤니티 탭 -->
        <div class="community-list tab-pane" id="all-communities">
            <!-- 검색 및 필터 영역 -->
            <div class="filter-section">
                <div class="search-box">
                    <input type="text" placeholder="커뮤니티 검색" class="search-input" id="keyword" value="${param.keyword}">
                    <i class="fas fa-search search-icon"></i>
                </div>
                <div class="filter-group">
                    <select class="filter-select" id="category">
                        <option value="">전체 카테고리</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.clubCateNo}" 
                                    ${param.category == category.clubCateNo ? 'selected' : ''}>
                                ${category.clubCateName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- 전체 커뮤니티 리스트 -->
            <c:forEach var="club" items="${articlePage.content}">
                <div class="community-item">
                    <div class="item-left">
                        <div class="community-icon">
                        	<img src="${club.fileSaveLocate}" style="width:40px;height:40px;" />
                        </div>
                        <div class="community-info">
                            <div class="community-title">
                                ${club.clubName}
                            </div>
                            <div class="community-desc">${club.clubDesc}</div>
                            <div class="community-sub"
							     data-club-cre-mem="${club.clubCreMem}"
							     data-club-cre-date="${club.clubCreDate}"
							     data-max-member="${club.maxMember}"
							     data-club-sec="${club.clubSec}"
							     data-join-way="${club.joinWay}">
							    <span><i class="fas fa-users"></i> 멤버 ${club.nowMember}명</span>
							</div>
                        </div>
                    </div>
                    <c:set var="isMember" value="false" />
                    <c:forEach var="myClub" items="${myClubs}">
                        <c:if test="${myClub.clubNo eq club.clubNo}">
                            <c:set var="isMember" value="true" />
                        </c:if>
                    </c:forEach>
                    
                    <c:choose>
					    <c:when test="${isMember || club.clubSec eq 1}">
					        <button class="enter-btn" onclick="location.href='/community/club/myPage/${club.clubNo}'">입장하기</button>
					    </c:when>
					    <c:otherwise>
					        <button class="join-btn" onclick="joinClub(${club.clubNo})">가입하기</button>
					    </c:otherwise>
					</c:choose>
                </div>
            </c:forEach>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <c:if test="${articlePage.startPage > 5}">
                    <button class="page-btn" onclick="changePage(${articlePage.startPage - 5})">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                </c:if>
                
                <c:forEach var="pNo" begin="${articlePage.startPage}" end="${articlePage.endPage}">
                    <button class="page-btn ${pNo == articlePage.currentPage ? 'active' : ''}" 
                            onclick="changePage(${pNo})">${pNo}</button>
                </c:forEach>
                
                <c:if test="${articlePage.endPage < articlePage.totalPages}">
                    <button class="page-btn" onclick="changePage(${articlePage.endPage + 1})">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- 커뮤니티 상세 모달 -->
<div id="communityModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="modalTitle">커뮤니티 이름</h2>
            <span class="close-btn">&times;</span>
        </div>
        <div class="modal-body">
            <div class="modal-info-group">
                <div class="modal-info-item">
                    <strong>커뮤니티 설명:</strong>
                    <p id="modalDescription" class="modal-description"></p>
                </div>
                <!-- <div class="modal-info-item">
                    <strong>개설자:</strong>
                    <span id="modalCreator"></span>
                </div> -->
                <div class="modal-info-item">
                    <strong>개설일:</strong>
                    <span id="modalCreatedDate"></span>
                </div>
                <div class="modal-info-item">
                    <strong>멤버 현황:</strong>
                    <span id="modalMemberCount"></span>
                </div>
                <div class="modal-info-item">
                    <strong>최대 인원:</strong>
                    <span id="modalMaxMember"></span>
                </div>
                <div class="modal-info-item">
                    <strong>가입 방식:</strong>
                    <span id="modalJoinWay"></span>
                </div>
                <div class="modal-info-item">
                    <strong>공개 여부:</strong>
                    <span id="modalSecurity"></span>
                </div>
            </div>
        </div>
        <div class="modal-footer">
		    <button class="cancel-btn" id="modalCloseBtn">닫기</button>
		    <c:choose>
		        <c:when test="${isMember || club.clubSec eq 1}">
		            <button class="btn-enter" id="modalEnterBtn" onclick="location.href='/community/club/myPage/${club.clubNo}'">입장하기</button>
		        </c:when>
		        <c:otherwise>
		            <button class="join-btn" id="modalEnterBtn" onclick="joinClub(${club.clubNo})">가입하기</button>
		        </c:otherwise>
		    </c:choose>
		</div>
    </div>
</div>

<!-- 가입신청 모달 추가 -->
<div class="modal" id="joinRequestModal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <h3>동호회 가입신청</h3>
            <span class="close">&times;</span>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label for="reqCont">가입신청 메시지</label>
                <textarea id="reqCont" class="form-input" 
                    placeholder="가입 신청 메시지를 입력해주세요." rows="4"></textarea>
            </div>
        </div>
        <div class="modal-footer" style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
    <button type="button" class="cancel-btn" onclick="closeJoinModal()">취소</button>
    <button type="button" class="submit-btn" onclick="submitJoinRequest()">신청하기</button>
</div>
    </div>
</div>



<script>
//날짜 포맷팅 함수 
function formatDate(dateStr) {
    if (!dateStr) return "";
    
    console.log("입력받은 날짜:", dateStr);
    
    try {
        const months = {
            'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04', 'May': '05', 'Jun': '06',
            'Jul': '07', 'Aug': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
        };

        const parts = dateStr.split(' ');
        console.log("Parts:", parts);
        
        if (parts.length >= 6) {
            const month = months[parts[1]] || '00';
            const day = String(parseInt(parts[2])).padStart(2, '0');
            const year = parts[parts.length - 1];
            
            // 여기를 수정
            const formattedDate = year + "-" + month + "-" + day;
            console.log("변환된 날짜:", formattedDate);
            
            return formattedDate;
        }
        
        return dateStr;
    } catch (e) {
        console.error("날짜 변환 중 오류:", e);
        return dateStr;
    }
}

$(document).ready(function() {
	  // 페이지 이동
	  function changePage(page) {
	      const keyword = $('#keyword').val();
	      const category = $('#category').val();
	      location.href = '/club/list?currentPage=' + page 
	          + '&keyword=' + encodeURIComponent(keyword)
	          + '&category=' + category;
	  }

	  // 검색 기능 
	  function search() {
	      const keyword = $('#keyword').val();
	      const category = $('#category').val();
	      location.href = '/club/list?currentPage=1&keyword=' + 
	          encodeURIComponent(keyword) + '&category=' + category;
	  }

	  // 엔터키 검색
	  $('#keyword').on('keyup', function(e) {
	      if (e.key === 'Enter') {
	          search();
	      }
	  });

	  // 검색 아이콘 클릭
	  $('.search-icon').on('click', function() {
	      search();
	  });

	  // 카테고리 변경
	  $('#category').on('change', function() {
	      search();
	  });

	  // 탭 전환
	  $('.tab').on('click', function() {
	      $('.tab').removeClass('active');
	      $(this).addClass('active');
	      
	      const tabId = $(this).data('tab');
	      $('.tab-pane').removeClass('active');
	      $('#' + tabId).addClass('active');
	  });

	  // 동호회 가입 신청
	  let selectedClubNo = null;

	  function joinClub(clubNo) {
	      selectedClubNo = clubNo;
	      $('#joinRequestModal').css('display', 'flex');
	  }

	  // 가입 신청 모달 닫기
	  function closeJoinModal() {
	      $('#joinRequestModal').css('display', 'none');
	      $('#reqCont').val('');
	  }

	  // 가입 신청 제출
	  function submitJoinRequest() {
	      const reqCont = $('#reqCont').val().trim();
	      
	      if(!reqCont) {
	          alert('가입신청 메시지를 입력해주세요.');
	          return;
	      }
	      
	      $.ajax({
	          url: '/community/club/clubRequest',  
	          type: 'POST',
	          data: {                   
	              clubNo: selectedClubNo,
	              empNo: '<sec:authentication property="principal.member.empNo"/>',
	              reqCont: reqCont
	          },
	          success: function(res) {
	              alert('가입신청이 완료되었습니다.');
	              closeJoinModal();
	              location.reload();
	          },
	          error: function() {
	              alert('서버와의 통신 중 오류가 발생했습니다.');
	          }
	      });
	  }

	  /* // 동호회 상태 확인
	  function checkClubStatus(clubNo) {
	      return $.ajax({
	          url: '/community/club/checkStatus/' + clubNo,
	          type: 'GET'
	      });
	  } */

	  // 커뮤니티 아이템 클릭 이벤트
	  $('.community-item').on('click', function(e) {
	      if ($(e.target).closest('.enter-btn, .join-btn').length > 0) {
	          return;
	      }

	      const $communitySubDiv = $(this).find('.community-sub');
	      const $btn = $(this).find('.enter-btn, .join-btn');
	      
	      let clubNo;
	      if ($btn.length > 0) {
	          const onclick = $btn.attr('onclick') || '';
	          const match = onclick.match(/\/community\/club\/myPage\/(\d+)/);
	          if (match) {
	              clubNo = match[1];
	          } else {
	              const joinMatch = onclick.match(/joinClub\((\d+)\)/);
	              if (joinMatch) {
	                  clubNo = joinMatch[1];
	              }
	          }
	      }

	      if (!clubNo) {
	          console.log('No club number found, skipping modal');
	          return;
	      }

	      const clubData = {
	          clubNo: clubNo,
	          clubName: $(this).find('.community-title').text().trim(),
	          clubDesc: $(this).find('.community-desc').text().trim(), 
	          clubCreMem: $communitySubDiv.data('club-cre-mem'),
	          clubCreDate: $communitySubDiv.data('club-cre-date'),
	          maxMember: $communitySubDiv.data('max-member'),
	          nowMember: $communitySubDiv.text().match(/\d+/)[0],
	          joinWay: $communitySubDiv.data('join-way'),
	          clubSec: $communitySubDiv.data('club-sec')
	      };

	      openCommunityModal(clubData, $(this));
	  });

	  // 커뮤니티 상세 모달
	  function openCommunityModal(communityData, $currentItem) {
	    $('#modalTitle').text(communityData.clubName);
	    $('#modalDescription').text(communityData.clubDesc);
	    // formatDate 함수를 사용하여 날짜 포맷팅
	    $('#modalCreatedDate').text(formatDate(communityData.clubCreDate) || '-');
	    $('#modalMemberCount').text(communityData.nowMember + '/' + communityData.maxMember + '명');
	    $('#modalMaxMember').text(communityData.maxMember + '명');
	    $('#modalJoinWay').text(communityData.joinWay === 1 ? '자동 승인' : '승인 필요');
	    $('#modalSecurity').text(communityData.clubSec === 1 ? '공개' : '비공개');
	    
	    const currentBtn = $currentItem.find('.btn-enter, .join-btn').clone();
	    $('.modal-footer').html(currentBtn);
	
	    $('#communityModal').css('display', 'flex');
	}

	  // 커뮤니티 상세 모달 닫기
	  function closeCommunityModal() {
	      $('#communityModal').css('display', 'none');
	  }

	  // 모달 닫기 버튼 이벤트
	  $('.close-btn, #modalCloseBtn').on('click', function() {
	      closeCommunityModal();
	  });

	  // 가입신청 모달 닫기 버튼
	  $('.close, .cancel-btn').on('click', function() {
	      closeJoinModal();
	  });

	  // 모달 외부 클릭시 닫기
	  $(window).on('click', function(event) {
	      if ($(event.target).is('#communityModal')) {
	          closeCommunityModal();
	      }
	      if ($(event.target).is('#joinRequestModal')) {
	          closeJoinModal();
	      }
	  });

	  // 가입신청 버튼 이벤트
	  $('.submit-btn').on('click', function() {
	      submitJoinRequest();
	  });

	  // 전역 함수로 노출
	  window.changePage = changePage;
	  window.joinClub = joinClub;
	});
</script>

<%@ include file="../include/footer.jsp" %>