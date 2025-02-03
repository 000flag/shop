let coupons = [];                    // 모든 쿠폰 정보를 저장하는 멤버 변수
let appliedCoupons = {};              // 적용된 쿠폰 상태 저장 (key: cartNo, value: 쿠폰 번호)
let usedCoupons = new Set();          // 사용 중인 쿠폰 번호를 저장하는 Set
let currentCartNo = null;          // 현재 모달에 표시 중인 상품 번호

document.addEventListener("DOMContentLoaded", () => {
    const deliverySelect = document.getElementById('delivery-request');
    const deliveryMessage = document.getElementById("delivery-message");
    const charCount = document.getElementById("char-count");

    if (deliverySelect) {
        // 옵션 변경 시 이벤트 리스너 추가
        deliverySelect.addEventListener('change', function () {
            toggleMessageVisibility();
        });
    }

    if (deliverySelect && deliveryMessage && charCount) {
        // 글자 수 카운트 업데이트 이벤트 리스너 추가
        deliveryMessage.addEventListener('keyup', function () {
            charCount.textContent = deliveryMessage.value.length + "/50";
        });

        // 메시지 표시/숨김 함수
        function toggleMessageVisibility() {
            if (deliverySelect.value === '직접 입력') {
                deliveryMessage.style.display = "block";
                charCount.style.display = "block";
                deliveryMessage.value = "";
                charCount.innerText = "0/50";
            } else {
                deliveryMessage.style.display = "none";
                charCount.style.display = "none";
                charCount.style.display = "none";
            }
        }

        // 페이지 로드 시 초기 상태 설정
        toggleMessageVisibility();
    }

    // 구매 적립/선할인 초기 설정
    toggleRewardDisplay(document.querySelector('input[name="reward"]:checked'));
});

// 구매 적립/선할인 선택
function toggleRewardDisplay(selectedRadio) {
    // 모든 reward span 요소 숨김 처리
    document.getElementById('reward-earn').style.display = 'none';
    document.getElementById('reward-discount').style.display = 'none';

    // total-save-point 요소 가져오기
    const totalSavePointElement = document.getElementById('total-save-point');

    if (selectedRadio.value === 'earn') {
        // '구매 적립' 선택 시 reward-earn의 텍스트에서 숫자 부분만 추출 후 표시
        document.getElementById('reward-earn').style.display = 'inline';

        // reward-earn에서 숫자 및 "원"만 추출하여 total-save-point에 표시
        const rewardEarnText = document.getElementById('reward-earn').innerText;
        const amountOnly = rewardEarnText.match(/\d+[,]*\d*원/); // 숫자와 '원'만 추출
        totalSavePointElement.innerText = amountOnly ? amountOnly[0] : '';

        // total-save-point 표시
        totalSavePointElement.parentElement.style.display = 'flex';

        minusSalePoint();
    } else if (selectedRadio.value === 'discount') {
        // '적립금 선할인' 선택 시 total-save-point 영역 숨기기
        document.getElementById('reward-discount').style.display = 'inline';
        totalSavePointElement.parentElement.style.display = 'none';

        plusSalePoints();
    }

    calcTotalPaymentPrice();
}

// 텍스트 요소에서 숫자 값만 추출하는 유틸리티 함수
function getNumericValue(elementId) {
    const text = document.getElementById(elementId).innerText;
    return parseInt(text.replace(/[^0-9]/g, ''), 10) || 0;
}

// 적립일 때 적립금 할인 빼기
function minusSalePoint() {
    const addPoint = getNumericValue('reward-earn');
    const usedPoint = getNumericValue('used-point');

    const updatedPoint = Math.max(0, usedPoint - addPoint);
    document.getElementById('used-point').textContent = "- " + updatedPoint.toLocaleString() + "원";
}

// 선할인일 때 적립금 할인 더하기
function plusSalePoints() {
    const addPoint = getNumericValue('reward-discount');
    const usedPoint = getNumericValue('used-point');

    const updatedPoint = usedPoint + addPoint;
    document.getElementById('used-point').textContent = "- " + updatedPoint.toLocaleString() + "원";
}

