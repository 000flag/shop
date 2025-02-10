// 아이디 중복 확인
function onCheckCusId() {
    const cus_id = document.getElementById("cus_id").value;

    if (!cus_id) {
        alert("아이디를 입력하세요");
        document.getElementById("cus_id").value = "";
        document.getElementById("cus_id").focus();
        return;
    }

    $.ajax({
        url: 'Controller?type=signup&action=select_exists',
        type: 'POST',
        data: {
            cus_id: cus_id,
        },
        success: function(response) {
            if (response.success) {
                if (response.response) {
                    alert("이미 존재하는 아이디입니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                }
            }
        },
        error: function() {
            alert("서버와의 통신 중 문제가 발생했습니다.");
        }
    });
}

// 이메일 유효성 검사
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// 전화번호 유효성 검사
function isValidPhone(phone) {
    const phoneRegex = /^(\d{2,3}-)?\d{3,4}-\d{4}$/;  // 전화번호 형식: "010-1234-5678", "02-123-4567" 등
    return phoneRegex.test(phone);
}

// 유효성 검사 함수
function validateFields() {
    const fields = [
        { id: 'cus_id', message: '아이디를 입력하세요.' },
        { id: 'cus_pw', message: '비밀번호를 입력하세요.' },
        { id: 'cus_name', message: '이름을 입력하세요.' },
        { id: 'cus_nickname', message: '닉네임을 입력하세요.' },
        { id: 'cus_birth', message: '생년월일을 입력하세요.' },
        { id: 'cus_phone', message: '전화번호를 입력하세요.' },
        { id: 'cus_email', message: '이메일을 입력하세요.' },
        { id: 'pos_code', message: '우편번호를 입력하세요.' },
        { id: 'addr1', message: '주소를 입력하세요.' },
    ];

    for (const field of fields) {
        const value = document.getElementById(field.id).value.trim();
        if (!value) {
            alert(field.message);
            document.getElementById(field.id).focus();
            return false;
        }

        if (field.id === 'cus_pw') {
            // 비밀번호 길이 체크
            if (value.length < 8) {
                alert('비밀번호는 8자 이상이어야 합니다.');
                document.getElementById(field.id).focus();
                return false;
            }

            // 비밀번호 유효성 체크: 대소문자, 숫자, 특수문자 포함
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/;
            if (!passwordRegex.test(value)) {
                alert('비밀번호는 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.');
                document.getElementById(field.id).focus();
                return false;
            }

            // 비밀번호 연속된 문자/숫자 체크
            const sequentialRegex = /(.)\1{2,}/;
            if (sequentialRegex.test(value)) {
                alert('비밀번호에 연속된 동일한 문자 또는 숫자를 사용할 수 없습니다.');
                document.getElementById(field.id).focus();
                return false;
            }
        }
    }

    const genderElement = document.querySelector('input[name="cus_gender"]:checked');
    if (!genderElement) {
        alert('성별을 선택하세요.');
        return false;
    }

    if (!isValidEmail(document.getElementById('cus_email').value)) {
        alert('유효한 이메일 주소를 입력하세요.');
        document.getElementById('cus_email').focus();
        return false;
    }

    if (!isValidPhone(document.getElementById('cus_phone').value)) {
        alert('유효한 전화번호를 입력하세요.');
        document.getElementById('cus_phone').focus();
        return false;
    }

    return true;
}

// 회원 가입
function insertCustomer() {
    if (!validateFields()) return;

    const genderElement = document.querySelector('input[name="cus_gender"]:checked');

    $.ajax({
        url: 'Controller?type=signup&action=insert',
        type: 'POST',
        data: {
            cus_id: document.getElementById('cus_id').value,
            cus_pw: document.getElementById('cus_pw').value,
            cus_name: document.getElementById('cus_name').value,
            cus_nickname: document.getElementById('cus_nickname').value,
            cus_gender: genderElement.value,
            cus_birth: document.getElementById('cus_birth').value,
            cus_phone: document.getElementById('cus_phone').value,
            cus_email: document.getElementById('cus_email').value,
            pos_code: document.getElementById('pos_code').value,
            addr1: document.getElementById('addr1').value,
            addr2: document.getElementById('addr2').value,
            height: document.getElementById('height').value || null,
            weight: document.getElementById('weight').value || null,
        },
        success: function(response) {
            if (response.success) {
                if (response.is_exists) {
                    alert("이미 존재하는 아이디입니다.");
                } else {
                    if (response.is_join) {
                        alert("회원 가입이 완료되었습니다.");
                        window.location.href = "Controller";
                    } else {
                        alert("회원 가입에 실패했습니다. 다시 시도해 주세요.");
                    }
                }
            }
        },
        error: function(error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 우편 번호 검색
function onGetPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            let addr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }

            document.getElementById('pos_code').value = data.zonecode;
            document.getElementById("addr1").value = addr;
            document.getElementById("addr2").focus();
        }
    }).open();
}