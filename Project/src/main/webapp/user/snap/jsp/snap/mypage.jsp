<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코디 페이지</title>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/user/snap/css/Snap/mypage.css">
</head>
<style>
    .image-gallery {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 10px;
    }

    .image-gallery img {
        max-width: 344.83px;
        aspect-ratio: 1 / 1; /* 정사각형 유지 */
        object-fit: cover;
    }
    .heart-icon {
        position: absolute !important;
        top: 10px !important;
        right: 10px !important;
        font-size: 24px!important;
        color: #ccc;
        z-index: 10!important;
        transition: color 0.3s ease!important;
    }

    .heart-icon:hover {
        transform: scale(1.2);
    }

</style>

<body>
<jsp:include page="/user/snap/jsp/layout/header.jsp"></jsp:include>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- 왼쪽 메뉴바 -->
        <div class="col-md-2 border-end position-fixed" style="height: 100vh;">
           <jsp:include page="/user/snap/jsp/layout/left.jsp"></jsp:include>
        </div>

        <!-- 콘텐츠 영역 -->
        <div class="col-md-10 offset-md-2">
            <!-- 필터 상단 -->

            <div class="mb-3 d-flex align-items-center">
                <select class="form-select me-2" style="width: auto;" onchange="location.href=this.value">
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&gender=전체" ${selectedGender == '전체' ? 'selected' : ''}>성별: 전체</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&gender=남성" ${selectedGender == '남성' ? 'selected' : ''}>성별: 남성</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&gender=여성" ${selectedGender == '여성' ? 'selected' : ''}>성별: 여성</option>
                </select>

                <select class="form-select me-2" style="width: auto;" onchange="location.href=this.value">
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&season=전체" ${selectedSeason == '전체' ? 'selected' : ''}>계절: 전체</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&season=봄" ${selectedSeason == '봄' ? 'selected' : ''}>계절: 봄</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&season=여름" ${selectedSeason == '여름' ? 'selected' : ''}>계절: 여름</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&season=가을" ${selectedSeason == '가을' ? 'selected' : ''}>계절: 가을</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&season=겨울" ${selectedSeason == '겨울' ? 'selected' : ''}>계절: 겨울</option>
                </select>

                <select class="form-select" style="width: auto;" onchange="location.href=this.value">
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=전체" ${selectedStyle == '전체' ? 'selected' : ''}>스타일: 전체</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=캐주얼" ${selectedStyle == '캐주얼' ? 'selected' : ''}>캐주얼</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=스트릿" ${selectedStyle == '스트릿' ? 'selected' : ''}>스트릿</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=걸리시" ${selectedStyle == '걸리시' ? 'selected' : ''}>걸리시</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=미니멀" ${selectedStyle == '미니멀' ? 'selected' : ''}>미니멀</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=스포티" ${selectedStyle == '스포티' ? 'selected' : ''}>스포티</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=시크" ${selectedStyle == '시크' ? 'selected' : ''}>시크</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=시티보이" ${selectedStyle == '시티보이' ? 'selected' : ''}>시티보이</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=로맨틱" ${selectedStyle == '로맨틱' ? 'selected' : ''}>로맨틱</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=고프코어" ${selectedStyle == '고프코어' ? 'selected' : ''}>고프코어</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=워크웨어" ${selectedStyle == '워크웨어' ? 'selected' : ''}>워크웨어</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=레트로" ${selectedStyle == '레트로' ? 'selected' : ''}>레트로</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=클래식" ${selectedStyle == '클래식' ? 'selected' : ''}>클래식</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=프레피" ${selectedStyle == '프레피' ? 'selected' : ''}>프레피</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=에스닉" ${selectedStyle == '에스닉' ? 'selected' : ''}>에스닉</option>
                    <option value="${pageContext.request.contextPath}/Controller?type=snap&style=리조트" ${selectedStyle == '리조트' ? 'selected' : ''}>리조트</option>


                </select>
                <%--                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#snapModal"   >--%>
                <%--                    스냅샷 쓰기--%>
                <%--                </button>--%>
            </div>

            <!-- 사진 리스트 -->
            <div class="row row-cols-1 row-cols-md-4 g-0">
                <c:forEach var="snap" items="${snapList}">
                    <div class="col">
                        <div class="position-relative">
                            <img src="${snap.snapshot_image}" class="img-fluid w-100" alt="Snap Image" onclick="location.href='Controller?type=sns&id=${snap.id}'">
                            <i class="bi bi-heart${snap.liked ? '-fill' : ''} heart-icon" data-board-no="${snap.id}"></i>
                        </div>
                    </div>
                </c:forEach>
            </div>


            <!-- 페이지네이션 -->
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <!-- 이전 버튼 -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="Controller?type=snap&page=${currentPage - 1}&gender=${param.gender}&season=${param.season}&style=${param.style}"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <!-- 페이지 번호 (모든 번호를 출력할 경우) -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="Controller?type=snap&page=${i}&gender=${param.gender}&season=${param.season}&style=${param.style}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <!-- 다음 버튼 -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="Controller?type=snap&page=${currentPage + 1}&gender=${param.gender}&season=${param.season}&style=${param.style}"
                           aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>

        </div>
    </div>
