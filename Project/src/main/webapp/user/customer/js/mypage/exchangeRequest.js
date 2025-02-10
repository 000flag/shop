// 교환 사유 필드 추가
function addReasonInput() {
    let selectValue = document.getElementById("select-reason").value;
    let exchangeInput = document.getElementById("exchange-input");

    if (selectValue == "직접 입력") {
        exchangeInput.style.display = "block";
    } else {
        exchangeInput.style.display = "none";
    }
}

$(document).ready(function () {
    // 페이지 로드 후 즉시 옵션 가져오기
    const prodNo = $('input[name="prod_no"]').val();
    const inventoryNo = $('input[name="inventory_no"]').val();
    if (prodNo) {
        productOptions(prodNo, inventoryNo);
    }

    // 사이즈 옵션이 변경될 때 이벤트 바인딩
    $('#exchange-option-size').on('change', function () {});
});

// 상품 옵션 목록을 비동기로 가져오기
function productOptions(prodNo) {
    $.ajax({
        url: 'Controller?type=exchangeRequest&action=select_size',
        type: 'POST',
        data: {
            prod_no: prodNo,
        },
        success: function (response) {
            if (response.success) {
                // 기존 옵션 초기화
                const optionSelect = $('#exchange-option-size');
                optionSelect.empty();
                optionSelect.append('<option selected="selected">:: 사이즈 선택 ::</option>');

                // 응답 데이터를 기반으로 옵션 추가
                response.data.forEach(function (item) {
                    // option의 value는 inventory_no, text는 option_name으로 설정
                    optionSelect.append(`<option value="${item.inventory_no}">${item.option_name}</option>`);
                });
            } else {
                alert('옵션 목록을 가져오는 데 실패했습니다.');
            }
        },
        error: function () {
            alert('서버와의 통신 중 오류가 발생했습니다.');
        }
    });
}

function exchangeRequest() {
    // 상품의 order_id 가져오기
    const order_id = $('input[name="id"]').val();

    // 상품의 prod_no 값을 가져오기
    const prodNo = $('input[name="prod_no"]').val();

    // ordercode 값을 가져오기
    const orderCode = $('input[name="orderCode"]').val();

    // 교환 사유 가져오기
    let reason = $('#select-reason').val();
    if (reason === ":: 교환 사유를 선택하세요 ::") {
        alert("교환 사유를 선택해 주세요.");
        return;
    }

    if (reason === "직접 입력") {
        reason = $('input[name="select-reason"]').val();
        if (!reason) {
            alert("교환 사유를 입력해 주세요.");
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

    // 사이즈 옵션 가져오기
    const selectedInventoryNo = $('#exchange-option-size').val();
    if (selectedInventoryNo === ":: 사이즈 ::") {
        alert("교환할 사이즈를 선택해 주세요.");
        return;
    }

    // 교환 신청 확인 경고창
    if (!confirm("교환 신청하시겠습니까?")) {
        return;  // 사용자가 취소를 누르면 함수 종료
    }

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=exchangeRequest&action=update',
        type: 'POST',
        data: {
            order_id: order_id,
            prod_no: prodNo,
            reason: reason,
            retrieve_deli_no: retrieveDeliNo,
            orderCode: orderCode,
            inventory_no: selectedInventoryNo
        },
        success: function (response) {
            if (response && response.success) {
                alert("교환 신청이 완료되었습니다.");
                window.location.href = "Controller?type=myPage";
            } else {
                alert(response.message || "교환 신청 중 오류가 발생했습니다.");
            }
        },
        error: function () {
            alert("서버와의 통신 중 오류가 발생했습니다.");
        }
    });
}