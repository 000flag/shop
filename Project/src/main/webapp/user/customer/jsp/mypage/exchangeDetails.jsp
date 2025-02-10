<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/exchangeDetails.css"/>
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

                        <c:if test="${requestScope.exchange ne null}">
                        <c:set var="exchange" value="${requestScope.exchange}"/>
                            <div class="wrap-title">
                                <span class="title">교환 상세내역</span>
                            </div>
                            <div class="exchange-details">
                                <%-- 주문 정보 --%>
                                <div class="order-info">
                                    <div class="order-date">${exchange.order_date}</div>
                                    <div class="wrap-order-details">
                                        <div class="order-number">${exchange.order_code}</div>
<%--                                        <div class="order-details-link"><a href="Controller?type=orderDetails">주문 상세</a></div>--%>
                                    </div>
                                </div>
                                <hr/>

                                <%-- 교환 상품 정보 --%>
                                <div class="exchange-product">
                                    <h2>교환 상품</h2>
                                    <c:if test="${exchange.status == '8'}">
                                        <span class="exchange-status">교환신청</span>
                                    </c:if>
                                    <c:if test="${exchange.status == '10'}">
                                        <span class="exchange-status">교환거부</span>
                                    </c:if>
                                    <div class="product-details">
                                        <img src="${fn:split(exchange.prod_image, ',')[0]}" alt="상품 이미지" class="product-image">
                                        <div class="product-info">
                                            <p class="product-brand">${exchange.brand}</p>
                                            <p class="product-name">${exchange.prod_name}</p>
                                            <p class="product-options">${exchange.option_name} / ${exchange.count}개</p>
                                            <p class="product-price"><fmt:formatNumber value="${exchange.result_amount}"/>원</p>
                                        </div>
                                    </div>
                                </div>
                                <hr/>

                                <%-- 교환 신청 정보 --%>
                                <c:if test="${requestScope.delivery ne null}">
                                <c:set var="delivery" value="${requestScope.delivery}"/>
                                    <div class="request-info">
                                        <h2 class="subtitle">교환 신청 정보</h2>
                                        <ul class="info-list">
                                            <li>
                                                <span class="info-label">신청 일시</span>
                                                <span class="info-value">${exchange.exchange_request_date}</span>
                                            </li>
                                            <li>
                                                <span class="info-label">교환 사유</span>
                                                <span class="info-value">${exchange.reason_customer}</span>
                                            </li>
                                            <c:if test="${exchange.status == '10'}">
                                                <li>
                                                    <span class="info-label">거부 사유</span>
                                                    <span class="info-value">${exchange.reason_seller}</span>
                                                </li>
                                            </c:if>
                                            <li>
                                                <span class="info-label">수거 방법</span>
                                                <span class="info-value">${delivery.request}</span>
                                            </li>
                                            <li>
                                                <span class="info-label">교환 회수지</span>
                                                <span class="info-value">
                                                    ${delivery.name} / ${delivery.phone}<br>
                                                    (${delivery.pos_code}) ${delivery.addr1} ${delivery.addr2}
                                                </span>
                                            </li>
                                            <li>
                                                <span class="info-label">교환상품 배송</span>
                                                <span class="info-value">
                                                    ${delivery.name} / ${delivery.phone}<br>
                                                    (${delivery.pos_code}) ${delivery.addr1} ${delivery.addr2}
                                                </span>
                                            </li>
                                            <li>
                                                <c:if test="${requestScope.vo ne null}">
                                                    <c:set var="vo" value="${requestScope.vo}"/>
                                                    <span class="info-label">반송지 주소</span>
                                                    <span class="info-value">
                                                            ${vo.seller_address}
                                                    </span>
                                                </c:if>
                                            </li>
                                        </ul>
                                    </div>
                                </c:if>
                                <p class="notice">* 주문 시 사용한 적립금 및 할인쿠폰은 취소완료 즉시 반환됩니다.</p>

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