</div>

<!-- 스냅작성모달페이지 -->
<jsp:include page="/user/snap/jsp/snap/snapModal.jsp"></jsp:include>
<script src="/JS/snapModal.js"></script>
<%--<jsp:include page="../layout/footer.jsp"></jsp:include>--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // document.addEventListener('DOMContentLoaded', function () {
  //   const heartIcons = document.querySelectorAll('.heart-icon');
  //
  //   heartIcons.forEach(icon => {
  //     icon.addEventListener('click', function (event) {
  //       event.stopPropagation(); // 이미지 클릭 이벤트와 분리
  //
  //       const boardNo = this.getAttribute('data-board-no'); // 게시물 번호 가져오기
  //       const isLiked = this.classList.contains('bi-heart-fill'); // 현재 좋아요 상태 확인
  //
  //       // 서버에 좋아요 상태 전송
  //       fetch('/Controller?type=likeToggle', {
  //         method: 'POST',
  //         headers: { 'Content-Type': 'application/json' },
  //         body: JSON.stringify({
  //           boardNo: boardNo,
  //
  //           status: isLiked ? 0 : 1 // 좋아요 상태 토글
  //         })
  //       })
  //           .then(response => response.json())
  //           .then(data => {
  //             if (data.success) {
  //               // 하트 상태 토글
  //               this.classList.toggle('bi-heart-fill');
  //               this.classList.toggle('bi-heart');
  //             } else {
  //               alert('좋아요 변경에 실패했습니다.');
  //             }
  //           })
  //           .catch(error => {
  //             console.error('Error:', error);
  //           });
  //     });
  //   });
  // });

  <%--document.addEventListener('DOMContentLoaded', function () {--%>
  <%--  const steps = document.querySelectorAll('.step');--%>
  <%--  const prevButton = document.getElementById('prevStep');--%>
  <%--  const nextButton = document.getElementById('nextStep');--%>
  <%--  const submitButton = document.getElementById('submitSnap');--%>
  <%--  let currentStep = 0;--%>

  <%--  function updateSteps() {--%>
  <%--    steps.forEach((step, index) => {--%>
  <%--      step.classList.toggle('d-none', index !== currentStep);--%>
  <%--    });--%>
  <%--    prevButton.disabled = currentStep === 0;--%>
  <%--    nextButton.classList.toggle('d-none', currentStep === steps.length - 1);--%>
  <%--    submitButton.classList.toggle('d-none', currentStep !== steps.length - 1);--%>
  <%--  }--%>

  <%--  prevButton.addEventListener('click', () => {--%>
  <%--    if (currentStep > 0) {--%>
  <%--      currentStep--;--%>
  <%--      updateSteps();--%>
  <%--    }--%>
  <%--  });--%>

  <%--  nextButton.addEventListener('click', () => {--%>
  <%--    if (currentStep < steps.length - 1) {--%>
  <%--      currentStep++;--%>
  <%--      updateSteps();--%>
  <%--    }--%>
  <%--  });--%>

  <%--  updateSteps();--%>
  <%--});--%>

  <%--function filterProducts() {--%>
  <%--  const searchInput = document.getElementById('searchProduct').value.toLowerCase();--%>
  <%--  const products = document.querySelectorAll('#productList .col');--%>

  <%--  products.forEach(product => {--%>
  <%--    const productName = product.querySelector('.card-text').innerText.toLowerCase();--%>
  <%--    if (productName.includes(searchInput)) {--%>
  <%--      product.style.display = '';--%>
  <%--    } else {--%>
  <%--      product.style.display = 'none';--%>
  <%--    }--%>
  <%--  });--%>
  <%--}--%>

  <%--//스타일 성별 태그 관련 설정--%>

  <%--document.addEventListener('DOMContentLoaded', () => {--%>
  <%--  const genderButtons = document.querySelectorAll('.gender-btn');--%>
  <%--  const seasonButtons = document.querySelectorAll('.season-btn');--%>
  <%--  const styleButtons = document.querySelectorAll('.style-btn');--%>

  <%--  const genderInput = document.getElementById('genderInput');--%>
  <%--  const seasonInput = document.getElementById('seasonInput');--%>
  <%--  const styleInput = document.getElementById('styleInput');--%>

  <%--  genderButtons.forEach(button => {--%>
  <%--    button.addEventListener('click', () => {--%>
  <%--      genderButtons.forEach(btn => btn.classList.remove('active'));--%>
  <%--      button.classList.add('active');--%>
  <%--      genderInput.value = button.dataset.value;--%>
  <%--    });--%>
  <%--  });--%>

  <%--  seasonButtons.forEach(button => {--%>
  <%--    button.addEventListener('click', () => {--%>
  <%--      const selectedSeasons = seasonInput.value ? seasonInput.value.split(',') : [];--%>
  <%--      if (selectedSeasons.includes(button.dataset.value)) {--%>
  <%--        button.classList.remove('active');--%>
  <%--        seasonInput.value = selectedSeasons.filter(season => season !== button.dataset.value).join(',');--%>
  <%--      } else if (selectedSeasons.length < 2) {--%>
  <%--        button.classList.add('active');--%>
  <%--        seasonInput.value = [...selectedSeasons, button.dataset.value].join(',');--%>
  <%--      } else {--%>
  <%--        alert('최대 2개의 계절만 선택 가능합니다.');--%>
  <%--      }--%>
  <%--    });--%>
  <%--  });--%>

  <%--  styleButtons.forEach(button => {--%>
  <%--    button.addEventListener('click', () => {--%>
  <%--      const selectedStyles = styleInput.value ? styleInput.value.split(',') : [];--%>
  <%--      if (selectedStyles.includes(button.dataset.value)) {--%>
  <%--        button.classList.remove('active');--%>
  <%--        styleInput.value = selectedStyles.filter(style => style !== button.dataset.value).join(',');--%>
  <%--      } else if (selectedStyles.length < 2) {--%>
  <%--        button.classList.add('active');--%>
  <%--        styleInput.value = [...selectedStyles, button.dataset.value].join(',');--%>
  <%--      } else {--%>
  <%--        alert('최대 2개의 스타일 태그만 선택 가능합니다.');--%>
  <%--      }--%>
  <%--    });--%>
  <%--  });--%>
  <%--});--%>

  <%--//메인이미지 서브이미지 보기--%>
  <%--document.addEventListener('DOMContentLoaded', () => {--%>
  <%--  // 메인 이미지 미리보기--%>
  <%--  const mainImageInput = document.getElementById('mainImage');--%>
  <%--  const mainImagePreview = document.getElementById('mainImagePreview').querySelector('img');--%>
  <%--  mainImagePreview.style.width = "300px";--%>
  <%--  mainImagePreview.style.height = "300px";--%>
  <%--  mainImagePreview.style.objectFit = "cover";--%>
  <%--  mainImageInput.addEventListener('change', (event) => {--%>
  <%--    const file = event.target.files[0];--%>
  <%--    if (file) {--%>
  <%--      const reader = new FileReader();--%>
  <%--      reader.onload = (e) => {--%>
  <%--        mainImagePreview.src = e.target.result;--%>
  <%--        mainImagePreview.style.display = 'block';--%>
  <%--      };--%>
  <%--      reader.readAsDataURL(file);--%>
  <%--    } else {--%>
  <%--      mainImagePreview.src = '';--%>
  <%--      mainImagePreview.style.display = 'none';--%>
  <%--    }--%>
  <%--  });--%>

  <%--  // 서브 이미지 미리보기--%>
  <%--  const additionalImagesInput = document.getElementById('additionalImages');--%>
  <%--  const additionalImagesPreview = document.getElementById('additionalImagesPreview');--%>

  <%--  additionalImagesInput.addEventListener('change', (event) => {--%>
  <%--    additionalImagesPreview.innerHTML = ''; // 기존 미리보기 초기화--%>
  <%--    const files = event.target.files;--%>
  <%--    if (files) {--%>
  <%--      Array.from(files).forEach((file) => {--%>
  <%--        const reader = new FileReader();--%>
  <%--        reader.onload = (e) => {--%>
  <%--          const img = document.createElement('img');--%>
  <%--          img.src = e.target.result;--%>
  <%--          img.className = 'img-thumbnail';--%>
  <%--          img.style.maxWidth = '100px';--%>
  <%--          img.style.height = 'auto';--%>
  <%--          additionalImagesPreview.appendChild(img);--%>
  <%--        };--%>
  <%--        reader.readAsDataURL(file);--%>
  <%--      });--%>
  <%--    }--%>
  <%--  });--%>
  <%--});--%>

  <%--//해쉬태그동작--%>

  <%--document.addEventListener('DOMContentLoaded', () => {--%>
  <%--  const hashtagInput = document.getElementById('hashtagInput');--%>
  <%--  const hashtagList = document.getElementById('hashtagList');--%>
  <%--  const hashtagsInput = document.getElementById('hashtagsInput');--%>
  <%--  const addHashtagButton = document.getElementById('addHashtag');--%>

  <%--  const hashtags = new Set(); // 중복 방지를 위해 Set 사용--%>

  <%--  // 해시태그 추가 함수--%>
  <%--  function addHashtag(tag) {--%>
  <%--    const formattedTag = tag.startsWith('#') ? tag : `#${tag}`; // #이 없으면 추가--%>
  <%--    if (formattedTag.length > 1 && !hashtags.has(formattedTag)) {--%>
  <%--      hashtags.add(formattedTag);--%>

  <%--      // UI에 해시태그 추가--%>
  <%--      const tagElement = document.createElement('span');--%>
  <%--      tagElement.className = 'badge bg-primary text-light';--%>
  <%--      tagElement.textContent = formattedTag;--%>
  <%--      tagElement.style.cursor = 'pointer';--%>

  <%--      // 삭제 기능 추가--%>
  <%--      tagElement.addEventListener('click', () => {--%>
  <%--        hashtags.delete(formattedTag);--%>
  <%--        tagElement.remove();--%>
  <%--        updateHashtagsInput();--%>
  <%--      });--%>

  <%--      hashtagList.appendChild(tagElement);--%>
  <%--      updateHashtagsInput();--%>
  <%--    }--%>
  <%--    hashtagInput.value = ''; // 입력 필드 초기화--%>
  <%--  }--%>

  <%--  // 해시태그를 숨겨진 인풋 필드에 업데이트--%>
  <%--  function updateHashtagsInput() {--%>
  <%--    hashtagsInput.value = Array.from(hashtags).join(','); // 해시태그를 콤마로 구분--%>
  <%--  }--%>

  <%--  // 엔터 키 입력 시 해시태그 추가--%>
  <%--  hashtagInput.addEventListener('keydown', (event) => {--%>
  <%--    if (event.key === 'Enter') {--%>
  <%--      event.preventDefault();--%>
  <%--      const tag = hashtagInput.value.trim();--%>
  <%--      if (tag) {--%>
  <%--        addHashtag(tag);--%>
  <%--      }--%>
  <%--    }--%>
  <%--  });--%>

  <%--  // 추가 버튼 클릭 시 해시태그 추가--%>
  <%--  addHashtagButton.addEventListener('click', () => {--%>
  <%--    const tag = hashtagInput.value.trim();--%>
  <%--    if (tag) {--%>
  <%--      addHashtag(tag);--%>
  <%--    }--%>
  <%--  });--%>
  <%--});--%>

  <%--//내가구매한상품 체크 콤보박스--%>

  <%--document.addEventListener('DOMContentLoaded', () => {--%>
  <%--  const productCheckboxes = document.querySelectorAll('.product-checkbox');--%>
  <%--  const hiddenInput = document.getElementById('selectedProdNo');--%>

  <%--  function updateSelectedProducts() {--%>
  <%--    const selectedValues = Array.from(productCheckboxes)--%>
  <%--        .filter(checkbox => checkbox.checked)--%>
  <%--        .map(checkbox => checkbox.value);--%>
  <%--    hiddenInput.value = selectedValues.join(',');--%>
  <%--    console.log('Selected products:', hiddenInput.value); // 디버깅용--%>
  <%--  }--%>

  <%--  productCheckboxes.forEach(checkbox => {--%>
  <%--    checkbox.addEventListener('change', updateSelectedProducts);--%>
  <%--  });--%>

  <%--  // 폼 제출 전 선택된 제품 확인--%>
  <%--  document.querySelector('form').addEventListener('submit', (e) => {--%>
  <%--    console.log('Form submitted. Selected products:', hiddenInput.value); // 디버깅용--%>
  <%--  });--%>
  <%--});--%>



</script>
</body>

</html>
