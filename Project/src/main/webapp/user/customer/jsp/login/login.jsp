<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/login/login.css"/>
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
    <c:if test="${not empty sessionScope.isLoggedIn and not sessionScope.isLoggedIn}">
        <script>
            alert("아이디 또는 비밀번호를 확인하세요.");
        </script>
    </c:if>

    <div class="card shadow p-4" style="width: 22rem;">
        <h1 class="text-center mb-4">MUSINSA</h1>
        <form action="Controller?type=login" method="POST">
            <div class="mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="아이디" autocomplete="off">
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" autocomplete="off">
            </div>
            <button type="submit" class="btn btn-dark w-100 mb-2">로그인</button>
            <%--<button type="button" class="btn btn-warning w-100 text-dark kakao-login-btn" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=274018667b4194489ad21f128fe91165&redirect_uri=http://localhost:8080/Controller?type=kakaoCallback'">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none" class="login-v2-button__item__logo"><title>kakao 로고</title><path fill-rule="evenodd" clip-rule="evenodd" d="M9.96052 3C5.83983 3 2.5 5.59377 2.5 8.79351C2.5 10.783 3.79233 12.537 5.75942 13.5807L4.9313 16.6204C4.85835 16.8882 5.1634 17.1029 5.39883 16.9479L9.02712 14.5398C9.33301 14.5704 9.64386 14.587 9.96052 14.587C14.0812 14.587 17.421 11.9932 17.421 8.79351C17.421 5.59377 14.0812 3 9.96052 3Z" fill="black"></path></svg>
                카카오 로그인
            </button>--%>
        </form>
        <div class="d-flex justify-content-between mt-3">
            <a href="Controller?type=signup" class="text-decoration-none text-muted">회원가입</a>
            <a href="Controller?type=login&action=find" class="text-decoration-none text-muted">비밀번호 찾기</a>
        </div>
    </div>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
