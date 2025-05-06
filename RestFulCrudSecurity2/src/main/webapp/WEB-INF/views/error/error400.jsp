<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<!-- 
../ : views폴더(부모)
 -->
<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

<!-- Main content -->

<!-- 
../ : views폴더(부모)
 -->
<!-- ///// header 시작 ///// -->
<jsp:include page="../include/header.jsp"></jsp:include>
<!-- ///// header 끝 ///// -->

<!-- Main content -->

<section class="content">
	<div class="error-page">
		<h2 class="headline text-warning">400</h2>
		<div class="error-content">
			<h3>
				<i class="fas fa-exclamation-triangle text-warning"></i> Bad Request
			</h3>
			<p>
				URL이 잘못 입력되었습니다. 만약, 메인으로 이동하고자 하면
				<a href="/">메인</a> 을 클릭해주세요.
			</p>
			<form class="search-form">
				<div class="input-group">
					<input type="text" name="search" class="form-control"
						placeholder="Search">
					<div class="input-group-append">
						<button type="submit" name="submit" class="btn btn-warning">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>

			</form>
		</div>

	</div>

</section>

<!-- ///// footer 시작 ///// -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<!-- ///// footer 끝 ///// -->  