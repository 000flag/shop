document.addEventListener('DOMContentLoaded', () => {
    // 정렬 선택 및 쿠폰 조회
    document.getElementById("coupon-select").addEventListener("change", function (e) {
        selectCoupons();
    });

    // 검색어 입력 및 쿠폰 조회
    document.getElementById("coupon-search-input").addEventListener("keydown", function (e) {
        if (e.key === 'Enter') {
            selectCoupons();
        }
    });
});

function onKeydownCoupon(e) {
    if (e.key == "Enter") {
        selectCoupons();
    }
}

function onChangeCouponSort() {
    selectCoupons();
}

// 쿠폰 조회
function selectCoupons() {
    const searchInput = document.querySelector('.search-input');
    const sortSelect = document.querySelector('.sort-select');

    const searchValue = searchInput.value;
    const selectedSortValue = sortSelect.value;

    $.ajax({
        url: "Controller?type=coupon&action=select",
        type: "POST",
        data: {
            searchValue: searchValue,
            sort: selectedSortValue,
        },
        success: function (response) {
            // 쿠폰 섹션만 표시하고 다른 섹션은 숨김
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
                if (section === "#coupon-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 #coupon-article에 렌더링
            $("#coupon-article").html(response);

            searchInput.value = searchValue;
            sortSelect.value = selectedSortValue;
        },
        error: function (status, error) {
            console.error("배송지 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}
