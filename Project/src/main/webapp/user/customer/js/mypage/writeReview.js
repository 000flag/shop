document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('.rating-stars .star');

    // 별점 클릭 이벤트 처리
    stars.forEach(star => {
        star.addEventListener('click', function () {
            // 모든 별의 selected 클래스 제거
            stars.forEach(s => s.classList.remove('selected'));

            // 클릭한 별과 그 이전 별까지 selected 클래스 추가
            const value = parseInt(this.getAttribute('data-value'));
            stars.forEach(s => {
                if (parseInt(s.getAttribute('data-value')) <= value) {
                    s.classList.add('selected');
                }
            });

            // 선택한 별점 값을 숨겨진 input에 저장
            document.getElementById('rating-value').value = value;
        });
    });

    // 글자수 카운트 이벤트
    document.getElementById('review-comment').addEventListener('input', function () {
        document.querySelector('.text-count').textContent = `${this.value.length}/500`;
    });
});

// 리뷰 등록
function insertReview() {
    // event.preventDefault(); // 폼 기본 제출 방지
    const form = document.getElementById('review-form');
    const formData = new FormData(form);

    // 각 입력 데이터들을 formData에 추가
    formData.append('rating', document.getElementById('rating-value').value);
    formData.append('comment', document.getElementById('review-comment').value);

    const photoInput = document.getElementById('photo-input');
    if (photoInput.files.length > 0) {
        formData.append('photo', photoInput.files[0]);
    }

    const genderElement = document.querySelector('input[name="options"]:checked');
    if (genderElement) {
        formData.append('gender', genderElement.value);
    }

    formData.append('height', document.getElementById('height').value);
    formData.append('weight', document.getElementById('weight').value);
    formData.append('isUpdateChecked', document.getElementById('update-body-info').checked);
    formData.append('prod_no', document.getElementById('prod_no').value);

    // 입력 데이터 유효성 검사
    if (!formData.get('rating')) {
        alert("별점을 선택해 주세요.");
        return;
    }

    if (!formData.get('comment') || formData.get('comment').length < 10) {
        alert("리뷰 내용을 최소 10자 이상 작성해 주세요.");
        return;
    }

    if (!formData.get('gender')) {
        alert("성별을 선택해 주세요.");
        return;
    }

    if (!formData.get('height') || !formData.get('weight')) {
        alert("키와 몸무게 정보를 입력해 주세요.");
        return;
    }

    if (!confirm("리뷰를 등록하시겠습니까?")) {
        return;
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=review&action=insert',
        type: 'POST',
        data: formData,
        processData: false,  // 데이터 직렬화 금지
        contentType: false,  // 기본적으로 multipart로 설정됨
        success: function (response) {
            if (response.success) {
                alert(response.message);
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "리뷰 등록 중 오류가 발생했습니다.");
            }
        },
        error: function (xhr) {
            console.error("리뷰 등록 중 서버 오류 발생:", xhr.responseText);
            alert("서버 오류 발생: " + xhr.responseText);
        }
    });
}

// 사진 추가 기능
function triggerFileInput() {
    document.getElementById('photo-input').click();
}

document.getElementById('photo-input').addEventListener('change', function (event) {
    const file = event.target.files[0];

    if (file) {
        const reader = new FileReader();

        reader.onload = function (e) {
            // 이미지 미리보기 추가
            const photoBox = document.querySelector('.photo-box');
            photoBox.dataset.photoName = file.name;
            photoBox.innerHTML = `<img src="${e.target.result}" alt="첨부된 사진" class="preview-img">`;
        };

        reader.readAsDataURL(file);
    }
});
