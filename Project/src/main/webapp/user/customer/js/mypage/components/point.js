// 적립금 조회
function selectPoint(action) {
    const targetTable = "#point-table-" + action;

    // AJAX 요청으로 Action 호출
    $.ajax({
        url: "Controller?type=point&action=" + action,
        type: "POST",
        success: function (response) {
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
                if (section === "#point-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 해당 탭에 렌더링
            $("#point-article").html(response); // 응답 데이터 삽입
            $(targetTable).show(); // 해당 테이블만 표시

            document.querySelectorAll(".nav-link").forEach(function (element) {
                if (element.classList.contains("active")) {
                    element.classList.remove("active");
                }
            });
            document.querySelector('[data-target="#point-' + action + '"]').classList.add('active');
            $("#point-list .list").hide();
            $("#point-" + action).show();
        },
        error: function (status, error) {
            console.error("포인트 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}