// 페이지 로드 시 실행
document.addEventListener("DOMContentLoaded", function () {
    selectOrder(); // 페이지 로드 시 주문내역 함수 실행
});

//주문내역 클릭 시 실행되는 함수
function selectOrder() {
    $.ajax({
        url: "Controller?type=order&action=all",
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
                if (section === "#order-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 #order-article에 렌더링
            $("#order-article").html(response);
        },
        error: function (status, error) {
            console.error("주문 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}

//날짜 조회
function searchOrder(){
    const startDate = document.getElementById("order-start-date").value;
    const endDate = document.getElementById("order-end-date").value;

    // 현재 날짜
    const today = new Date();
    today.setHours(0, 0, 0, 0); // 시간을 00:00:00으로 설정하여 비교

    // 입력된 날짜를 Date 객체로 변환
    const start = new Date(startDate);
    const end = new Date(endDate);

    // 입력된 날짜의 시간도 00:00:00으로 초기화
    start.setHours(0, 0, 0, 0);
    end.setHours(0, 0, 0, 0);

    // 조회 기간이 내일 이후일 때 경고 (오늘 날짜는 허용)
    if (start > today || end > today) {
        alert("조회 기간은 오늘 날짜 또는 이전 날짜만 선택할 수 있습니다.");
        return;
    }

    // 조회 기간이 올바른 순서인지 확인
    if (start > end) {
        alert("시작 날짜는 종료 날짜보다 이전이어야 합니다.");
        return;
    }

    $.ajax({
        url: "Controller?type=order&action=date",
        type: "POST",
        data: {
            startDate: startDate,
            endDate: endDate
        },
        success: function (response) {
            $("#order-article").html(response);
        },
        error: function (status, error) {
            console.error("상품문의 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}

function confirmPurchase(orderCode) {
    if (confirm("해당 상품을 구매 확정하시겠습니까?")) {
        $.ajax({
            url: 'Controller?type=order&action=status',
            type: 'POST',
            data: {
                orderCode: orderCode,
                status: '5'
            },
            dataType: 'json',
            success: function(response) {
                if (response.response) {
                    alert("구매 확정이 완료되었습니다.");
                    location.reload();
                } else {
                    alert("구매 확정에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                alert("구매 확정에 실패했습니다. 다시 시도해 주세요.");
            }
        });
    }
}