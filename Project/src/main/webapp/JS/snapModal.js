document.addEventListener('DOMContentLoaded', function () {
  const heartIcons = document.querySelectorAll('.heart-icon');

  heartIcons.forEach(icon => {
    icon.addEventListener('click', function (event) {
      event.stopPropagation(); // 이미지 클릭 이벤트와 분리

      const boardNo = this.getAttribute('data-board-no'); // 게시물 번호 가져오기
      const isLiked = this.classList.contains('bi-heart-fill'); // 현재 좋아요 상태 확인

      // 서버에 좋아요 상태 전송
      fetch('/Controller?type=likeToggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          boardNo: boardNo,

          status: isLiked ? 0 : 1 // 좋아요 상태 토글
        })
      })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              // 하트 상태 토글
              this.classList.toggle('bi-heart-fill');
              this.classList.toggle('bi-heart');
            } else {
              alert('좋아요 변경에 실패했습니다.');
            }
          })
          .catch(error => {
            console.error('Error:', error);
          });
    });
  });
});

document.addEventListener('DOMContentLoaded', function () {
  const steps = document.querySelectorAll('.step');
  const prevButton = document.getElementById('prevStep');
  const nextButton = document.getElementById('nextStep');
  const submitButton = document.getElementById('submitSnap');
  let currentStep = 0;

  function updateSteps() {
    steps.forEach((step, index) => {
      step.classList.toggle('d-none', index !== currentStep);
    });
    prevButton.disabled = currentStep === 0;
    nextButton.classList.toggle('d-none', currentStep === steps.length - 1);
    submitButton.classList.toggle('d-none', currentStep !== steps.length - 1);
  }

  prevButton.addEventListener('click', () => {
    if (currentStep > 0) {
      currentStep--;
      updateSteps();
    }
  });

  nextButton.addEventListener('click', () => {
    if (currentStep < steps.length - 1) {
      currentStep++;
      updateSteps();
    }
  });

  updateSteps();
});

function filterProducts() {
  const searchInput = document.getElementById('searchProduct').value.toLowerCase();
  const products = document.querySelectorAll('#productList .col');

  products.forEach(product => {
    const productName = product.querySelector('.card-text').innerText.toLowerCase();
    if (productName.includes(searchInput)) {
      product.style.display = '';
    } else {
      product.style.display = 'none';
    }
  });
}

//스타일 성별 태그 관련 설정

document.addEventListener('DOMContentLoaded', () => {
  const genderButtons = document.querySelectorAll('.gender-btn');
  const seasonButtons = document.querySelectorAll('.season-btn');
  const styleButtons = document.querySelectorAll('.style-btn');

  const genderInput = document.getElementById('genderInput');
  const seasonInput = document.getElementById('seasonInput');
  const styleInput = document.getElementById('styleInput');

  genderButtons.forEach(button => {
    button.addEventListener('click', () => {
      genderButtons.forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');
      genderInput.value = button.dataset.value;
    });
  });

  seasonButtons.forEach(button => {
    button.addEventListener('click', () => {
      const selectedSeasons = seasonInput.value ? seasonInput.value.split(',') : [];
      if (selectedSeasons.includes(button.dataset.value)) {
        button.classList.remove('active');
        seasonInput.value = selectedSeasons.filter(season => season !== button.dataset.value).join(',');
      } else if (selectedSeasons.length < 2) {
        button.classList.add('active');
        seasonInput.value = [...selectedSeasons, button.dataset.value].join(',');
      } else {
        alert('최대 2개의 계절만 선택 가능합니다.');
      }
    });
  });

  styleButtons.forEach(button => {
    button.addEventListener('click', () => {
      const selectedStyles = styleInput.value ? styleInput.value.split(',') : [];
      if (selectedStyles.includes(button.dataset.value)) {
        button.classList.remove('active');
        styleInput.value = selectedStyles.filter(style => style !== button.dataset.value).join(',');
      } else if (selectedStyles.length < 2) {
        button.classList.add('active');
        styleInput.value = [...selectedStyles, button.dataset.value].join(',');
      } else {
        alert('최대 2개의 스타일 태그만 선택 가능합니다.');
      }
    });
  });
});

