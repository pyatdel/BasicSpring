<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<%@ include file="../include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<%@ include file="../include/sidebar.jsp" %>


<!-- ///// content 시작 ///// -->

<button id="kaobtn" style="background: #fee500; color:#000; border-radius: 12px; padding: 10px 20px;">카카오페이</button>

<script type="text/javascript">
    // 카카오페이 결제 팝업창 연결
    $(function() {
        $("#kaobtn").click(function(e) {
            // 아래 데이터 외에도 필요한 데이터를 원하는 대로 담고, Controller에서 @RequestBody로 받으면 됨
            let data = {
                name: '상품명',    // 카카오페이에 보낼 대표 상품명
                totalPrice: 20000 // 총 결제금액
            };
          
            $.ajax({
                type: 'GET',
                url: '/cash/cashList/',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function(response) {
                    location.href = response.next_redirect_pc_url;
                }
            });
        });
    });
</script>
<!-- ///// content 끝 ///// -->

<%@ include file="../include/footer.jsp" %>   
	