function onResetCusId() {
    // 비밀번호와 비밀번호 확인 값 가져오기
    const password = document.getElementById('cus_pw').value.trim();
    const passwordConfirm = document.getElementById('cus_pw_confirm').value.trim();

    // 빈 값 확인
    if (!password) {
        alert('비밀번호를 입력하세요.');
        document.getElementById('cus_pw').focus();
        return;
    }

    if (!passwordConfirm) {
        alert('비밀번호 확인을 입력하세요.');
        document.getElementById('cus_pw_confirm').focus();
        return;
    }

    // 비밀번호와 확인 값 일치 여부 검사
    if (password !== passwordConfirm) {
        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        document.getElementById('cus_pw_confirm').focus();
        return;
    }

    $.ajax({
        url: 'Controller?type=login&action=update_customer',
        type: 'POST',
        data: {
            cus_pw: password,
        },
        success: function(response) {
            if (response.success) {
                alert("비밀번호가 변경되었습니다.");

                document.getElementById('cus_pw').value = "";
                document.getElementById('cus_pw_confirm').value = "";

                window.location.replace("Controller");
            }
        },
        error: function(error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}