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

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/pwConfirm.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <c:if test="${not empty valid}">
                <script>
                    if ("${valid}" === "true") {
                        window.location.href = "Controller?type=pwConfirm&action=update";
                    } else if ("${valid}" === "false") {
                        alert("비밀번호를 확인하세요.");
                    }
                </script>
            </c:if>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="password-confirm-container">
                            <div class="password-confirm-header">
                                <span class="password-title">비밀번호 입력</span>
                            </div>
                            <p class="password-instruction">정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 입력해주세요</p>
                            <div class="input-group password-input-container">
                                <input type="password" class="form-control password-input" placeholder="비밀번호 입력" id="cus_pw" name="cus_pw" autoComplete="off"/>
                            </div>
                            <small id="errorMessage" class="error-message">8자 이상 입력해 주십시오</small>
                            <div class="confirm-button-container">
                                <button class="btn btn-dark" id="btn-confirm" onclick="onCustomerConfirm()">완료</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <script>
                alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
                window.location.href = 'Controller?type=login';
            </script>
        </c:otherwise>
    </c:choose>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/mypage/pwConfirm.js"></script>
</body>
</html>
