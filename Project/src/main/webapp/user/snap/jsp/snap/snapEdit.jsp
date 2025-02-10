<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Snap 수정 - 관리자 페이지</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/snap/css/Snap/Mysnap.css">
    <style>
        /* 전체 배경 및 기본 폰트 */
        body {
            background-color: #f8f9fa;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
        }
        /* 좌측 메뉴 영역 */
        .left-column {
            background-color: #ffffff;
            border-right: 1px solid #dee2e6;
            min-height: 100vh;
            padding: 0;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }
        /* 우측 수정 영역 */
        .right-column {
            background-color: #ffffff;
            min-height: 100vh;
            padding: 30px;
            overflow-y: auto;
        }
        /* 각 섹션 제목 스타일 */
        .section-title {
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 8px;
            margin-bottom: 20px;
            font-size: 1.5rem;
            font-weight: 600;
            color: #0d6efd;
        }
        /* 이미지 캐러셀 및 상품 카드 */
        .image-carousel img {
            height: 400px;
            object-fit: cover;
            width: 100%;
        }
        .product-card img {
            height: 150px;
            object-fit: cover;
            width: 100%;
        }
        /* 수정 완료 버튼 영역 (sticky footer) */
        .form-footer {
            position: sticky;
            bottom: 0;
            background-color: #ffffff;
            padding: 15px 0;
            border-top: 1px solid #dee2e6;
            z-index: 10;
        }
        /* 버튼 활성화 스타일 */
        .btn-outline-primary.active { background-color: #0d6efd; color: #fff; }
        .btn-outline-success.active { background-color: #198754; color: #fff; }
        .btn-outline-info.active { background-color: #0dcaf0; color: #fff; }
        /* Modal 커스텀 */
        .modal-content {
            border-radius: 0.5rem;
            overflow: hidden;
        }
    </style>
</head>
<body>
<!-- 헤더 (필요시 include) -->
<jsp:include page="/user/snap/jsp/layout/header.jsp" />

<div class="container-fluid">
    <div class="row g-0">
        <!-- 좌측 메뉴 영역 (왼쪽 컬럼) -->
        <div class="col-md-3 left-column">
            <jsp:include page="/user/snap/jsp/layout/left.jsp" />
        </div>
        <!-- 우측 수정 영역 (오른쪽 컬럼) -->
        <div class="col-md-9 right-column">
            <!-- 페이지 제목 -->
            <h2 class="mb-4">Snap 수정</h2>

            <!-- 수정 폼 -->
            <form id="snapEditForm" action="${pageContext.request.contextPath}/Controller?type=snapUpdate" method="post">
                <!-- 변경되지 않는 정보 (숨은 필드) -->
                <input type="hidden" name="id" value="${board.id}" />
                <input type="hidden" name="existingSnapshotImage" value="${board.snapshot_image}" />
                <input type="hidden" name="existingAdditionalImages" value="${board.additional_images}" />
                <input type="hidden" name="prod_no" value="${board.prod_no}" />

                <!-- 섹션: 이미지 미리보기 및 연결된 상품 -->
                <div class="row mb-5">
                    <div class="col-md-6">
                        <h3 class="section-title">이미지 미리보기</h3>
                        <!-- 이미지 캐러셀 -->
                        <div id="editImageCarousel" class="carousel slide image-carousel border rounded shadow-sm" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="${board.snapshot_image}" alt="메인 이미지">
                                </div>
                                <c:if test="${not empty board.additional_images}">
                                    <c:forEach var="imgUrl" items="${fn:split(board.additional_images, ',')}">
                                        <div class="carousel-item">
                                            <img src="${fn:trim(imgUrl)}" alt="추가 이미지">
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#editImageCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">이전</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#editImageCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">다음</span>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h3 class="section-title">연결된 상품</h3>
                        <c:if test="${not empty productList}">
                            <div id="editProductCarousel" class="carousel slide" data-bs-ride="carousel">
                                <div class="carousel-inner">
                                    <c:forEach var="product" items="${productList}" varStatus="status">
                                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                            <div class="card product-card shadow-sm">
                                                <img src="${product.prod_image}" class="card-img-top" alt="${product.name}">
                                                <div class="card-body p-2">
                                                    <p class="card-text small mb-0">${product.name}</p>
                                                    <p class="card-text small text-muted mb-0">가격: ${product.price}원</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#editProductCarousel" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">이전</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#editProductCarousel" data-bs-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="visually-hidden">다음</span>
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- 섹션: Snap 내용 수정 및 태그 등 -->
                <div class="row mb-5">
                    <div class="col-12">
                        <h3 class="section-title">Snap 내용 수정</h3>
                    </div>
                    <div class="col-md-12 mb-3">
                        <label for="content" class="form-label">내용</label>
                        <textarea id="content" name="content" class="form-control" rows="8" required>${board.content}</textarea>
                    </div>
                    <div class="col-md-12 mb-3">
                        <label for="tags" class="form-label">태그</label>
                        <input type="text" id="tags" name="tags" class="form-control" value="${board.tags}" />
                        <small class="text-muted">태그는 콤마로 구분 (예: #태그1, #태그2)</small>
                    </div>
                    <div class="col-md-12 mb-3">
                        <label class="form-label">성별</label>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-outline-primary gender-btn" data-value="남성">남성</button>
                            <button type="button" class="btn btn-outline-primary gender-btn" data-value="여성">여성</button>
                        </div>
                        <input type="hidden" name="gender" id="genderInput" value="${board.gender}" />
                    </div>
                    <div class="col-md-12 mb-3">
                        <label class="form-label">계절 (최대 2개)</label>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-outline-success season-btn" data-value="봄">봄</button>
                            <button type="button" class="btn btn-outline-success season-btn" data-value="여름">여름</button>
                            <button type="button" class="btn btn-outline-success season-btn" data-value="가을">가을</button>
                            <button type="button" class="btn btn-outline-success season-btn" data-value="겨울">겨울</button>
                        </div>
                        <input type="hidden" name="season" id="seasonInput" value="${board.season}" />
                    </div>
                    <div class="col-md-12 mb-3">
                        <label class="form-label">스타일 태그 (최대 2개)</label>
                        <div class="d-flex gap-2 flex-wrap">
                            <button type="button" class="btn btn-outline-info style-btn" data-value="캐주얼">캐주얼</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="스트릿">스트릿</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="걸리시">걸리시</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="미니멀">미니멀</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="스포티">스포티</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="시크">시크</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="시티보이">시티보이</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="로맨틱">로맨틱</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="고프코어">고프코어</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="워크웨어">워크웨어</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="레트로">레트로</button>
                            <button type="button" class="btn btn-outline-info style-btn" data-value="클래식">클래식</button>
                        </div>
                        <input type="hidden" name="style" id="styleInput" value="${board.style}" />
                    </div>
                    <div class="col-md-12 mb-3">
                        <label for="fileInput" class="form-label">추가 이미지 첨부</label>
                        <input type="file" id="fileInput" name="file" accept="image/*" class="form-control">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 수정 완료 버튼 영역 (하단 고정) -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-9 offset-md-3">
            <div class="form-footer">
                <button type="submit" form="snapEditForm" class="btn btn-primary btn-lg w-100">수정 완료</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery 및 Bootstrap JS (경로 수정 필요) -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

<!-- 페이지 내 추가 JS: 버튼 활성화, 선택, 등 -->
<script>
  // 성별 버튼 처리
  document.addEventListener('DOMContentLoaded', function() {
    const genderInput = document.getElementById('genderInput');
    const genderButtons = document.querySelectorAll('.gender-btn');
    genderButtons.forEach(button => {
      if(button.dataset.value === genderInput.value.trim()){
        button.classList.add('active');
      }
    });
    genderButtons.forEach(button => {
      button.addEventListener('click', function() {
        genderButtons.forEach(btn => btn.classList.remove('active'));
        this.classList.add('active');
        genderInput.value = this.dataset.value;
      });
    });
  });

  // 계절 버튼 처리 (다중 선택)
  document.addEventListener('DOMContentLoaded', function() {
    const seasonInput = document.getElementById('seasonInput');
    const seasonButtons = document.querySelectorAll('.season-btn');
    let initSeasons = seasonInput.value ? seasonInput.value.split(',').map(s => s.trim()) : [];
    seasonButtons.forEach(button => {
      if(initSeasons.includes(button.dataset.value)){
        button.classList.add('active');
      }
    });
    seasonButtons.forEach(button => {
      button.addEventListener('click', function() {
        let selectedSeasons = seasonInput.value ? seasonInput.value.split(',').map(s => s.trim()).filter(s => s !== "") : [];
        if(selectedSeasons.includes(this.dataset.value)){
          this.classList.remove('active');
          selectedSeasons = selectedSeasons.filter(s => s !== this.dataset.value);
        } else {
          if(selectedSeasons.length < 2){
            this.classList.add('active');
            selectedSeasons.push(this.dataset.value);
          } else {
            alert('최대 2개의 계절만 선택 가능합니다.');
          }
        }
        seasonInput.value = selectedSeasons.join(',');
      });
    });
  });

  // 스타일 버튼 처리 (다중 선택)
  document.addEventListener('DOMContentLoaded', function() {
    const styleInput = document.getElementById('styleInput');
    const styleButtons = document.querySelectorAll('.style-btn');
    let initStyles = styleInput.value ? styleInput.value.split(',').map(s => s.trim()) : [];
    styleButtons.forEach(button => {
      if(initStyles.includes(button.dataset.value)){
        button.classList.add('active');
      }
    });
    styleButtons.forEach(button => {
      button.addEventListener('click', function() {
        let selectedStyles = styleInput.value ? styleInput.value.split(',').map(s => s.trim()).filter(s => s !== "") : [];
        if(selectedStyles.includes(this.dataset.value)){
          this.classList.remove('active');
          selectedStyles = selectedStyles.filter(s => s !== this.dataset.value);
        } else {
          if(selectedStyles.length < 2){
            this.classList.add('active');
            selectedStyles.push(this.dataset.value);
          } else {
            alert('최대 2개의 스타일 태그만 선택 가능합니다.');
          }
        }
        styleInput.value = selectedStyles.join(',');
      });
    });
  });
</script>
</body>
</html>
