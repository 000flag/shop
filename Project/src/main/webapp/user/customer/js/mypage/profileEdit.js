// 구매자 정보 조회
function selectCustomer() {
    $.ajax({
        url: "Controller?type=myPage&action=select_customer",
        method: "POST",
        success: function (response) {
            $("#profile-acticle").html(response);
        },
        error: function (err) {
            alert("정보 수정 중 오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}

// 구매자 정보 수정
function updateCustomer() {
    const email =  $("#email").val();
    const phone =  $("#phone").val();

    const regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
    if(!regEmail.test(email)) {
        alert('이메일을 확인하세요.');
        $("#email").val("");
        $("#email").focus();
        return;
    }

    const regPhone = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    if(!regPhone.test(phone)) {
        alert('핸드폰 번호를 확인하세요.');
        $("#phone").val("");
        $("#phone").focus();
        return;
    }

    $.ajax({
        url: "Controller?type=myPage&action=update_customer",
        method: "POST",
        data: {
            email: email,
            phone: phone
        },
        success: function (response) {
            alert("수정하였습니다.");

            // 모달 닫기
            $(".modal-header .close").click();

            // 회원 정보 조회
            selectCustomer();
        },
        error: function (err) {
            alert("정보 수정 중 오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}

// 비밀번호 수정
function updatePassword() {
    const currentPw = document.getElementById('current_pw').value.trim();
    const changePw = document.getElementById('change_pw').value.trim();
    const confirmPw = document.getElementById('confirm_pw').value.trim();

    // 변경 비밀번호 유효성 체크
    if (changePw.length < 8) {
        alert('변경 비밀번호는 8자 이상이어야 합니다.');
        document.getElementById('change_pw').focus();
        return false;
    }

    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{};':"\\|,.<>\/\?]).{8,}$/;
    if (!passwordRegex.test(changePw)) {
        alert('변경 비밀번호는 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.');
        document.getElementById('change_pw').focus();
        return false;
    }

    const sequentialRegex = /(.)\1{2,}/;
    if (sequentialRegex.test(changePw)) {
        alert('변경 비밀번호에 연속된 동일한 문자 또는 숫자를 사용할 수 없습니다.');
        document.getElementById('change_pw').focus();
        return false;
    }

    if (changePw !== confirmPw) {
        alert('변경 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
        document.getElementById('confirm_pw').focus();
        return false;
    }

    // 현재 비밀번호 확인
    $.ajax({
        url: 'Controller?type=myPage&action=confirm',
        type: 'POST',
        data: {
            cus_pw: currentPw
        },
        success: function (response) {
            if (!response.data.valid) {
                alert('현재 비밀번호가 일치하지 않습니다.');
                document.getElementById('current_pw').focus();
                return false;
            }

            // 비밀번호 변경
            $.ajax({
                url: 'Controller?type=myPage&action=update_password',
                type: 'POST',
                data: {
                    change_pw: changePw
                },
                success: function (data) {
                    if (data.success) {
                        alert('비밀번호가 성공적으로 변경되었습니다. 다시 로그인해 주세요.');
                        window.location.replace("Controller?type=logout");
                    } else {
                        alert('비밀번호 변경에 실패했습니다. 다시 시도해 주세요.');
                    }
                },
                error: function () {
                    alert('비밀번호 변경 중 오류가 발생했습니다.');
                }
            });
        },
        error: function () {
            alert('현재 비밀번호 확인 중 오류가 발생했습니다.');
        }
    });
}

// 회원 탈퇴
function retiredCustomer() {
    $.ajax({
        url: 'Controller?type=myPage&action=retired_customer',
        type: 'POST',
        success: function (response) {
            if (response.success) {
                alert("회원 탈퇴가 되었습니다. 그동안 이용해주셔서 감사합니다.");
                window.location.replace('Controller');
            } else {
                alert("회원 탈퇴 중 오류가 발생했습니다. 다시 시도해 주세요.");
            }
        },
        error: function (xhr) {
            console.error("프로필 변경 중 서버 오류 발생:", xhr.responseText);
            alert("서버 오류 발생: " + xhr.responseText);
        }
    });
}
