<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
 <style>

.community-settings-wrapper {
    padding: 30px;
    background: #f8f9fa;
    min-height: calc(100vh - 60px);
}

/* 상단 네비게이션 */
.settings-nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #dee2e6;
}

.nav-left {
    display: flex;
    align-items: center;
    gap: 15px;
}

.back-btn {
    background: none;
    border: none;
    font-size: 20px;
    color: #495057;
    cursor: pointer;
}

.nav-left h2 {
    font-size: 24px;
    font-weight: 600;
    margin: 0;
}

.nav-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}

.nav-actions button {
    padding: 8px 16px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
}

.delete-btn {
    background: white;
    border: 1px solid #dee2e6;
    color: #dc3545;
}

.save-btn {
    background: #228be6;
    border: none;
    color: white;
}

/* 탭 메뉴 */
.settings-tabs {
    display: flex;
    border-bottom: 1px solid #dee2e6;
    margin-bottom: 30px;
}

.tab {
    padding: 12px 24px;
    color: #495057;
    cursor: pointer;
    font-weight: 500;
}

.tab.active {
    color: #228be6;
    border-bottom: 2px solid #228be6;
}

/* 설정 섹션 공통 스타일 */
.settings-section {
    background: #fef7f1;
    padding: 25px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.section-header h3 {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin: 0;
}

.last-updated {
    color: #868e96;
    font-size: 14px;
    margin: 0;
}

/* 폼 스타일 */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #495057;
}

.form-input, .form-textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 14px;
}

.form-textarea {
    min-height: 100px;
    resize: vertical;
}

/* 아이콘 선택 */
.icon-select {
    display: flex;
    align-items: center;
    gap: 15px;
}

.current-icon {
    width: 48px;
    height: 48px;
    background: #e9ecef;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: #495057;
}

.select-icon-btn {
    padding: 8px 16px;
    background: white;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    color: #495057;
    cursor: pointer;
}

.member-list {
    margin-top: 20px;
}

.member-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    margin-bottom: 10px;
}

.member-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

.profile-img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
}

.member-details {
    display: flex;
    flex-direction: column;
}

.member-name {
    font-weight: 500;
    color: #333;
}

.member-role {
    font-size: 0.9em;
    color: #666;
}

.member-stats {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    color: #666;
    font-size: 0.9em;
}

.role-select {
    padding: 6px 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    margin-right: 10px;
}

.remove-member-btn {
    padding: 6px 12px;
    background: white;
    border: 1px solid #dc3545;
    color: #dc3545;
    border-radius: 4px;
    cursor: pointer;
}

.remove-member-btn:hover {
    background: #dc3545;
    color: white;
}

.member-actions {
    display: flex;
    align-items: center;
    gap: 10px;
}

.search-input {
    padding: 8px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    width: 200px;
}

/* 부마스터 설정 */
.sub-masters {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.sub-master-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
}

.member-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

.profile-img {
    width: 32px;
    height: 32px;
    border-radius: 50%;
}

.remove-btn {
    padding: 6px 12px;
    background: white;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    color: #dc3545;
    cursor: pointer;
}

