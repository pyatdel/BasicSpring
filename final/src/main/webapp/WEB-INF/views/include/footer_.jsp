<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</div>
    </div>

    <script>

        // 모든 사이드바를 닫는 함수
function closeAllSidebars() {
    const sidebars = document.querySelectorAll('.mail-sidebar, .schedule-sidebar, .salary-sidebar, .prod-sidebar, .business-sidebar, .contract-sidebar, .cash-sidebar, .attendance-sidebar, .edu-sidebar, .pro-sidebar, .price-sidebar');
    sidebars.forEach(sidebar => sidebar.classList.remove('visible'));
}

// 메일 사이드바 토글
document.getElementById('mail-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('mail-sidebar').classList.toggle('visible');
});

// 일정 사이드바 토글
document.getElementById('schedule-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('schedule-sidebar').classList.toggle('visible');
});

// 급여 사이드바 토글
document.getElementById('salary-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('salary-sidebar').classList.toggle('visible');
});

// 고객 사이드바 토글
// document.getElementById('prod-menu').addEventListener('click', function() {
//     closeAllSidebars();
//     document.getElementById('prod-sidebar').classList.toggle('visible');
// });

// 영업 사이드바 토글
document.getElementById('business-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('business-sidebar').classList.toggle('visible');
});

// 계약 사이드바 토글
document.getElementById('contract-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('contract-sidebar').classList.toggle('visible');
});

// 매출 사이드바 토글
document.getElementById('cash-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('cash-sidebar').classList.toggle('visible');
});

// 근태 사이드바 토글
// document.getElementById('attendance-menu').addEventListener('click', function() {
//     closeAllSidebars();
//     document.getElementById('attendance-sidebar').classList.toggle('visible');
// });

// 소통 사이드바 토글
document.getElementById('edu-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('edu-sidebar').classList.toggle('visible');
});

// 프로필 사이드바 토글
// document.getElementById('pro-menu').addEventListener('click', function() {
//     closeAllSidebars();
//     document.getElementById('pro-sidebar').classList.toggle('visible');
// });

// 결재 사이드바 토글
document.getElementById('price-menu').addEventListener('click', function() {
    closeAllSidebars();
    document.getElementById('price-sidebar').classList.toggle('visible');
});



    </script>
</body>

</html>