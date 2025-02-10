<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/payment/payment.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <%-- header --%>
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="text-title">
                            <h3>주문서</h3>
                        </div>
                        <div class="delivery-info-container">
                            <c:if test="${not empty requestScope.delivery}">
                                <c:set var="dvo" value="${requestScope.delivery}"/>
                                <div class="header" data-value="${dvo.id}">
                                    <h3>${dvo.name} <span class="badge">기본 배송지</span></h3>
                                    <button class="btn btn-outline-secondary btn-sm change-address-btn" data-toggle="modal" data-target="#deliveryModal">배송지 변경</button>
                                </div>
                                <p class="address">${dvo.addr1} ${dvo.addr2}</p>
                                <p class="phone">${dvo.phone}</p>
                                <p class="" id="request-delivery">${dvo.request}</p>
                            </c:if>
                        </div>
                        <div class="order-product-container">
                            <c:if test="${not empty sessionScope.cartItems}">
                                <h3>주문 상품 <fmt:formatNumber value="${fn:length(sessionScope.cartItems)}"/>개</h3>
                                <c:set var="original_amount" value="0"/>
                                <c:set var="sale_amount" value="0"/>
                                <c:set var="sale_percent" value="0"/>
                                <c:set var="total_amount" value="0"/>
                                <c:forEach var="item" items="${sessionScope.cartItems}">
                                    <c:set var="original_amount" value="${original_amount + (item.price * item.count)}"/>
                                    <div class="product-info" data-cart-no="${item.id}" data-prod-no="${item.prod_no}" data-inventory-no="${item.inventory_no}">
                                        <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" class="product-image"/>
                                        <div class="product-details">
                                            <p class="product-brand">${item.brand}</p>
                                            <p class="product-name" id="product-name">${item.p_name}</p>
                                            <p class="product-size">${item.option_name} / <span id="product-count">${item.count}</span>개</p>
                                            <p class="product-price">
                                                <c:choose>
                                                    <c:when test="${not empty item.saled_price}">
                                                        <p class="original-price"><fmt:formatNumber value="${item.price * item.count}"/>원</p>
                                                        <c:if test="${not empty item.sale}">
                                                            <span class="sale-percent">${item.sale}%</span>
                                                            <c:set var="sale_percent" value="${sale_percent + item.sale}"/>
                                                        </c:if>
                                                        <span class="discounted-price"><fmt:formatNumber value="${item.saled_price * item.count}"/>원</span>
                                                        <!-- 할인 가격이 있을 경우 누적 -->
                                                        <c:set var="total_amount" value="${total_amount + (item.saled_price * item.count)}"/>
                                                        <c:set var="sale_amount" value="${sale_amount + ((item.price * item.count) - (item.saled_price * item.count))}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="original-price"><fmt:formatNumber value="${item.price * item.count}"/>원</span>
                                                        <!-- 할인 가격이 없을 경우 원래 가격 누적 -->
                                                        <c:set var="total_amount" value="${total_amount + (item.price * item.count)}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <input type="hidden" class="prod_point" data-points="points" value="${total_amount * (sessionScope.customer_info.point_condition / 100)}"/>
                                            </p>
                                        </div>
                                        <button type="button" class="btn btn-outline-secondary coupon-btn" onclick="onShowCouponModal(${item.id}, ${item.prod_no})">쿠폰 사용</button>
                                        <button type="button" class="btn btn-outline-danger cancel-coupon-btn" onclick="cancelCoupon(${item.id})">사용 취소</button>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="points-container">
                            <div class="points-left">
                                <h3>보유 적립금 사용</h3>
                                <span class="svg-icon" data-toggle="modal" data-target="#pointsModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                        <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                                    </svg>
                                </span>
                            </div>
                            <div class="points-input">
                                <input type="text" id="point-input" oninput="formatCurrency()" placeholder="사용할 적립금을 입력하세요"/>
                                <button type="button" class="btn btn-outline-secondary apply-btn" onclick="applyPoint()">사용</button>
                                <button type="button" class="btn btn-outline-secondary cancel-btn" onclick="resetPoint()">사용 취소</button>
                            </div>
                            <p class="points-info">적용한도(7%) <span class="max-points" id="max-points"><fmt:formatNumber value="${total_amount * 0.07}"/></span>원 / 보유 <span class="save-points" id="save-points"><fmt:formatNumber value="${requestScope.points}"/></span>원</p>
                        </div>
                        <div class="reward-container">
                            <div class="reward-top">
                                <h3>구매 적립/선할인</h3>
                                <span class="svg-icon" data-toggle="modal" data-target="#rewardModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                        <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                                    </svg>
                                </span>
                            </div>
                            <div class="reward-options">
                                <div class="reward-item">
                                    <label>
                                        <input type="radio" name="reward" value="earn" onclick="toggleRewardDisplay(this)" checked> 구매 적립
                                    </label>
                                    <span id="reward-earn" class="text-blue">
                                        <fmt:formatNumber value="${total_amount * (sessionScope.customer_info.point_condition / 100)}"/>원 적립
                                    </span>
                                </div>
                                <div class="reward-item">
                                    <label>
                                        <input type="radio" name="reward" value="discount" onclick="toggleRewardDisplay(this)" data-value="${sessionScope.customer_info.point_condition}"> 적립금 선할인
                                    </label>
                                    <span id="reward-discount" class="text-blue" style="display:none;">
                                        - <fmt:formatNumber value="${total_amount * (sessionScope.customer_info.point_condition / 100)}"/>원
                                    </span>
                                </div>
                            </div>
                        </div>
