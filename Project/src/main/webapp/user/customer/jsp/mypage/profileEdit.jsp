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

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/profileEdit.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="edit-header">
                            <h2>회원 정보 변경</h2>
                        </div>
                        <div class="profile-container" id="profile-acticle">
                            <jsp:include page="./components/profile.jsp"></jsp:include>
                        </div>
                        <div class="retired-link-container">
                            <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#retiredCustomerModal">회원탈퇴</button>
                        </div>
                    </div>
                </div>

                <%-- footer --%>
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <%-- 회원정보 변경 모달 --%>
            <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">회원정보 변경</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="email-change-form">
                                <div class="form-group">
                                    <label>이메일</label>
                                    <input type="email" class="form-control email-input" id="email" name="email" placeholder="이메일" autoComplete="off" value="${sessionScope.customer_info.email}"/>
                                </div>
                                <div class="form-group">
                                    <label>휴대폰 번호</label>
                                    <input type="text" class="form-control verification-input" id="phone" name="phone" placeholder="휴대폰 번호" autoComplete="off" value="${sessionScope.customer_info.phone}"/>
                                </div>
                                <div class="change-button-container">
                                    <button type="button" class="btn btn-dark" id="btn-change" onclick="updateCustomer()">변경</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 비밀번호 변경 모달 --%>
            <div class="modal fade" id="changePwModal" tabindex="-1" role="dialog" aria-labelledby="changePwModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">비밀번호 변경</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="email-change-form">
                                <div class="form-group">
                                    <label>현재 비밀번호</label>
                                    <input type="password" class="form-control current-pw-input" id="current_pw" name="current_pw" placeholder="현재 비밀번호를 입력하세요" autoComplete="off"/>
                                </div>
                                <div class="form-group">
                                    <label>변경 비밀번호</label>
                                    <input type="password" class="form-control change-pw-input" id="change_pw" name="change_pw" placeholder="변경 비밀번호를 입력하세요" autoComplete="off"/>
                                </div>
                                <div class="form-group">
                                    <label>비밀번호 확인</label>
                                    <input type="password" class="form-control confirm-pw-input" id="confirm_pw" name="confirm_pw" placeholder="비밀번호를 재입력하세요" autoComplete="off"/>
                                </div>
                                <div class="change-button-container">
                                    <button type="button" class="btn btn-dark" id="btn-pw-change" onclick="updatePassword()">변경</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 회원 탈퇴 모달 --%>
            <div class="modal fade" id="retiredCustomerModal" tabindex="-1" role="dialog" aria-labelledby="retiredCustomerModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-body">
                            <h5 class="modal-title">정말 탈퇴 하시겠습니까?</h5>
                            <p class="modal-description">
                                탈퇴 후 계정 정보가 영구히 삭제되며 복구가 불가합니다.
                            </p>
                            <div class="modal-actions">
                                <button type="button" class="btn btn-outline-dark" data-dismiss="modal">취소</button>
                                <button type="button" class="btn btn-dark" onclick="retiredCustomer()">탈퇴</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <script>
                alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
                window.location.href = 'Controller?type=login';
            </script>
        </c:otherwise>
    </c:choose>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/mypage/profileEdit.js"></script>
</body>
</html>