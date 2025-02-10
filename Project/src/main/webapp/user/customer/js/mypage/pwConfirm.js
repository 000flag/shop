document.addEventListener("DOMContentLoaded", function () {
    // 초기화
    document.getElementById("cus_pw").value = "";
    document.getElementById("btn-confirm").disabled = true;

    // 비밀번호 입력 값 8자 이상 체크
    document.getElementById("cus_pw").addEventListener("keyup", function () {
        const passwordInput = this;
        const errorMessage = document.getElementById("errorMessage");
        const confirmButton = document.getElementById("btn-confirm");

        if (passwordInput.value.length < 8) {
            passwordInput.classList.add("invalid");
            errorMessage.classList.add("visible");
            confirmButton.disabled = true;
        } else {
            passwordInput.classList.remove("invalid");
            errorMessage.classList.remove("visible");
            confirmButton.disabled = false;
        }
    });

    document.getElementById("cus_pw").addEventListener("keydown", function (e) {
        if (e.key === 'Enter') {
            onCustomerConfirm();
        }
    });
});

function onCustomerConfirm() {
    const cus_pw =  document.getElementById("cus_pw").value;

    if (cus_pw.length < 4) {
        return;
    }

    $.ajax({
        url: "Controller?type=myPage&action=confirm",
        method: "POST",
        data: {
            cus_pw: cus_pw
        },
        success: function (response) {
            if (response.data.valid) {
                window.location.href = "Controller?type=myPage&action=edit";
            } else {
                alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
            }
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}