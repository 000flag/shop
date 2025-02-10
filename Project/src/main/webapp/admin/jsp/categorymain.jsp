<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>카테고리 관리</title>
    <style>
       <jsp:include page="css/table.css"></jsp:include>
    </style>
</head>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>

<div class="container-fluid mt-4">
    <!-- 대분류 목록 영역 -->
    <div class="col-9">


        <div class="d-flex justify-content-between align-items-center">
            <h5>대분류 목록</h5>
            <div>
                <!-- 대분류 추가 버튼, 모달 연결 -->
                <button class="btn btn-primary add-user-btn" data-bs-toggle="modal" data-bs-target="#mainCategoryModal">대분류 추가</button>
            </div>
        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="major_category_name">

                    <c:forEach var="name" items="${majorcategoryName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'is_del'}">
                            <option class="column-name" value="${name}">${name}</option>
                        </c:if>
                    </c:forEach>
                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="major_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="major_search_btn">
                    검색
                </button>
                <!-- 드롭다운 메뉴 -->
                <%--<ul class="dropdown-menu dropdown-menu-end">
                    <c:forEach var="name" items="${majorcategoryName}" begin="1">
                        <li><a class="dropdown-item" href="#">${name}</a></li>
                    </c:forEach>
                </ul>--%>
            </div>
        </div>

        <table class="table mt-3" id="major_category_table categoryTable">
            <thead class="table-light">

            <tr>

                <c:forEach var="name" items="${majorcategoryName}">
                    <c:if test="${name ne 'id' && name ne 'is_del'}">
                        <th class="column-name">${name}</th>
                    </c:if>
                </c:forEach>


                <th>&nbsp;</th>
            </tr>
            </thead>
            <tbody id="categoryBody">
            <c:forEach var ="mcl"  items="${majorcategoryList}">
                <c:if test="${mcl.is_del eq 0}">
                    <tr id = "row-${mcl.id}">

                        <td>${mcl.name}</td>
                        <td>${mcl.ename}</td>
                        <td>${mcl.type}</td>
                        <td>
                            <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteMajorModal"
                                    onclick = "setMajorId('${mcl.id}')">삭제</button>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=categorymain'">초기화</button>
        </div>

        <hr/>

        <!-- 중분류 목록 부분 -->
        <div class="d-flex justify-content-between align-items-center">
            <h5>중분류 목록</h5>
            <div>
                <!-- 중분류 추가 버튼, 모달 연결 -->
                <button class="btn btn-primary add-user-btn" data-bs-toggle="modal" data-bs-target="#middleCategoryModal">중분류 추가</button>
            </div>
        </div>

        <div class="mt-3">
            <div class="input-group">
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="middle_category_name">


                    <option value="major_name">대분류 이름</option>
                    <option value="name">이름</option>
                    <option value="type">타입</option>



                </select>
                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="middle_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="middle_search_btn">
                    검색
                </button>

            </div>
        </div>

        <table class="table mt-3" id="middle_category_table">
            <thead class="table-light">

            <tr>



                <th>&nbsp;대분류 이름</th>
                <th>&nbsp;이름</th>
                <th>&nbsp;타입</th>
                <th></th>
            </tr>
            </thead>
            <tbody id="middleCategoryBody">
            <c:forEach var="mdcl" items="${middlecategoryList}">
                <c:if test="${mdcl.is_del eq 0}">
                <tr id = "row-${mdcl.id}">

                    <td>${mdcl.major_name}</td>
                    <td>${mdcl.name}</td>
                    <td>${mdcl.type}</td>
                    <td>
                        <button class="btn btn-secondary add-user-btn delete-middle-btn"
                                data-bs-toggle="modal"
                                data-bs-target="#deleteMiddleModal"
                                data-middle-id="${mdcl.id}">삭제</button>

                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary">초기화</button>
        </div>
    </div>
</div>

<!-- 대분류 설정 모달 (대분류 추가용) -->
<div class="modal fade" id="mainCategoryModal" tabindex="-1" aria-labelledby="mainCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mainCategoryModalLabel">대분류 설정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addCategoryForm" action="Controller" method="POST">
                <div class="modal-body">

                    <!-- type 파라미터 전달 -->
                    <div class="row mb-3">
                        <div class="col-md-2 fw-bold">대분류 명</div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="categoryName" name="name" placeholder="상의, 하의 등 분류별 명칭">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-2 fw-bold">대분류 영문명</div>
                        <div class="col-md-6">
                            <input type="text" class="form-control" id="categoryEname" name="ename" placeholder="영어 명칭">
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary" id="saveButton">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%--대분류 삭제 모달 창--%>
<div class="modal fade" id="deleteMajorModal" tabindex="-1" aria-labelledby="deleteMajorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteMajorModalLabel">삭제 사유</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deleteMajorForm">
                <div class="modal-body">
                    <input type="hidden" id="deleteMajorId" name="id">
                    <textarea class="form-control" id="deleteMajorReason" name="content" rows="3" placeholder="해당 판매자대기를 삭제할 이유를 적어주세요."></textarea>
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
<%--중분류 삭제 모달 창--%>
<div class="modal fade" id="deleteMiddleModal" tabindex="-1" aria-labelledby="deleteMiddleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteMiddleModalLabel">삭제 사유</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deleteMiddleForm">
                <div class="modal-body">
                    <input type="hidden" id="deleteMiddleId" name="id">
                    <textarea class="form-control" id="deleteMiddleReason" name="content" rows="3" placeholder="해당 판매자대기를 삭제할 이유를 적어주세요."></textarea>
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

