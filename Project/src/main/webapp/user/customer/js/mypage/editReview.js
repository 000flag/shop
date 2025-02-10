document.addEventListener('DOMContentLoaded', function () {
    // 글자수 카운트 이벤트
    document.getElementById('review-comment').addEventListener('input', function () {
        document.querySelector('.text-count').textContent = `${this.value.length}/500`;
    });
});

// 별점
function updateStarRating(selectedStar) {
    const stars = document.querySelectorAll('#review-score i');

    // 별들을 순회하며 상태 변경 및 rating-value 값 설정
    stars.forEach(star => {
        const starValue = parseInt(star.getAttribute('data-star'), 10);

        if (starValue <= selectedStar) {
            star.classList.remove('bi-star');
            star.classList.add('bi-star-fill');
        } else {
            star.classList.remove('bi-star-fill');
            star.classList.add('bi-star');
        }
    });

    // 별점 값을 hidden input에 설정
    document.getElementById('rating-value').value = selectedStar;
}

// 리뷰 수정
function updateReview() {
    const form = document.getElementById('review-form');
    const formData = new FormData(form);

    // 댓글 추가 (별점은 이미 hidden input에 설정되어 있음)
    formData.append('comment', document.getElementById('review-comment').value);

    const photoInput = document.getElementById('photo-input');
    if (photoInput.files.length > 0) {
        formData.append('photo', photoInput.files[0]);
    }

    // 별점 값이 없을 경우 경고
    if (!formData.get('rating') || formData.get('rating') === "0") {
        alert("별점을 선택해 주세요.");
        return;
    }

    if (!formData.get('comment') || formData.get('comment').length < 10) {
        alert("리뷰 내용을 최소 10자 이상 작성해 주세요.");
        return;
    }

    if (!confirm("리뷰를 수정하시겠습니까?")) {
        return;
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=review&action=update',
        type: 'POST',
        data: formData,
        processData: false,  // 데이터 직렬화 금지
        contentType: false,  // multipart 형식 설정
        success: function (response) {
            if (response.success) {
                alert(response.message);
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "리뷰 수정 중 오류가 발생했습니다.");
            }
        },
        error: function (xhr) {
            console.error("리뷰 수정 중 서버 오류 발생:", xhr.responseText);
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