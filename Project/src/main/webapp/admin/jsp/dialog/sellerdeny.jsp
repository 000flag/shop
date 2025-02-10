<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>판매자 거절 dialog</title>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-body">

            <h5 class="card-title">거절 사유</h5>
            <div class="row">
                <div class="col-md-12">
                    <textarea class="form-control" rows="3">입점을 추가한 이유를 적어주세요.</textarea>
                    <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-3 mb-4">
        <button class="btn btn-outline-secondary" onclick="location.href='Controller?type=sellermain';">뒤로가기</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>