<!-- 중분류 설정 모달 (중분류 추가용) -->
<div class="modal fade" id="middleCategoryModal" tabindex="-1" aria-labelledby="middleCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="middleCategoryModalLabel">중분류 설정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id = "addMiddleCategoryForm" action="Controller" method="POST">
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-md-2 fw-bold">상위 대분류</div>
                    <div class="col-md-6">

                        <select class="form-select" id="majorCategoryId" name="majorCategoryId">
                            <option value="1">상의</option>
                            <option value="2">하의</option>
                            <option value="3">아우터</option>
                            <option value="4">신발</option>
                        </select>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-2 fw-bold">중분류 명</div>
                    <div class="col-md-6">
                        <input type="text" class="form-control" id="middleCategoryName" name="middleCategoryName" placeholder="맨투맨">

                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-2 fw-bold">종류</div>
                    <div class="col-md-6">
                        <input type="text" class="form-control" id="middleCategoryType" name="middleCategoryType" value="1">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-primary" id="middlesaveBtn">저장</button>
            </div>
            </form>
        </div>
    </div>
</div>

<!-- 부트스트랩 관련 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    $(function () {
        $("#major_search_btn").click(function () {
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#major_category_name").val();
            let word = $("#major_word").val();
            alert(category_name + "/" + word);
            let param = "type=searchMajorCategory&searchType=" +
                encodeURIComponent(category_name) +
                "&searchValue=" + encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function (data) {
                console.log(data);

                $("#categoryBody").html(data);
            });
        });

        $("#middle_search_btn").click(function () {
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#middle_category_name").val();
            let word = $("#middle_word").val();
            alert(category_name + "/" + word);
            let param = "type=searchMiddleCategory&searchType=" +
                encodeURIComponent(category_name) +
                "&searchValue=" + encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function (data) {
                $("#middle_category_table tbody").html(data);
            });
        });




    });
    const columnTranslations = {
        'id': '아이디',
        'name': '이름',
        'ename': '영문 이름',
        'type': '타입',
        'major_no': '대분류 번호'
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



    $("#saveButton").click(function () {
        let name = $("#categoryName").val().trim();
        let ename = $("#categoryEname").val().trim();


        // 입력값 검증
        if (!name || !ename ) {
            alert("모든 항목을 입력해주세요!");
            return;
        }


        // 모달 닫기
        $("#mainCategoryModal").modal("hide");
    });


    //제홍씨 추가한부분이에요 추가 비동기
    $(document).ready(function () {
        $("#addCategoryForm").submit(function (event) {
            event.preventDefault();
            let majorId = $("#deleteMajorId").val();
            console.log("mm"+majorId);
            $.ajax({
                type: "POST",
                url: "Controller?type=addMajorCategory",
                data: $(this).serialize(),
                dataType: "json",
                success: function (response) {
                    if (response.success) {
                        let name = $("input[name='name']").val();
                        console.log(name)
                        let ename = $("input[name='ename']").val();
                        console.log(ename)
                        let majorId = response.result;

                        let newRow = `
                      <tr id="row-`+majorId+`">
                <td>` + name + `</td>
                <td>` + ename + `</td>
                <td></td>
                <td>
                    <button class="btn btn-secondary add-user-btn"
                            data-bs-toggle="modal"
                            data-bs-target="#deleteMajorModal"
                            onclick="setMajorId(` + majorId + `)">삭제</button>
                </td>
            </tr>
        `;





                        $("#row-" + majorId).remove();

                        $("#categoryBody").append(newRow);


                        $("input[name='name']").val('');
                        $("input[name='ename']").val('');
                    } else {
                        alert("카테고리 추가 실패!");
                    }
                },
                error: function () {
                    alert("서버 오류 발생!");
                }
            });
        });
    });
    function setMajorId(majorId) {
        console.log("전달된 대분류 ID:", majorId);
        $("#deleteMajorId").val(majorId);



    }
    $(document).on("click", ".delete-middle-btn", function () {
        let middleId = $(this).data("middle-id"); // 버튼의 data-middle-id 값 가져오기
        console.log("전달된 중분류 ID:", middleId);
        $("#deleteMiddleId").val(middleId);
      });


    $(document).ready(function () {<%--폼태그--%>
        $("#deleteMajorForm").submit(function (event) {
            event.preventDefault(); // 기본 form 제출 막기

            let majorId = $("#deleteMajorId").val();

            let content = $("#deleteMajorReason").val();

            if (!majorId) {
                alert("삭제할 대분류 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonCategory",
                    id: majorId,

                    content: content,
                    action: "major"
                },
                dataType: "json", <%--보내지는 데이터 타입--%>
                <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
                <%--삭제시 반드시 1로 만들어준다-->
                <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
                <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

                success: function (response) {
                    if (response.status === "success") {
                        console.log("삭제 성공:", response);

                        <%--테이블의 열의 id를 레코드를 삭제--%>
                        $("#row-" + majorId).remove();



                        $("#deleteMajorModal").modal("hide");

                        alert("대분류가 삭제되었습니다.");
                    } else {
                        console.error("삭제 실패:", response.message);
                        alert("대분류 삭제에 실패했습니다: " + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("삭제 실패:", error);
                    alert("대분류 삭제 중 오류가 발생했습니다.");
                }
            });
        });
    });
    $(document).ready(function () {<%--폼태그--%>
        $("#deleteMiddleForm").submit(function (event) {
            event.preventDefault(); // 기본 form 제출 막기

            let middleId = $("#deleteMiddleId").val();

            let content = $("#deleteMiddleReason").val();

            if (!middleId) {
                alert("삭제할 중분류 ID가 없습니다.");
                return;
            }

            $.ajax({
                url: "Controller",
                type: "POST",
                data: {
                    type: "buttonCategory",
                    id: middleId,

                    content: content,
                    action: "middle"
                },
                dataType: "json", <%--보내지는 데이터 타입--%>
                <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
                <%--삭제시 반드시 1로 만들어준다-->
                <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
                <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

                success: function (response) {
                    if (response.status === "success") {
                        console.log("삭제 성공:", response);

                        <%--테이블의 열의 id를 레코드를 삭제--%>
                        $("#row-" + middleId).remove();



                        $("#deleteMiddleModal").modal("hide");

                        alert("중분류가 삭제되었습니다.");
                    } else {
                        console.error("삭제 실패:", response.message);
                        alert("대분류 삭제에 실패했습니다: " + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("삭제 실패:", error);
                    alert("대분류 삭제 중 오류가 발생했습니다.");
                }
            });
        });
    });
    $("#middlesaveBtn").click(function(){
        let majorCategoryId = $("#majorCategoryId").val().trim();
        let middleCategoryName = $("#middleCategoryName").val().trim();
        let middleCategoryType = $("#middleCategoryType").val().trim();
        if(!majorCategoryId|| !middleCategoryName  || !middleCategoryType ) {
            alert("모든 항목을 입력해주세요!");
            return;
        }
        $("#middleCategoryModal").modal("hide");


    });
    $(document).ready(function () {

        $("#addMiddleCategoryForm").submit(function (event) {
            event.preventDefault();
            let middleId = $("#deleteMiddleId").val();

           let majorCategoryId = $("#majorCategoryId").val();
           let middleCategoryName = $("#middleCategoryName").val().trim();
          let middleCategoryType = $("#middleCategoryType").val().trim();
            console.log("md:"+middleId);
          const categoryMap = {
            "1": "상의",
            "2": "하의",
            "3": "아우터",
            "4": "신발"
          };
          let majorCategoryText = categoryMap[majorCategoryId];


            $.ajax({
                type: "POST",
                url: "Controller?type=addMiddleCategory",
                data: {
                  majorCategoryId: majorCategoryId, // DB에 숫자로 저장
                  middleCategoryName: middleCategoryName,
                  middleCategoryType: middleCategoryType
                },
                dataType: "json",
                success: function(response){
                    if(response.success) {
                      let middleId = response.id;
                      console.log("middle"+middleId)

                      if(! middleId){
                        alert("서버에서 응다이없어");
                        return;
                      }

                      const categoryMap = {
                        "1": "상의",
                        "2": "하의",
                        "3": "아우터",
                        "4": "신발"
                      };
                      let majorCategoryText = categoryMap[majorCategoryId]; // 변환된 텍스트
                      let newRow = `
                        <tr id="row-` + middleId + `">
                            <td>` + majorCategoryText + `</td>
                            <td>` + middleCategoryName + `</td>
                            <td>` + middleCategoryType + `</td>
                            <td>
                                <button class="btn btn-secondary add-user-btn delete-middle-btn"
                                        data-bs-toggle="modal"
                                        data-bs-target="#deleteMiddleModal"
                                        data-middle-id="` + middleId + `">삭제</button>
                            </td>
                        </tr>`;
                        $("#row-" + middleId).remove();
                        $("#middleCategoryBody").append(newRow);
                      $("#majorCategoryId").val('');
                      $("#middleCategoryName").val('');
                      $("#middleCategoryType").val('');
                    }else{
                        alert("카테고리 추가 실패!");
                    }
                },
                error: function() {
                    alert("서버 오류 발생!");
                }
            });

        });
    });





</script>

</body>
</html>