<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/orderDelivery.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <%-- header --%>
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <!-- content -->
            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="order-container">
                            <div class="order-status">
                                <h2 class="order-title">진행 중 주문 현황</h2>

                                <c:if test="${requestScope.list eq null}">
                                    <div class="order-item">
                                        <span>현재 진행 중인 주문 현황이 없습니다.</span>
                                    </div>
                                </c:if>

                                <c:if test="${requestScope.list ne null}">
                                    <!-- 현재 주문 코드 추적 변수 -->
                                    <c:set var="currentOrderCode" value="" />

                                    <!-- 주문 목록 반복 -->
                                    <c:forEach var="item" items="${requestScope.list}" varStatus="itemLoop">
                                        <!-- 주문 코드가 바뀌었을 때 새로운 블록 생성 -->
                                        <c:if test="${currentOrderCode != item.order_code}">
                                            <c:set var="currentOrderCode" value="${item.order_code}" />

                                            <!-- 주문 코드별 헤더 -->
                                            <div class="order-group-header">
                                                <h3 class="order-group-title">${currentOrderCode}</h3>
                                            </div>

                                            <!-- 새로운 주문 코드 그룹 시작 -->
                                            <div class="wrap-order-item">
                                        </c:if>

                                        <!-- 주문 상품 출력 -->
                                        <div class="order-item" onclick="location.href='Controller?type=deliveryStatus&order_code=${item.order_code}&brand=${item.brand}'">
                                            <img src="${fn:split(item.prod_image, ',')[0]}" alt="Product Image" class="product-image">
                                            <div class="order-details">
                                                <c:choose>
                                                    <c:when test="${item.delivery_type == 'EXCHANGE_REQUESTED'}">
                                                        <div class="payment-status">교환 신청</div>
                                                    </c:when>
                                                    <c:when test="${item.delivery_type == 'EXCHANGE_IN_PROGRESS'}">
                                                        <div class="payment-status">교환 배송 중</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${item.status == '1'}">
                                                                <div class="payment-status">결제완료</div>
                                                            </c:when>
                                                            <c:when test="${item.status == '2'}">
                                                                <div class="payment-status">배송전</div>
                                                            </c:when>
                                                            <c:when test="${item.status == '3'}">
                                                                <div class="payment-status">배송중</div>
                                                            </c:when>
                                                            <c:when test="${item.status == '4'}">
                                                                <div class="payment-status">배송완료</div>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="product-name">${item.brand}</div>
                                                <div class="product-description">
                                                        ${item.prod_name}<br>${item.option_name} / ${item.count}개
                                                </div>
                                            </div>
                                        </div>

                                        <!-- 마지막 상품 또는 다음 주문 코드가 변경되었을 때 wrap-order-item 닫기 -->
                                        <c:if test="${itemLoop.last || (itemLoop.index + 1) < fn:length(requestScope.list) && requestScope.list[itemLoop.index + 1].order_code != item.order_code}">
                                            </div> <!-- wrap-order-item 닫기 -->
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </div>

                <%-- footer --%>
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>
        </c:when>
    </c:choose>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
