function selectQuestion() {
    $.ajax({
        url: "Controller?type=question&action=select",
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
                if (section === "#question-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 #question-article에 렌더링
            $("#question-article").html(response);
        },
        error: function (status, error) {
            console.error("상품문의 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}

function searchQuestion(){
    const status = document.getElementById("question-status").value;
    const startDate = document.getElementById("question-start-date").value;
    const endDate = document.getElementById("question-end-date").value;

    // 현재 날짜
    const today = new Date();
    today.setHours(0, 0, 0, 0); // 시간을 00:00:00으로 설정하여 비교

    // 입력된 날짜를 Date 객체로 변환
    const start = new Date(startDate);
    const end = new Date(endDate);

    // 조회 기간이 오늘보다 나중일 때 경고
    if (start > today || end > today) {
        alert("조회 기간은 오늘 이전 날짜만 선택할 수 있습니다.");
        return;
    }

    // 조회 기간이 올바른 순서인지 확인
    if (start > end) {
        alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
        return;
    }

    $.ajax({
        url: "Controller?type=question&action=search",
        type: "POST",
        data: {
            status: status,
            startDate: startDate,
            endDate: endDate
        },
        success: function (response) {
            $("#question-article").html(response);
        },
        error: function (status, error) {
            console.error("상품문의 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}