// 쿠폰 사용 모달 열기
function onShowCouponModal(cartNo, prodNo) {
    currentCartNo = cartNo;  // cartNo를 currentCartNo에 저장

    $('#couponModal').on('shown.bs.modal', function () {
        const isVisible = $('#couponModal').is(':visible');

        if (isVisible) {
            selectCoupon(prodNo);  // 쿠폰 목록 가져오기 및 렌더링
        }
    });

    $('#couponModal').modal('show');
}

// 쿠폰 사용 모달 닫기
function onHideCouponModal() {
    $('#couponModal').modal('hide');
}

// 쿠폰 적용 버튼 클릭 시 호출
function onApplyCoupon() {
    const selectedCoupon = document.querySelector('.coupon-radio:checked');
    if (!selectedCoupon) {
        alert('적용할 쿠폰을 선택하세요.');
        return;
    }

    // 이전에 적용된 쿠폰이 있으면 제거
    if (appliedCoupons[currentCartNo]) {
        usedCoupons.delete(appliedCoupons[currentCartNo]);
    }

    // 새로운 쿠폰 저장
    const couponId = selectedCoupon.value;
    appliedCoupons[currentCartNo] = couponId;  // cartNo 기준으로 쿠폰 저장
    usedCoupons.add(couponId);

    // 쿠폰 할인 적용
    const selectedCouponData = coupons.find(coupon => coupon.coupon_id === couponId);
    if (selectedCouponData) {
        const salePer = parseFloat(selectedCouponData.sale_per);

        updateProductPriceWithDiscount(currentCartNo, salePer);
    }

    alert('쿠폰이 적용되었습니다.');
    $('#couponModal').modal('hide');
}

// 상품 가격 업데이트 함수
function updateProductPriceWithDiscount(productNo, salePer) {
    const productElement = document.querySelector(".product-info[data-cart-no='" + productNo + "']");
    const discountedPriceElement = productElement.querySelector('.discounted-price');

    if (!discountedPriceElement) {
        return;
    }

    // 원래 가격을 가져오거나 처음 적용 시 저장
    let originalPrice = productElement.getAttribute('data-original-price');
    if (!originalPrice) {
        const currentPriceText = discountedPriceElement.innerText.replace(/[^0-9]/g, '');
        originalPrice = parseFloat(currentPriceText);
        productElement.setAttribute('data-original-price', originalPrice);
    }

    // 할인 가격 계산
    const discountAmount = originalPrice * (salePer / 100);
    const discountedPrice = originalPrice - discountAmount;

    // 할인 가격 업데이트
    discountedPriceElement.innerText = new Intl.NumberFormat().format(Math.floor(discountedPrice)) + '원';

    calcTotalDiscountedPrice();
}

// 쿠폰 사용 취소 함수
function cancelCoupon() {
    if (appliedCoupons[currentCartNo]) {
        // 사용 중인 쿠폰 제거
        usedCoupons.delete(appliedCoupons[currentCartNo]);
        delete appliedCoupons[currentCartNo];

        // 상품 가격 원래 금액으로 복구
        resetProductPriceToOriginal(currentCartNo);

        alert('쿠폰이 취소되었습니다.');
        renderCouponList();  // 상태 갱신을 위해 다시 렌더링
    } else {
        alert('현재 상품에 적용된 쿠폰이 없습니다.');
    }
}

// 원래 가격으로 복구
function resetProductPriceToOriginal(cartNo) {
    const productElement = document.querySelector(".product-info[data-cart-no='" + cartNo + "']");
    const discountedPriceElement = productElement.querySelector('.discounted-price');
    const originalPrice = productElement.getAttribute('data-original-price');

    if (!discountedPriceElement || !originalPrice) {
        return;
    }

    // 원래 가격으로 업데이트
    discountedPriceElement.innerText = new Intl.NumberFormat().format(parseFloat(originalPrice)) + '원';

    calcTotalDiscountedPrice();
}

