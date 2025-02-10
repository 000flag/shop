<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-22
  Time: 오후 9:09
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!-- 필요한 CSS/JS 파일 추가 (예: Bootstrap) -->
</head>
<body>
<div class="modal fade" id="snapModal" tabindex="-1" aria-labelledby="snapModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="snapModalLabel">Snap 작성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- id="snapForm" 추가 -->
                <form id="snapForm" action="${pageContext.request.contextPath}/Controller?type=snapWrite" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="prod_no" id="selectedProdNo">
                    <div id="snapSteps">
                        <!-- Step 1: 메인 이미지 업로드 -->
                        <div class="step" id="step1">
                            <label for="mainImage" class="form-label">메인 이미지 업로드</label>
                            <input type="file" class="form-control" id="mainImage" name="mainImage" accept="image/*" required>
                            <div id="mainImagePreview" class="mt-3">
                                <img src="" alt="Main Image Preview" class="img-fluid" style="max-width: 100%; display: none;">
                            </div>
                        </div>

                        <!-- Step 2: 추가 이미지 업로드 -->
                        <div class="step d-none" id="step2">
                            <label for="additionalImages" class="form-label">추가 이미지 업로드</label>
                            <input type="file" class="form-control" id="additionalImages" name="additionalImages" accept="image/*" multiple>
                            <div id="additionalImagesPreview" class="mt-3 d-flex flex-wrap gap-2"></div>
                        </div>

                        <!-- Step 3: 관련 상품 태그 -->
                        <div class="step d-none" id="step3">
                            <label for="searchProduct" class="form-label">관련 상품 태그</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="searchProduct" placeholder="검색어를 입력해주세요" onkeyup="filterProducts()">
                                <button class="btn btn-outline-secondary" type="button">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                            <h6 class="mb-3">내가 구매한 상품</h6>
                            <div class="row row-cols-1 row-cols-md-4 g-3" id="productList">
                                <c:forEach var="product" items="${sessionScope.purchasedProducts}">
                                    <div class="col text-center">
                                        <div class="card h-100">
                                            <div class="position-relative">
                                                <img src="${product.prod_image}" class="card-img-top" alt="${product.name}">
                                                <input type="checkbox" name="prod_no" class="form-check-input position-absolute top-0 end-0 m-2 product-checkbox" value="${product.id}">
                                            </div>
                                            <div class="card-body p-2">
                                                <p class="card-text">${product.name}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Step 4: 내용 입력 -->
                        <div class="step d-none" id="step4">
                            <label for="content" class="form-label mt-3">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="5" placeholder="내용을 입력하세요" required></textarea>

                            <!-- 해시태그 추가 -->
                            <label class="form-label mt-3">해시태그</label>
                            <div class="d-flex gap-2 align-items-center">
                                <input type="text" id="hashtagInput" class="form-control" placeholder="#태그 입력 후 엔터" />
                                <button type="button" id="addHashtag" class="btn btn-outline-primary">추가</button>
                            </div>
                            <div id="hashtagList" class="mt-3 d-flex flex-wrap gap-2"></div>
                            <input type="hidden" name="tags" id="hashtagsInput">
                        </div>

                        <!-- Step 5: 성별, 계절, 스타일 선택 -->
                        <div class="step d-none" id="step5">
                            <!-- 성별 -->
                            <div class="mb-4">
                                <label class="form-label">성별</label>
                                <div class="d-flex gap-3">
                                    <button type="button" class="btn btn-outline-primary gender-btn" data-value="남성">남성</button>
                                    <button type="button" class="btn btn-outline-primary gender-btn" data-value="여성">여성</button>
                                </div>
                                <input type="hidden" name="gender" id="genderInput">
                            </div>

                            <!-- 계절 -->
                            <div class="mb-4">
                                <label class="form-label">계절 (최대 2개)</label>
                                <div class="d-flex flex-wrap gap-2">
                                    <button type="button" class="btn btn-outline-success season-btn" data-value="봄">봄</button>
                                    <button type="button" class="btn btn-outline-success season-btn" data-value="여름">여름</button>
                                    <button type="button" class="btn btn-outline-success season-btn" data-value="가을">가을</button>
                                    <button type="button" class="btn btn-outline-success season-btn" data-value="겨울">겨울</button>
                                </div>
                                <input type="hidden" name="season" id="seasonInput">
                            </div>

                            <!-- 스타일 태그 -->
                            <div class="mb-4">
                                <label class="form-label">스타일 태그 (최대 2개)</label>
                                <div class="d-flex flex-wrap gap-2">
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
                                <input type="hidden" name="style" id="styleInput">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="prevStep" disabled>이전</button>
                            <button type="button" class="btn btn-primary" id="nextStep">다음</button>
                            <!-- type="button"을 유지 -->
                            <button type="submit" id="submitSnap">저장</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 저장 버튼 클릭 시 폼 제출 처리 -->
<script>
  // document.addEventListener('DOMContentLoaded', function () {
  //   const submitButton = document.getElementById('submitSnap');
  //   const form = document.getElementById('snapForm');
  //
  //   submitButton.addEventListener('click', function () {
  //     console.log('폼 제출 시도!');
  //     form.submit(); // 폼 강제 제출
  //   });
  // });
</script>
</body>
</html>
