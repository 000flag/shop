<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>부트스트랩 모달 + 캐러셀</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- 버튼 (모달 열기) -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#imageModal">
  사진 보기
</button>

<!-- 모달 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="imageModalLabel">사진 갤러리</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 캐러셀 (사진 넘기는 기능) -->
        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
          <div class="carousel-inner">
            <%-- JSP 태그 라이브러리 선언 --%>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <%-- 이미지 리스트를 ',' 기준으로 분리하여 저장 --%>
            <c:set var="imageList" value="${fn:split(imageString, ',')}" />

            <%-- 이미지 리스트 반복 출력 --%>
            <c:forEach var="image" items="${imageList}" varStatus="status">
              <div class="carousel-item ${status.first ? 'active' : ''}">
                <img src="${image}" class="d-block w-100" alt="이미지">
              </div>
            </c:forEach>
          </div>

          <!-- 좌우 컨트롤 버튼 -->
          <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">이전</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">다음</span>
          </button>
        </div>

        <!-- 설명 영역 -->
        <div class="mt-3">
          <h5>content</h5>
          <p>여기에 이미지 설명이나 추가적인 내용을 넣을 수 있어요.</p>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
