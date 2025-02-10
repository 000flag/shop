function insertQuestion(){
    const question_type = document.getElementById("question-type").value;
    const question_title = document.getElementById("question-title").value;
    const question_check = document.getElementById("question-private-check").checked ? "1" : "0";
    const question_content = document.getElementById("question-content").value;
    // const question_image = document.getElementById("question_image").value;

    if (question_type === "0") {
        alert("문의 유형을 선택하세요.");
        return;
    }
    if (!question_title) {
        alert("문의 제목을 입력하세요.");
        return;
    }
    if (!question_content) {
        alert("문의 내용을 입력하세요.");
        return;
    }

    $.ajax({
        url: "Controller?type=question&action=insert",
        type: "POST",
        data: {
            prod_no: document.getElementById("prod_no").value,
            question_type: question_type,
            question_title: question_title,
            question_check: question_check,
            question_content: question_content
        },
        success: function (response) {
            alert("상품 문의가 성공적으로 등록되었습니다.");
            window.location.href = 'Controller?type=productDetails&action=select&prod_no=' + document.getElementById("prod_no").value
        },
        error: function (status, error) {
            alert("상품 문의 등록 중 오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}

function openFileExplorer() {
    document.getElementById("question-image").click();
}