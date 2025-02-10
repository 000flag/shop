<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/deliveryStatus.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <!-- content -->
            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <c:if test="${requestScope.list ne null}">
                            <c:set var="currentBrand" value="${requestScope.list[0].brand}" />
                            <c:set var="deliveryType" value="${requestScope.list[0].delivery_type}" />
                            <div class="wrap-title">
                                <c:choose>
                                    <c:when test="${deliveryType == 'EXCHANGE_REQUESTED' || deliveryType == 'EXCHANGE_IN_PROGRESS'}">
                                        <h3 class="title">교환 배송 조회</h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h3 class="title">배송 조회</h3>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="wrap-content">
                                <!-- 브랜드 헤더 -->
                                <div class="order-group-header">
                                    <h3 class="order-group-title">${requestScope.list[0].order_code}</h3>
                                    <p class="brand-title">${currentBrand}</p>
                                </div>

                                <!-- 배송 상태 -->
                                <div class="delivery-status">
                                    <div class="wrap-date">
                                        <c:choose>
                                            <c:when test="${requestScope.list[0].status == '1'}">
                                                <span class="date-message">결제 완료</span>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '2'}">
                                                <span class="date-message">배송 시작</span>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '3'}">
                                                <span class="date-message">배송 중</span>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '4'}">
                                                <span class="date-message">배송 완료</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="status-bar">
                                        <span class="status active">배송 시작</span>
                                        <span class="status">배송 중</span>
                                        <span class="status">배송 완료</span>
                                    </div>
                                    <div class="progress">
                                        <c:choose>
                                            <c:when test="${requestScope.list[0].status == '1'}">
                                                <div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '2' || requestScope.list[0].status == '8'}">
                                                <div class="progress-bar" role="progressbar" style="width: 33%" aria-valuenow="33" aria-valuemin="33" aria-valuemax="100"></div>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '3'}">
                                                <div class="progress-bar" role="progressbar" style="width: 66%" aria-valuenow="66" aria-valuemin="66" aria-valuemax="100"></div>
                                            </c:when>
                                            <c:when test="${requestScope.list[0].status == '4' || requestScope.list[0].status == '5'}">
                                                <div class="progress-bar" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="100" aria-valuemax="100"></div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- 주문 내역 -->
                                <div class="order-section">
                                    <div class="order-header">
                                        <span class="order-date">${requestScope.list[0].order_date}</span>
                                        <a href="Controller?type=orderDetails&action=select&order_code=${requestScope.list[0].order_code}" class="order-details">주문 상세</a>
                                    </div>
                                    <c:forEach var="item" items="${requestScope.list}">
                                        <div class="product-info">
                                            <img src="${fn:split(item.prod_image, ',')[0]}" alt="Product Image" class="product-image">
                                            <div class="product-details">
                                                <p class="product-brand">${item.brand}</p>
                                                <p class="product-name">${item.prod_name}</p>
                                                <p class="product-option">${item.option_name} / ${item.count}개</p>
                                                <p class="product-price"><fmt:formatNumber value="${item.amount}"/>원</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <c:if test="${requestScope.list[0].status != '1'}">
                                    <!-- 택배 정보 -->
                                    <div class="courier-info">
                                        <div class="wrap-courier">
                                            <p class="courier-title">택배사</p>
                                            <p class="courier-name">${requestScope.list[0].courier}</p>
                                        </div>
                                        <div class="wrap-tracking">
                                            <p class="tracking-title">송장 번호</p>
                                            <div class="tracking-info">
                                                <c:choose>
                                                    <c:when test="${not empty requestScope.list[0].invoice_number}">
                                                        <a href="#" class="tracking-number">${requestScope.list[0].invoice_number}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        4081918387
                                                    </c:otherwise>
                                                </c:choose>
                                                <i class="bi bi-copy"></i>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <p class="delivery-notice">상품이 집하된 후 배송 상태를 조회하실 수 있습니다.</p>
                                <div class="accordion" id="accordionExample">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingOne">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                                일반 배송 상품은 언제 배송되나요?
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="info-container">
                                                    <p class="info-description">
                                                        일반배송은 브랜드마다 일정이 다르고 평일 기준으로 출고 됩니다. 출고일정은 상품의 상세페이지 출고 정보에서 확인가능합니다.
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>평일 기준 출고로 연휴 및 공휴일은 배송일에서 제외됩니다.</li>
                                                        <li>무신사 스토어는 전 상품 100% 무료 배송입니다.</li>
                                                        <li>배송 지역 상품의 경우 상품명에 지역문으로 아이콘이 표시됩니다.</li>
                                                        <li>출고 지연 발생 시에는 알림톡 또는 문자로 통해 안내해 드립니다.</li>
                                                        <li>주문 시 배송 메모에 배송 희망 일자를 작성하셔도 해당일에 지정 배송은 어렵습니다.</li>
                                                    </ul>
                                                    <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=board&action=faq&action=faq'">배송조회 FAQ 바로가기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingTwo">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                배송 완료 상품을 받지 못했어요.
                                            </button>
                                        </h2>
                                        <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="info-container">
                                                    <p class="info-description">
                                                        택배사 배송 완료 이후 상품을 받지 못했거나 분실되었다면 아래 내용을 확인하여 1:1문의로 남겨주세요.
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>상품이 배송 완료 상태인지 확인해주세요.</li>
                                                        <li>상품 주문 시 입력한 수령지 정보를 확인해 주세요.</li>
                                                        <li>위탁 장소(소화전, 경비실 등)에 택배가 보관되어 있는지 확인해주세요.</li>
                                                        <li>택배사로부터 배송 완료 문자 또는 전화를 받았는지 확인해주세요.</li>
                                                        <li>상품이 분실로 확인될 경우 재배송 또는 환불 중 희망하는 처리 방법을 알려주세요.</li>
                                                    </ul>
                                                    <p class="info-description">
                                                        안내 사항
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>택배사 확인은 영업일 기준 1~2일 소요될 수 있습니다</li>
                                                        <li>확인 과정에서 상품 수령할 경우 고객센터 또는 1:1 문의로 전달 바랍니다.</li>
                                                    </ul>
                                                    <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=board&action=faq'">고객센터 FAQ 바로가기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingThree">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                배송 조회는 어떻게 하나요?
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="info-container">
                                                    <p class="info-description">
                                                        안내 사항
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>출고 후 송장 조회까지는 평일 기준 1일 소요됩니다.</li>
                                                        <li>출고 처리 중 (상품 포장 및 확인하는) 단계부터는 주소(옵션) 변경 및 취소가 가능하지 않습니다.</li>
                                                    </ul>
                                                    <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=board&action=faq'">송장 흐름 멈춤 FAQ 바로가기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingFour">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                주문제작 상품은 언제 배송 되나요?
                                            </button>
                                        </h2>
                                        <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="info-container">
                                                    <p class="info-description">
                                                        주문 제작 상품은 평일 기준으로 평균 10일 이내 출고 됩니다.<br/>
                                                        단, 브랜드마다 출고 일정은 다릅니다.
                                                    </p>
                                                    <p class="info-description">
                                                        주문 제작 상품 및 일정 확인 방법
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>상품명 앞에 주문제작이 기재되어 있다면 주문 제작 상품입니다.</li>
                                                        <li>출고 일정 확인 방법: 상품 상세페이지에서 일정을 확인해주세요.</li>
                                                    </ul>
                                                    <p class="info-description">
                                                        안내 사항
                                                    </p>
                                                    <ul class="info-list">
                                                        <li>결제 완료 후 평균 10~15일의 제작 기간이 소요됩니다.</li>
                                                        <li>출고 후에도 실제 도착까지는 기간이 더 소요될 수 있습니다.</li>
                                                        <li>제작 중 주문 정보(옵션) 변경 및 취소가 어렵습니다.</li>
                                                    </ul>
                                                    <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=board&action=faq'">배송조회 FAQ 바로가기</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <script>
                alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
                window.location.href = 'Controller?type=login';
            </script>
        </c:otherwise>
    </c:choose>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
