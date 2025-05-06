<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>마이페이지</title>
<link rel="stylesheet" href="/dash/css/bootstrap.min.css">
<link rel="stylesheet" href="/dash/css/style.css">
<link href="/img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
	<!-- 사이드바 -->
	<jsp:include page="./include/mangerSidebar.jsp"></jsp:include>

	<!-- 메인 컨텐츠 -->
	<div class="container mt-4">
		<div class="row">
			<!-- 프로필 사진 카드 -->
			<div class="col-md-4">
				<div class="card text-center shadow-sm">
					<div class="card-body">
						<img
							src="${userInfo.empProfile != null ? userInfo.empProfile : '/img/default-profile.png'}"
							alt="User Profile" class="rounded-circle mb-3"
							style="width: 300px; height: 380px;">
						<h4>${userInfo.empName}</h4>
					</div>
				</div>
			</div>
			<!-- 프로필 정보 카드 -->
			<div class="col-md-8">
				<div class="card shadow-sm">
					<div class="card-body2">
						<p>
							<strong>사번:</strong> ${userInfo.empId}
						</p>
						<p>
							<strong>부서:</strong> ${userInfo.deptNo}
						</p>
						<p>
							<strong>직급:</strong> ${userInfo.postNo}
						</p>
						<p>
							<strong>연락처:</strong> ${userInfo.empPhone}
						</p>
						<p>
							<strong>이메일:</strong> ${userInfo.empEmail}
						</p>
						<p>
							<strong>주소:</strong> ${userInfo.empStreet} ${userInfo.empDetail}
						</p>
						<button type="button" id="openModal" class="btn btn-primary">수정하기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 휴가 정보 테이블 -->
		<div class="mt-4">
			<div class="card shadow-sm">
				<div class="card-body">
					<table class="table table-bordered">
						<thead class="table-light">
							<tr>
								<th>올해 부여한 휴가 횟수</th>
								<th>사용한 휴가 횟수</th>
								<th>남은 휴가 횟수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${userInfo.empAnnual}</td>
								<td>${userInfo.empAnnual}</td>
								<td>${userInfo.empAnnual}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- 모달 -->
	<div id="editModal" class="modal" tabindex="-1" role="dialog"
		style="display: none;">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">정보 수정</h5>
					<button type="button" class="btn-close" id="closeModal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="editForm" action="/adminmain/adminprofile/edit" method="post"
						enctype="multipart/form-data">
						<div class="form-group">
							<label for="empName">이름:</label> <input type="text" id="empName"
								name="empName" class="form-control" value="${userInfo.empName}"
								required>
						</div>
						<div class="form-group">
							<label for="empEmail">이메일:</label> <input type="email"
								id="empEmail" name="empEmail" class="form-control"
								value="${userInfo.empEmail}" required>
						</div>
						<div class="form-group">
							<label for="empPhone">전화번호:</label> <input type="text"
								id="empPhone" name="empPhone" class="form-control"
								value="${userInfo.empPhone}" required>
						</div>
						<div class="form-group">
							<label for="empDetail">주소:</label> <input type="text" class="form-control form-control-user"
                           id="empZip" name="empZip" placeholder="우편번호" readonly onclick="sample4_execDaumPostcode()">
						</div>
						<div class="form-group">
							<input type="text" class="form-control form-control-user" id="empStreet" name="empStreet" placeholder="도로명 주소" readonly>
						</div>
						<div class="form-group">
							<input type="text" class="form-control form-control-user" id="empDetail" name="empDetail" placeholder="상세 주소" onclick="addrCheck()">
						</div>
						<div class="form-group">
							<label for="profileImage">프로필 사진:</label> <input type="file"
								id="profileImage" name="profileImage" class="form-control"
								accept="image/*">
							<!-- 기존 이미지 경로 유지 -->
							<input type="hidden" id="currentProfileImage"
								name="currentProfileImage" value="${userInfo.empProfile}">
							<!-- 이미지 미리보기 -->
							<div class="mt-3">
								<img id="imagePreview"
									src="${userInfo.empProfile != null ? userInfo.empProfile : '/img/default-profile.png'}"
									alt="이미지 미리보기" class="rounded-circle"
									style="width: 150px; height: 150px; object-fit: cover;">
							</div>
						</div>
						<button type="submit" class="btn btn-primary">저장</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		// 모달 열기
		document.getElementById("openModal").onclick = function() {
			document.getElementById("editModal").style.display = "block";
		};

		// 모달 닫기
		document.getElementById("closeModal").onclick = function() {
			document.getElementById("editModal").style.display = "none";
		};

		document
				.getElementById('profileImage')
				.addEventListener(
						'change',
						function(event) {
							const file = event.target.files[0];
							if (file) {
								// 파일 형식 검증 (JPG, PNG, GIF만 허용)
								const allowedExtensions = [ 'image/jpeg',
										'image/png', 'image/gif' ];
								if (!allowedExtensions.includes(file.type)) {
									alert('JPG, PNG, GIF 형식의 파일만 업로드 가능합니다.');
									event.target.value = ''; // 선택 초기화
									return;
								}

								// 파일 크기 검증 (2MB 제한)
								const maxSize = 2 * 1024 * 1024; // 2MB
								if (file.size > maxSize) {
									alert('파일 크기는 2MB를 초과할 수 없습니다.');
									event.target.value = ''; // 선택 초기화
									return;
								}

								// 이미지 미리보기
								const reader = new FileReader();
								reader.onload = function(e) {
									document.getElementById('imagePreview').src = e.target.result;
								};
								reader.readAsDataURL(file);
							}
						});
	</script>
	
	<!-- api 영역 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample4_execDaumPostcode(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	// 우편번호
	                $("#empZip").val(data.zonecode);
	                // 도로명 및 지번주소
	                $("#empStreet").val(data.roadAddress);
	            }
	        }).open();
	    }
	</script>
	<script type="text/javascript">
	    function addrCheck() {
	        if($("#empZip").val() == '' && $("#empStreet").val() == ''){
	            alert("우편번호를 클릭하여 주소를 검색해주세요.");
	            $("#empZip").focus();
	        }
    }
</script>
