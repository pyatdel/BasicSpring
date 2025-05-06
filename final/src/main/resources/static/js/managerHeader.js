// 서브메뉴 토글
const submenuToggles = document.querySelectorAll('.submenu-toggle');
submenuToggles.forEach(toggle => {
    toggle.addEventListener('click', function() {
        const sidebar = document.getElementById("mySidebar");
        const subMenu = this.nextElementSibling;

        // 사이드바가 열렸을 때만 서브 메뉴 열린다 
        if (sidebar.classList.contains('open')) {
            const isOpen = subMenu.style.display === 'block';

            if (isOpen) {
                subMenu.style.display = 'none';
                subMenu.style.height = '0';
            } else {
                subMenu.style.display = 'block';
                subMenu.style.height = `${subMenu.scrollHeight}px`;
            }
        }
    });
});

// 사이드바 열기
function openNav() {
    document.getElementById("mySidebar").classList.add('open');
    document.getElementById("myOverlay").classList.add('open');
    document.querySelector('.content').style.width = 'calc(100% - 250px)';  // 사이드바 열릴때 content 너비 조정
    document.querySelector('.content').style.marginLeft = '250px';  // 콘텐츠 왼쪽 여백

    // 사이드바 펼칠때 서브메뉴 보임
    const submenuLinks = document.querySelectorAll('.submenu-toggle + .sub-menu');
    submenuLinks.forEach(subMenu => {
        subMenu.style.display = 'none';  // 서브 메뉴 숨김
    });

    // 메뉴 버튼 사이드바 따라다니게
    document.querySelector('.menu-btn').classList.add('open');
}

// 사이드바 닫기
function closeNav() {
    document.getElementById("mySidebar").classList.remove('open');
    document.getElementById("myOverlay").classList.remove('open');
    document.querySelector('.content').style.width = '96%';  // 사이드바 닫히면 콘텐츠 영역 너비 원래대로
    document.querySelector('.content').style.marginLeft = '70px';  // 사이드바 너비만큼 왼쪽 여백

    // 사이드바 접힐 때 서브 메뉴 숨김
    const submenuLinks = document.querySelectorAll('.submenu-toggle + .sub-menu');
    submenuLinks.forEach(subMenu => {
        subMenu.style.display = 'none';  
        subMenu.style.height = '0';
    });

    // 메뉴 버튼 위치 원래대로
    document.querySelector('.menu-btn').classList.remove('open');
}

let sidebar =document.querySelector(".sidebar")
let menubtn =document.querySelector(".menu-btn")
// 메뉴 버튼 클릭 시 사이드바 열고 닫기
document.querySelector('.menu-btn').addEventListener('click', function() {
    const sidebar = document.getElementById("mySidebar");
    if (sidebar.classList.contains('open')) {
        sidebar.style.transition="0.35s"
        menubtn.style.transition='left 0.35s ease'
        closeNav();
    } else {
        openNav();
		menubtn.style.transition='none !important'
    }
});

document.getElementById("adminMenu").style.display = "block"; 
    document.getElementById("empSidebar").style.display = "none";  // 관리자 메뉴 보이기
// 관리자 모드
document.getElementById("adminModeBtn").addEventListener("click", function() {
    document.getElementById("adminMenu").style.display = "block";  // 관리자 메뉴 보이기
    document.getElementById("empSidebar").style.display = "none";  // 관리자 메뉴 보이기
});

// 직원 모드
document.getElementById("employeeModeBtn").addEventListener("click", function() {
    document.getElementById("adminMenu").style.display = "none";  // 관리자 메뉴 숨기기
    document.getElementById("empSidebar").style.display = "block";  // 직원 메뉴 보이기
});

// 드롭다운
function toggleDropdown(dropdownId) {
    const dropdowns = document.querySelectorAll('.dropdown-content');
    dropdowns.forEach(dropdown => {
        if (dropdown.id !== dropdownId) {
            dropdown.style.display = 'none';
        }
    });

    const dropdown = document.getElementById(dropdownId);
    if (dropdown.style.display === 'block') {
        dropdown.style.display = 'none';
    } else {
        dropdown.style.display = 'block';
    }
}

// 클릭한 메뉴 ID 저장 변수
let lastClicked = null;

function changeColor(event, menuId) {
    event.preventDefault(); 

    // 클릭 메뉴 ID 맞는 요소
    const clickedElement = document.getElementById(menuId);
    const upclickdElement = document.getElementById("employeeModeBtn");
    upclickdElement.style.color = 'rgb(22 22 22)'; // 색 리셋

    // 이전 메뉴 색 리셋
    if (lastClicked && lastClicked !== clickedElement) {
        lastClicked.style.color = 'rgb(22 22 22)'; // 색 리셋
        upclickdElement.style.color = 'rgb(22 22 22)'; // 색 리셋
        clickedElement.style.fontWeight = 'lighter'; 
    }

    // 클릭된 메뉴 색상 변경
    clickedElement.style.color = 'rgb(0, 156, 255)';
    clickedElement.style.fontWeight = 'bold'; 

    // 마지막 클릭 메뉴 업데이트
    lastClicked = clickedElement;
}

// 페이지 로드 시 사이드바를 열리도록 기본 설정
window.addEventListener('DOMContentLoaded', function() {
    openNav();  // 사이드바가 기본적으로 열리도록 설정
});

/* 
        // window 클릭시 드롭다운 닫기
        window.addEventListener('click', function(event) {
            const dropdowns = document.querySelectorAll('.dropdown-content');
            dropdowns.forEach(dropdown => {
                if (!event.target.matches('.dropdown-toggle') && !event.target.closest('.dropdown-content')) {
                    dropdown.style.display = 'none';
                }
            });
        });
*/