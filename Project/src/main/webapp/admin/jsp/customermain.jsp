<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>쇼핑몰 관리자 대시보드</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- 추가 CSS (테이블 디자인 등) -->
    <style>
        /* 사이드바와 페이지 레이아웃 */
        #wrapper {
            display: flex;
            width: 100%;
            height: 100vh;
            overflow: hidden;
        }
        #sidebar-wrapper {
            min-width: 250px;
            max-width: 250px;
            background: #f8f9fa;
            border-right: 1px solid #dee2e6;
        }
        #sidebar-wrapper .sidebar-heading {
            padding: 1rem 1.5rem;
            font-size: 1.25rem;
            background: #e9ecef;
        }
        #sidebar-wrapper .list-group-item {
            border: none;
            padding: 0.75rem 1.5rem;
            cursor: pointer;
        }
        #sidebar-wrapper .list-group-item:hover {
            background: #e2e6ea;
        }
        #page-content-wrapper {
            flex: 1;
            overflow-y: auto;
        }
        /* 페이지 상단 요약 카드 영역 */
        .summary-card {
            min-height: 120px;
        }
        /* jsp include 된 테이블 CSS (있다면) */
        <jsp:include page="css/table.css"></jsp:include>
    </style>
</head>
<body>
<!-- 상단 Header (공통 헤더 포함) -->
<jsp:include page="layout/header.jsp"></jsp:include>

