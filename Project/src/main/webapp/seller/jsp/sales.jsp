<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
    margin: 20px;
      font-family: Arial, sans-serif;
    }
    .header-spacing {
      margin-top: 30px;
    }
    .section-title {
      font-size: 1.5rem;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .table-container {
      margin-bottom: 40px;
    }
    table th, table td {
      text-align: center;
      vertical-align: middle;
    }
    .d-flex-between {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .search-container {
      display: flex;
      gap: 10px;
      align-items: center;
      margin-bottom: 20px;
    }

    .search-container input {
      max-width: 300px; /* 원하는 크기로 설정 */
      width: 100%;
    }
    .summary-card {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
      background-color: #f8f9fa;
    }
    /* 페이지네이션 기본 스타일 */
    .pagination {
      display: flex;
      justify-content: center;
      gap: 5px; /* 페이지 버튼 간격 */
    }

    /* 기본 페이지 버튼 스타일 */
    .page-item {
      list-style: none; /* 리스트 스타일 제거 */
    }

    /* 페이지 번호 버튼 */
    .page-item .page-link {
      cursor: pointer;
      padding: 8px 12px;
      text-decoration: none;
      color: #000; /* 기본 검은색 */
      border: 1px solid #ddd; /* 테두리 연하게 */
      border-radius: 5px;
      transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
    }

    /* 마우스 올렸을 때 효과 */
    .page-item .page-link:hover {
      background-color: #f1f1f1; /* 연한 회색 */
      color: black;
    }

    /* ✅ 현재 선택된 페이지 */
    .page-item.active .page-link {
      background-color: white; /* 흰색 배경 */
      color: black; /* 검은색 글씨 */
      font-weight: bold;
      border: 2px solid black; /* 테두리를 더 두껍게 */
      box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2); /* 가벼운 그림자 효과 */
    }

    /* 이전/다음 버튼 스타일 */
    .page-item.disabled .page-link {
      color: #aaa;
      pointer-events: none;
      background-color: #f8f9fa;
      border-color: #ddd;
    }
  </style>
</head>
<%@ include file="layout/header.jsp" %>
<body>
<div class="container header-spacing">
  <h1 class="section-title">매출/정산 관리</h1>

  <!-- 매출 요약 -->
  <c:set var="totalFinalPrice" value="0"/>
  <c:forEach var="sale" items="${salesList}">
    <c:if test="${sale.status eq 5}">
      <c:set var="totalFinalPrice" value="${totalFinalPrice + sale.final_price}"/>
    </c:if>
  </c:forEach>
  <div class="summary-card d-flex-between">
    <div>
      <h5>기간 별 매출</h5>
      <p class="text-primary fw-bold" id="totalSalesAmount" name="totalSalesAmount">₩ ${totalFinalPrice}</p>
      <%-- ✅ 초기값을 `totalFinalPrice`로 설정 --%>
    </div>
    <div>
      <h5>총 주문 수</h5>
      <p class="text-success fw-bold">${totalSalesCount}건</p>
    </div>
    <div>
      <h5>총 정산 금액</h5>
      <p class="text-danger fw-bold">₩ ${totalFinalPrice}</p> <%-- ✅ JSP에서 합산 후 출력 --%>
    </div>
  </div>
  <div class="search-container"> <!-- 날짜 설정 버튼 -->
    <label for="startDate">시작일:</label>
    <input type="date" class="form-control" id="startDate">

    <label for="endDate">종료일:</label>
    <input type="date" class="form-control" id="endDate">

    <button type="button" class="btn btn-outline-secondary" id="dateSearchBtn">🔍 기간 검색</button>
    <button type="button" class="btn btn-outline-secondary" id="calculateSalesBtn">💰 기간별 매출 계산</button>
  </div>
  <!-- 검색 필드 -->
  <div class="search-container">
    <select class="form-select" id="searchCategory" aria-label="검색 카테고리" style="max-width: 200px;">
      <option value="orderId">주문 ID</option>
      <option value="productName">상품명</option>
      <option value="category">카테고리</option>
      <option value="status">상태</option> <!-- 상태 옵션 추가 -->
    </select>
    <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요" aria-label="검색어" style="max-width: 200px;">
    <select class="form-select" id="categorySelect" style="display: none; max-width: 200px;">
      <option value="전체">전체</option>
      <option value="맨투맨">맨투맨</option>
      <option value="셔츠">셔츠</option>
      <option value="후드">후드</option>
      <option value="니트">니트</option>
      <option value="반소매티셔츠">반소매티셔츠</option>
      <option value="데님팬츠">데님팬츠</option>
      <option value="트레이닝/조거팬츠">트레이닝/조거팬츠</option>
      <option value="코튼팬츠">코튼팬츠</option>
      <option value="숏팬츠">숏팬츠</option>
      <option value="슈트팬츠/슬랙스">슈트팬츠/슬랙스</option>
      <option value="숏패딩/헤비아우터">숏패딩/헤비아우터</option>
      <option value="무스탕/퍼">무스탕/퍼</option>
      <option value="후드집업">후드집업</option>
      <option value="플리스/뽀글이">플리스/뽀글이</option>
      <option value="코트">코트</option>
      <option value="스니커즈">스니커즈</option>
      <option value="부츠/워커">부츠/워커</option>
      <option value="구두">구두</option>
      <option value="샌들/슬리퍼">샌들/슬리퍼</option>
      <option value="스포츠화">스포츠화</option>
    </select>
    <select class="form-select" id="statusSelect" style="display: none; max-width: 200px;"> <!-- 상태 선택 콤보박스 -->
      <option value="결제 완료">결제 완료</option>
      <option value="발송준비/배송전">발송준비/배송전</option>
      <option value="발송완료/배송중">발송완료/배송중</option>
      <option value="배송완료">배송완료</option>
      <option value="구매확정">구매확정</option>
      <option value="구매취소">구매취소</option>
      <option value="반품신청">반품신청</option>
      <option value="교환신청">교환신청</option>
      <option value="반품거부">반품거부</option>
      <option value="교환거부">교환거부</option>
      <option value="반품완료">처리 중</option>
    </select>
    <button type="button" class="btn btn-outline-secondary" id="totalSearch">검색</button>
  </div>

  <!-- 매출 테이블 -->
  <div class="table-container">
    <table class="table table-bordered" id="mainTable">
      <thead class="table-light">
      <tr>
        <th>주문 ID</th>
        <th>주문일</th>
        <th>상품명</th>
        <th>카테고리</th>
        <th>쿠폰 할인률</th>
        <th>정산 금액</th>
        <th>상태</th>
        <th>관리</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="sale" items="${salesList}">
        <tr>
          <td>${sale.order_id}</td>
          <td>${sale.order_date}</td>
          <td>${sale.product_name}</td>
          <td>${sale.category_name}</td>
          <td>${sale.discount_value}%</td>
          <td>₩${sale.final_price}</td>
          <td>
            <c:choose>
              <c:when test="${sale.status eq 1}"><span class="badge bg-primary">결제 완료</span></c:when>
              <c:when test="${sale.status eq 2}"><span class="badge bg-secondary">발송준비/배송전</span></c:when>
              <c:when test="${sale.status eq 3}"><span class="badge bg-info">발송완료/배송중</span></c:when>
              <c:when test="${sale.status eq 4}"><span class="badge bg-warning text-dark">배송완료</span></c:when>
              <c:when test="${sale.status eq 5}"><span class="badge bg-warning">구매확정</span></c:when>
              <c:when test="${sale.status eq 6}"><span class="badge bg-success">구매취소</span></c:when>
              <c:when test="${sale.status eq 7}"><span class="badge bg-dark">반품신청</span></c:when>
              <c:when test="${sale.status eq 8}"><span class="badge bg-danger">교환신청</span></c:when>
              <c:when test="${sale.status eq 9}"><span class="badge bg-danger">반품거부</span></c:when>
              <c:when test="${sale.status eq 10}"><span class="badge bg-danger">교환거부</span></c:when>
              <c:when test="${sale.status eq 11}"><span class="badge bg-danger">반품완료</span></c:when>
              <c:otherwise><span class="badge bg-secondary">미정</span></c:otherwise>

            </c:choose>
          </td>
          <td>
            <button class="btn btn-sm btn-warning detail-button" data-order-id="${sale.order_id}">상세</button>
          </td>
        </tr>
      </c:forEach>
      </tbody>

    </table>
  </div>
  <nav>
    <ul class="pagination justify-content-center" id="pageNumbers">
      <li class="page-item disabled" id="prevPage">
        <a class="page-link" href="#" aria-label="Previous">이전</a>
      </li>
      <!-- 페이지 번호가 여기에 동적으로 추가됨 -->
      <li class="page-item" id="nextPage">
        <a class="page-link" href="#" aria-label="Next">다음</a>
      </li>
    </ul>
  </nav>
</div>

<!-- 주문 상세 모달 -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="orderDetailModalLabel">주문 상세 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 주문 정보 -->
        <h6 class="fw-bold mb-3">주문 정보</h6>
        <table class="table table-bordered">
          <tbody>
          <tr>
            <th>주문 ID</th>
            <td id="detailOrderId">-</td>
          </tr>
          <tr>
            <th>주문일</th>
            <td id="detailOrderDate">-</td>
          </tr>
          <tr>
            <th>주문 상태</th>
            <td id="detailOrderStatusText">-</td>  <!-- ✅ 상태를 텍스트로만 표시 -->
          </tr>
          </tbody>
        </table>

        <!-- 고객 정보 -->
        <h6 class="fw-bold mb-3">고객 정보</h6>
        <table class="table table-bordered">
          <tbody>
          <tr>
            <th>고객명</th>
            <td id="detailCustomerName">-</td>
          </tr>
          <tr>
            <th>연락처</th>
            <td id="detailCustomerPhone">-</td>
          </tr>
          <tr>
            <th>배송 주소</th>
            <td id="detailCustomerAddress">-</td>
          </tr>
          </tbody>
        </table>

        <!-- 상품 정보 -->
        <h6 class="fw-bold mb-3">상품 정보</h6>
        <table class="table table-bordered">
          <thead class="table-light">
          <tr>
            <th>상품명</th>
            <th>카테고리</th>
            <th>수량</th>
            <th>판매 금액</th>
            <th>할인률</th>
            <th>합계</th>
          </tr>
          </thead>
          <tbody id="detailProductList">
          <td id="detailProductName">-</td>
          <td id="detailCategoryName">-</td>
          <td id="detailQuantity">-</td>
          <td id="detailPrice">-</td>
          <td id="detailCoupon">-</td>
          <td id="detailTotalPrice">-</td>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script>

  document.addEventListener("DOMContentLoaded", function () {
    const calculateSalesBtn = document.getElementById("calculateSalesBtn");
    const totalSalesAmountElement = document.getElementById("totalSalesAmount");

    console.log("🔵 totalSalesAmountElement:", totalSalesAmountElement);
    filteredRows = [...originalRows];

    // ✅ totalPages 업데이트 (검색이 아닐 때도 전체 페이지 적용)
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);

    // ✅ 페이지네이션 먼저 업데이트한 후 첫 페이지 표시
    updatePagination();
    showPage(1);
    if (calculateSalesBtn) {
      calculateSalesBtn.addEventListener("click", function () {
        const startDate = document.getElementById("startDate").value;
        const endDate = document.getElementById("endDate").value;
        let totalAmount = 0;

        if (!startDate || !endDate) {
          alert("📅 시작일과 종료일을 모두 선택하세요!");
          return;
        }

        const start = new Date(startDate);
        const end = new Date(endDate);
        end.setHours(23, 59, 59, 999);

        document.querySelectorAll("#mainTable tbody tr").forEach(row => {

          const orderDateText = row.children[1].textContent.trim();
          const finalPriceText = row.children[5].textContent.replace(/[₩,]/g, "").trim();
          const statusText = row.children[6].textContent.trim();

          console.log("🔍 finalPriceText 값:", finalPriceText);

          const finalPrice = parseInt(finalPriceText) || 0;
          const orderDate = new Date(orderDateText);

          if (!isNaN(orderDate) && orderDate >= start && orderDate <= end && statusText === "구매확정") {
            totalAmount += finalPrice;
          }
        });
        console.log("💰 totalAmount 계산 중: ", totalAmount)
        if (isNaN(totalAmount)) {
          totalAmount = 0;
        }

        console.log("💰 최종 계산된 매출:", totalAmount);
        if (totalSalesAmountElement) {
          setTimeout(() => {
            totalSalesAmountElement.innerHTML = "";
            totalSalesAmountElement.innerHTML = "₩ "+totalAmount;
            console.log(`나 나 나 ${totalAmount.toLocaleString()}`);
            console.log("🟢 최종 표시될 금액:", totalSalesAmountElement.innerHTML);
          }, 50);
        } else {
          console.error("❌ totalSalesAmountElement가 존재하지 않습니다.");
        }
      });
    } else {
      console.error("❌ 'calculateSalesBtn' 버튼을 찾을 수 없음.");
    }
  });


  const rowsPerPage = 5; // 한 페이지당 표시할 행 수
  let currentPage = 1; // 현재 페이지
  let originalRows = Array.from(document.querySelectorAll("#mainTable tbody tr")); // 원본 데이터 저장
  let filteredRows = [...originalRows]; // 검색된 데이터 (초기에는 원본과 동일)
  let totalPages = Math.ceil(filteredRows.length / rowsPerPage); // 전체 페이지 수

  const prevPageButton = document.getElementById("prevPage");
  const nextPageButton = document.getElementById("nextPage");
  const pageNumbersContainer = document.getElementById("pageNumbers");
  const pagesPerGroup = 3;
  let currentGroup = 1;

  // ✅ 페이지 표시 함수
  function showPage(page) {
    if (filteredRows.length === 0) {
      document.querySelectorAll("#mainTable tbody tr").forEach(row => row.style.display = "none");
      return;
    }

    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    // ✅ 모든 행 숨기고, 현재 페이지 데이터만 보이게 설정
    originalRows.forEach(row => row.style.display = "none");
    filteredRows.slice(start, end).forEach(row => row.style.display = "");

    // ✅ 페이지 정보 업데이트
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    currentPage = Math.min(currentPage, totalPages); // 현재 페이지가 범위 초과 시 보정
    updatePagination();
  }

  // ✅ 페이지네이션 버튼 업데이트
  function updatePagination() {
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    const totalGroups = Math.ceil(totalPages / pagesPerGroup);
    currentGroup = Math.ceil(currentPage / pagesPerGroup);

    document.querySelectorAll("#pageNumbers .page-item").forEach(el => {
      if (el.id !== "prevPage" && el.id !== "nextPage") el.remove();
    });

    let startPage = (currentGroup - 1) * pagesPerGroup + 1;
    let endPage = Math.min(startPage + pagesPerGroup - 1, totalPages);

    for (let i = startPage; i <= endPage; i++) {
      const pageItem = document.createElement("li");
      pageItem.classList.add("page-item");
      if (i === currentPage) pageItem.classList.add("active");

      const pageLink = document.createElement("a");
      pageLink.classList.add("page-link");
      pageLink.href = "#";
      pageLink.textContent = i;

      pageLink.addEventListener("click", () => {
        document.querySelector(".page-item.active")?.classList.remove("active");
        pageItem.classList.add("active");
        currentPage = i;
        showPage(currentPage);
      });

      pageItem.appendChild(pageLink);
      nextPageButton.before(pageItem);
    }

    prevPageButton.classList.toggle("disabled", currentGroup === 1);
    nextPageButton.classList.toggle("disabled", currentGroup === totalGroups);
  }

  // ✅ 이전 페이지 그룹 이동
  prevPageButton.addEventListener("click", () => {
    if (currentGroup > 1) {
      currentGroup--;
      currentPage = (currentGroup - 1) * pagesPerGroup + 1;
      showPage(currentPage);
    }
  });

  // ✅ 다음 페이지 그룹 이동
  nextPageButton.addEventListener("click", () => {
    const totalGroups = Math.ceil(totalPages / pagesPerGroup);
    if (currentGroup < totalGroups) {
      currentGroup++;
      currentPage = (currentGroup - 1) * pagesPerGroup + 1;
      showPage(currentPage);
    }
  });

  document.querySelector("#totalSearch").addEventListener("click", function () {
    const criteria = document.querySelector("#searchCategory").value;
    let keyword = document.querySelector("#searchInput").value.toLowerCase();
    const selectedCategory = document.querySelector("#categorySelect").value.toLowerCase();
    const selectedStatus = document.querySelector("#statusSelect").value;

    // ✅ 검색어가 없으면 전체 목록으로 복원
    if (!keyword && criteria !== "category" && criteria !== "status") {
      filteredRows = [...originalRows];
    } else {
      filteredRows = originalRows.filter(row => {
        let cellValue = "";
        switch (criteria) {
          case "orderId":
            cellValue = row.children[0].textContent.toLowerCase();
            break;
          case "productName":
            cellValue = row.children[2].textContent.toLowerCase();
            break;
          case "category":
            return selectedCategory === "전체" || row.children[3].textContent.trim() === selectedCategory;
          case "status":
            return selectedStatus === "전체" || row.children[6].textContent.trim() === selectedStatus;
        }
        return cellValue.includes(keyword);
      });
    }

    // ✅ 검색 후 데이터가 없으면 원래 데이터로 복원
    if (filteredRows.length === 0) {
      alert("🔍 검색된 데이터가 없습니다. 전체 목록을 복원합니다.");
      filteredRows = [...originalRows];
    }

    // ✅ totalPages 업데이트 (검색 결과에 따라 전체 페이지 수 계산)
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);

    // ✅ 현재 페이지 보정 (검색 결과 개수가 적을 경우)
    currentPage = 1;

    // ✅ 페이지네이션 업데이트
    updatePagination();

    // ✅ 페이지 표시 (이제 페이징이 유지됨!)
    showPage(currentPage);
  });



  function showOrderDetail() {
    const orderId = this.getAttribute("data-order-id");

    // ✅ 필터링된 데이터에서 display: none 여부 확인
    const row = this.closest("tr");
    if (window.getComputedStyle(row).display === "none") {
      alert("현재 필터링된 데이터에 해당 주문이 없습니다.");
      return;
    }

    console.log("🔍 주문 상세 요청: ", orderId);
    resetModalData(); // ✅ 모달 데이터 초기화

    fetch('/shop/Controller?type=salesModal&orderId=' + orderId)
            .then(response => response.json())
            .then(data => {
              console.log("🟢 받은 데이터:", data);
              if (!data || data.length === 0) {
                alert("❌ 주문 정보를 불러올 수 없습니다.");
                return;
              }

              // 데이터 업데이트
              document.getElementById("detailOrderId").textContent = data[0].order_id || "-";
              document.getElementById("detailOrderDate").textContent = data[0].order_date || "-";
              document.getElementById("detailCustomerName").textContent = data[0].customer_name || "-";
              document.getElementById("detailCustomerPhone").textContent = data[0].customer_phone || "-";
              document.getElementById("detailCustomerAddress").textContent = data[0].customer_address || "-";
              document.getElementById("detailProductName").textContent = data[0].product_name || "-";
              document.getElementById("detailCategoryName").textContent = data[0].category_name || "-";
              document.getElementById("detailQuantity").textContent = data[0].quantity || "-";
              document.getElementById("detailPrice").textContent = data[0].price || "-";
              document.getElementById("detailCoupon").textContent = data[0].discount_value || "-";
              document.getElementById("detailTotalPrice").textContent = data[0].total_price || "-";

              // 상태 값 변환
              const statusMap = {
                1: "결제완료", 2: "발송준비/배송전", 3: "발송완료/배송중",
                4: "배송완료", 5: "구매확정", 6: "구매취소",
                7: "반품신청", 8: "교환신청", 9: "반품거부",
                10: "교환거부", 11: "반품완료"
              };
              document.getElementById("detailOrderStatusText").textContent = statusMap[data[0].status] || "미정";

              // ✅ 모달 띄우기
              const modal = new bootstrap.Modal(document.getElementById("orderDetailModal"));
              modal.show();
            })
            .catch(error => {
              console.error("❌ AJAX 오류:", error);
              alert("데이터를 불러오는 중 오류가 발생했습니다.");
            });
  }

  function attachDetailButtonEvent() {
    document.querySelectorAll(".detail-button").forEach(button => {
      button.removeEventListener("click", showOrderDetail);
      button.addEventListener("click", showOrderDetail);
    });
  }

  // ✅ 페이지 로드 후 이벤트 바인딩
  document.addEventListener("DOMContentLoaded", () => {
    attachDetailButtonEvent();
  });

  // ✅ 모달 초기화 함수 수정
  function resetModalData() {
    const fields = [
      "detailOrderId", "detailOrderDate", "detailCustomerName",
      "detailCustomerPhone", "detailCustomerAddress", "detailProductName",
      "detailCategoryName", "detailQuantity", "detailPrice",
      "detailCoupon", "detailTotalPrice", "detailOrderStatusText"
    ];

    fields.forEach(field => {
      document.getElementById(field).innerText = "-"; // ✅ 기본 값 설정
    });
  }
  resetModalData();

  // ✅ 날짜 검색 필터 적용
  document.getElementById("dateSearchBtn").addEventListener("click", function () {
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;

    if (!startDate || !endDate) {
      alert("📅 시작일과 종료일을 모두 선택하세요!");
      return;
    }

    const start = new Date(startDate);
    const end = new Date(endDate);
    end.setHours(23, 59, 59, 999);

    filteredRows = originalRows.filter(row => {
      const orderDateText = row.children[1].textContent.trim();
      const orderDate = new Date(orderDateText);
      return !isNaN(orderDate) && orderDate >= start && orderDate <= end;
    });

    if (filteredRows.length === 0) {
      alert("🔍 검색된 데이터가 없습니다. 전체 목록을 복원합니다.");
      filteredRows = [...originalRows];
    }

    // ✅ 검색 후 첫 페이지부터 다시 표시
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    currentPage = 1;
    updatePagination();
    showPage(currentPage); // ✅ 첫 페이지부터 다시 표시
  });

  // ✅ 전체 검색 기능 개선
  document.getElementById("totalSearch").addEventListener("click", function () {
    const criteria = document.querySelector("#searchCategory").value;
    const keyword = document.querySelector("#searchInput").value.toLowerCase();
    const selectedCategory = document.querySelector("#categorySelect").value.toLowerCase();
    const selectedStatus = document.querySelector("#statusSelect").value;

    filteredRows = originalRows.filter(row => {
      let cellValue = "";
      switch (criteria) {
        case "orderId":
          cellValue = row.children[0].textContent.toLowerCase();
          break;
        case "productName":
          cellValue = row.children[2].textContent.toLowerCase();
          break;
        case "category":
          return selectedCategory === "전체" || row.children[3].textContent.trim() === selectedCategory;
        case "status":
          return selectedStatus === "전체" || row.children[6].textContent.trim() === selectedStatus;
      }
      return cellValue.includes(keyword);
    });

    if (filteredRows.length === 0) {
      alert("🔍 검색된 데이터가 없습니다. 전체 목록을 복원합니다.");
      filteredRows = [...originalRows];
    }

    // ✅ 검색 후 첫 페이지부터 다시 표시
    totalPages = Math.ceil(filteredRows.length / rowsPerPage);
    currentPage = 1;
    updatePagination();
    showPage(currentPage); // ✅ 첫 페이지부터 다시 표시
  });


  // ✅ 검색 카테고리 변경 시 UI 업데이트
  document.getElementById("searchCategory").addEventListener("change", function () {
    const selectedValue = this.value;
    const searchInput = document.getElementById("searchInput");
    const categorySelect = document.getElementById("categorySelect");
    const statusSelect = document.getElementById("statusSelect");

    if (selectedValue === "category") {
      searchInput.style.display = "none";
      categorySelect.style.display = "block";
      statusSelect.style.display = "none";
    } else if (selectedValue === "status") {
      searchInput.style.display = "none";
      categorySelect.style.display = "none";
      statusSelect.style.display = "block";
    } else {
      searchInput.style.display = "block";
      categorySelect.style.display = "none";
      statusSelect.style.display = "none";
    }
  });

</script>
</body>
</html>