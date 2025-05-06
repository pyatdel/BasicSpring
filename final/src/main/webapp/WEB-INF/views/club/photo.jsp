<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>

<!-- 라이브러리 include  -->
   <jsp:include page="../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
    
    <!-- Bootstrap 4 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- Lightbox CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css" rel="stylesheet">
 <title>사진 게시판</title>
    
    <style>
        /* 기본 레이아웃 */
        .community-board-wrapper {
            padding: 40px;
            background: #f8f9fa;
            min-height: calc(100vh - 60px);
        }

        /* 카드 스타일 */
        .card {
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s;
            height: 100%;
            margin-bottom: 0;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        .card-title {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .card-text {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .card-footer {
            background-color: transparent;
            border-top: 1px solid #eee;
            padding: 0.75rem 1.25rem;
        }

        .card-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 2;
        }

        /* 사용자 정보 */
        .user-info {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
        }

        .user-info img {
            width: 24px;
            height: 24px;
            margin-right: 8px;
        }

        /* 아이콘 및 카운터 */
        .card-footer i {
            margin-right: 4px;
        }

        /* 드롭다운 메뉴 */
        .dropdown-menu {
            font-size: 0.9rem;
        }

        .dropdown-item {
            padding: 0.5rem 1rem;
        }

        .dropdown-item i {
            width: 1.2rem;
        }

        /* Masonry 그리드 */
        .grid-item {
            width: 100%;
            padding: 10px;
            display: none;  /* 초기에 숨김 처리 */
        }

        @media (min-width: 768px) {
            .grid-item {
                width: 50%;
            }
        }

        @media (min-width: 992px) {
            .grid-item {
                width: 33.333%;
            }
        }

        @media (min-width: 1200px) {
            .grid-item {
                width: 25%;
            }
        }

        /* 더보기 버튼 */
        .btn-outline-success {
            padding: 0.75rem 2rem;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .community-board-wrapper {
                padding: 20px;
            }

            .btn-outline-success {
                width: 100%;
            }
        }
    </style>
</head>

<!-- 헤더 include  -->
   <jsp:include page="../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->

    <div class="container-fluid">
        <!-- 상단 정보 카드 -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2 class="mb-1">
                            <i class="fas fa-images text-success"></i> 사진게시판
                        </h2>
                        <p class="text-muted mb-0">연못에</p>
                    </div>
                    <div>
                        <button class="btn btn-success" onclick="location.href='photo-write.jsp'">
                            <i class="fas fa-upload"></i> 사진 올리기
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 필터 및 검색 -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <select class="form-control">
                            <option value="latest">최신순</option>
                            <option value="popular">인기순</option>
                            <option value="views">조회순</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-control">
                            <option value="12">12개씩 보기</option>
                            <option value="24">24개씩 보기</option>
                            <option value="36">36개씩 보기</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 사진 그리드 -->
        <div class="row" id="masonry-grid">
            <!-- 인기 사진 -->
            <div class="grid-item">
			    <div class="card h-100">
			        <div class="card-badge badge badge-danger">인기</div>
                    <a href="/api/placeholder/800/600" data-lightbox="gallery" 
			           data-title="지리산 정상에서 만난 새해 첫 일출">
			            <img src="/api/placeholder/400/300" class="card-img-top" alt="지리산 설경">
			        </a>
                    <div class="card-body">
                        <h5 class="card-title">지리산 정상에서 만난 새해 첫 일출</h5>
                        <p class="card-text">2024년 첫 산행, 정상에서 맞이한 일출이 정말 장관이었습니다!</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="user-info">
                                <img src="/api/placeholder/32/32" class="rounded-circle">
                                <span>산사랑</span>
                            </div>
                            <small class="text-muted">2024.01.01</small>
                        </div>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">
                            <i class="far fa-eye"></i> 521
                            <i class="far fa-heart ml-2"></i> 48
                            <i class="far fa-comment ml-2"></i> 23
                        </small>
                        <div class="dropdown float-right">
                            <button class="btn btn-link text-muted p-0" type="button" data-toggle="dropdown">
                                <i class="fas fa-ellipsis-v"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="#"><i class="fas fa-download mr-2"></i>다운로드</a>
                                <a class="dropdown-item" href="#"><i class="fas fa-share mr-2"></i>공유하기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 일반 사진들 -->
            <c:forEach var="i" begin="1" end="8" varStatus="status">
			    <div class="grid-item ${status.index > 3 ? 'hidden-item' : ''}">
			        <div class="card h-100">
			            <c:if test="${i <= 2}">
			                <div class="card-badge badge badge-danger">New</div>
			            </c:if>
                        <a href="/api/placeholder/800/600" data-lightbox="gallery" 
			               data-title="${i}번째 산행 사진">
			                <img src="/api/placeholder/400/${300 + i * 10}" class="card-img-top" alt="산행 사진">
			            </a>
                        <div class="card-body">
                            <h5 class="card-title">
                                <c:choose>
                                    <c:when test="${i == 1}">북한산 겨울 산행</c:when>
                                    <c:when test="${i == 2}">설악산 대청봉 야경</c:when>
                                    <c:when test="${i == 3}">한라산 등반 인증</c:when>
                                    <c:when test="${i == 4}">가을 단풍 산행</c:when>
                                    <c:otherwise>산행 추억 #${i}</c:otherwise>
                                </c:choose>
                            </h5>
                            <p class="card-text">
                                <c:choose>
                                    <c:when test="${i == 1}">겨울 북한산의 멋진 설경을 담아보았습니다.</c:when>
                                    <c:when test="${i == 2}">야간 산행에서 만난 환상적인 야경</c:when>
                                    <c:when test="${i == 3}">드디어 한라산 정상 등반 성공!</c:when>
                                    <c:when test="${i == 4}">가을의 마지막 단풍을 담아봤어요</c:when>
                                    <c:otherwise>즐거운 산행 현장을 공유합니다.</c:otherwise>
                                </c:choose>
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="user-info">
                                    <img src="/api/placeholder/32/32" class="rounded-circle">
                                    <span>등산러버${i}</span>
                                </div>
                                <small class="text-muted">2024.01.${30-i}</small>
                            </div>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">
                                <i class="far fa-eye"></i> ${200 + i * 10}
                                <i class="far fa-heart ml-2"></i> ${15 + i}
                                <i class="far fa-comment ml-2"></i> ${5 + i}
                            </small>
                            <div class="dropdown float-right">
                                <button class="btn btn-link text-muted p-0" type="button" data-toggle="dropdown">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href="#"><i class="fas fa-download mr-2"></i>다운로드</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-share mr-2"></i>공유하기</a>
                                    <c:if test="${true}">
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="#"><i class="fas fa-edit mr-2"></i>수정</a>
                                        <a class="dropdown-item text-danger" href="#"><i class="fas fa-trash-alt mr-2"></i>삭제</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 더보기 버튼 -->
        <div class="text-center mt-4 mb-4">
            <button class="btn btn-outline-success btn-lg">
                더보기 <i class="fas fa-chevron-down ml-2"></i>
            </button>
        </div>
    </div>
 <jsp:include page="../include/footer.jsp"></jsp:include>

<!-- JavaScript Dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
<script src="https://unpkg.com/imagesloaded@5/imagesloaded.pkgd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/js/lightbox.min.js"></script>

<script>
$(document).ready(function() {
    // Masonry 초기화
    var $grid = $('#masonry-grid');
    
    // 모든 그리드 아이템 초기 숨김
    $('.grid-item').hide();
    
    // Masonry 설정
    $grid.masonry({
        itemSelector: '.grid-item',
        percentPosition: true,
        transitionDuration: '0.2s'
    });
    
    // 이미지 로드 완료 후 처리
    $grid.imagesLoaded().progress(function(instance, image) {
        var $item = $(image.img).closest('.grid-item');
        if (!$item.hasClass('hidden-item')) {
            $item.show();
            $grid.masonry('layout');
        }
    });

    // 더보기 버튼 클릭 이벤트
    $('.btn-outline-success').click(function() {
        var $hiddenItems = $('.hidden-item');
        $hiddenItems.show();
        
        // 숨겨진 아이템들의 이미지가 로드된 후 레이아웃 재조정
        $grid.imagesLoaded().done(function() {
            $grid.masonry('layout');
        });
        
        // 모든 항목이 표시되면 더보기 버튼 숨김
        $(this).fadeOut();
    });

    // 정렬 변경 이벤트
    $('select').first().change(function() {
        var sortType = $(this).val();
        var $items = $('.grid-item').sort(function(a, b) {
            if (sortType === 'latest') {
                // 날짜 비교
                var dateA = new Date($(a).find('.text-muted').last().text());
                var dateB = new Date($(b).find('.text-muted').last().text());
                return dateB - dateA;
            } else if (sortType === 'popular') {
                // 좋아요 수 비교
                var likesA = parseInt($(a).find('.fa-heart').next().text());
                var likesB = parseInt($(b).find('.fa-heart').next().text());
                return likesB - likesA;
            } else {
                // 조회수 비교
                var viewsA = parseInt($(a).find('.fa-eye').next().text());
                var viewsB = parseInt($(b).find('.fa-eye').next().text());
                return viewsB - viewsA;
            }
        });

        $grid.empty().append($items);
        $grid.masonry('reloadItems').masonry('layout');
    });

    // 검색 기능
    $('.input-group button').click(function() {
        var searchText = $('.input-group input').val().toLowerCase();
        $('.grid-item').each(function() {
            var $item = $(this);
            var title = $item.find('.card-title').text().toLowerCase();
            var content = $item.find('.card-text').text().toLowerCase();
            var username = $item.find('.user-info span').text().toLowerCase();

            if (title.includes(searchText) || 
                content.includes(searchText) || 
                username.includes(searchText)) {
                $item.show();
            } else {
                $item.hide();
            }
        });
        $grid.masonry('layout');
    });

    // 검색어 입력 시 엔터키 처리
    $('.input-group input').keypress(function(e) {
        if (e.which === 13) {
            $('.input-group button').click();
        }
    });

    // Lightbox 설정
    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true,
        'albumLabel': "사진 %1 / %2",
        'fadeDuration': 300
    });

    // 이미지 에러 처리
    $('img').on('error', function() {
        $(this).attr('src', '/resources/images/no-image.png');
    });

    // 공유하기 버튼 클릭 이벤트
    $(document).on('click', '.dropdown-item', function(e) {
        var action = $(this).text().trim();
        if (action === '공유하기') {
            e.preventDefault();
            // 공유하기 기능 구현
            if (navigator.share) {
                navigator.share({
                    title: $(this).closest('.card').find('.card-title').text(),
                    text: $(this).closest('.card').find('.card-text').text(),
                    url: window.location.href
                });
            } else {
                alert('공유하기 기능을 지원하지 않는 브라우저입니다.');
            }
        }
    });

    // 삭제 버튼 클릭 이벤트
    $(document).on('click', '.text-danger', function(e) {
        e.preventDefault();
        if (confirm('정말 삭제하시겠습니까?')) {
            var $item = $(this).closest('.grid-item');
            $item.fadeOut(function() {
                $item.remove();
                $grid.masonry('layout');
            });
        }
    });
});
</script>
</html>