// 쿠폰 목록
function selectCoupon(productNo) {
    $.ajax({
        url: "Controller?type=order&action=coupon",
        method: 'POST',
        data: {
            prod_no: productNo
        },
        success: function (response) {
            if (response.success) {
                coupons = response.data;

                // 쿠폰 목록 렌더링
                renderCouponList();
            } else {
                alert("응답에 실패했습니다.");
            }
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 쿠폰 목록을 렌더링하는 함수
function renderCouponList() {
    const couponList = document.getElementById('coupon-list');
    couponList.innerHTML = '';

    if (coupons.length > 0) {
        let maxSalePer = 0;
        coupons.forEach(function (coupon) {
            maxSalePer = Math.max(maxSalePer, parseFloat(coupon.sale_per));
        });

        coupons.forEach(function (coupon) {
            const couponItem = document.createElement('div');
            couponItem.className = 'coupon-item';

            const radioInput = document.createElement('input');
            radioInput.type = 'radio';
            radioInput.id = 'coupon_' + coupon.coupon_id;
            radioInput.name = 'coupon';
            radioInput.className = 'coupon-radio';
            radioInput.value = coupon.coupon_id;

            // 적용된 쿠폰 상태 반영
            if (appliedCoupons[currentCartNo] === coupon.coupon_id) {
                radioInput.checked = true;  // 현재 상품에 적용된 쿠폰은 체크 상태로 표시
            } else if (usedCoupons.has(coupon.coupon_id)) {
                radioInput.disabled = true;  // 다른 상품에 적용된 쿠폰은 비활성화
            }

            couponItem.appendChild(radioInput);

            const label = document.createElement('label');
            label.setAttribute('for', 'coupon_' + coupon.coupon_id);
            label.className = 'coupon-label';

            const discountText = document.createElement('p');
            discountText.className = 'discount';
            discountText.innerText = coupon.sale_per + '% 할인';
            label.appendChild(discountText);

            const description = document.createElement('p');
            description.className = 'description';

            if (parseFloat(coupon.sale_per) === maxSalePer) {
                const highlight = document.createElement('span');
                highlight.className = 'highlight';
                highlight.innerText = '[최대 할인 쿠폰] ';
                description.appendChild(highlight);
            }

            const nameText = document.createTextNode(coupon.name);
            description.appendChild(nameText);
            label.appendChild(description);

            const expiryText = document.createElement('p');
            expiryText.className = 'expiry';
            expiryText.innerText = coupon.end_date + '까지';
            label.appendChild(expiryText);

            couponItem.appendChild(label);
            couponList.appendChild(couponItem);
        });
    }
}

// 주문 코드
function onGetOrderCode() {
    // 오늘 날짜 가져오기
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, '0');
    const date = String(today.getDate()).padStart(2, '0');

    // 랜덤 4자리 숫자 생성
    const randomFourDigits = Math.floor(1000 + Math.random() * 9000);

    // 날짜와 랜덤 숫자 결합
    const result = year + month + date + randomFourDigits;

    return result;
}

// 배송지 번호 가져오기
function onGetDeliveryId() {
    const headerElement = document.querySelector(".delivery-info-container .header");

    let dataValue = null;
    if (headerElement) {
        dataValue = headerElement.getAttribute("data-value");
    }

    return dataValue;
}

// 사용 적립금 금액 가져오기
function onGetUsedPoints() {
    const usedPoint = document.getElementById('point-input');
    let inputValue = usedPoint.value;

    inputValue = inputValue.replace(/[^0-9]/g, '');

    return inputValue;
}

// 결제 상품 가져오기
function onGetProducts() {
    const products = document.querySelectorAll('.product-info');
    const productData = {};

    // 각 상품 정보를 순회하며 JSON 객체에 추가
    products.forEach(product => {
        const cartNo = product.getAttribute('data-cart-no');
        const prodNo = product.getAttribute('data-prod-no');
        const inventoryNo = product.getAttribute('data-inventory-no');
        const discountedPriceElement = product.querySelector('.discounted-price');
        const productCountElement = product.querySelector('#product-count');

        // 가격 설정 (할인 가격이 없을 경우 원래 가격 사용)
        let price = 0;
        if (discountedPriceElement) {
            price = parseFloat(discountedPriceElement.innerText.replace(/[^0-9]/g, '')) || 0;
        } else {
            const originalPriceElement = product.querySelector('.original-price');
            if (originalPriceElement) {
                price = parseFloat(originalPriceElement.innerText.replace(/[^0-9]/g, '')) || 0;
            }
        }

        // 상품 수량 가져오기
        const count = productCountElement ? parseInt(productCountElement.innerText.replace(/[^0-9]/g, '')) || 0 : 0;

        // JSON 객체에 추가
        if (cartNo) {
            productData[cartNo] = {
                prodNo: prodNo,
                inventoryNo: inventoryNo,
                amount: price,
                count: count
            };
        }
    });

    return productData;
}

// 상품과 쿠폰 동일 상품 번호 병합
function mergeProducts() {
    const products = onGetProducts();
    const mergedProducts = {};

    for (const cartNo in products) {
        mergedProducts[cartNo] = {
            prod: {
                prodNo: products[cartNo].prodNo,
                inventoryNo: products[cartNo].inventoryNo,
                amount: products[cartNo].amount,
                count: products[cartNo].count
            }
        };

        // 쿠폰이 적용된 경우 병합
        if (appliedCoupons.hasOwnProperty(cartNo)) {
            mergedProducts[cartNo].coupon = appliedCoupons[cartNo];
        }
    }

    console.log('Merged Products:', JSON.stringify(mergedProducts, null, 2));

    return mergedProducts;
}

// 적립금 가져오기
function onGetSavePoint() {
    const totalSavePointElement = document.getElementById('total-save-point');

    // 요소가 보이는 경우 숫자 값 반환
    if (totalSavePointElement && totalSavePointElement.parentElement.style.display !== 'none') {
        const pointText = totalSavePointElement.innerText;
        return parseInt(pointText.replace(/[^0-9]/g, ''), 10) || 0;  // 숫자 추출 후 변환 실패 시 0 반환
    }

    // 요소가 숨겨져 있거나 값이 없을 경우 0 반환
    return 0;
}

// 결제 API
function onPayment() {
    // 선택된 결제 방식을 확인
    const tossPayRadio = document.getElementById("tosspay-radio");
    const kakaoPayRadio = document.getElementById("kakaopay-radio");

    const order_code = onGetOrderCode();
    const deli_no = onGetDeliveryId();
    const point_amount = onGetUsedPoints();
    const products = mergeProducts();
    const save_point = onGetSavePoint();

    console.log('Final Products for Payment:', products);

    const totalAmount = parseInt(document.getElementById("total_amount").innerText.replaceAll(',', '').replace('원', ''), 10);
    const taxFreeAmount = Math.floor(totalAmount * 0.1);

    if (tossPayRadio.checked) {
        // TossPayments 로직 실행
        const clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq';
        const tossPayments = TossPayments(clientKey);

        tossPayments
            .requestPayment('카드', {
                amount: totalAmount, // 결제 금액
                orderId: order_code, // 주문 ID
                orderName: prodName, // 주문명
                customerName: '김토스', // 구매자 이름
                successUrl: 'https://docs.tosspayments.com/guides/payment/test-success',
                failUrl: 'https://docs.tosspayments.com/guides/payment/test-fail',
            })
            .catch(function (error) {
                if (error.code === 'USER_CANCEL') {
                    alert('결제가 취소되었습니다.');
                } else if (error.code === 'INVALID_CARD_COMPANY') {
                    alert('유효하지 않은 카드입니다.');
                } else {
                    alert('결제 중 오류가 발생했습니다.');
                }
            });
    } else if (kakaoPayRadio.checked) {
        $.ajax({
            url: 'Controller?type=order&action=kakaopay',
            method: 'POST',
            data: {
                order_code: order_code,
                products: JSON.stringify(products),  // 문자열로 변환
                deli_no: deli_no,
                save_point: save_point,
                point_amount: point_amount,
                total_amount: totalAmount,
                tax_free_amount: taxFreeAmount,
            },
            dataType: "JSON",
            success: function (response) {
                if (response.success) {
                    if (response.data && response.data.next_redirect_pc_url) {
                        window.location.href = response.data.next_redirect_pc_url;
                    }
                } else {
                    alert('결제 중 오류가 발생했습니다. 관리자에게 문의해 주세요.');
                }
            },
            error: function (err) {
                alert('결제 중 오류가 발생했습니다.');
                console.error(err);
            }
        });
    } else {
        alert('결제 방식을 선택해 주세요.');
    }
}

// 주문 배송지 변경
function updateDeliveryAddr() {
    // 기존 배송지 ID
    const DeliveryID = document.querySelector(".deli-no").value;
    // 선택된 배송지 ID 가져오기
    const selectedDeliveryId = document.querySelector('input[name="deliveryAddress"]:checked').value;
    const orderCode = document.querySelector("#orderCode").value;

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
                $('#changeDeliveryModal').click();
                // 변경된 데이터를 DOM에 반영
                document.querySelector('.name').textContent = response.data.deli_name;
                document.querySelector('.phone').textContent = response.data.phone;
                document.querySelector('.address').textContent =
                    `${response.data.pos_code} ${response.data.addr1} ${response.data.addr2}`;
            } else {
                alert("배송지 수정 중 오류가 발생했습니다.");
            }
        },
        error: function() {
            alert("서버와의 통신 중 문제가 발생했습니다.");
        }
    });
}

