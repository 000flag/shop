<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 21.
  Time: 오후 2:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>쿠폰 관리</title>
</head>
<link rel="stylesheet" href="css/table.css></link>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>

<div class="container-fluid mt-4">
  <!-- 일반 게시판 목록 영역 -->
  <div class="col-9">
    <div class="d-flex justify-content-between align-items-center">
      <h5>쿠폰 목록</h5>
      <div>
        <!-- 대분류 추가 버튼, 모달 연결 -->
        <button class="btn btn-primary add-user-btn" data-bs-toggle="modal" data-bs-target="#CouponModal">쿠폰 추가</button>
      </div>
    </div>

    <div class="mt-3">
      <div class="input-group">
        <!-- 검색 아이콘 -->
        <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
        <select class="form-select" aria-label="Default select example" id="coupon_name">

          <option value="root_no">관리자번호</option>
          <option value="category_no">카테고리번호</option>
          <option value="seller_no">판매자번호</option>
          <option value="grade_no">등급번호</option>
          <option value="type">종류</option>
          <option value="name">이름</option>
          <option value="sale_per">할인율</option>
          <option value="start_date">시작일자</option>
          <option value="end_date">끝일자</option>
          <option value="status">상태</option>



        </select>


        <!-- 검색 입력 -->
        <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="coupon_word">
        <!-- 드롭다운 버튼 -->
        <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="coupon_search_btn">
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

    <table class="table mt-3" id="coupon_table">
      <thead class="table-light">

      <tr>

        <th>관리자번호</th>
        <th>카테고리번호</th>
        <th>판매자번호</th>
        <th>등급번호</th>
        <th>종류</th>
        <th>이름</th>
        <th>할인율</th>
        <th></th>
        <th>시작일자</th>
        <th>끝일자</th>
        <th>상태</th>
        <th></th>



      </tr>
      </thead>
      <tbody>
      <c:forEach var ="coul"  items="${couponList}">
        <tr id = "row-${coul.id}">


          <td>${coul.root_no}</td>
          <td>${coul.category_no}</td>
          <td>${coul.seller_no}</td>
          <td>${coul.grade_no}</td>
          <td>${coul.type}</td>
          <td>${coul.name}</td>
          <td>${coul.sale_per}</td>
          <td>${coul.sale_price}</td>
          <td>${coul.start_date}</td>
          <td>${coul.end_date}</td>
          <td>${coul.status}</td>


          <td><button class="btn btn-outline-secondary btn-sm">수정</button>
            <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteCouponModal"
                    onclick = "setCouponId('${coul.id}')">삭제</button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  <div>
    <div class="mt-3 mb-4">
      <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=couponmain'">초기화</button>
    </div>

    <hr/><!---------------------------------------------->
    <div class="modal fade" id="deleteCouponModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="rejectModalLabel">쿠폰 지우기 사유</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form id="deleteCouponForm">
            <div class="modal-body">
              <input type="hidden" id="deleteCouponId" name="id">

              <textarea class="form-control" id="deleteReason" name="content" rows="3">쿠폰을 삭제할 이유를 적어주세요.</textarea>
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
</div>
<!-- 부트스트랩 관련 스크립트 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  $(document).ready(function () {<%--폼태그--%>
    $("#deleteCouponForm").submit(function (event) {
      event.preventDefault(); // 기본 form 제출 막기

      let couponId = $("#deleteCouponId").val();

      let content = $("#deleteReason").val();

      if (!couponId) {
        alert("삭제할 쿠폰 ID가 없습니다.");
        return;
      }

      $.ajax({
        url: "Controller",
        type: "POST",
        data: {
          type: "deleteCoupon",
          id: couponId,

          content: content
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
            $("#row-" + response.deletedId).remove();


            $("#deleteCouponModal").modal("hide");

            alert("쿠폰이 삭제되었습니다.");
          } else {
            console.error("삭제 실패:", response.message);
            alert("쿠폰 삭제에 실패했습니다: " + response.message);
          }
        },
        error: function (xhr, status, error) {
          console.error("삭제 실패:", error);
          alert("게시글 삭제 중 오류가 발생했습니다.");
        }
      });
    });
  });
  function setCouponId(couponId) {
    console.log("전달된 ID:", couponId);
    $("#deleteCouponId").val(couponId);
    console.log("현재 값:", $("#deleteCouponId").val());
  }
  $(function (){



    $("#coupon_search_btn").click(function(){
      //검색버튼을 클릭할 때마다 수행하는 곳
      let category_name = $("#coupon_name").val();
      let word = $("#coupon_word").val();
      alert(category_name+"/"+word);
      let param = "type=searchCoupon&searchType="+
              encodeURIComponent(category_name)+
              "&searchValue="+encodeURIComponent(word);
      //비동기식 통신
      $.ajax({
        url: "Controller",
        type: "POST",
        data: param,
      }).done(function(data){
        $("#coupon_table tbody").html(data);
      });
    });
  });
  $(document).ready(function () {

    $("#addCouponForm").submit(function (event) {
      event.preventDefault();
      let root_no = $("#rootId").val();

      let category_no = $("#category_no").val();
      let seller_no = $("#seller_no").val().trim();
      let grade_no = $('#grade_no').val().trim();
      let type = $('#name').val().trim();
      let name = $('#sale_per').val().trim();
      let sale_per = $('#sale_per').val().trim();
      let start_date = $('#start_date').val().trim();
      let end_date = $('#end_date').val().trim();
      


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

