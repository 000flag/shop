$(document).ready(function () {
    // 라디오 버튼 선택 시 이벤트 처리
    $('input[name="cancelReason"]').on('change', function () {
        const selectedValue = $(this).val();

        if (selectedValue === "reason4") {
            $('#custom-reason-input').show();  // 기타 선택 시 입력 필드 표시
        } else {
            $('#custom-reason-input').hide();  // 다른 사유 선택 시 입력 필드 숨김
        }
    });

    // o_list 길이를 확인하여 버튼에 이벤트 할당
    $('#cancelRequestButton').on('click', cancelRequest); // 개별 취소
    $('#cancelAllRequestButton').on('click', cancelRequestAll); // 전체 취소
});

function getSelectedCancelReason() {
    // 선택된 라디오 버튼 가져오기
    const selectedRadio = document.querySelector('input[name="cancelReason"]:checked');

    if (!selectedRadio) {
        alert("취소 사유를 선택해 주세요.");
        return null;
    }

    // 선택된 라디오 버튼의 label 값 가져오기
    const reasonLabel = document.querySelector(`label[for="${selectedRadio.id}"]`).textContent.trim();

    return reasonLabel;
}

function cancelRequest() {
    // 상품의 order_id 가져오기
    const order_id = $('input[name="order_id"]').val();

    // 상품의 prod_no 가져오기
    const prodNo = $('input[name="prod_no"]').val();

    // ordercode 값을 가져오기
    const orderCode = $('#orderCode').val();

    //benefit_type 값 가져오기
    const benefit_type = $('input[name="benefit_type"]').val();

    // 취소 사유 가져오기
    let reason = getSelectedCancelReason();
    if (!reason) {
        return;  // 취소 사유가 선택되지 않았으면 함수 종료
    }

    // '기타' 사유일 경우 추가 입력값 가져오기
    if (reason === '기타') {
        const customReason = $('input[name="customCancelReason"]').val();
        if (!customReason) {
            alert("기타 사유를 입력해 주세요.");
            return;
        }
        reason = customReason;
    }

    // 사용된 적립금 가져오기
    const pointUsed = $('input[name="cancel-point-used"]').val();

    // 계좌 정보는 주문 상태가 '0'이 아닌 경우에만 가져오기
    let bank = '';
    let accountNumber = '';
    if ($('#cancel-bank-select').length > 0 && $('#account-number').length > 0) {
        bank = $('#cancel-bank-select').find('option:selected').val();
        accountNumber = $('#account-number').val();

        if (!bank) {
            alert("은행을 선택해 주세요.");
            return;
        }

        if (!accountNumber) {
            alert("계좌번호를 입력해 주세요.");
            return;
        }

        if (!/^\d{2,4}-\d{3,4}-\d{4,6}$/.test(accountNumber)) {
            alert("올바른 계좌번호 형식이 아닙니다.");
        }
    }

    // 환불 예정 금액 가져오기
    const refundAmount = $('.cancel-refund-info .cancel-refund-amount').text().replace(/[^0-9]/g, '');

    // 경고창 띄우기
    if (!confirm("취소 하시겠습니까?")) {
        return;
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=cancelOrder&action=update',
        type: 'POST',
        data: {
            order_id: order_id,
            prod_no: prodNo,
            reason: reason,
            bank: bank || null,
            account_number: accountNumber || null,
            orderCode: orderCode,
            refund_amount: refundAmount || null,
            point_used: pointUsed || null,
            benefit_type: benefit_type
        },
        success: function (response) {
            if (response && response.success) {
                alert("주문 취소가 완료되었습니다.");
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "주문 취소 중 오류가 발생했습니다.");
            }
        },
        error: function () {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}

function cancelRequestAll() {
    const orderCode = $('#orderCode').val();

    let reason = getSelectedCancelReason();
    if (!reason) return;

    if (reason === '기타') {
        const customReason = $('input[name="customCancelReason"]').val();
        if (!customReason) {
            alert("기타 사유를 입력해 주세요.");
            return;
        }
        reason = customReason;
    }

    const pointUsed = $('input[name="cancel-point-used"]').val();
    let bank = '', accountNumber = '';
    if ($('#cancel-bank-select').length > 0 && $('#account-number').length > 0) {
        bank = $('#cancel-bank-select').find('option:selected').val();
        accountNumber = $('#account-number').val();

        if (!bank) {
            alert("은행을 선택해 주세요.");
            return;
        }

        if (!accountNumber) {
            alert("계좌번호를 입력해 주세요.");
            return;
        }

        if (!/^\d{2,4}-\d{3,4}-\d{4,6}$/.test(accountNumber)) {
            alert("올바른 계좌번호 형식이 아닙니다.");
        }
    }

    const refundAmount = $('.cancel-refund-info .cancel-refund-amount').text().replace(/[^0-9]/g, '');
    if (!confirm("전체 주문을 취소하시겠습니까?")) return;

    $.ajax({
        url: 'Controller?type=cancelOrder&action=update_all',
        type: 'POST',
        data: {
            orderCode: orderCode,
            reason: reason,
            bank: bank || null,
            account_number: accountNumber || null,
            refund_amount: refundAmount || null,
            point_used: pointUsed || null
        },
        success: function (response) {
            if (response && response.success) {
                alert("전체 주문 취소가 완료되었습니다.");
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "전체 주문 취소 중 오류가 발생했습니다.");
            }
        },
        error: function () {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}