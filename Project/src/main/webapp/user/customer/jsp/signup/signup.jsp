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

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/signup/signup.css"/>
</head>
<body class="bg-light">
    <c:if test="${not empty requestScope.is_exists and requestScope.is_exists eq true}">
        <script>
            alert("이미 존재하는 아이디입니다.");
        </script>
    </c:if>

    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow p-4 w-100" style="max-width: 500px;">
            <!-- MUSINSA 로고 -->
            <h1 class="text-center fw-bold mb-4">MUSINSA</h1>

            <!-- 아이디 -->
            <div class="input-group mb-3">
                <label for="cus_id" class="form-label" style="width: 100%">아이디</label>
                <input type="text" class="form-control" id="cus_id" name="cus_id"  maxlength="30" placeholder="아이디를 입력하세요" autocomplete="off" required>
                <div class="input-group-append">
                    <button class="btn btn-dark" type="button" onclick="onCheckCusId()">아이디 확인</button>
                </div>
            </div>

            <!-- 비밀번호 -->
            <div class="mb-3">
                <label for="cus_pw" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="cus_pw" name="cus_pw" placeholder="비밀번호를 입력하세요" maxlength="30" autocomplete="off" required>
            </div>

            <!-- 이름 -->
            <div class="mb-3">
                <label for="cus_name" class="form-label">이름</label>
                <input type="text" class="form-control" id="cus_name" name="cus_name" placeholder="이름을 입력하세요" maxlength="50" autocomplete="off" required>
            </div>

            <!-- 닉네임 -->
            <div class="mb-3">
                <label for="cus_nickname" class="form-label">닉네임</label>
                <input type="text" class="form-control" id="cus_nickname" name="cus_nickname" placeholder="닉네임을 입력하세요" maxlength="50" autocomplete="off" required>
            </div>

            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="cus_gender" id="gender_m" value="1" required>
                    <label class="form-check-label" for="gender_m">남성</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="cus_gender" id="gender_w" value="2" required>
                    <label class="form-check-label" for="gender_w">여성</label>
                </div>
            </div>

            <!-- 생년월일 -->
            <div class="mb-3">
                <label for="cus_birth" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="cus_birth" name="cus_birth" required>
            </div>

            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="cus_phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="cus_phone" name="cus_phone" placeholder="전화번호를 입력하세요" maxlength="30" autocomplete="off" required>
            </div>

            <!-- 이메일 -->
            <div class="mb-3">
                <label for="cus_email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="cus_email" name="cus_email" placeholder="이메일을 입력하세요" maxlength="100" autocomplete="off" required>
            </div>

            <!-- 주소 -->
            <div class="mb-3">
                <div class="input-group mb-3">
                    <label for="pos_code" class="form-label" style="width: 100%;">주소</label>
                    <input type="text" class="form-control" placeholder="우편번호" id="pos_code" name="pos_code" autocomplete="off" required/>
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button" onclick="onGetPostcode()">우편번호 찾기</button>
                    </div>
                </div>
                <div>
                    <input type="text" class="form-control" id="addr1" name="addr1" placeholder="주소" autocomplete="off"/><br/>
                    <input type="text" class="form-control" id="addr2" name="addr2" placeholder="상세주소" autocomplete="off"/><br/>
                </div>
            </div>

            <!-- 키 -->
            <div class="mb-3">
                <label for="height" class="form-label">키</label>
                <input type="number" class="form-control" id="height" name="height" placeholder="키(cm)를 입력하세요" autocomplete="off">
            </div>

            <!-- 몸무게 -->
            <div class="mb-3">
                <label for="weight" class="form-label">몸무게</label>
                <input type="number" class="form-control" id="weight" name="weight" placeholder="몸무게(kg)를 입력하세요" autocomplete="off">
            </div>

            <!-- 회원가입 버튼 -->
            <button type="button" class="btn btn-dark w-100" onclick="insertCustomer()">회원가입</button>

            <div class="d-flex justify-content-center mt-3">
                <a href="../index.jsp" class="text-decoration-none text-muted">이전 페이지</a>
            </div>
        </div>
    </div>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <%-- 카카오맵 --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="./user/customer/js/signup/signup.js"></script>
</body>
</html>
