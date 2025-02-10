// 리뷰내역 클릭 시 실행되는 함수
function selectMypageReview() {
    $.ajax({
        url: "Controller?type=review&action=select",
        type: "POST",
        success: function (response) {
            // 상품문의 섹션만 표시하고 다른 섹션은 숨김
            const allSections = [
                "#order-article",
                "#refund-article",
                "#review-article",
                "#inquiry-article",
                "#question-article",
                "#point-article",
                "#coupon-article",
                "#delivery-article"
            ];
            allSections.forEach((section) => {
                if (section === "#review-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 #review-article에 렌더링
            $("#review-article").html(response);
        },
        error: function (status, error) {
            console.error("주문 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}
