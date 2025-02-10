function onExistCusId() {
    const cus_id = document.getElementById('cus_id').value;

    if (!cus_id) {
        alert("아이디를 입력하세요.");
        document.getElementById('cus_id').value = "";
        document.getElementById('cus_id').focus();
        return;
    }

    $.ajax({
        url: 'Controller?type=login&action=search_customer',
        type: 'POST',
        data: {
            cus_id: document.getElementById('cus_id').value,
        },
        success: function(response) {
            if (response.success) {
                if (!response.is_exists) {
                    alert("존재하지 않는 사용자입니다.");
                    document.getElementById('cus_id').value = "";
                    document.getElementById('cus_id').focus();
                } else {
                    document.getElementById('cus_id').value = "";
                    document.getElementById('cus_id').focus();

                    window.location.href = "Controller?type=login&action=reset";
                }
            }
        },
        error: function(error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}