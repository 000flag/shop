// 좋아요 아이콘 클릭 시
function toggleHeart(obj, value) {
    // 아이콘이 비어 있는 하트인지 확인
    if (!obj.classList.contains('bi-heart')) {
        // 좋아요 취소 처리 로직 호출
        deleteProdLike(value);

        // 다시 비어 있는 하트로 변경 및 애니메이션 추가
        obj.classList.remove('bi-heart-fill', 'heart-active');
        obj.classList.add('bi-heart', 'heart-animation');
    }

    // 애니메이션이 끝나면 클래스 제거
    obj.addEventListener('animationend', function () {
        obj.classList.remove('heart-animation');
    }, { once: true });
}

// 좋아요 해제
function deleteProdLike(value) {
    $.ajax({
        url: "Controller?type=like&action=unlike",
        method: 'POST',
        data: {
            prod_no: value
        },
        success: function () {
            window.location.href = "Controller?type=like&action=select";
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}