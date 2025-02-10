
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="comm.vo.seller.SellerVO" %>
<%
    SellerVO vo = (SellerVO) request.getAttribute("vo");
    if (vo == null) {
        vo = new SellerVO(); // 기본 객체 생성
        System.out.println("🚨 vo가 null입니다! 기본 객체를 생성합니다.");
    }
%>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-01-14
  Time: 오후 2:24
  To change this template use File | Settings | File Templates.
--%>


<html>
<meta charset="utf-8">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>

        /* 상단 네비게이션 바와 로고 스타일 */
        .navbar {
            background-color: #343a40; /* 검정색 배경 */
        }

        .navbar-brand {
            font-size: 1.8rem;
            color: white;
        }

        /* 이미지를 오른쪽으로 치우치지 않게 조정 */
        .brand-form {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            width: 50%;
            margin: auto;
            text-align: left;
        }

        .logo-container {
            margin-right: 100px;  /* 오른쪽 여백 조정 */
            border: 5px solid #ccc; /* 경계선 색상 */
            padding: 10px; /* 내부 여백 */
            border-radius: 10px; /* 둥근 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            background-color: #f9f9f9; /* 배경색 */
        }

        #logoImage {
            width: 400px;  /* 가로 400px 고정 */
            height: 300px;  /* 높이 300px 고정 */
            object-fit: contain;  /* 비율 유지하며 이미지 크기 조정 */
        }

        /* 버튼 가운데 정렬 */
        #customButton {
            display: block;
            margin: 10px auto;
        }
        .brand-form > div {
            width: 400px;  /* 400px로 고정 */
        }

        /* 텍스트 필드와 textarea의 가로 길이 고정 */
        input[type="text"], input[type="email"], textarea {
            width: 100%;  /* 부모의 100%를 따르도록 설정 */
        }
    </style>
</head>
<%@ include file="layout/header.jsp" %>
<body>

<div class="container mt-4">


    <!-- 브랜드 정보 폼 -->
    <form method="POST" action="Controller?type=updateSeller" class="brand-form" enctype="multipart/form-data">
        <!-- 왼쪽: 브랜드 로고 이미지 -->
        <div class="logo-container">
            <img id="logoImage" src="${vo.seller_icon}" alt="브랜드 로고" class="img-fluid"/>

            <input type="file" id="brandImage" name="brandImage" style="display: none;" onchange="uploadLogo(event)">
            <button type="button" id="customButton" class="btn btn-outline-primary" onclick="document.getElementById('brandImage').click();">
                로고 변경
            </button>
        </div>

        <!-- 오른쪽: 브랜드 정보 폼 -->
        <div style="flex-grow: 1;">
            <div class="mb-3">
                <label for="sellerId" class="form-label">판매자 아이디</label>
                <input type="text" class="form-control" id="sellerId" name="sellerId" value="${vo.seller_id}" disabled>
            </div>
            <div class="mb-3">
                <label for="brandName" class="form-label">브랜드 이름</label>
                <input type="text" class="form-control" id="brandName" name="brandName" value="${vo.name}" disabled>
            </div>
            <div class="mb-3">
                <label for="brandPhone" class="form-label">브랜드 전화번호</label>
                <input type="text" class="form-control" id="brandPhone" name="brandPhone" value="${vo.phone}" disabled>
            </div>
            <div class="mb-3">
                <label for="brandEmail" class="form-label">브랜드 이메일 주소</label>
                <input type="email" class="form-control" id="brandEmail" name="brandEmail" value="${vo.email}" disabled>
            </div>
            <div class="mb-3">
                <label for="brandAddress" class="form-label">회사 주소</label>
                <input type="text" class="form-control" id="brandAddress" name="brandAddress" value="${vo.address}" disabled>
            </div>
            <div class="mb-3">
                <label for="brandDesc" class="form-label">브랜드 설명</label>
                <textarea class="form-control" id="brandDesc" name="brandDesc" disabled>${vo.desc}</textarea>
            </div>

            <!-- 수정/저장 버튼 -->
            <div class="d-flex gap-3">
                <button type="button" class="btn btn-primary" id="editButton" onclick="enableEditing()">수정</button>
                <button type="submit" class="btn btn-success" id="saveButton" disabled>저장</button>
            </div>
        </div>
    </form>

    <script>
        // 텍스트 필드 활성화

        function enableEditing() {
            document.querySelectorAll("input, textarea").forEach(input => input.disabled = false);
            document.getElementById('saveButton').disabled = false;
        }

        document.getElementById('saveButton').addEventListener("click", function () {
            document.querySelectorAll("input:not(#sellerId), textarea").forEach(input => input.readOnly = false);
        });



        function uploadLogo(event) {
            var file = event.target.files[0];
            if (!file) return;


            var reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("logoImage").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    </script>
</div>
</body>
</html>