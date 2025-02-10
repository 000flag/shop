document.addEventListener("DOMContentLoaded", function () {
    // 카테고리
    const categoryTabs = document.querySelectorAll(".review-categories li");
    const reviewLists = document.querySelectorAll(".review-list");

    categoryTabs.forEach((tab) => {
        tab.addEventListener("click", function () {
            categoryTabs.forEach((tab) => tab.classList.remove("active"));
            reviewLists.forEach((list) => list.classList.remove("active"));

            this.classList.add("active");
            const target = this.getAttribute("data-target");
            document.getElementById(target).classList.add("active");
        });
    });
    
    // 수량 변경
    const cartCountElements = document.querySelectorAll(".cart-count");
    cartCountElements.forEach(function (cartCountElement) {
        // - 버튼, + 버튼, 카운트 값 span 선택
        const minusButton = cartCountElement.querySelector(".btn-minus");
        const plusButton = cartCountElement.querySelector(".btn-plus");
        const spanElement = cartCountElement.querySelector(".cart-count-value");

        // - 버튼 클릭 이벤트
        minusButton.addEventListener("click", function () {
            let count = parseInt(spanElement.textContent, 10);
            if (count > 0) {
                count -= 1;
                spanElement.textContent = count;
            }
        });

        // + 버튼 클릭 이벤트
        plusButton.addEventListener("click", function () {
            let count = parseInt(spanElement.textContent, 10);
            count += 1;
            spanElement.textContent = count;
        });
    });
});

// 리뷰 입력(키, 몸무게)
function onCheckInput() {
    const heightInputElement = document.getElementById("height-input");
    const weightInputElement = document.getElementById("weight-input");

    // 숫자만 허용 (특수문자와 음수 제거)
    heightInputElement.value = heightInputElement.value.replace(/[^0-9]/g, "");
    weightInputElement.value = weightInputElement.value.replace(/[^0-9]/g, "");
}

// 문의 탭 클릭 함수
document.addEventListener("DOMContentLoaded", function () {
    // 모든 탭 버튼과 탭 패널을 선택
    const tabs = document.querySelectorAll(".tab-btn");
    const panels = document.querySelectorAll(".tab-panel");

    // 탭 클릭 이벤트 처리 함수
    function handleTabClick(event) {
        // 모든 탭 버튼과 패널의 active 클래스 제거
        tabs.forEach((btn) => btn.classList.remove("active"));
        panels.forEach((panel) => panel.classList.remove("active"));

        // 현재 클릭한 탭 버튼에 active 클래스 추가
        const clickedTab = event.target;
        clickedTab.classList.add("active");

        // 클릭한 탭의 target 속성 가져오기
        const target = clickedTab.getAttribute("data-target");

        if (target === "review") {
            selectReview();
        } else if (target === "question") {
            selectQuestion();
        }

        document.getElementById(target).classList.add("active");
    }

    // 각 탭 버튼에 클릭 이벤트 추가
    tabs.forEach((tab) => {
        tab.addEventListener("click", handleTabClick);
    });
});

// 장바구니 추가
function insertCart() {
    const prod_no = document.getElementById("prod_id").dataset.item;
    const sizeSelect = document.getElementById("cart-select-size");
    const selectedOption = sizeSelect.options[sizeSelect.selectedIndex];  // 선택된 옵션 가져오기
    const inventory_no = selectedOption.getAttribute("data-value");  // data-value 값 가져오기
    const cartCountValue = document.getElementById("count-value");
    const count = parseInt(cartCountValue.textContent, 10);

    if (size == "0") {
        alert("사이즈를 선택하세요.");
        return;
    }
    
    if (count == 0) {
        alert("수량을 선택하세요.");
        return;
    }

    $.ajax({
        url: "Controller?type=cart&action=insert",
        method: 'POST',
        data: {
            prod_no: prod_no,
            inventory_no: inventory_no,
            count: count
        },
        success: function () {
            if (confirm("장바구니에 상품이 담겼습니다. 장바구니로 이동하시겠습니까?")) {
                window.location.replace("Controller?type=cart");
            }
        }
    });
}