<div id="wrapper">
    <!-- 사이드바 -->
    <div id="sidebar-wrapper">
        <div class="sidebar-heading">쇼핑몰 관리자</div>
        <div class="list-group list-group-flush">
            <a href="#dashboard" class="list-group-item list-group-item-action">대시보드</a>
            <a href="#active" class="list-group-item list-group-item-action">구매자 목록</a>
            <a href="#withdrawn" class="list-group-item list-group-item-action">탈퇴 목록</a>
            <a href="#stopped" class="list-group-item list-group-item-action">정지 목록</a>
        </div>
    </div>

    <!-- 페이지 콘텐츠 -->
    <div id="page-content-wrapper">
        <div class="container-fluid p-4">
            <!-- 대시보드 타이틀 -->
            <h1 class="mb-4" id="dashboard">대시보드</h1>

            <!-- 요약 카드 (예시로 서버에서 전달받은 변수 사용) -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-white bg-primary summary-card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">구매자 수</h5>
                            <p class="card-text display-6">
                                <c:out value="${activeCount}" default="0"/>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-success summary-card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">탈퇴 수</h5>
                            <p class="card-text display-6">
                                <c:out value="${withdrawnCount}" default="0"/>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-danger summary-card mb-3">
                        <div class="card-body">
                            <h5 class="card-title">정지 수</h5>
                            <p class="card-text display-6">
                                <c:out value="${stoppedCount}" default="0"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- [1] 구매자 목록 (is_del == 0) 섹션 -->
            <section id="active" class="mb-5">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">구매자 목록 (is_del == 0)</h5>
                    </div>
                    <div class="card-body">
                        <!-- 검색바 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <select class="form-select" id="customer_name0">
                                <option value="grade_name">등급이름</option>
                                <option value="cus_id">사용자 id</option>
                                <option value="name">이름</option>
                                <option value="nickname">닉네임</option>
                                <option value="gender">성별</option>
                                <option value="birth_date">생일</option>
                                <option value="phone">전화번호</option>
                                <option value="email">이메일</option>
                                <option value="weight">무게</option>
                                <option value="height">키</option>
                                <option value="total">전체</option>
                                <option value="grade_expire_date">등급만기일자</option>
                            </select>
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="customer_word0">
                            <button class="btn btn-outline-secondary" type="button" id="customer_search_btn0">검색</button>
                        </div>
                        <!-- 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-striped" id="customer_table0">
                                <thead class="table-light">
                                <tr>
                                    <c:forEach var="name" items="${customerName}">
                                        <c:if test="${name ne 'id' && name ne 'cus_pw' && name ne 'profile_image' && name ne 'is_del' && name ne 'Introduce'}">
                                            <th class="column-name">${name}</th>
                                        </c:if>
                                    </c:forEach>
                                    <th>액션</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cus0l" items="${customerList}">
                                    <c:if test="${cus0l.is_del eq 0}">
                                        <tr id="row-${cus0l.id}">
                                            <td>${cus0l.grade_name}</td>
                                            <td>${cus0l.cus_id}</td>
                                            <td>${cus0l.name}</td>
                                            <td>${cus0l.nickname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cus0l.gender == 1}">남자</c:when>
                                                    <c:when test="${cus0l.gender == 2}">여자</c:when>
                                                    <c:otherwise>알 수 없음</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${cus0l.birth_date}</td>
                                            <td>${cus0l.phone}</td>
                                            <td>${cus0l.email}</td>
                                            <td>${cus0l.weight}</td>
                                            <td>${cus0l.height}</td>
                                            <td>${cus0l.total}</td>
                                            <td>${cus0l.grade_expire_date}</td>
                                            <td>
                                                <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#stopCustomerModal"
                                                        onclick="setCustomerId('${cus0l.id}')">정지</button>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- 초기화 버튼 (필요시) -->
                        <button class="btn btn-outline-secondary">초기화</button>
                    </div>
                </div>
            </section>

            <!-- [2] 탈퇴 목록 (is_del == 1) 섹션 -->
            <section id="withdrawn" class="mb-5">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">탈퇴 목록 (is_del == 1)</h5>
                    </div>
                    <div class="card-body">
                        <!-- 검색바 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <select class="form-select" id="customer_name1">
                                <option value="grade_name">등급이름</option>
                                <option value="cus_id">사용자 id</option>
                                <option value="name">이름</option>
                                <option value="nickname">닉네임</option>
                                <option value="gender">성별</option>
                                <option value="birth_date">생일</option>
                                <option value="phone">전화번호</option>
                                <option value="email">이메일</option>
                                <option value="weight">무게</option>
                                <option value="height">키</option>
                                <option value="total">전체</option>
                                <option value="grade_expire_date">등급만기일자</option>
                            </select>
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="customer_word1">
                            <button class="btn btn-outline-secondary" type="button" id="customer_search_btn1">검색</button>
                        </div>
                        <!-- 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-striped" id="customer_table1">
                                <thead class="table-light">
                                <tr>
                                    <c:forEach var="name" items="${customerName}">
                                        <c:if test="${name ne 'id' && name ne 'cus_pw' && name ne 'profile_image' && name ne 'is_del' && name ne 'Introduce'}">
                                            <th class="column-name">${name}</th>
                                        </c:if>
                                    </c:forEach>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cus1l" items="${customerList}">
                                    <c:if test="${cus1l.is_del eq 1}">
                                        <tr>
                                            <td>${cus1l.grade_name}</td>
                                            <td>${cus1l.cus_id}</td>
                                            <td>${cus1l.name}</td>
                                            <td>${cus1l.nickname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cus1l.gender == 1}">남자</c:when>
                                                    <c:when test="${cus1l.gender == 2}">여자</c:when>
                                                    <c:otherwise>알 수 없음</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${cus1l.birth_date}</td>
                                            <td>${cus1l.phone}</td>
                                            <td>${cus1l.email}</td>
                                            <td>${cus1l.weight}</td>
                                            <td>${cus1l.height}</td>
                                            <td>${cus1l.total}</td>
                                            <td>${cus1l.grade_expire_date}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <button class="btn btn-outline-secondary">초기화</button>
                    </div>
                </div>
            </section>

            <!-- [3] 정지 목록 (is_del == 2) 섹션 -->
            <section id="stopped" class="mb-5">
                <div class="card">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">정지 목록 (is_del == 2)</h5>
                    </div>
                    <div class="card-body">
                        <!-- 검색바 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <select class="form-select" id="customer_name2">
                                <option value="grade_name">등급이름</option>
                                <option value="cus_id">사용자 id</option>
                                <option value="name">이름</option>
                                <option value="nickname">닉네임</option>
                                <option value="gender">성별</option>
                                <option value="birth_date">생일</option>
                                <option value="phone">전화번호</option>
                                <option value="email">이메일</option>
                                <option value="weight">무게</option>
                                <option value="height">키</option>
                                <option value="total">전체</option>
                                <option value="grade_expire_date">등급만기일자</option>
                            </select>
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요" id="customer_word2">
                            <button class="btn btn-outline-secondary" type="button" id="customer_search_btn2">검색</button>
                        </div>
                        <!-- 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-striped" id="customer_table2">
                                <thead class="table-light">
                                <tr>
                                    <c:forEach var="name" items="${customerName}">
                                        <c:if test="${name ne 'id' && name ne 'cus_pw' && name ne 'profile_image' && name ne 'is_del' && name ne 'Introduce'}">
                                            <th class="column-name">${name}</th>
                                        </c:if>
                                    </c:forEach>
                                    <th>액션</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cus2l" items="${customerList}">
                                    <c:if test="${cus2l.is_del eq 2}">
                                        <tr id="row-${cus2l.id}">
                                            <td>${cus2l.grade_name}</td>
                                            <td>${cus2l.cus_id}</td>
                                            <td>${cus2l.name}</td>
                                            <td>${cus2l.nickname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cus2l.gender == 1}">남자</c:when>
                                                    <c:when test="${cus2l.gender == 2}">여자</c:when>
                                                    <c:otherwise>알 수 없음</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${cus2l.birth_date}</td>
                                            <td>${cus2l.phone}</td>
                                            <td>${cus2l.email}</td>
                                            <td>${cus2l.weight}</td>
                                            <td>${cus2l.height}</td>
                                            <td>${cus2l.total}</td>
                                            <td>${cus2l.grade_expire_date}</td>
                                            <td>
                                                <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#admitCustomerModal"
                                                        onclick="setCustomerId('${cus2l.id}')">복귀</button>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <button class="btn btn-outline-secondary">초기화</button>
                    </div>
                </div>
            </section>

        </div>
    </div>
</div>

