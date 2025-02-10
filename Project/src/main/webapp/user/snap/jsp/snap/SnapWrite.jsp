<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Snap 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .img-preview {
            max-width: 100%;
            max-height: 300px;
            object-fit: cover;
        }
        .btn-group button {
            margin-right: 10px;
        }
        .badge-btn {
            padding: 5px 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Snap 수정</h1>
    <form action="${pageContext.request.contextPath}/Controller?type=snapUpdate" method="post" enctype="multipart/form-data">
        <!-- Hidden Input for Board ID -->
        <input type="hidden" name="board_no" id="editBoardNo" value="${snap.id}">

        <!-- Main Image -->
        <div class="mb-4">
            <label for="mainImage" class="form-label">메인 이미지</label>
            <img src="${snap.snapshot_image}" alt="Main Image Preview" class="img-preview d-block mb-3" id="mainImagePreview" />
            <input type="file" class="form-control" id="mainImage" name="mainImage" accept="image/*">
        </div>

        <!-- Additional Images -->
        <div class="mb-4">
            <label for="additionalImages" class="form-label">추가 이미지</label>
            <div class="d-flex flex-wrap gap-2 mb-3" id="additionalImagesPreview">
                <c:forEach var="image" items="${fn:split(snap.additional_images, ',')}">
                    <img src="${image}" class="img-preview">
                </c:forEach>
            </div>
            <input type="file" class="form-control" id="additionalImages" name="additionalImages" accept="image/*" multiple>
        </div>

        <!-- Content -->
        <div class="mb-4">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="content" rows="5" required>${snap.content}</textarea>
        </div>

        <!-- Gender -->
        <div class="mb-4">
            <label class="form-label">성별</label>
            <div class="btn-group">
                <button type="button" class="btn ${snap.gender == '남성' ? 'btn-primary' : 'btn-outline-primary'} gender-btn" data-value="남성">남성</button>
                <button type="button" class="btn ${snap.gender == '여성' ? 'btn-primary' : 'btn-outline-primary'} gender-btn" data-value="여성">여성</button>
            </div>
            <input type="hidden" name="gender" id="genderInput" value="${snap.gender}">
        </div>

        <!-- Season -->
        <div class="mb-4">
            <label class="form-label">계절</label>
            <div class="btn-group">
                <c:forEach var="season" items="['봄', '여름', '가을', '겨울']">
                    <button type="button" class="btn ${fn:contains(snap.season, season) ? 'btn-success' : 'btn-outline-success'} season-btn" data-value="${season}">${season}</button>
                </c:forEach>
            </div>
            <input type="hidden" name="season" id="seasonInput" value="${snap.season}">
        </div>

        <!-- Style -->
        <div class="mb-4">
            <label class="form-label">스타일</label>
            <div class="btn-group">
                <c:forEach var="style" items="['캐주얼', '스트릿', '미니멀', '레트로', '클래식']">
                    <button type="button" class="btn ${fn:contains(snap.style, style) ? 'btn-info' : 'btn-outline-info'} style-btn" data-value="${style}">${style}</button>
                </c:forEach>
            </div>
            <input type="hidden" name="style" id="styleInput" value="${snap.style}">
        </div>

        <!-- Tags -->
        <div class="mb-4">
            <label class="form-label">해시태그</label>
            <input type="text" class="form-control" id="hashtagInput" placeholder="#태그 입력 후 엔터">
            <div id="hashtagList" class="d-flex flex-wrap gap-2 mt-2">
                <c:forEach var="tag" items="${fn:split(snap.tags, ',')}">
                    <span class="badge bg-primary badge-btn">${tag}</span>
                </c:forEach>
            </div>
            <input type="hidden" name="tags" id="tagsInput" value="${snap.tags}">
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-success">수정 완료</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', () => {
    // 1. 성별 버튼 클릭 이벤트
    const genderButtons = document.querySelectorAll('.gender-btn');
    const genderInput = document.getElementById('genderInput');

    genderButtons.forEach(button => {
      button.addEventListener('click', () => {
        genderButtons.forEach(btn => btn.classList.remove('btn-primary'));
        button.classList.add('btn-primary');
        button.classList.remove('btn-outline-primary');
        genderInput.value = button.getAttribute('data-value');
      });
    });

    // 2. 계절 버튼 클릭 이벤트
    const seasonButtons = document.querySelectorAll('.season-btn');
    const seasonInput = document.getElementById('seasonInput');

    seasonButtons.forEach(button => {
      button.addEventListener('click', () => {
        const selectedSeasons = seasonInput.value ? seasonInput.value.split(',') : [];
        const value = button.getAttribute('data-value');

        if (selectedSeasons.includes(value)) {
          // 이미 선택된 경우 제거
          button.classList.remove('btn-success');
          button.classList.add('btn-outline-success');
          seasonInput.value = selectedSeasons.filter(season => season !== value).join(',');
        } else if (selectedSeasons.length < 2) {
          // 최대 2개 선택 가능
          button.classList.add('btn-success');
          button.classList.remove('btn-outline-success');
          seasonInput.value = [...selectedSeasons, value].join(',');
        } else {
          alert('최대 2개의 계절만 선택 가능합니다.');
        }
      });
    });

    // 3. 스타일 버튼 클릭 이벤트
    const styleButtons = document.querySelectorAll('.style-btn');
    const styleInput = document.getElementById('styleInput');

    styleButtons.forEach(button => {
      button.addEventListener('click', () => {
        const selectedStyles = styleInput.value ? styleInput.value.split(',') : [];
        const value = button.getAttribute('data-value');

        if (selectedStyles.includes(value)) {
          // 이미 선택된 경우 제거
          button.classList.remove('btn-info');
          button.classList.add('btn-outline-info');
          styleInput.value = selectedStyles.filter(style => style !== value).join(',');
        } else if (selectedStyles.length < 2) {
          // 최대 2개 선택 가능
          button.classList.add('btn-info');
          button.classList.remove('btn-outline-info');
          styleInput.value = [...selectedStyles, value].join(',');
        } else {
          alert('최대 2개의 스타일 태그만 선택 가능합니다.');
        }
      });
    });

    // 4. 메인 이미지 미리보기
    const mainImageInput = document.getElementById('mainImage');
    const mainImagePreview = document.getElementById('mainImagePreview');

    mainImageInput.addEventListener('change', event => {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = e => {
          mainImagePreview.src = e.target.result;
          mainImagePreview.style.display = 'block';
        };
        reader.readAsDataURL(file);
      } else {
        mainImagePreview.src = '';
        mainImagePreview.style.display = 'none';
      }
    });

    // 5. 추가 이미지 미리보기
    const additionalImagesInput = document.getElementById('additionalImages');
    const additionalImagesPreview = document.getElementById('additionalImagesPreview');

    additionalImagesInput.addEventListener('change', event => {
      additionalImagesPreview.innerHTML = ''; // 기존 미리보기 초기화
      const files = event.target.files;
      if (files) {
        Array.from(files).forEach(file => {
          const reader = new FileReader();
          reader.onload = e => {
            const img = document.createElement('img');
            img.src = e.target.result;
            img.className = 'img-thumbnail';
            img.style.maxWidth = '100px';
            img.style.height = 'auto';
            additionalImagesPreview.appendChild(img);
          };
          reader.readAsDataURL(file);
        });
      }
    });

    // 6. 해시태그 추가/제거
    const hashtagInput = document.getElementById('hashtagInput');
    const hashtagList = document.getElementById('hashtagList');
    const tagsInput = document.getElementById('tagsInput');
    const hashtags = new Set(tagsInput.value.split(',').filter(tag => tag)); // 기존 해시태그 로드

    function updateTagsInput() {
      tagsInput.value = Array.from(hashtags).join(',');
    }

    function addHashtag(tag) {
      if (!tag || hashtags.has(tag)) return; // 중복 방지
      hashtags.add(tag);

      const badge = document.createElement('span');
      badge.className = 'badge bg-primary badge-btn me-2';
      badge.textContent = tag;

      badge.addEventListener('click', () => {
        hashtags.delete(tag);
        badge.remove();
        updateTagsInput();
      });

      hashtagList.appendChild(badge);
      updateTagsInput();
    }

    hashtagInput.addEventListener('keydown', event => {
      if (event.key === 'Enter') {
        event.preventDefault();
        const tag = hashtagInput.value.trim();
        addHashtag(tag.startsWith('#') ? tag : `#${tag}`);
        hashtagInput.value = '';
      }
    });
  });

</script>
</body>
</html>