// 적립금 입력
function formatCurrency() {
    const pointInput = document.getElementById('point-input');
    let inputValue = pointInput.value;

    inputValue = inputValue.replace(/[^0-9]/g, '');

    if (!inputValue) {
        pointInput.value = '';
        return;
    }

    const formattedValue = parseInt(inputValue, 10).toLocaleString();
    pointInput.value = formattedValue;
}

// 적립급 사용
function applyPoint() {
    const pointInputElement = document.getElementById('point-input');
    const maxPointsElement = document.getElementById('max-points');
    const savePointsElement = document.getElementById('save-points');
    const usedPointElement = document.getElementById('used-point');

    if (pointInputElement.value) {
        const maxPoints = parseInt(maxPointsElement.textContent.replace(/[^0-9]/g, ''), 10);
        const savePoints = parseInt(savePointsElement.textContent.replace(/[^0-9]/g, ''), 10);
        const inputValue = parseInt(pointInputElement.value.replaceAll(/[^0-9]/g, ""), 10);

        if (isNaN(inputValue) || (inputValue > maxPoints) || (inputValue > savePoints)) {
            pointInputElement.value = savePoints.toLocaleString();
            usedPointElement.textContent = "- " + savePoints.toLocaleString() + "원";
        } else {
            usedPointElement.textContent = "- " + savePoints.toLocaleString() + "원";
        }

        calcTotalPaymentPrice();
    } else {
        alert("사용할 적립금을 입력해 주세요.");
    }
}

