document.addEventListener('DOMContentLoaded', function() {
    const tabButtons = document.querySelectorAll('.tab-button');
    const selectElements = document.querySelectorAll('.inquiry-select');
    const orderInputGroup = document.querySelector('.inquiry-order');

    // 각 버튼 클릭 시 동작
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            tabButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');

            selectElements.forEach(select => {
                select.style.display = 'none';
            });

            document.getElementById("inquiry-order").style.display = 'none';
            document.getElementById("inquiry-order-code").value = "";

            // 클릭된 버튼의 data-target 속성 값에 해당하는 select만 보이기
            const target = this.getAttribute('data-target');
            const targetSelect = document.getElementById('inquiry-select-' + target);
            if (targetSelect) {
                targetSelect.style.display = 'inline-block';
            }
        });
    });

    // 페이지 로드 시 첫 번째 버튼을 클릭한 상태로 설정
    tabButtons[0].click();

    // 각 select 요소 변경 시
    selectElements.forEach(select => {
        select.addEventListener('change', function() {
            const selectedValues = Array.from(selectElements).map(select => select.value);

            // 조건에 맞는 값들만 확인하고, 그에 따라 input-group의 표시 여부 설정
            const requiredValues = ['1', '2', '3', '6', '7', '8', '9', '14', '15'];

            if (selectedValues.some(value => requiredValues.includes(value))) {
                orderInputGroup.style.display = 'flex';
            } else {
                orderInputGroup.style.display = 'none';
            }
        });
    });

    // 주문번호 조회 모달의 모든 기간 버튼
    const filterButtons = document.querySelectorAll('.filter-button');
    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            // 클릭한 버튼에만 'active' 클래스 추가
            button.classList.add('active');
        });
    });

    // 주문번호 조회 모달 모든 inquiry-selected-btn
    const selectButtons = document.querySelectorAll(".inquiry-selected-btn");
    const inquiryOrderCodeInput = document.getElementById("inquiry-order-code");
    selectButtons.forEach((button) => {
        button.addEventListener("click", () => {
            // 버튼의 부모인 order-item에서 order-no 값을 가져오기
            const orderNo = button.parentElement.querySelector(".order-no").textContent.split("No. ")[1].trim();
            // input 필드에 order-no 값 설정
            inquiryOrderCodeInput.value = orderNo;

            // 모달 닫기
            $("#inquiryOrderModal .close").click();
        });
    });

    // 사진 서버로 전송
    document.getElementById("photo-input").addEventListener("change", function () {
        const files = this.files;

        if (files.length > 0) {
            const formData = new FormData(); // FormData 객체 생성

            // 선택된 파일 추가
            Array.from(files).forEach((file) => {
                formData.append("additional", file);
            });

            $.ajax({
                url: "Controller?type=board&action=saveimg",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    alert("파일 업로드 성공!");
                },
                error: function (xhr, status, error) {
                    console.error("업로드 실패:", error);
                    alert("파일 업로드 중 문제가 발생했습니다.");
                },
            });
        }
    });
});

async function onSendInquiry() {
    // 모든 select 요소를 가져오기
    const inquirySelects = document.querySelectorAll('.inquiry-select');
    let selectedValue = '';

    // 보이는 select 요소의 값을 가져오기
    inquirySelects.forEach((select) => {
        const isVisible = window.getComputedStyle(select).display !== 'none'; // 보이는지 확인
        if (isVisible) {
            selectedValue = select.value;
        }
    });

    const orderCode = document.getElementById("inquiry-order-code").value;
    const content = document.getElementById("content").value;

    await $.ajax({
        url: 'Controller?type=board&action=insert',
        method: 'POST',
        data: {
            inquiryType: selectedValue,
            orderCode: orderCode,
            content: content,
            // fileUrls: fileURLs.join(','), // 파일 URL을 쉼표로 구분하여 전송
        },
        success: function () {
            alert('문의가 등록되었습니다.');

            window.location.href = 'Controller?type=myPage';
        },
        error: function () {
            alert("문의 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
        },
    });
}