// 구매하기 버튼 클릭 시
function onMovePayment() {
    const prod_no = document.getElementById("prod_id").dataset.item;
    const sizeSelect = document.getElementById("cart-select-size");
    const selectedOption = sizeSelect.options[sizeSelect.selectedIndex];  // 선택된 옵션 가져오기
    const inventory_no = selectedOption.getAttribute("data-value");  // data-value 값 가져오기
    const cartCountValue = document.getElementById("count-value");
    const count = parseInt(cartCountValue.textContent, 10);

    if (size == "0") {
        alert("사이즈를 선택하세요.");
        return;
    }

    if (count == 0) {
        alert("수량을 선택하세요.");
        return;
    }

    window.location.replace("Controller?type=order&action=payment&prod_no=" + prod_no + "&inventory_no=" + inventory_no + "&count=" + count);
}

// 좋아요 아이콘 클릭 시
function toggleProdDetailsHeart(obj, value) {
    // 아이콘이 비어 있는 하트인지 확인
    if (obj.classList.contains('bi-heart')) {
        // 좋아요 처리 로직 호출
        settingLike(obj, value, true);

        // 하트 채우기로 변경 및 애니메이션 추가
        obj.classList.remove('bi-heart');
        obj.classList.add('bi-heart-fill', 'heart-animation', 'heart-active');
    } else {
        // 좋아요 취소 처리 로직 호출
        settingLike(obj, value, false);

        // 다시 비어 있는 하트로 변경 및 애니메이션 추가
        obj.classList.remove('bi-heart-fill', 'heart-active');
        obj.classList.add('bi-heart', 'heart-animation');
    }

    // 애니메이션이 끝나면 클래스 제거
    obj.addEventListener('animationend', function () {
        obj.classList.remove('heart-animation');
    }, { once: true });
}

// 좋아요 설정/해제
function settingLike(obj, value, isLiked) {
    $.ajax({
        url: isLiked ? "Controller?type=productDetails&action=like" : "Controller?type=productDetails&action=unlike",
        method: "POST",
        data: {
            prod_no: value
        },
        success: function (response) {
            if (isLiked) {
                obj.classList.remove("bi-heart");
                obj.classList.add("bi-heart-fill");

                document.getElementById("prod_like_count").textContent++;
            } else {
                obj.classList.remove("bi-heart-fill");
                obj.classList.add("bi-heart");

                document.getElementById("prod_like_count").textContent--;
            }
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 리뷰 조회
function selectReview() {
    const gender = document.getElementById('gender-select').value;
    const height = document.getElementById('height-input').value;
    const weight = document.getElementById('weight-input').value;

    const data = {
        prod_no: document.getElementById("prod_id").dataset.item,
        gender: gender,
        height: height,
        weight: weight
    };

    $.ajax({
        url: 'Controller?type=productDetails&action=review',
        method: 'POST',
        data: data,
        success: function (response) {
            $("#review").html(response);

            document.getElementById("gender-select").value = gender;
            document.getElementById("height-input").value = height;
            document.getElementById("weight-input").value = weight;
        },
        error: function (error) {
            alert("리뷰 데이터를 가져오는 중 오류가 발생했습니다.");
        }
    });
}

// 문의 조회
function selectQuestion() {
    $.ajax({
        url: "Controller?type=productDetails&action=question",
        type: "POST",
        data: {
            prod_no: document.getElementById("prod_id").dataset.item,
        },
        success: function (response) {
            $("#question").html(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("문의 데이터를 가져오는 중 오류가 발생했습니다.");
        }
    });
}

// 판매자에게 문의하기
function onMoveQuestionPage() {
    window.location.href = "Controller?type=question&action=write&prod_no=" + document.getElementById("prod_id").dataset.item;
}