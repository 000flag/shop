//주문 배송지 변경
function updateDeliveryAddress() {
    // 기존 배송지 ID
    const DeliveryID = document.querySelector(".deli-no").value;
    // 선택된 배송지 ID 가져오기
    const selectedDeliveryId = document.querySelector('input[name="deliveryAddress"]:checked').value;
    const orderCode = document.querySelector("#orderCode").value;

    // AJAX 요청
    $.ajax({
        url: 'Controller?type=orderDetails&action=update', // 배송지 변경 처리 URL
        type: 'POST',
        data: {
            pre_delivery_id: DeliveryID,
            delivery_id: selectedDeliveryId,  // 선택된 배송지 ID
            order_code: orderCode // 현재 주문 코드도 함께 전달
        },
        success: function(response) {
            if (response.success) {
                alert("배송지가 수정되었습니다.");

                // 모달 닫기
                $(".modal-header .close").click();

                // 변경된 데이터를 DOM에 반영
                document.querySelector('.name').textContent = response.data.deli_name;
                document.querySelector('.phone').textContent = response.data.phone;
                document.querySelector('.address').textContent = `${response.data.pos_code} ${response.data.addr1} ${response.data.addr2}`;
            } else {
                alert("배송지 수정 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            alert("서버와의 통신 중 문제가 발생했습니다.");
        }
    });
}

// 옵션 변경 모달 열기 및 사이즈 조회 실행
function ShowOptionModal(prod_no) {
    $('#orderDetails_optionModal').on('shown.bs.modal', function () {
        const isVisible = $('#orderDetails_optionModal').is(':visible');

        if (isVisible) {
            selectProdSize(prod_no);  // 모달이 표시될 때 사이즈 정보 조회
        }
    });
}

// 사이즈 정보 조회
function selectProdSize(prod_no) {
    $.ajax({
        url: "Controller?type=orderDetails&action=select_size",
        method: 'POST',
        data: {
            prod_no: prod_no
        },
        success: function (response) {
            if (response.success) {
                const optionSelect = document.getElementById('orderDetails-size-options');
                optionSelect.innerHTML = '';  // 기존 옵션 제거

                // 응답 데이터를 바탕으로 옵션 추가
                response.data.forEach(function (item) {
                    const option = document.createElement('option');
                    option.value = item.inventory_no;
                    option.textContent = item.option_name;

                    optionSelect.appendChild(option);
                });
            } else {
                alert("옵션 정보를 불러오는 데 실패했습니다.");
            }
        },
        error: function (error) {
            alert("서버와의 통신 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 사이즈 변경 처리
function ChangeProdSize() {
    // JSP에서 숨겨진 필드의 값 가져오기
    const order_id = document.getElementById('orderId').value;
    const order_code = document.getElementById('orderCode').value;
    const prod_no = document.getElementById('prod-no').value;

    const selectedOption = document.querySelector('#orderDetails-size-options').selectedOptions[0];
    const inventory_no = selectedOption.value;

    $.ajax({
        url: "Controller?type=orderDetails&action=update_size",
        method: 'POST',
        data: {
            order_id: order_id,
            order_code: order_code,
            prod_no: prod_no,
            inventory_no: inventory_no
        },
        success: function (response) {
            if (response.success) {
                // 옵션 변경 성공 시 모달 닫기
                $('#orderDetails_optionModal').click();
                alert("옵션이 성공적으로 변경되었습니다.");
            } else {
                alert("옵션 변경에 실패했습니다.");
            }
        },
        error: function (error) {
            alert("서버와의 통신 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

