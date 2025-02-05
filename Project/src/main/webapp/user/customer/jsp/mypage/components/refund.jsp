<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="refund-section">
    <div class="refund-header">
        <span class="refund-title">취소/반품/교환</span>
    </div>
</div>
<div class="refund-tabs">
    <ul class="nav nav-tabs" id="refund-nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#" data-target="#list-all" onclick="selectRefundTab('all')">전체</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-target="#list-cancelRefund" onclick="selectRefundTab('cancelRefund')">취소/반품</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-target="#list-exchange" onclick="selectRefundTab('exchange')">교환</a>
        </li>
    </ul>
</div>
<div id="refund-list">
    <%-- 전체 조회 --%>
    <div id="list-all" class="list">
        <div class="wrap-refund-list">
            <c:if test="${requestScope.all eq null or requestScope.cancelRefund eq null or requestScope.exchange eq null}">
                <div class="refund-summary">
                    <span>조회 내역이 없습니다.</span>
                </div>
            </c:if>
            <c:if test="${requestScope.all ne null}">
                <c:forEach var="all" items="${requestScope.all}" varStatus="status">
                    <div class="refund-summary">
                        <div class="refund-header">
                            <div class="refund-date">${all.order_date}</div>
                            <div class="refund-details-link">
                                <a href="Controller?type=orderDetails&action=select&order_code=${all.order_code}">주문 상세</a>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${all.status == '6'}">
                                <div class="refund-status">취소</div>
                            </c:when>
                            <c:when test="${all.status == '7'}">
                                <div class="refund-status">반품</div>
                            </c:when>
                            <c:when test="${all.status == '8'}">
                                <div class="refund-status">교환</div>
                            </c:when>
                        </c:choose>
                        <div class="order-product">
                            <img src="${fn:split(all.prod_image, ',')[0]}" alt="상품 이미지" class="product-img">
                            <div class="product-info">
                                <p class="product-brand">${all.brand}</p>
                                <p class="product-name">${all.prod_name}</p>
                                <p class="product-options">${all.option_name} / ${all.count}개</p>
                                <p class="product-price"><fmt:formatNumber value="${all.amount}"/>원</p>
                            </div>
                        </div>
                        <div class="wrap-buttons">
                            <c:if test="${all.status == '6'}">
                                <button type="button" class="btn btn-outline-secondary" onclick="location.href='Controller?type=cancelDetails&action=select&order_code=${all.order_code}&prod_no=${all.prod_no}'">취소 상세</button>
                            </c:if>
                            <c:if test="${all.status == '7'}">
                                <button type="button" class="btn btn-outline-secondary" onclick="location.href='Controller?type=refundDetails&action=select&order_code=${all.order_code}&prod_no=${all.prod_no}'">반품 상세</button>
                                <button class="btn btn-outline-secondary delivery-status-button" onclick="location.href='Controller?type=deliveryStatus'">반품 배송 조회</button>
                                <button class="btn btn-outline-secondary delivery-status-button" onclick="location.href='Controller?type=deliveryStatus'">회수 배송 조회</button>
                            </c:if>
                            <c:if test="${all.status == '8'}">
                                <button type="button" class="btn btn-outline-secondary" onclick="location.href='Controller?type=cancelDetails&action=select&order_code=${all.order_code}&prod_no=${all.prod_no}'">교환 상세</button>
                                <button class="btn btn-outline-secondary delivery-status-button" onclick="location.href='Controller?type=deliveryStatus'">교환 배송 조회</button>
                                <button class="btn btn-outline-secondary delivery-status-button" onclick="location.href='Controller?type=deliveryStatus'">회수 배송 조회</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <%-- 반품/취소 조회 --%>
    <div id="list-cancelRefund" class="list" style="display: none;">
        <div class="wrap-refund-list">
            <c:forEach var="cancelRefund" items="${requestScope.cancelRefund}" varStatus="status">
                <div class="refund-summary">
                    <div class="refund-header">
                        <div class="refund-date">${cancelRefund.order_date}</div>
                        <div class="refund-details-link"><a href="Controller?type=orderDetails&action=select&order_code=${cancelRefund.order_code}">주문 상세</a></div>
                    </div>
                    <c:if test="${cancelRefund.status == '6'}">
                        <div class="refund-status">취소</div>
                    </c:if>
                    <c:if test="${cancelRefund.status == '7'}">
                        <div class="refund-status">반품</div>
                    </c:if>
                    <div class="order-product">
                        <div class="product-image"></div>
                        <div class="product-info">
                            <p class="product-brand">${cancelRefund.brand}</p>
                            <p class="product-name">${cancelRefund.prod_name}</p>
                            <p class="product-options">${cancelRefund.option_name} / ${cancelRefund.count}개</p>
                            <p class="product-price"><fmt:formatNumber value="${cancelRefund.amount}"/>원</p>
                        </div>
                    </div>
                    <div class="wrap-buttons">
                        <button type="button" class="btn btn-outline-secondary" onclick="location.href='Controller?type=refundDetails&action=select&order_code=${cancelRefund.order_code}&prod_no=${cancelRefund.prod_no}'">반품 상세</button>
                        <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#repurchaseModal">재구매</button>
                        <button type="button" class="btn btn-outline-secondary">회수 배송 조회</button>
                    </div>
                </div><hr/>
            </c:forEach>
        </div>
    </div>

    <%-- 교환 조회 --%>
    <div id="list-exchange" class="list" style="display: none;">
        <div class="wrap-refund-list">

            <c:forEach var="exchange" items="${requestScope.exchange}" varStatus="status">
                <div class="exchange-summary">
                    <div class="exchange-header">
                        <div class="exchange-date">${exchange.order_date}</div>
                        <div class="exchange-details-link">
                            <a href="Controller?type=orderDetails&action=select&order_code=${exchange.order_code}">주문 상세</a>
                        </div>
                    </div>
                    <div class="exchange-status">교환</div>
                    <div class="order-product">
                        <div class="product-image"></div>
                        <div class="product-info">
                            <p class="product-brand">${exchange.brand}</p>
                            <p class="product-name">${exchange.prod_name}</p>
                            <p class="product-options">${exchange.option_name} / ${exchange.count}개</p>
                            <p class="product-price"><fmt:formatNumber value="${exchange.amount}"/>원</p>
                        </div>
                    </div>
                    <div class="wrap-buttons">
                        <button type="button" class="btn btn-outline-secondary" onclick="location.href='Controller?type=exchangeDetails&action=select&order_code=${exchange.order_code}&prod_no=${exchange.prod_no}'">교환 상세</button>
                        <button type="button" class="btn btn-outline-secondary">교환 배송 조회</button>
                        <button type="button" class="btn btn-outline-secondary">회수 배송 조회</button>
                    </div>
                </div><hr/>
            </c:forEach>
        </div>
    </div>
</div>