<%--                        <div class="payment-methods-container">--%>
<%--                            <h3>결제 수단</h3>--%>
<%--                            <div class="radio-group">--%>
<%--                                <label>--%>
<%--                                    <input type="radio" name="payment-method" id="tosspay-radio">--%>
<%--                                    <img class="logo-finance" src="./user/images/logo-finance-toss.png"/>토스페이--%>
<%--                                </label>--%>
<%--                                <label>--%>
<%--                                    <input type="radio" name="payment-method" id="kakaopay-radio">--%>
<%--                                    <img class="logo-finance" src="./user/images/logo-finance-kakaopay.png"/>카카오페이--%>
<%--                                </label>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class="payment-details-container">
                            <h3>결제 금액</h3>
                            <ul>
                                <li>
                                    <span>상품 금액</span>
                                    <span id="total-ori-amount"><fmt:formatNumber value="${original_amount}"/>원</span>
                                </li>
                                <li>
                                    <span>할인 금액</span>
                                    <span class="text-blue" id="total-saled-amount">- <fmt:formatNumber value="${sale_amount}"/>원</span>
                                </li>
                                <li>
                                    <span>적립금 사용</span>
                                    <span class="text-blue" id="used-point">- 0원</span>
                                </li>
                                <li>
                                    <span>배송비</span>
                                    <span>무료</span>
                                </li>
                                <li class="total">
                                    <span>총 결제 금액</span>
                                    <span class="text-red">${sale_percent}% <span class="text-red" id="total-payment-amount"><fmt:formatNumber value="${total_amount}"/></span>원</span>
                                </li>
                            </ul>
                        </div>
                        <div class="reward-benefits-container">
                            <div class="reward-benefits-top">
                                <h3>적립 혜택</h3>
                                <span class="svg-icon" data-toggle="modal" data-target="#rewardBenefitsModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                        <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                                    </svg>
                                </span>
                            </div>
                            <ul>
                                <c:if test="${not empty sessionScope.customer_info}">
                                    <li>
                                        <span>${sessionScope.customer_info.grade_name} · ${sessionScope.customer_info.point_condition}% 적립</span>
                                        <span id="total-save-point"></span>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                        <div class="order-benefits-container">
                            <div class="order-benefits-top">
                                <div class="benefits-left">
                                    <h5>이번 주문으로 받을 혜택</h5>
                                    <span class="svg-icon" data-toggle="modal" data-target="#benefitsModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                    <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                                </svg>
                            </span>
                                </div>
                                <div class="benefits-right">
                                    <span class="text-blue total-benefit" id="total_amount"><fmt:formatNumber value="${total_amount}"/>원</span>
                                </div>
                            </div>
                            <div class="order-benefits-bottom">
                                <p class="small-text">주문 내용을 확인했으며 결제에 동의합니다.</p>
                                <p class="small-text">회원님의 개인정보는 안전하게 관리됩니다.</p>
                                <p class="small-text">무신사는 통신판매중개자로, 업체 배송 상품의 상품/상품정보/거래 등에 대한 책임은 무신사가 아닌 판매자에게 있습니다.</p>
                            </div>
                        </div>
                        <div class="payment-button-container">
                            <button type="button" class="btn btn-dark" onclick="onPayment()"><span id="total-payment"><fmt:formatNumber value="${total_amount}"/></span>원 결제하기</button>
                        </div>
                    </div>
                </div>

                <%-- footer --%>
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <%-- 배송지 변경 모달 --%>
            <div class="modal fade" id="deliveryModal" tabindex="-1" role="dialog" aria-labelledby="deliveryModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deliveryModalTitle">배송지 정보 <span class="change-delivery-notice">*배송지 추가 및 수정은 마이페이지에서 가능합니다.</span></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <c:if test="${requestScope.deli_list ne null}">
                                <c:forEach var="deli" items="${requestScope.deli_list}" varStatus="status">
                                    <div class="address-item">
                                        <input type="radio" id="address${status.index}" name="deliveryAddress" value="${deli.id}" ${status.index == 0 ? 'checked' : ''}>
                                        <label for="address${status.index}">
                                            <span class="address-name">${deli.name}</span>
                                            <c:if test="${deli.is_default == '1'}">
                                                <span class="default-label">기본 배송지</span>
                                            </c:if>
                                            <p class="address-detail">${deli.addr1} ${deli.addr2}</p>
                                            <p class="deli-phone">${deli.phone}</p>
                                        </label>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-dark confirm-btn" onclick="updateDeliveryAddr()">변경하기</button>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 쿠폰 모달 --%>
            <div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="couponModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">쿠폰 사용</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="onHideCouponModal()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="coupon-list" id="coupon-list">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-dark btn-block" onclick="onApplyCoupon()">적용하기</button>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 보유 적립금 모달 --%>
            <div class="modal fade" id="pointsModal" tabindex="-1" role="dialog" aria-labelledby="pointsModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="pointsModalTitle">보유 적립금</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div>
                                <ul>
                                    <li>적립금은 회원 등급별 적립금 적용 한도 이내로 사용할 수 있습니다.</li>
                                    <li>회원 등급별 적립금 적용 한도는 상품의 판매 가격을 기준으로 산정됩니다.</li>
                                </ul>
                                <div>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>등급</th>
                                                <th>적용 한도</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>전체</th>
                                                <td>판매가 기준 7%</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <ul>
                                    <li>일부 상품은 적립금을 사용할 수 없습니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 선결제 모달 --%>
            <div class="modal fade" id="rewardModal" tabindex="-1" role="dialog" aria-labelledby="rewardModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="rewardModalTitle">구매 적립/선할인 안내</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul>
                                <li>등급 적립과 선할인 중 1개의 혜택을 선택할 수 있습니다.</li>
                                <li>등급 적립은 상품을 구매할 때 지급되는 적립금으로 등급별로 적립률이 다릅니다.</li>
                                <li>선할인은 구매 후 지급받을 적립금을 구매 전에 미리 사용할 수 있는 기능으로, 선할인 선택 시 등급별 선할인율만큼 할인됩니다.</li>
                            </ul>
                            <div>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>등급</th>
                                            <th>선할인율</th>
                                            <th>적립률</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty requestScope.grades}">
                                            <c:forEach var="item" items="${requestScope.grades}">
                                                <tr>
                                                    <th>${item.name}</th>
                                                    <td>${item.sale_condition}%</td>
                                                    <td>${item.point_condition}%</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <ul>
                                <li>일부 상품은 등급 적립과 선할인 혜택을 받을 수 없습니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 적립 혜택 안내 모달 --%>
            <div class="modal fade" id="rewardBenefitsModal" tabindex="-1" role="dialog" aria-labelledby="rewardBenefitsModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="rewardBenefitsModalTitle">적립 혜택 안내</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="reward-section grade-reward">
                                <div class="reward-title">등급 적립</div>
                                <ul class="reward-list">
                                    <li>상품 구매 시 지급되는 등급별 적립금의 총합으로, 선할인 미적용 시 적립됩니다.</li>
                                    <li>일부 적립 불가한 상품이 있을 수 있습니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- 혜택 안내 모달 --%>
            <div class="modal fade" id="benefitsModal" tabindex="-1" role="dialog" aria-labelledby="benefitsModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="benefitsModalTitle">이번 주문으로 받을 혜택 안내</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul>
                                <li>이번 주문으로 회원님이 받게 될 총 혜택 금액입니다.</li>
                                <li>혜택 금액은 상품 및 쿠폰 할인 등 할인금액, 보유 적립금 및 선할인 사용액, 그리고 해당 주문으로 받을 수 있는 최대 적립금액의 총합입니다.</li>
                            </ul>
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

    <%-- Toss --%>
    <script src="https://js.tosspayments.com/v1/payment-widget"></script>

    <script src="./user/customer/js/payment/payment.js"></script>
</body>
</html>