<!-- 모달: 구매자 정지 -->
<div class="modal fade" id="stopCustomerModal" tabindex="-1" aria-labelledby="stopModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="stopModalLabel" class="modal-title">정지 사유</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <form id="stopCustomerForm">
                <div class="modal-body">
                    <input type="hidden" id="stopCustomerId" name="id">
                    <textarea class="form-control" id="stopCustomerReason" name="content" rows="3"
                              placeholder="해당 구매자를 정지할 이유를 작성해주세요."></textarea>
                    <small class="text-danger">* 특수문자 사용 시 전송 에러가 발생할 수 있습니다.</small>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 모달: 구매자 복귀 -->
<div class="modal fade" id="admitCustomerModal" tabindex="-1" aria-labelledby="admitModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="admitModalLabel" class="modal-title">복귀 사유</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <form id="admitCustomerForm">
                <div class="modal-body">
                    <input type="hidden" id="admitCustomerId" name="id">
                    <textarea class="form-control" id="admitCustomerReason" name="content" rows="3"
                              placeholder="해당 구매자를 복귀시킬 사유를 작성해주세요."></textarea>
                    <small class="text-danger">* 특수문자 사용 시 전송 에러가 발생할 수 있습니다.</small>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JQuery, Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript: 검색, 모달, 컬럼명 변환 등 -->
<script>
    // 검색 기능: 각 검색 버튼에 대해 Ajax 요청 처리
    $(function (){
        $("#customer_search_btn0").click(function(){
            let category_name = $("#customer_name0").val();
            let word = $("#customer_word0").val();
            if(word === "남자"){
                word = 1;
            } else if(word === "여자"){
                word = 2;
            }
            let param = "type=searchCustomer0&searchType=" +
                encodeURIComponent(category_name) +
                "&searchValue=" + encodeURIComponent(word);
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#customer_table0 tbody").html(data);
            });
        });

        $("#customer_search_btn1").click(function(){
            let category_name = $("#customer_name1").val();
            let word = $("#customer_word1").val();
            if(word === "남자"){
                word = 1;
            } else if(word === "여자"){
                word = 2;
            }
            let param = "type=searchCustomer1&searchType=" +
                encodeURIComponent(category_name) +
                "&searchValue=" + encodeURIComponent(word);
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#customer_table1 tbody").html(data);
            });
        });

        $("#customer_search_btn2").click(function(){
            let category_name = $("#customer_name2").val();
            let word = $("#customer_word2").val();
            if(word === "남자"){
                word = 1;
            } else if(word === "여자"){
                word = 2;
            }
            let param = "type=searchCustomer2&searchType=" +
                encodeURIComponent(category_name) +
                "&searchValue=" + encodeURIComponent(word);
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#customer_table2 tbody").html(data);
            });
        });
    });

    // 구매자 정지/복귀 시 모달에 ID 설정
    function setCustomerId(customerId) {
        console.log("전달된 ID:", customerId);
        $("#stopCustomerId").val(customerId);
        $("#admitCustomerId").val(customerId);
    }

    // 컬럼명 한글 변환 (필요시)
    const columnTranslations = {
        'grade_no': '등급이름',
        'cus_id': '사용자 id',
        'cus_pw': '사용자 pw',
        'name': '이름',
        'nickname': '닉네임',
        'gender': '성별',
        'birth_date': '생일',
        'phone': '전화번호',
        'email': '이메일',
        'weight': '무게',
        'height': '키',
        'total': '전체',
        'grade_expire_date': '등급만기일자',
        'is_del': '삭제여부'
    };

    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.column-name').forEach(element => {
            const colName = element.innerText.trim();
            if (columnTranslations[colName]) {
                element.innerText = columnTranslations[colName];
            }
        });
    });

    // 폼 제출: 구매자 정지
    $(document).ready(function () {
        $("#stopCustomerForm").submit(function (event) {
            event.preventDefault();
            let customerId = $("#stopCustomerId").val();
            let content = $("#stopCustomerReason").val();

            if (!customerId) {
                alert("정지할 구매자 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonCustomer",
                    id: customerId,
                    content: content,
                    action: "stop"
                },
                dataType: "json",
                success: function (response) {
                    if (response.status === "success") {
                        $("#row-" + customerId).remove();
                        $("#stopCustomerModal").modal("hide");
                        alert("구매자가 정지되었습니다.");
                    } else {
                        alert("구매자 정지에 실패했습니다: " + response.message);
                    }
                },
                error: function () {
                    alert("구매자 정지 중 오류가 발생했습니다.");
                }
            });
        });

        // 폼 제출: 구매자 복귀
        $("#admitCustomerForm").submit(function (event) {
            event.preventDefault();
            let customerId = $("#admitCustomerId").val();
            let content = $("#admitCustomerReason").val();

            if (!customerId) {
                alert("복귀할 구매자 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonCustomer",
                    id: customerId,
                    content: content,
                    action: "admit"
                },
                dataType: "json",
                success: function (response) {
                    if (response.status === "success") {
                        $("#row-" + customerId).remove();
                        $("#admitCustomerModal").modal("hide");
                        alert("구매자가 복귀되었습니다.");
                    } else {
                        alert("구매자 복귀에 실패했습니다: " + response.message);
                    }
                },
                error: function () {
                    alert("구매자 복귀 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>
