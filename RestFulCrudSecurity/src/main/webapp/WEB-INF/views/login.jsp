<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="./include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- ///// content 시작 ///// -->

<section class="d-flex vh-100">
  <div class="container-fluid row justify-content-center align-content-center">
    <div class="card bg-dark" style="border-radius: 1rem;">
      <div class="card-body p-5 text-center">
        <h2 class="text-white">LOGIN</h2>
        <p class="text-white-50 mt-2 mb-5">서비스를 사용하려면 로그인을 해주세요!</p>

        <div class = "mb-2">
        <!-- 
        요청 URI : /login : (스프링 시큐리티와 약속된 URI)
        요청 파라미터 : request{username=test@test.com,password=java}
        요청 방식 : post
        
         -->
          <form action="/login" method="POST">
<%--             <input type="hidden" name="${_csrf?.parameterName}" value="${_csrf?.token}" /> --%>
            <div class="mb-3">
              <label class="form-label text-white">Email address</label>
              <input type="email" class="form-control" name="username"
              	required placeholder="이메일 아이디를 작성해주세요" />
            </div>
            <div class="mb-3">
              <label class="form-label text-white">Password</label>
              <input type="password" class="form-control" name="password"
              	required placeholder="비밀번호를 입력해주세요" />
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
          </form>

          <button type="button" class="btn btn-secondary mt-3" onclick="location.href='/signup'">회원가입</button>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ///// content 끝 ///// -->

<%@ include file="./include/footer.jsp" %>   
