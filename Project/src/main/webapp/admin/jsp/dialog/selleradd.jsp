<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>판매자 추가 dialog</title>
</head>
<body>
<div class="container mt-5">
    <!-- 판매자 추가 버튼 -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#sellerModal">
        판매자 추가
    </button>

    <!-- 모달 HTML -->
    <div class="modal fade" id="sellerModal" tabindex="-1" aria-labelledby="sellerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="sellerModalLabel">판매자 설정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- 판매자 정보 입력 폼 -->
                    <div class="row mb-3">
                        <div class="col-md-2 fw-bold">판매자 id</div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" value="aaaa">
                        </div>
                        <div class="col-md-1 text-end fw-bold">판매자 pw</div>
                        <div class="col-md-1">
                            <input type="text" class="form-control" value="1111">
                        </div>
                        <div class="col-md-1 text-end fw-bold">이름</div>
                        <div class="col-md-1">
                            <input type="text" class="form-control" value="마루치">
                        </div>
                    </div>

                    <hr>

                    <div class="row mb-3">
                        <div class="col-md-2 fw-bold">연락처</div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" value="02-1234-5678">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-2 fw-bold">이메일</div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" value="email@example.com">
                        </div>
                    </div>

                    <hr>

                    <h5 class="card-title">승인 사유</h5>
                    <div class="row">
                        <div class="col-md-12">
                            <textarea class="form-control" rows="3">입점을 추가한 이유를 적어주세요.</textarea>
                            <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary">저장</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 뒤로가기 버튼 -->
    <div class="mt-3 mb-4">
        <button class="btn btn-outline-secondary" onclick="location.href='Controller?type=sellermain';">뒤로가기</button>
    </div>
</div>

<!-- Bootstrap JS, Popper.js, 그리고 Bootstrap Bundle JS 로딩 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
