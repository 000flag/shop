<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-14
  Time: 오후 3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 유형 선택</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">개인회원 또는 기업회원을 선택해 주세요.</h2>
    <div class="row justify-content-center">
        <!-- 개인회원 -->
        <div class="col-md-4 text-center">
            <div class="card shadow-sm">
                <div class="card-body">
                    <i class="bi bi-person-circle display-4 text-primary"></i>
                    <h5 class="card-title mt-3">개인회원</h5>
                    <a href="personalSignUp.jsp" class="btn btn-primary mt-2">가입하기</a>
                </div>
            </div>
        </div>
        <!-- 기업회원 -->
        <div class="col-md-4 text-center">
            <div class="card shadow-sm">
                <div class="card-body">
                    <i class="bi bi-buildings display-4 text-primary"></i>
                    <h5 class="card-title mt-3">기업회원</h5>
                    <a href="companySignUp.jsp" class="btn btn-primary mt-2">가입하기</a>
                </div>
            </div>
        </div>
    </div>
</div>
 <form action="Controller?type=admin" method="post"></form>

<!-- Bootstrap JS and icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>