//메인이미지 서브이미지 보기
document.addEventListener('DOMContentLoaded', () => {
  // 메인 이미지 미리보기
  const mainImageInput = document.getElementById('mainImage');
  const mainImagePreview = document.getElementById('mainImagePreview').querySelector('img');
  mainImagePreview.style.width = "300px";
  mainImagePreview.style.height = "300px";
  mainImagePreview.style.objectFit = "cover";
  mainImageInput.addEventListener('change', (event) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        mainImagePreview.src = e.target.result;
        mainImagePreview.style.display = 'block';
      };
      reader.readAsDataURL(file);
    } else {
      mainImagePreview.src = '';
      mainImagePreview.style.display = 'none';
    }
  });

  // 서브 이미지 미리보기
  const additionalImagesInput = document.getElementById('additionalImages');
  const additionalImagesPreview = document.getElementById('additionalImagesPreview');

  additionalImagesInput.addEventListener('change', (event) => {
    additionalImagesPreview.innerHTML = ''; // 기존 미리보기 초기화
    const files = event.target.files;
    if (files) {
      Array.from(files).forEach((file) => {
        const reader = new FileReader();
        reader.onload = (e) => {
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
});

//해쉬태그동작

document.addEventListener('DOMContentLoaded', () => {
  const hashtagInput = document.getElementById('hashtagInput');
  const hashtagList = document.getElementById('hashtagList');
  const hashtagsInput = document.getElementById('hashtagsInput');
  const addHashtagButton = document.getElementById('addHashtag');

  const hashtags = new Set(); // 중복 방지를 위해 Set 사용

  // 해시태그 추가 함수
  function addHashtag(tag) {
    const formattedTag = tag.startsWith('#') ? tag : `#${tag}`; // #이 없으면 추가
    if (formattedTag.length > 1 && !hashtags.has(formattedTag)) {
      hashtags.add(formattedTag);

      // UI에 해시태그 추가
      const tagElement = document.createElement('span');
      tagElement.className = 'badge bg-primary text-light';
      tagElement.textContent = formattedTag;
      tagElement.style.cursor = 'pointer';

      // 삭제 기능 추가
      tagElement.addEventListener('click', () => {
        hashtags.delete(formattedTag);
        tagElement.remove();
        updateHashtagsInput();
      });

      hashtagList.appendChild(tagElement);
      updateHashtagsInput();
    }
    hashtagInput.value = ''; // 입력 필드 초기화
  }

  // 해시태그를 숨겨진 인풋 필드에 업데이트
  function updateHashtagsInput() {
    hashtagsInput.value = Array.from(hashtags).join(','); // 해시태그를 콤마로 구분
  }

  // 엔터 키 입력 시 해시태그 추가
  hashtagInput.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      event.preventDefault();
      const tag = hashtagInput.value.trim();
      if (tag) {
        addHashtag(tag);
      }
    }
  });

  // 추가 버튼 클릭 시 해시태그 추가
  addHashtagButton.addEventListener('click', () => {
    const tag = hashtagInput.value.trim();
    if (tag) {
      addHashtag(tag);
    }
  });
});

//내가구매한상품 체크 콤보박스

document.addEventListener('DOMContentLoaded', () => {
  const productCheckboxes = document.querySelectorAll('.product-checkbox');
  const hiddenInput = document.getElementById('selectedProdNo');

  function updateSelectedProducts() {
    const selectedValues = Array.from(productCheckboxes)
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
    hiddenInput.value = selectedValues.join(',');
    console.log('Selected products:', hiddenInput.value); // 디버깅용
  }

  productCheckboxes.forEach(checkbox => {
    checkbox.addEventListener('change', updateSelectedProducts);
  });

  // 폼 제출 전 선택된 제품 확인
  document.querySelector('form').addEventListener('submit', (e) => {
    console.log('Form submitted. Selected products:', hiddenInput.value); // 디버깅용
  });
});

document.getElementById('snapEditForm').addEventListener('submit', function(e) {
  const submitButton = document.getElementById('submitSnap');
  // 중복 클릭 방지를 위해 저장 버튼 비활성화
  submitButton.disabled = true;
  submitButton.textContent = '저장 중...';
});
