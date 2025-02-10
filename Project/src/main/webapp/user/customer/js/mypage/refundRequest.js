$(document).ready(function () {
    // o_list 길이를 확인하여 버튼 이벤트 할당
    const orderListLength = $('input[name="order_id"]').length;
    if (orderListLength > 1) {
        $('#refundRequestButton').on('click', refundRequestAll);
    } else {
        $('#refundRequestButton').on('click', refundRequest);
    }
});

//반품 사유 필드 추가
function addReasonInput() {
    let selectValue = document.getElementById("select").value;
    let refundInput = document.getElementById("refund-input");

    if (selectValue == "직접 입력") {
        refundInput.style.display = "block";
    } else {
        refundInput.style.display = "none";
    }
}

function refundRequest() {
    // 상품의 order_id 가져오기
    const order_id = $('input[name="order_id"]').val();

    // 상품의 prod_no 가져오기
    const prodNo = $('input[name="prod_no"]').val();

    // ordercode 값을 가져오기
    const orderCode = $('input[name="orderCode"]').val();

    //benefit_type 값 가져오기
    const benefit_type = $('input[name="benefit_type"]').val();

    // 반품 사유 가져오기
    let reason = $('#select').val();
    if (reason === "0") {
        alert("반품 사유를 선택해 주세요.");
        return;
    }
    if (reason === "직접 입력") {
        reason = $('input[name="request-reason"]').val();
        if (!reason) {
            alert("반품 사유를 입력해 주세요.");
            return;
        }
    }

    // 회수지 번호 가져오기
    const retrieveDeliElement = document.querySelector('input[name="retrieve_deli_no"]:checked');
    if (!retrieveDeliElement) {
        alert("회수지를 선택해 주세요.");
        return;
    }
    const retrieveDeliNo = retrieveDeliElement.value;

    // 계좌 정보 가져오기
    const bank = $('#bank-select').find('option:selected').val();
    const accountNumber = $('#account-number').val();

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

    // 환불 예정 금액 가져오기
    const refundAmount = $('.refund-info .refund-amount').text().replace(/[^0-9]/g, '');

    // 사용된 적립금 가져오기
    const pointUsed = $('input[name="point-used"]').val();

    // 반품 신청 확인 경고창
    if (!confirm("반품 신청하시겠습니까?")) {
        return;  // 사용자가 취소를 누르면 함수 종료
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=refundRequest&action=update',
        type: 'POST',
        data: {
            order_id: order_id,
            prod_no: prodNo,
            reason: reason,
            retrieve_deli_no: retrieveDeliNo,
            bank: bank,
            account_number: accountNumber,
            orderCode: orderCode,
            refund_amount: refundAmount,
            point_used: pointUsed || null,
            benefit_type: benefit_type
        },
        success: function (response) {
            if (response && response.success) {
                alert("반품 신청이 완료되었습니다.");
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "반품 신청 중 오류가 발생했습니다.");
            }
        },
        error: function () {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}

function refundRequestAll() {
    // orderCode 가져오기
    const orderCode = $('input[name="orderCode"]').val();

    // 반품 사유 가져오기
    let reason = $('#select').val();
    if (reason === "0") {
        alert("반품 사유를 선택해 주세요.");
        return;
    }
    if (reason === "직접 입력") {
        reason = $('input[name="request-reason"]').val();
        if (!reason) {
            alert("반품 사유를 입력해 주세요.");
            return;
        }
    }

    // 회수지 번호 가져오기
    const retrieveDeliElement = document.querySelector('input[name="retrieve_deli_no"]:checked');
    if (!retrieveDeliElement) {
        alert("회수지를 선택해 주세요.");
        return;
    }
    const retrieveDeliNo = retrieveDeliElement.value;

    // 계좌 정보 가져오기
    const bank = $('#bank-select').find('option:selected').val();
    const accountNumber = $('#account-number').val();

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

    // 환불 예정 금액 가져오기
    const refundAmount = $('.refund-info .refund-amount').text().replace(/[^0-9]/g, '');

    // 사용된 적립금 가져오기
    const pointUsed = $('input[name="point-used"]').val();

    // 반품 신청 확인 경고창
    if (!confirm("전체 반품 신청을 하시겠습니까?")) {
        return;  // 사용자가 취소를 누르면 함수 종료
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=refundRequest&action=update_all',
        type: 'POST',
        data:{
            orderCode: orderCode,
            reason: reason,
            retrieve_deli_no: retrieveDeliNo,
            bank: bank,
            account_number: accountNumber,
            refund_amount: refundAmount,
            point_used: pointUsed || null
        },
        success: function (response) {
            if (response && response.success) {
                alert("전체 반품 신청이 완료되었습니다.");
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "전체 반품 신청 중 오류가 발생했습니다.");
            }
        },
        error: function () {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}
