<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-01-14
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    String nickname = (String) session.getAttribute("nickname");
    boolean isLoggedIn = (nickname != null);
%>




<html>
<header>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <%--    <link rel="stylesheet" href="css/styles.css">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <nav class="navbar navbar-expand-lg bg-dark navbar-dark">
        <div class="container-fluid">
            <!-- 로고 -->
            <a class="navbar-brand fw-bold text-white" href="./shop/seller/jsp/index.jsp" style="font-size: 1.8rem;">MUSINSA</a>

            <!-- 검색창 -->


            <!-- 네비게이션 메뉴 -->

        </div>
    </nav>
    <div class="index header d-flex align-items-center p-3 bg-light border-bottom">
        <!-- 왼쪽: 로그인 버튼 -->
        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${not empty sessionScope.name}">
                    <span class="me-2">환영합니다, <strong>${sessionScope.name}님</strong></span>
                    <button type="button" class="btn btn-outline-danger"
                            onclick="location.href='Controller?type=adminlogout';">로그아웃</button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-outline"
                            onclick="location.href='Controller?type=adminlogout';">로그인</button>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 중앙: 바로접속 ~ 고객센터 -->
        <div class="d-flex gap-3 align-items-center justify-content-center flex-grow-1">
            <a href="${pageContext.request.contextPath}/Controller?type=adminindex" class="text-decoration-none text-dark">대시보드</a>

            <a href="${pageContext.request.contextPath}/Controller?type=sellermain" class="text-decoration-none text-dark">판매자관리</a>
            <a href="${pageContext.request.contextPath}/Controller?type=customermain" class="text-decoration-none text-dark">구매자관리</a>
            <a href="${pageContext.request.contextPath}/Controller?type=categorymain" class="text-decoration-none text-dark">카테고리관리</a>
            <a href="${pageContext.request.contextPath}/Controller?type=boardmain" class="text-decoration-none text-dark">게시판관리</a>
            <a href="${pageContext.request.contextPath}/Controller?type=couponmain" class="text-decoration-none text-dark">쿠폰관리</a>
            <a href="${pageContext.request.contextPath}/Controller?type=logsee" class="text-decoration-none text-dark">로그확인</a>
        </div>

    </div>
</header>
</html>
