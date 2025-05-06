<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
  <style>
.community-create-wrapper {
    padding: 30px;
    background: #f8f9fa;
    min-height: calc(100vh - 60px);
}

.create-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid #dee2e6;
}

.page-title {
    font-size: 24px;
    font-weight: 600;
    color: #333;
}

.header-buttons {
    display: flex;
    gap: 10px;
}

.cancel-btn, .submit-btn {
    padding: 8px 20px;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
}

.cancel-btn {
    background: white;
    border: 1px solid #dee2e6;
    color: #495057;
}

.submit-btn {
    background: #007bff;
    border: none;
    color: white;
}

.create-content {
    max-width: 800px;
    margin: 0 auto;
}

.section {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

.section-title {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 24px;
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: 500;
    color: #212529;
}

.required {
    color: #dc3545;
    margin-left: 4px;
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

.input-desc {
    margin-top: 6px;
    font-size: 12px;
    color: #6c757d;
}

.icon-selector {
    display: flex;
    align-items: center;
    gap: 15px;
}

.selected-icon {
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

.icon-select-btn {
    padding: 8px 16px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    background: white;
    color: #495057;
    cursor: pointer;
}

.setting-options {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.setting-option {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    cursor: pointer;
}

.setting-option:hover {
    background: #f8f9fa;
}

.setting-option input[type="radio"] {
    margin-top: 4px;
}

.option-title {
    font-weight: 500;
    margin-bottom: 4px;
}

.option-desc {
    font-size: 14px;
    color: #6c757d;
}

.board-type {
    margin-top: 20px;
}

.type-options {
    display: flex;
    gap: 20px;
    margin-top: 15px;
}

.type-option {
    text-align: center;
    cursor: pointer;
}

.type-preview {
    width: 200px;
    height: 120px;
    border: 2px solid #dee2e6;
    border-radius: 4px;
    margin-bottom: 8px;
}

.type-option.active .type-preview {
    border-color: #007bff;
}

.type-name {
    font-size: 14px;
    color: #495057;
}

.type-preview.classic {
    background: url('/images/board-classic.png') center/cover;
}

.type-preview.feed {
    background: url('/images/board-feed.png') center/cover;
}
</style>  
   </head>
   
<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->
   
<!-- 동호회 개설 컨텐츠 시작 -->
<form action="/community/club/insertPost" method="post" enctype="multipart/form-data" class="community-create-wrapper">
    <div class="create-header">
        <h2 class="page-title">동호회 개설</h2>
        <div class="header-buttons">
            <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
            <button type="submit" class="submit-btn">개설하기</button>
        </div>
    </div>

    <div class="create-content">
        <!-- 기본 정보 섹션 -->
        <div class="section">
            <h3 class="section-title">기본 정보</h3>
            <div class="form-group">
                <label class="form-label">동호회 이름 <span class="required">*</span></label>
                <input type="text" name="clubName" class="form-input" placeholder="동호회 이름을 입력해주세요" required>
                <p class="input-desc">2~20자 이내로 입력해주세요</p>
            </div>
            
            <div class="form-group">
                <label for="clubCate">커뮤니티 선택 <span class="required">*</span></label>
                <select class="form-control" id="clubCate" name="clubCategoryVO.clubCateNo" required>
				    <option value="">동호회 분류를 선택하세요</option>
				    <c:forEach var="clubCategoryVO" items="${clubCategoryVOList}">
				        <option value="${clubCategoryVO.clubCateNo}">${clubCategoryVO.clubCateName}</option>
				    </c:forEach>
				</select>
            </div>
            
            <div class="form-group">
                <label class="form-label">동호회 설명 <span class="required">*</span></label>
                <textarea name="clubDesc" class="form-textarea" placeholder="동호회에 대한 설명을 입력해주세요" required></textarea>
                <p class="input-desc">최대 200자까지 입력 가능합니다</p>
            </div>

            <div class="form-group">
                <label class="form-label">동호회 아이콘</label>
                <div class="icon-selector">
                    <div class="selected-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <input type="file" name="uploadFile" id="uploadFile" style="display: none">
                    <button type="button" class="icon-select-btn" onclick="document.getElementById('uploadFile').click()">아이콘 선택</button>
                </div>
            </div>
        </div>

        <!-- 공개 설정 섹션 -->
        <div class="section">
            <h3 class="section-title">공개 설정</h3>
            <div class="setting-options">
                <div class="setting-option">
                    <input type="radio" name="clubSec" id="public" value="1" checked>
                    <label for="public">
                        <div class="option-title">
                            <i class="fas fa-globe"></i> 공개
                        </div>
                        <div class="option-desc">
                            모든 구성원이 동호회와 게시글을 볼 수 있습니다
                        </div>
                    </label>
                </div>

                <div class="setting-option">
                    <input type="radio" name="clubSec" id="private" value="2">
                    <label for="private">
                        <div class="option-title">
                            <i class="fas fa-lock"></i> 비공개
                        </div>
                        <div class="option-desc">
                            동호회 멤버만 게시글을 볼 수 있습니다
                        </div>
                    </label>
                </div>
            </div>
        </div>

        <!-- 게시판 설정 섹션 -->
        <div class="section">
            <h3 class="section-title">게시판 설정</h3>
            <div class="board-settings">
                <div class="board-type">
                    <label class="form-label">게시판 유형</label>
                    <div class="type-options">
                        <div class="type-option active">
                            <input type="radio" name="clubPat" value="1" id="typeClassic" checked style="display: none;">
                            <label for="typeClassic">
                                <div class="type-preview classic"></div>
                                <div class="type-name">클래식형</div>
                            </label>
                        </div>
                        <div class="type-option">
                            <input type="radio" name="clubPat" value="2" id="typeFeed" style="display: none;">
                            <label for="typeFeed">
                                <div class="type-preview feed"></div>
                                <div class="type-name">피드형</div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden fields -->
        <input type="hidden" name="clubCreMem" value="${userInfo.empNo}">
        <input type="hidden" name="empNo" value="${userInfo.empNo}">
<%@ include file="../include/footer.jsp" %>
    </div>
</form>


 
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 커뮤니티 개설 컨텐츠 끝 -->


</html>