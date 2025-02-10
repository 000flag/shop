<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-16
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <%--    <link rel="stylesheet" href="css/styles.css">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- 제이쿼리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Style -->
    <link rel="stylesheet" href="/user/css/SnapHeader.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/story.css">
    <link rel="stylesheet" href="/css/popular.css">
    <link rel="stylesheet" href="/user/css/SnapProfile.css">
    <link rel="stylesheet" href="/css/upload.css">
    <link rel="stylesheet" href="/css/update.css">
    <link rel="shortcut icon" href="/images/insta.svg">

    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
          rel="stylesheet">
</head>

<body>
<!--principalId 담아두기 -->
<input type="hidden" id="principalId" value="${principal.user.id}" />
<header class="header">
    <div class="container">
        <a href="/" class="logo">
<%--            <img src="/images/logo.jpg" alt="">--%>
            <h2>MUSINSA</h2>
        </a>
        <nav class="navi">
            <ul class="navi-list">
                <li class="navi-item"><a href="/">
                    <i class="fas fa-home"></i>
                </a></li>
                <li class="navi-item"><a href="/image/popular">
                    <i class="far fa-compass"></i>
                </a></li>
                <li class="navi-item"><a href="/user/${principal.user.id}">
                    <i class="far fa-user"></i>
                </a></li>
            </ul>
        </nav>
    </div>
</header>