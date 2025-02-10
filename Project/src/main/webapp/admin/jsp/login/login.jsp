<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Musinsa Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
<div class="card shadow p-4" style="width: 22rem;">
    <h1 class="text-center mb-4">MUSINSA</h1>
    <form action="Controller?type=adminlogin" method="POST">
        <div class="mb-3">
            <input type="text" class="form-control" id="username" name="username" placeholder="아이디">
        </div>
        <div class="mb-3">
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
        </div>
        <button type="submit" class="btn btn-dark w-100 mb-2">로그인</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