.add-sub-master-btn {
    padding: 12px;
    background: #f8f9fa;
    border: 1px dashed #adb5bd;
    border-radius: 4px;
    color: #495057;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

/* 공개 설정 */
.privacy-settings {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.setting-option {
    display: flex;
    background: #FFFFFF;
    align-items: flex-start;
    gap: 12px;
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    cursor: pointer;
}

.option-info {
    flex: 1;
}

.option-title {
    font-weight: 500;
    margin-bottom: 4px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.option-desc {
    color: #868e96;
    font-size: 14px;
}

/* 모달 설정 */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
}

.modal-content {
    position: relative;
    background-color: #fff;
    margin: 50px auto;
    width: 90%;
    max-width: 600px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
    padding: 20px;
    border-bottom: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    margin: 0;
    font-size: 18px;
    font-weight: 600;
}

.close-btn {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #868e96;
}

.modal-body {
    padding: 20px;
    max-height: 60vh;
    overflow-y: auto;
}

/* 검색 섹션 */
.search-section {
    margin-bottom: 20px;
}

.search-input {
    width: 100%;
    padding: 10px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 14px;
}

/* 필터 섹션 */
.filter-section {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
    flex-wrap: wrap;
}

.filter-group {
    flex: 1;
    min-width: 150px;
}

.filter-group label {
    display: block;
    margin-bottom: 5px;
    font-size: 14px;
    color: #495057;
}

.filter-select {
    width: 100%;
    padding: 8px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-size: 14px;
}

/* 멤버 목록 섹션 */
.member-list-section {
    margin-bottom: 20px;
}

.member-item {
    display: flex;
     background: #FFFFFF;
    justify-content: space-between;
    align-items: center;
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    margin-bottom: 8px;
}

.member-info {
    display: flex;
    align-items: center;
    gap: 12px;
}

.member-profile {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
}

.member-details {
    display: flex;
    flex-direction: column;
}

.member-name {
    font-weight: 500;
    color: #495057;
}

.member-dept {
    font-size: 13px;
    color: #868e96;
}

.invite-action-btn {
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #228be6;
    color: #228be6;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.invite-action-btn:hover {
    background-color: #228be6;
    color: #fff;
}

/* 전체 선택 섹션 */
.select-all-section {
    margin-top: 15px;
    padding: 10px 0;
    border-top: 1px solid #e9ecef;
}

.select-all-section label {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #495057;
    font-size: 14px;
}

/* 모달 푸터 */
.modal-footer {
    padding: 15px 20px;
    border-top: 1px solid #e9ecef;
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}

.modal-footer button {
    padding: 8px 16px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
}

.cancel-btn {
    background: #fff;
    border: 1px solid #dee2e6;
    color: #495057;
}

.confirm-btn {
    background: #228be6;
    border: none;
    color: #fff;
}

.remove-member-btn {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.remove-member-btn:hover {
    background-color: #c82333;
}

/* 게시판 관리 */
.board-list {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.board-item {
    display: flex;
    background: #FFFFFF;
    justify-content: space-between;
    align-items: center;
    padding: 12px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
}

.board-info {
    display: flex;
    align-items: center;
    gap: 12px;
}

.board-name {
    font-weight: 500;
}

.post-count {
    color: #868e96;
    font-size: 14px;
}

.board-actions {
    display: flex;
    gap: 8px;
}

.edit-btn, .board-actions .delete-btn {
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
}

.edit-btn {
    background: white;
    border: 1px solid #dee2e6;
    color: #495057;
}

.board-actions .delete-btn {
    background: white;
    border: 1px solid #
}

.stats-overview {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.stat-title {
    color: #666;
    font-size: 14px;
    margin-bottom: 8px;
}

.stat-value {
    font-size: 24px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
}

.stat-change {
    font-size: 14px;
}

.stat-change.increase {
    color: #40c057;
}

.stat-change.decrease {
    color: #fa5252;
}

.stats-detail {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-top: 30px;
}

.stats-chart, .popular-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
}

.chart-container {
    margin-top: 20px;
}

.chart-mock {
    height: 200px;
    display: flex;
    align-items: flex-end;
    gap: 10px;
}

.chart-bar {
    flex: 1;
    background: #228be6;
    border-radius: 4px 4px 0 0;
}

.chart-labels {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
}

.popular-list {
    margin-top: 15px;
}

.popular-item {
    display: flex;
    align-items: center;
    padding: 12px;
    border-bottom: 1px solid #dee2e6;
}

.rank {
    width: 24px;
    height: 24px;
    background: #e9ecef;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 12px;
}

.title {
    flex: 1;
}

.views {
    color: #868e96;
    font-size: 14px;
}

</style>   
    
 </head>
<!-- 여기 style css 들어가야해요  -->

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->


<!-- 동호회 관리 컨텐츠 시작 -->
<div class="community-settings-wrapper">
    <!-- 상단 네비게이션 -->
    <div class="settings-nav">
        <div class="nav-left">
            <button class="back-btn" onclick="history.back()">
                <i class="fas fa-arrow-left"></i>
            </button>
            <h2>동호회 관리</h2>
        </div>
        <!-- <div class="nav-actions">
            <button class="delete-btn">폐쇄하기</button>
            <button type="submit" form="clubManageForm" class="save-btn">저장</button>
        </div> -->
    </div>

    <!-- 설정 메뉴 탭 -->
    <div class="settings-tabs">
        <div class="tab active" data-tab="info-tab">정보</div>
        <div class="tab" data-tab="members-tab">멤버</div>
        <div class="tab" data-tab="boards-tab">게시판</div>
    </div>

    <!-- 설정 컨텐츠 -->
    <div class="settings-content">
        <!-- 정보 탭 콘텐츠 -->
		<div id="info-tab" class="tab-content">
		    <form id="clubManageForm" method="post" action="/community/club/updateAjax">
			    <input type="hidden" name="clubNo" value="${club.clubNo}" />
			    <input type="hidden" name="comNo" value="${club.comNo}" />
			    
			    <input type="hidden" name="communityVO.comNo" value="${club.communityVO.comNo}" />
			    <input type="hidden" name="communityVO.comTitle" value="${club.communityVO.comTitle}" />
			    <input type="hidden" name="communityVO.comCont" value="${club.communityVO.comCont}" />
		        
		        <!-- 기본 정보 설정 -->
		        <div class="settings-section">
		            <div class="section-header">
					  <h3>기본 정보</h3>
					  <p class="last-updated">최종 수정: <fmt:formatDate value="${club.clubModiDate}" pattern="yyyy.MM.dd" /></p>
					</div>
		            
		            <div class="form-group">
		                <label>동호회 이름</label>
		                <input type="text" name="clubName" class="form-input" value="${club.clubName}">
		            </div>
		
		            <div class="form-group">
		                <label>동호회 설명</label>
		                <textarea name="clubDesc" class="form-textarea">${club.clubDesc}</textarea>
		            </div>
		
		            <div class="form-group">
		                <label>최대 인원</label>
		                <input type="number" name="maxMember" class="form-input" value="${club.maxMember}">
		            </div>
		
		            <div class="form-group">
		                <label>카테고리</label>
		                <select name="clubCategoryVO.clubCateNo" class="form-input">
		                    <c:forEach var="category" items="${categories}">
		                        <option value="${category.clubCateNo}" 
		                                ${club.clubCategoryVO.clubCateNo == category.clubCateNo ? 'selected' : ''}>
		                            ${category.clubCateName}
		                        </option>
		                    </c:forEach>
		                </select>
		            </div>
		        </div>
		
		        <!-- 가입 방식 설정 -->
		        <div class="settings-section">
		            <div class="section-header">
		                <h3>가입 방식 설정</h3>
		            </div>
		
		            <div class="privacy-settings">
		                <div class="setting-option">
		                    <input type="radio" name="joinWay" id="joinWay1" value="1" ${club.joinWay == 1 ? 'checked' : ''}>
		                    <label for="joinWay1">
		                        <div class="option-info">
		                            <div class="option-title">
		                                <i class="fas fa-check-circle"></i> 자동 승인
		                            </div>
		                            <div class="option-desc">
		                                가입 신청시 자동으로 승인됩니다.
		                            </div>
		                        </div>
		                    </label>
		                </div>
		
		                <div class="setting-option">
		                    <input type="radio" name="joinWay" id="joinWay2" value="2" ${club.joinWay == 2 ? 'checked' : ''}>
		                    <label for="joinWay2">
		                        <div class="option-info">
		                            <div class="option-title">
		                                <i class="fas fa-user-check"></i> 승인 후 가입
		                            </div>
		                            <div class="option-desc">
		                                운영진의 승인 후 가입이 가능합니다.
		                            </div>
		                        </div>
		                    </label>
		                </div>
		            </div>
		        </div>
		
		        <!-- 공개 설정 -->
		        <div class="settings-section">
		            <div class="section-header">
		                <h3>공개 설정</h3>
		            </div>
		
		            <div class="privacy-settings">
		                <div class="setting-option">
		                    <input type="radio" name="clubSec" id="open" value="1" ${club.clubSec == 1 ? 'checked' : ''}>
		                    <label for="open">
		                        <div class="option-info">
		                            <div class="option-title">
		                                <i class="fas fa-globe"></i> 공개
		                            </div>
		                            <div class="option-desc">
		                                모든 구성원이 동호회를 검색하고 볼 수 있습니다.
		                            </div>
		                        </div>
		                    </label>
		                </div>
		
		                <div class="setting-option">
		                    <input type="radio" name="clubSec" id="closed" value="2" ${club.clubSec == 2 ? 'checked' : ''}>
		                    <label for="closed">
		                        <div class="option-info">
		                            <div class="option-title">
		                                <i class="fas fa-lock"></i> 비공개
		                            </div>
		                            <div class="option-desc">
		                                초대를 통해서만 가입이 가능합니다.
		                            </div>
		                        </div>
		                    </label>
		                </div>
		            </div>
		        </div>
		        
		    </form>
		</div>
		        
        <!-- 멤버 탭 콘텐츠 -->
		<div id="members-tab" class="tab-content" style="display: none;">
		    <div class="settings-section">
		        <div class="section-header">
		            <h3>멤버 관리</h3>
		            <div class="member-actions">
		                <input type="text" id="memberSearch" placeholder="멤버 검색" class="search-input">
		                <button class="invite-btn" style="display: flex; align-items: center; gap: 8px; padding: 8px 16px; background-color: #228be6; color: white; border: none; border-radius: 4px; cursor: pointer;">
		                    <i class="fas fa-user-plus"></i> 멤버 초대
		                </button>
		            </div>
		        </div>
		        
		        
		
		        <div class="member-list">
		            <c:forEach var="member" items="${club.memberList}">
		                <div class="member-item">
		                    <div class="member-info">
		                        <img src="${member.employeeVO.empProfile == null ? '/resources/images/profile-default.png' : member.employeeVO.empProfile}" class="profile-img">
		                        <div class="member-details">
		                            <span class="member-name">${member.employeeVO.empName}</span>
		                            <span class="member-role">${member.clubRoleVO.roleName}</span>
		                        </div>
		                    </div>
		                    <div class="member-stats">
 		                       <%-- <span>${member.employeeVO.departmentVO.deptName}</span> --%>
		                        <span>가입일: <fmt:formatDate value="${member.joinDate}" pattern="yyyy.MM.dd"/></span>
		                    </div>
		                    <div class="member-actions">
							    <select class="role-select" data-emp-no="${member.empNo}" data-current-role="${member.roleNo}">
								    <option value="1" ${member.roleNo == 1 ? 'selected' : ''}>마스터</option>
								    <option value="2" ${member.roleNo == 2 ? 'selected' : ''}>부마스터</option>
								    <option value="3" ${member.roleNo == 3 ? 'selected' : ''}>일반회원</option>
								</select>
							    <button class="remove-member-btn" data-emp-no="${member.empNo}">추방</button>
							</div>
		                </div>
		            </c:forEach>
		        </div>
		    </div>
		</div>
		
		<!-- 멤버 초대 모달 -->
		<div id="inviteMemberModal" class="modal">
		    <div class="modal-content">
		        <div class="modal-header">
		            <h3>멤버 초대하기</h3>
		            <button type="button" class="close-btn">&times;</button>
		        </div>
		        <div class="modal-body">
		            <!-- 검색 영역 -->
		            <div class="search-section">
		                <div class="search-input-group">
		                    <input type="text" id="memberSearchInput" 
		                           name="empName" 
		                           class="search-input" 
		                           placeholder="이름으로 검색하세요...">
		                </div>
		            </div>
		            
		            <!-- 필터 섹션 -->
		            <div class="filter-section">
		                <div class="filter-group">
		                    <label>부서</label>
		                    <select name="deptNo" class="filter-select">
							    <option value="0">전체</option>
							    <c:forEach var="dept" items="${deptList}">
							        <option value="${dept.deptNo}">${dept.deptName}</option>
							    </c:forEach>
							</select>
		                </div>
		                <div class="filter-group">
		                    <label>직책</label>
		                    <select name="postNo" class="filter-select">
							    <option value="0">전체</option>
							    <c:forEach var="position" items="${positionList}">
							        <option value="${position.postNo}">${position.postName}</option>
							    </c:forEach>
							</select>
		                </div>
		            </div>
		
		            <!-- 검색 결과 목록 -->
		            <div class="member-list-section">
		                <div class="member-search-result">
		                    <!-- 검색 결과가 여기에 동적으로 추가됨 -->
		                </div>
		            </div>
		
		            <div class="select-all-section">
		                <label>
		                    <input type="checkbox" id="selectAllMembers">
		                    모든 검색결과 선택하기
		                </label>
		            </div>
		        </div>
		        <div class="modal-footer">
		            <button type="button" class="cancel-btn">닫기</button>
		            <button type="button" class="confirm-btn">초대하기</button>
		        </div>
		    </div>
		</div>
		
		<div class="nav-actions">
		            <button class="delete-btn">폐쇄하기</button>
		            <button type="submit" form="clubManageForm" class="save-btn">저장</button>
		        </div>
		
		<!-- 게시판 탭 콘텐츠 -->
		<div id="boards-tab" class="tab-content" style="display: none;">
		    <div class="settings-section">
		        <div class="section-header">
		            <h3>게시판 설정</h3>
		            <button class="add-board-btn">
		                <i class="fas fa-plus"></i> 새 게시판 만들기
		            </button>
		        </div>
		        <div class="board-list">
                    <div class="board-item">
                        <div class="board-info">
                            <i class="fas fa-comments"></i>
                            <span class="board-name">자유게시판</span>
                            <span class="post-count">25개의 글</span>
                        </div>
                        <div class="board-actions">
                            <button class="edit-btn">수정</button>
                            <button class="delete-btn">삭제</button>
                        </div>
                    </div>

                    <div class="board-item">
                        <div class="board-info">
                            <i class="fas fa-bullhorn"></i>
                            <span class="board-name">공지사항</span>
                            <span class="post-count">3개의 글</span>
                        </div>
                        <div class="board-actions">
                            <button class="edit-btn">수정</button>
                            <button class="delete-btn">삭제</button>
                        </div>
                    </div>

                    <div class="board-item">
                        <div class="board-info">
                            <i class="fas fa-image"></i>
                            <span class="board-name">사진게시판</span>
                            <span class="post-count">12개의 글</span>
                        </div>
                        <div class="board-actions">
                            <button class="edit-btn">수정</button>
                            <button class="delete-btn">삭제</button>
                        </div>
                    </div>
		
		        <div class="board-settings-list">
		            <div class="board-setting-item">
		                <div class="board-setting-header">
		                    <div class="board-basic-info">
		                        <i class="fas fa-comments"></i>
		                        <span class="board-name">자유게시판</span>
		                    </div>
		                    <div class="board-toggle">
		                        <label class="switch">
		                            <input type="checkbox" checked>
		                            <span class="slider"></span>
		                        </label>
		                    </div>
		                </div>
		                <div class="board-setting-content">
		                    <div class="setting-row">
		                        <label>게시판 설명</label>
		                        <input type="text" value="자유로운 주제로 대화를 나누는 공간입니다." class="form-input">
		                    </div>
		                    <div class="setting-row">
		                        <label>권한 설정</label>
		                        <select class="form-select">
		                            <option>모든 멤버 글쓰기 가능</option>
		                            <option>부마스터 이상 글쓰기 가능</option>
		                            <option>마스터만 글쓰기 가능</option>
		                        </select>
		                    </div>
		                    <div class="setting-row">
		                        <label>게시글 정렬</label>
		                        <select class="form-select">
		                            <option>최신순</option>
		                            <option>추천순</option>
		                            <option>조회순</option>
		                        </select>
		                    </div>
		                </div>
		            </div>
		
		            <div class="board-setting-item">
		                <div class="board-setting-header">
		                    <div class="board-basic-info">
		                        <i class="fas fa-bullhorn"></i>
		                        <span class="board-name">공지사항</span>
		                    </div>
		                    <div class="board-toggle">
		                        <label class="switch">
		                            <input type="checkbox" checked>
		                            <span class="slider"></span>
		                        </label>
		                    </div>
		                </div>
		                <div class="board-setting-content">
		                    <div class="setting-row">
		                        <label>게시판 설명</label>
		                        <input type="text" value="커뮤니티의 주요 공지사항을 안내하는 공간입니다." class="form-input">
		                    </div>
		                    <div class="setting-row">
		                        <label>권한 설정</label>
		                        <select class="form-select">
		                            <option>마스터만 글쓰기 가능</option>
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="nav-actions">
		            <button class="delete-btn">폐쇄하기</button>
		            <button type="submit" form="clubManageForm" class="save-btn">저장</button>
		        </div>
		
		<!-- 통계 탭 콘텐츠 -->
		<div id="stats-tab" class="tab-content" style="display: none;">
		    <div class="settings-section">
		        <div class="section-header">
		            <h3>커뮤니티 통계</h3>
		            <div class="period-selector">
		                <button class="period-btn active">주간</button>
		                <button class="period-btn">월간</button>
		                <button class="period-btn">연간</button>
		            </div>
		        </div>
		
		        <div class="stats-overview">
		            <div class="stat-card">
		                <div class="stat-title">총 멤버</div>
		                <div class="stat-value">127명</div>
		                <div class="stat-change increase">+12명</div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-title">총 게시글</div>
		                <div class="stat-value">1,234개</div>
		                <div class="stat-change increase">+89개</div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-title">총 댓글</div>
		                <div class="stat-value">3,456개</div>
		                <div class="stat-change increase">+234개</div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-title">일일 방문자</div>
		                <div class="stat-value">89명</div>
		                <div class="stat-change decrease">-5명</div>
		            </div>
		        </div>
		
		        <div class="stats-detail">
		            <div class="stats-chart">
		                <h4>활동 추이</h4>
		                <div class="chart-container">
		                    <!-- 차트가 들어갈 공간 -->
		                    <div class="placeholder-chart">
		                        <div class="chart-bar" style="height: 60%"></div>
		                        <div class="chart-bar" style="height: 80%"></div>
		                        <div class="chart-bar" style="height: 40%"></div>
		                        <div class="chart-bar" style="height: 90%"></div>
		                        <div class="chart-bar" style="height: 70%"></div>
		                        <div class="chart-bar" style="height: 50%"></div>
		                        <div class="chart-bar" style="height: 75%"></div>
		                    </div>
		                </div>
		            </div>
		
		            <div class="popular-content">
		                <h4>인기 게시글</h4>
		                <div class="popular-list">
		                    <div class="popular-item">
		                        <span class="rank">1</span>
		                        <span class="title">취미로 시작하는 프로그래밍</span>
		                        <span class="views">조회수 1,234</span>
		                    </div>
		                    <div class="popular-item">
		                        <span class="rank">2</span>
		                        <span class="title">주말 등산 모임 후기</span>
		                        <span class="views">조회수 987</span>
		                    </div>
		                    <div class="popular-item">
		                        <span class="rank">3</span>
		                        <span class="title">취미 공유 이벤트 안내</span>
		                        <span class="views">조회수 856</span>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>


<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<script>
$(document).ready(function() {
    // 페이지 로드시 첫번째 탭 콘텐츠만 표시
    // $('.tab-content:not(:first)').hide();
    $('.tab-content').not(':first').hide();
    
    // 탭 클릭 이벤트 처리
    $('.settings-tabs .tab').click(function() {
    var tabId = $(this).attr('data-tab');
    
    console.log('Tab clicked:', tabId);
    console.log('Stats tab visibility:', $('#' + tabId).is(':visible'));
    console.log('Stats tab height:', $('#' + tabId).height());
    console.log('Stats tab CSS:', {
        display: $('#stats-tab').css('display'),
        visibility: $('#stats-tab').css('visibility'),
        opacity: $('#stats-tab').css('opacity'),
        position: $('#stats-tab').css('position'),
        zIndex: $('#stats-tab').css('z-index')
    });
    
    // 기존 코드
    $('.settings-tabs .tab').removeClass('active');
    $(this).addClass('active');
    $('.tab-content').hide();
    $('#' + tabId).show();
});

    // 저장 버튼 클릭 이벤트
    $('.save-btn').click(function(e) {
        e.preventDefault();  
        
        $.ajax({
            url: '/community/club/updateAjax',
            type: 'POST',
            data: $('#clubManageForm').serialize(),
            success: function(response) {
                alert("수정이 완료되었습니다.");
                location.reload();
            },
            error: function() {
                alert('수정 중 오류가 발생했습니다.');
            }
        });
    });

    // 권한 변경 이벤트
    $('.role-select').change(function() {
        const empNo = $(this).data('emp-no');
        const roleNo = $(this).val();
        const clubNo = ${club.clubNo};
        
        if (confirm('권한을 변경하시겠습니까?')) {
            $.ajax({
                url: '/community/club/updateRole',
                type: 'POST',
                data: {
                    clubNo: clubNo,
                    empNo: empNo,
                    roleNo: roleNo
                },
                success: function(response) {
                    alert('권한이 변경되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('권한 변경 중 오류가 발생했습니다.');
                }
            });
        } else {
            $(this).val($(this).data('current-role'));
        }
    });

    // 멤버 검색 기능 (기존 멤버 목록)
    $('#memberSearch').on('keyup', function() {
        const searchText = $(this).val().toLowerCase();
        $('.member-item').each(function() {
            const memberName = $(this).find('.member-name').text().toLowerCase();
            if (memberName.includes(searchText)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    // 멤버 추방 버튼 이벤트
    $('.remove-member-btn').click(function() {
        const empNo = $(this).data('emp-no');
        const clubNo = ${club.clubNo};

        if (confirm('해당 멤버를 추방하시겠습니까?')) {
            $.ajax({
                url: '/community/club/kickMember',
                type: 'POST',
                data: {
                    clubNo: clubNo,
                    empNo: empNo,
                    memState: 3  // 3: 추방 상태
                },
                success: function(response) {
                    alert('멤버가 추방되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('멤버 추방 중 오류가 발생했습니다.');
                }
            });
        }
    });
    
    // 동호회 폐쇄 버튼 이벤트
    $('.delete-btn').click(function() {
        if (confirm('정말 동호회를 폐쇄하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
            const clubNo = ${club.clubNo};
            
            $.ajax({
                url: '/community/club/deleteClub',
                type: 'POST',
                data: { clubNo: clubNo },
                success: function(response) {
                    alert('동호회가 폐쇄되었습니다.');
                    window.location.href = '/community/club/list';
                },
                error: function() {
                    alert('동호회 폐쇄 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 멤버 초대 모달 관련 이벤트들
    // 모달 열기
    $('.invite-btn').click(function() {
        $('#inviteMemberModal').fadeIn();
        searchMembers(); // 모달 열릴 때 초기 검색 실행
    });

    // 모달 닫기
    $('.close-btn, .cancel-btn').click(function() {
        $('#inviteMemberModal').fadeOut();
    });

    // 모달 외부 클릭시 닫기
    $(window).click(function(e) {
        if ($(e.target).is('#inviteMemberModal')) {
            $('#inviteMemberModal').fadeOut();
        }
    });

    // 검색 및 필터링 함수
    function searchMembers() {
        const searchData = {
            empName: $('#memberSearchInput').val(),
            deptNo: $('select[name="deptNo"]').val(),
            postNo: $('select[name="postNo"]').val(),
            clubNo: ${club.clubNo}
        };
        
        $.ajax({
            url: '/community/club/inviteMemberList',
            type: 'GET',
            data: searchData,
            success: function(response) {
                const $resultContainer = $('.member-search-result');
                $resultContainer.empty();
                
                response.forEach(function(emp) {
                    const memberItem = `
                        <div class="member-item" data-emp-no="\${emp.empNo}">
                            <div class="member-info">
                                <img src="\${emp.empProfile || '/resources/upload/images/profile-default.png'}" 
                                     alt="Profile" class="member-profile">
                                <div class="member-details">
                                    <span class="member-name">\${emp.empName}</span>
                                    <span class="member-dept">\${emp.departmentVO.deptName}</span>
                                    <span class="member-position">\${emp.positionVO.postName}</span>
                                </div>
                            </div>
                            <button class="invite-action-btn">초대하기</button>
                        </div>
                    `;
                    $resultContainer.append(memberItem);
                });
            },
            error: function() {
                alert('멤버 검색 중 오류가 발생했습니다.');
            }
        });
    }

    // 검색 이벤트
    $('#memberSearchInput').on('keyup', function() {
        searchMembers();
    });

    // 필터 변경 이벤트
    $('.filter-select').on('change', function() {
        searchMembers();
    });

    // 초대하기 버튼 클릭 이벤트 (동적 생성된 요소)
    $(document).on('click', '.invite-action-btn', function() {
        const $btn = $(this);
        if ($btn.hasClass('invited')) {
            $btn.removeClass('invited').text('초대하기')
                .css({
                    'background-color': '#fff',
                    'color': '#228be6'
                });
        } else {
            $btn.addClass('invited').text('초대됨')
                .css({
                    'background-color': '#e9ecef',
                    'color': '#495057'
                });
        }
    });

    // 전체 선택 이벤트
    $('#selectAllMembers').change(function() {
        const isChecked = $(this).prop('checked');
        $('.member-item:visible').each(function() {
            const $btn = $(this).find('.invite-action-btn');
            if (isChecked && !$btn.hasClass('invited')) {
                $btn.click();
            } else if (!isChecked && $btn.hasClass('invited')) {
                $btn.click();
            }
        });
    });

    // 초대하기 최종 확인 버튼
    $('.confirm-btn').click(function() {
        const empNoList = [];
        $('.invite-action-btn.invited').each(function() {
            empNoList.push($(this).closest('.member-item').data('emp-no'));
        });

        if (empNoList.length === 0) {
            alert('초대할 멤버를 선택해주세요.');
            return;
        }

        $.ajax({
            url: '/community/club/inviteMembers',
            type: 'POST',
            data: {
                clubNo: ${club.clubNo},
                empNoList: empNoList
            },
            success: function(response) {
                alert(response.message || '선택한 멤버들을 초대했습니다.');
                $('#inviteMemberModal').fadeOut();
                location.reload();
            },
            error: function() {
                alert('멤버 초대 중 오류가 발생했습니다.');
            }
        });
    });
});
</script>

<%@ include file="../include/footer.jsp" %>