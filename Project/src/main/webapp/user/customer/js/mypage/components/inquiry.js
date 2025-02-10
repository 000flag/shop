// 초기 상태 설정
document.addEventListener("DOMContentLoaded", () => {
    const startDateInput = document.getElementById("inquiry-start-date");
    const endDateInput = document.getElementById("inquiry-end-date");
    const today = new Date();
    const formattedToday = today.toISOString().split("T")[0]; // 오늘 날짜 (YYYY-MM-DD)

    // 종료 날짜는 오늘 날짜를 기준으로 제한
    endDateInput.max = formattedToday;

    // 초기 날짜 유효성 검사 및 설정
    validateDateInputs();

    // 로드 시 선택된 옵션에 따라 초기 날짜 설정
    inquiry_onChangeDateRange();
});

// 시작 날짜 변경 시 유효성 검사
function onChageInquiryStartDate() {
    const startDateInput = document.getElementById("inquiry-start-date");
    const endDateInput = document.getElementById("inquiry-end-date");

    if (startDateInput.value > endDateInput.value) {
        alert("시작 날짜는 종료 날짜보다 클 수 없습니다.");
        startDateInput.value = endDateInput.value;
    }
}

// 종료 날짜 변경 시 유효성 검사
function onChageInquiryEndDate() {
    const startDateInput = document.getElementById("inquiry-start-date");
    const endDateInput = document.getElementById("inquiry-end-date");
    const today = new Date();
    const formattedToday = today.toISOString().split("T")[0]; // 오늘 날짜 (YYYY-MM-DD)

    if (endDateInput.value > formattedToday) {
        alert("종료 날짜는 오늘 날짜를 초과할 수 없습니다.");
        endDateInput.value = formattedToday;
    }
    if (endDateInput.value < startDateInput.value) {
        alert("종료 날짜는 시작 날짜보다 작을 수 없습니다.");
        endDateInput.value = startDateInput.value;
    }
}

// 1:1문의 클릭 시
function selectInquiry() {
    $.ajax({
        url: "Controller?type=board&action=select",
        type: "POST",
        success: function (response) {
            // 1:1문의 섹션만 표시하고 다른 섹션은 숨김
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
                if (section === "#inquiry-article") {
                    $(section).show();
                } else {
                    $(section).hide();
                }
            });

            // 응답 데이터를 #inquiry-article에 렌더링
            $("#inquiry-article").html(response);
        },
        error: function (status, error) {
            console.error("1:1문의 정보를 가져오는 데 실패했습니다.", error);
        }
    });
}

// 기간 설정 옵션 변경 시
function inquiry_onChangeDateRange() {
    const dateRange = document.getElementById("inquiry-date-range").value;
    const startDateInput = document.getElementById("inquiry-start-date");
    const endDateInput = document.getElementById("inquiry-end-date");
    const today = new Date();
    const formattedToday = today.toISOString().split("T")[0];
    let startDate = null;

    // 날짜 범위 계산
    if (dateRange === "1-week") {
        startDate = new Date(today);
        startDate.setDate(today.getDate() - 7);
    } else if (dateRange === "1-month") {
        startDate = new Date(today);
        startDate.setMonth(today.getMonth() - 1);
    } else if (dateRange === "3-months") {
        startDate = new Date(today);
        startDate.setMonth(today.getMonth() - 3);
    }

    // 시작 날짜와 종료 날짜 설정
    if (startDate) {
        startDateInput.value = startDate.toISOString().split("T")[0];
        endDateInput.value = formattedToday;
    } else {
        startDateInput.value = "";
        endDateInput.value = "";
    }

    // 유효성 검사
    validateDateInputs();
}

// 날짜 입력 유효성 검사
function validateDateInputs() {
    const startDateInput = document.getElementById("inquiry-start-date");
    const endDateInput = document.getElementById("inquiry-end-date");
    const today = new Date().toISOString().split("T")[0];

    // 종료 날짜가 오늘을 초과하면 수정
    if (endDateInput.value > today) {
        endDateInput.value = today;
    }

    // 시작 날짜가 종료 날짜보다 크면 수정
    if (startDateInput.value && endDateInput.value && startDateInput.value > endDateInput.value) {
        alert("시작 날짜는 종료 날짜보다 클 수 없습니다.");
        startDateInput.value = endDateInput.value;
    }
}

// 검색 버튼 클릭 시
function inquiry_onSearchInquiry() {
    const status = document.getElementById("inquiry-status").value; // 처리 상태
    const startDate = document.getElementById("inquiry-start-date").value; // 시작 날짜 (사용자 입력)
    const endDate = document.getElementById("inquiry-end-date").value; // 종료 날짜 (사용자 입력)

    // AJAX 요청
    $.ajax({
        url: "Controller?type=board&action=search",
        method: "POST",
        data: {
            status: status,
            startDate: startDate,
            endDate: endDate
        },
        success: function (response) {
            // 검색 결과를 렌더링
            $("#inquiry-article").html(response);

            if (status) {
                document.getElementById("inquiry-status").value = status;
            }

            if (startDate) {
                document.getElementById("inquiry-start-date").value = startDate;
            }

            if (endDate) {
                document.getElementById("inquiry-end-date").value = endDate;
            }
        },
        error: function () {
            alert("검색 중 오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}