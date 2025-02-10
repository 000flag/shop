document.addEventListener("DOMContentLoaded", function () {
    let countdownValue = 3;
    const timerElement = document.getElementById('timer');
    const progressCircle = document.querySelector('.circle-progress');
    const timerContainer = document.getElementById('timer-container');
    const orderCompleted = document.getElementById('order-completed');
    const orderCompletedText = document.querySelector('.completed-text');

    // Progress circle 설정
    const radius = progressCircle.r.baseVal.value;
    const circumference = 2 * Math.PI * radius;

    progressCircle.style.strokeDasharray = circumference;
    progressCircle.style.strokeDashoffset = circumference;

    function setProgress(value) {
        const offset = circumference - (value / 5) * circumference;
        progressCircle.style.strokeDashoffset = offset;
    }

    // 글자 크기 애니메이션 함수
    let isFontSizeLarge = true;
    function toggleFontSize() {
        if (isFontSizeLarge) {
            orderCompletedText.style.fontSize = '35px';
        } else {
            orderCompletedText.style.fontSize = '45px';
        }
        isFontSizeLarge = !isFontSizeLarge;
    }

    // 카운트다운 시작
    timerElement.textContent = countdownValue;
    setProgress(countdownValue);

    // 애니메이션 및 카운트다운 시작
    const animationInterval = setInterval(toggleFontSize, 800); // 0.8초마다 글자 크기 변경

    const countdownInterval = setInterval(function () {
        countdownValue--;
        timerElement.textContent = countdownValue;
        setProgress(countdownValue);

        if (countdownValue <= 0) {
            clearInterval(countdownInterval);
            clearInterval(animationInterval);
            timerContainer.style.display = 'none';
            orderCompleted.style.display = 'none';

            selectOrderDetails();
        }
    }, 1000);
});

// 주문 상세 조회
function selectOrderDetails() {
    const order_code = document.getElementById("order-details").dataset.order;

    $.ajax({
        url: "Controller?type=order&action=completed",
        method: 'POST',
        data: {
            order_code: order_code
        },
        success: function (response) {
            $("#order-details").html(response);
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 주문 배송지 변경
function updateDeliAddr() {
    const DeliveryID = document.querySelector(".deli-no").value;
    const selectedDeliveryId = document.querySelector('input[name="deliveryAddress"]:checked').value;
    const orderCode = document.querySelector("#orderCode").value;

    $.ajax({
        url: 'Controller?type=orderDetails&action=update',
        type: 'POST',
        data: {
            pre_delivery_id: DeliveryID, // 기존 배송지 id
            delivery_id: selectedDeliveryId, // 선택된 배송지 id
            order_code: orderCode // 주문 코드
        },
        success: function(response) {
            if (response.success) {
                alert("배송지가 수정되었습니다.");

                $(".modal-header .close").click();

                document.querySelector('.name').textContent = response.data.deli_name;
                document.querySelector('.phone').textContent = response.data.phone;
                document.querySelector('.address').textContent = response.data.pos_code + response.data.addr1 + response.data.addr2;
            } else {
                alert("배송지 수정 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            alert("서버와의 통신 중 문제가 발생했습니다.");
        }
    });
}