// 사용 적립금 초기화
function resetPoint() {
    // 포인트 입력 초기화 및 표시 초기화
    document.getElementById('point-input').value = '';
    document.getElementById('used-point').textContent = '- 0원';

    calcTotalPaymentPrice();
}

// 모든 할인 전 금액 가져오기
function getTotalOriginalPrice() {
    const originalPriceElements = document.querySelectorAll(".original-price");
    const totalPrice = Array.from(originalPriceElements).reduce((sum, el) => {
        const price = parseFloat(el.innerText.replace(/[^0-9]/g, '')) || 0;
        return sum + price;
    }, 0);

    return totalPrice;
}

// 모든 할인 금액 가져오기
function getTotalDiscountedPrice() {
    const discountedPriceElements = document.querySelectorAll(".discounted-price");
    const totalDiscountedPrice = Array.from(discountedPriceElements).reduce((sum, el) => {
        const price = parseFloat(el.innerText.replace(/[^0-9]/g, '')) || 0;
        return sum + price;
    }, 0);

    return totalDiscountedPrice;
}

// 할인된 금액 계산
function calcTotalDiscountedPrice() {
    const originalPrice = getTotalOriginalPrice();
    const discountedPrice = getTotalDiscountedPrice();

    const calcDisPrice = parseInt(originalPrice, 10) - parseInt(discountedPrice, 10);
    document.getElementById("total-saled-amount").innerText = "- " + calcDisPrice.toLocaleString() + "원";

    calcTotalPaymentPrice();
}

// 결제 금액 계산
function calcTotalPaymentPrice() {
    const totalOriginalPrice = document.getElementById("total-ori-amount").innerText.replace('원', '').replace(/[^0-9]/g, '');
    const totalDiscountedPrice = document.getElementById("total-saled-amount").innerText.replace('원', '').replace(/[^0-9]/g, '');
    const totalUsedPoint = document.getElementById("used-point").innerText.replace('원', '').replace(/[^0-9]/g, '');

    const calcTotalPrice = parseInt(totalOriginalPrice, 10) - (parseInt(totalDiscountedPrice, 10) + parseInt(totalUsedPoint, 10));

    document.getElementById("total-payment-amount").innerText = calcTotalPrice.toLocaleString();
    document.getElementById("total_amount").innerText = calcTotalPrice.toLocaleString() + "원";
    document.getElementById("total-payment").innerText = calcTotalPrice.toLocaleString();
}