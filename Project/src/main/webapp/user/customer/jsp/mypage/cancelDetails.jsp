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
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/cancelDetails.css"/>
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
                        <div class="wrap-title">
                            <span class="title">취소 상세내역</span>
                        </div>

                        <c:if test="${requestScope.cancel ne null}">
                        <c:set var="cancel" value="${requestScope.cancel}" />
                        <div class="wrap-content">
                            <div class="cancel-details">
                            <%-- 주문 정보 --%>
                            <div class="order-info">
                                <div class="order-date">${cancel.order_date}</div>
                                <div class="wrap-order-details">
                                    <div class="order-number">${cancel.order_code}</div>
<%--                                    <div class="order-details-link"><a href="Controller?type=orderDetails">주문 상세</a></div>--%>
                                </div>
                            </div>
                            <hr/>

                            <%-- 취소 상품 정보 --%>
                            <div class="cancel-product">
                                <h2>취소 상품</h2>
                                <span class="cancel-status">구매취소</span>
                                <div class="product-details">
                                    <img src="${fn:split(cancel.prod_image, ',')[0]}" alt="상품 이미지" class="product-image">
                                    <div class="product-info">
                                        <p class="product-brand">${cancel.brand}</p>
                                        <p class="product-name">${cancel.prod_name}</p>
                                        <p class="product-options">${cancel.option_name} / ${cancel.count}개</p>
                                        <p class="product-price"><fmt:formatNumber value="${cancel.result_amount}" maxFractionDigits="0" />원</p>
                                    </div>
                                </div>
                            </div><hr/>

                            <%-- 취소 신청 정보 --%>
                            <div class="cancel-info">
                                <h2 class="subtitle">취소 신청 정보</h2>
                                <ul class="info-list">
                                    <li>
                                        <span class="info-label">신청 일시</span>
                                        <span class="info-value">${cancel.cancel_request_date}</span>
                                    </li>
                                    <li>
                                        <span class="info-label">완료 일시</span>
                                        <span class="info-value">${cancel.cancel_request_date}</span>
                                    </li>
                                    <li>
                                        <span class="info-label">취소 사유</span>
                                        <span class="info-value">${cancel.reason_customer}</span>
                                    </li>
                                </ul>
                            </div><hr/>

                                <!-- 환불 요청 내역 -->
                                <div class="refund-request">
                                    <h3 class="subtitle">환불 정보</h3>
                                    <ul class="detail-list">
                                        <li>
                                            <span class="detail-label">상품 결제금액</span>
                                            <span class="detail-value"><fmt:formatNumber value="${cancel.result_amount}" maxFractionDigits="0" />원</span>
                                        </li>
                                        <c:if test="${not empty requestScope.coupon_name}">
                                            <li>
                                                <span class="detail-label">쿠폰 사용</span>
                                                <span class="detail-value">[${requestScope.coupon_name}]  ${requestScope.sale_per}%</span>
                                            </li>
                                        </c:if>
                                        <li>
                                            <span class="detail-label">적립금 사용</span>
                                            <span class="detail-value">-<fmt:formatNumber value="${requestScope.point_amount}" maxFractionDigits="0" />원</span>
                                        </li>
                                        <li>
                                            <span class="detail-label">기본 배송비</span>
                                            <span class="detail-value">무료</span>
                                        </li>
                                    </ul>
                                </div>
                                <hr />

                                <!-- 환불 예정 금액 -->
                                <div class="refund-amount">
                                    <div class="wrap-p">
                                        <h3 class="subtitle">환불 금액</h3>
                                        <p class="refund-expected"><fmt:formatNumber value="${cancel.result_amount}" maxFractionDigits="0" />원</p>
                                    </div>
                                </div>

                            <%-- 안내사항 --%>
                            <div class="notice">* 주문 시 사용한 적립금 및 할인쿠폰은 환불 즉시 반환됩니다.</div>
                        </div>
                        </c:if>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <!-- 재구매 모달 -->
            <div class="modal fade" id="repurchaseModal" tabindex="-1" role="dialog" aria-labelledby="repurchaseModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="repurchaseModalLabel">동일한 옵션/수량으로 재구매 하시겠습니까?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>다른 옵션/수량으로 구매하려면 장바구니에 담은 후 변경해 보세요.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=cart'">장바구니 담기</button>
                            <button type="button" class="btn btn-dark button" onclick="location.href='Controller?type=order&action=order'">구매하기</button>
                        </div>
                    </div>
                </div>
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
