<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 20.
  Time: 오후 2:55
  To change this template use File | Settings | File Templates.
--%>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">


    <style>
    <jsp:include page ="css/table.css"></jsp:include>
    </style>
</head>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>

<div class="container-fluid mt-4">


    <!-- Main Content -->
    <div class="col-9">

        <div class="d-flex justify-content-between align-items-center">
            <h5>승인대기(active = 1)</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="seller1_name">
                    <c:forEach var="name" items="${sellerName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">

                            <option class="column-name" value="${name}">${name}</option>

                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="seller1_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="seller1_search_btn">
                    검색
                </button>

            </div>
        </div>

        <table class="table mt-3" id="seller1_table">
            <thead class="table-light">
            <tr>

                <c:forEach var="name" items="${sellerName}">
                    <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">
                        <th class="column-name" >${name}</th>


                    </c:if>
                </c:forEach>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var ="sl1"  items="${sellerList}">
                <c:if test="${sl1.active eq 1}">


                    <tr id="row-${sl1.id}">

                        <td>${sl1.seller_id}</td>
                        <td>${sl1.name}</td>
                        <td>${sl1.phone}</td>
                        <td>${sl1.email}</td>
                        <td>${sl1.desc}</td>
                        <td>${sl1.courier}</td>
                        <td>${sl1.address}</td>
                        <td>${sl1.active}</td>
                        <td><button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#rejectSellerModal"
                                    onclick="setSellerId('${sl1.id}')"> 거절</button>
                            <button class="btn btn-primary add-user-btn" data-bs-toggle="modal" data-bs-target="#admitSellerModal"
                                    onclick="setSellerId('${sl1.id}')"> 승인</button></td>

                    </tr>
                </c:if>
            </c:forEach>
            <%--is_del로 상태변경--%>


            </tbody>

        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary">초기화</button>
        </div>
        <hr/>
        <div class="d-flex justify-content-between align-items-center">
            <h5>현재 판매자 목록(active = 0)</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="seller0_name">
                    <c:forEach var="name" items="${sellerName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">

                            <option class="column-name" value="${name}">${name}</option>

                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="seller0_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="seller0_search_btn">
                    검색
                </button>

            </div>
        </div>

        <table class="table mt-3" id="seller0_table">
            <thead class="table-light">
            <tr>

                <c:forEach var="name" items="${sellerName}">
                    <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">
                        <th class="column-name" >${name}</th>


                    </c:if>
                </c:forEach>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var ="sl0"  items="${sellerList}">
                <c:if test="${sl0.active eq 0}">


                    <tr id="row-${sl0.id}">

                        <td>${sl0.seller_id}</td>
                        <td>${sl0.name}</td>
                        <td>${sl0.phone}</td>
                        <td>${sl0.email}</td>
                        <td>${sl0.desc}</td>
                        <td>${sl0.courier}</td>
                        <td>${sl0.address}</td>
                        <td>${sl0.active}</td>
                        <td><button class="btn btn-dark add-user-btn" data-bs-toggle="modal" data-bs-target="#stopSellerModal"
                                    onclick="setSellerId('${sl0.id}')"> 판매정지</button></td>
                    </tr>
                </c:if>
            </c:forEach>
            <%--is_del로 상태변경--%>


            </tbody>

        </table>


        <hr/>
        <div class="d-flex justify-content-between align-items-center">
            <h5>승인거절(active = 2)</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="seller2_name">
                    <c:forEach var="name" items="${sellerName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">

                            <option class="column-name" value="${name}">${name}</option>

                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="seller2_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="seller2_search_btn">
                    검색
                </button>

            </div>
        </div>

        <table class="table mt-3" id="seller2_table">
            <thead class="table-light">
            <tr>

                <c:forEach var="name" items="${sellerName}">
                    <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">
                        <th class="column-name" >${name}</th>


                    </c:if>
                </c:forEach>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var ="sl2"  items="${sellerList}">
                <c:if test="${sl2.active eq 2}">


                    <tr>

                        <td>${sl2.seller_id}</td>
                        <td>${sl2.name}</td>
                        <td>${sl2.phone}</td>
                        <td>${sl2.email}</td>
                        <td>${sl2.desc}</td>
                        <td>${sl2.courier}</td>
                        <td>${sl2.address}</td>
                        <td>${sl2.active}</td>

                    </tr>
                </c:if>
            </c:forEach>
            <%--is_del로 상태변경--%>


            </tbody>

        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary">초기화</button>
        </div>
        <hr/>
        <div class="d-flex justify-content-between align-items-center">
            <h5>판매정지(active = 3)</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="seller3_name">
                    <c:forEach var="name" items="${sellerName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">

                            <option class="column-name" value="${name}">${name}</option>

                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="seller3_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="seller3_search_btn">
                    검색
                </button>

            </div>
        </div>

        <table class="table mt-3" id="seller3_table">
            <thead class="table-light">
            <tr>

                <c:forEach var="name" items="${sellerName}">
                    <c:if test="${name ne 'id' && name ne 'seller_pw'&& name ne 'is_del'&&name ne 'seller_icon'}">
                        <th class="column-name" >${name}</th>


                    </c:if>
                </c:forEach>
                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var ="sl3"  items="${sellerList}">
                <c:if test="${sl3.active eq 3}">


                    <tr>

                        <td>${sl3.seller_id}</td>
                        <td>${sl3.name}</td>
                        <td>${sl3.phone}</td>
                        <td>${sl3.email}</td>
                        <td>${sl3.desc}</td>
                        <td>${sl3.courier}</td>
                        <td>${sl3.address}</td>
                        <td>${sl3.active}</td>

                    </tr>
                </c:if>
            </c:forEach>
            <%--is_del로 상태변경--%>


            </tbody>

        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary">초기화</button>
        </div>










    </div>
    <%--판매자대기 거절 모달 창--%>
    <div class="modal fade" id="rejectSellerModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rejectModalLabel">거절 사유</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="rejectSellerForm">
                    <div class="modal-body">
                        <input type="hidden" id="rejectSellerId" name="id">

                        <textarea class="form-control" id="rejectSellerReason" name="content" rows="3" placeholder="해당 판매자대기를 삭제할 이유를 적어주세요."></textarea>
                        <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--판매자대기 승인 모달 창--%>
    <div class="modal fade" id="admitSellerModal" tabindex="-1" aria-labelledby="admitModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="admitModalLabel">승인 사유</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="admitSellerForm">
                    <div class="modal-body">
                        <input type="hidden" id="admitSellerId" name="id">

                        <textarea class="form-control" id="admitSellerReason" name="content" rows="3" placeholder="해당 판매자대기를 승인할 이유를 적어주세요."></textarea>
                        <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--판매자 정지 모달 창--%>
    <div class="modal fade" id="stopSellerModal" tabindex="-1" aria-labelledby="stopModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="stopModalLabel">정지 사유</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="stopSellerForm">
                    <div class="modal-body">
                        <input type="hidden" id="stopSellerId" name="id">

                        <textarea class="form-control" id="stopSellerReason" name="content" rows="3" placeholder="해당 판매자를 정지할 이유를 적어주세요."></textarea>
                        <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    $(function (){
        $("#seller0_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#seller0_name").val();
            let word = $("#seller0_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchSeller0&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#seller0_table tbody").html(data);
            });
        });

    });
    $(function (){
        $("#seller1_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#seller1_name").val();
            let word = $("#seller1_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchSeller1&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#seller1_table tbody").html(data);
            });
        });
    });
    $(function (){
        $("#seller2_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#seller2_name").val();
            let word = $("#seller2_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchSeller2&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#seller2_table tbody").html(data);
            });
        });
    });
    $(function (){
        $("#seller3_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#seller3_name").val();
            let word = $("#seller3_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchSeller3&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#seller3_table tbody").html(data);
            });
        });
    });

    const columnTranslations = {
        'seller_id': '판매자 id',

        'name': '이름',

        'gender': '성별',
        'birth_date': '생일',
        'phone': '전화번호',
        'email': '이메일',
        'desc': '분류',
        'courier': '배송회사',
        'address': '주소',


    };

    // 페이지 로딩 후 컬럼 이름을 한국어로 변환
    document.addEventListener('DOMContentLoaded', function() {
        const columnElements = document.querySelectorAll('.column-name'); // 'column-name' 클래스를 가진 요소들

        columnElements.forEach(element => {
            const columnName = element.innerText.trim();
            if (columnTranslations[columnName]) {
                element.innerText = columnTranslations[columnName];  // 한국어로 번역
            }
        });
    });

    function setSellerId(sellerId) {
        console.log("전달된 판매자 ID:", sellerId);
        $("#rejectSellerId").val(sellerId);
        $("#admitSellerId").val(sellerId);
        $("#stopSellerId").val(sellerId);


    }
    function setAdmitSellerId(sellerId){
        console.log("전달된 판매자 ID:", sellerId);
        $("#admitSellerId").val(sellerId);
    }
    $(document).ready(function () {<%--폼태그--%>
        $("#rejectSellerForm").submit(function (event) {
            event.preventDefault(); // 기본 form 제출 막기

            let sellerId = $("#rejectSellerId").val();

            let content = $("#rejectSellerReason").val();

            if (!sellerId) {
                alert("삭제할 게시판 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonSeller",
                    id: sellerId,

                    content: content,
                    action: "reject"
                },
                dataType: "json", <%--보내지는 데이터 타입--%>
                <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
                <%--삭제시 반드시 1로 만들어준다-->
                <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
                <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

                success: function (response) {
                    if (response.status === "success") {
                        console.log("거절 성공:", response);

                        <%--테이블의 열의 id를 레코드를 삭제--%>
                        $("#row-" + sellerId).remove();



                        $("#rejectSellerModal").modal("hide");

                        alert("판매자가 거절되었습니다.");
                    } else {
                        console.error("거절 실패:", response.message);
                        alert("판매자 거절에 실패했습니다: " + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("거절 실패:", error);
                    alert("판매자 거절 중 오류가 발생했습니다.");
                }
            });
        });
    });
    $(document).ready(function () {<%--폼태그--%>
        $("#admitSellerForm").submit(function (event) {
            event.preventDefault(); // 기본 form 제출 막기

            let sellerId = $("#admitSellerId").val();

            let content = $("#admitSellerReason").val();

            if (!sellerId) {
                alert("승인할 게시판 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonSeller",
                    id: sellerId,

                    content: content,
                    action: "admit"
                },
                dataType: "json", <%--보내지는 데이터 타입--%>
                <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
                <%--삭제시 반드시 1로 만들어준다-->
                <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
                <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

                success: function (response) {
                    if (response.status === "success") {
                        console.log("승인 성공:", response);

                        <%--테이블의 열의 id를 레코드를 삭제--%>
                        $("#row-" + sellerId).remove();



                        $("#admitSellerModal").modal("hide");

                        alert("판매자가 승인되었습니다.");
                    } else {
                        console.error("승인 실패:", response.message);
                        alert("판매자 승인에 실패했습니다: " + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("승인 실패:", error);
                    alert("판매자 승인 중 오류가 발생했습니다.");
                }
            });
        });
    });
    $(document).ready(function () {<%--폼태그--%>
        $("#stopSellerForm").submit(function (event) {
            event.preventDefault(); // 기본 form 제출 막기

            let sellerId = $("#stopSellerId").val();

            let content = $("#stopSellerReason").val();

            if (!sellerId) {
                alert("승인할 게시판 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonSeller",
                    id: sellerId,

                    content: content,
                    action: "stop"
                },
                dataType: "json", <%--보내지는 데이터 타입--%>
                <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
                <%--삭제시 반드시 1로 만들어준다-->
                <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
                <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

                success: function (response) {
                    if (response.status === "success") {
                        console.log("정지 성공:", response);

                        <%--테이블의 열의 id를 레코드를 삭제--%>
                        $("#row-" + sellerId).remove();



                        $("#stopSellerModal").modal("hide");

                        alert("판매자가 정지되었습니다.");
                    } else {
                        console.error("정지 실패:", response.message);
                        alert("판매자 정지에 실패했습니다: " + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("정지 실패:", error);
                    alert("판매자 정지 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
</body>
</html>

