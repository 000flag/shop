<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
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
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/orderDetails.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <%-- header --%>
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <c:if test="${requestScope.o_list ne null}">
                            <input type="hidden" id="orderCode" value="${requestScope.o_list[0].order_code}">
                            <div class="order-details-title">주문 상세 내역</div>
                            <div class="order-header">
                                <p>${requestScope.o_list[0].order_date}</p>
                                <p>주문번호 ${requestScope.o_list[0].order_code}</p>
                            </div>
                            <div class="delivery-info">
                                <div class="info-header">
                                    <input type="hidden" class="deli-no" name="deli-no" value="${o_list[0].deli_no}">
                                    <p class="name">${o_list[0].deli_name}</p>
                                    <c:if test="${requestScope.o_list[0].status == '0' or requestScope.o_list[0].status == '1'}">
                                        <button class="btn btn-outline-secondary btn-sm change-address-button" data-toggle="modal" data-target="#deliveryModal">배송지 변경</button>
                                    </c:if>
                                </div>
                                <p class="phone">${o_list[0].phone}</p>
                                <div class="address-row">
                                    <p class="address">(${o_list[0].pos_code}) ${o_list[0].addr1} ${o_list[0].addr2}</p>
                                    <p class="request">${o_list[0].deli_request}</p>
                                </div>
                            </div>
                            <div class="product-section">
                                <h5>주문 상품 ${requestScope.totalCount}개</h5>
                                <c:forEach var="item" items="${requestScope.o_list}" varStatus="status">
                                    <c:choose>
                                        <c:when test="${item.status == '1'}"><p class="payment-status">결제 완료</p></c:when>
                                        <c:when test="${item.status == '2'}"><p class="payment-status">배송전</p></c:when>
                                        <c:when test="${item.status == '3'}"><p class="payment-status">배송중</p></c:when>
                                        <c:when test="${item.status == '4'}"><p class="payment-status">배송완료</p></c:when>
                                        <c:when test="${item.status == '5'}"><p class="payment-status">구매확정</p></c:when>
                                        <c:when test="${item.status == '6'}"><p class="payment-status">구매취소</p></c:when>
                                        <c:when test="${item.status == '7'}"><p class="payment-status">반품신청</p></c:when>
                                        <c:when test="${item.status == '8'}"><p class="payment-status">교환신청</p></c:when>
                                    </c:choose>
                                    <div class="product-item">
                                        <img src="${item.prod_image}" alt="상품 이미지" class="product-img">
                                        <div class="product-details">
                                            <div class="product-header">
                                                <p class="product-brand"><strong>${item.brand}</strong></p>
                                            </div>
                                            <p class="product-name">${item.prod_name}<br>${item.option_name} / ${item.count}개</p>
                                            <div class="product-price-row">
                                                <p class="product-price">
                                                    <fmt:formatNumber value="${item.result_amount}"/>원
                                                </p>
                                            </div>
                                        </div>
                                        <c:if test="${item.status == '1'}">
                                            <input type="hidden" id="prod-no" class="prod-no" value="${item.prod_no}">
                                            <input type="hidden" id="orderId" value="${item.id}">
                                            <input type="hidden" id="orderCode" value="${item.order_code}">
                                            <input type="hidden" id="inventoryNo" value="">
                                            <button class="btn btn-outline-secondary option-button" data-toggle="modal" data-target="#orderDetails_optionModal" onclick="ShowOptionModal(${item.prod_no})">옵션 변경</button>
                                        </c:if>
                                    </div>
                                    <div class="product-actions">
                                        <c:choose>
                                            <c:when test="${item.status == '1'}">
                                                <button class="btn btn-outline-secondary cancel-button" onclick="location.href='Controller?type=cancelOrder&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">주문 취소</button>
                                            </c:when>
                                            <c:when test="${item.status == '2' or item.status == '3' or item.status == '4'}">
                                                <button class="btn btn-outline-secondary refund-button" onclick="location.href='Controller?type=refundRequest&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">반품 요청</button>
                                                <button class="btn btn-outline-secondary exchange-button" onclick="location.href='Controller?type=exchangeRequest&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">교환 요청</button>
                                            </c:when>
                                            <c:when test="${item.status == '6'}">
                                                <button class="btn btn-outline-secondary cancel-details-button" onclick="location.href='Controller?type=cancelDetails&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">취소 상세</button>
                                            </c:when>
                                            <c:when test="${item.status == '7'}">
                                                <button class="btn btn-outline-secondary refund-details-button" onclick="location.href='Controller?type=refundDetails&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">반품 상세</button>
                                            </c:when>
                                            <c:when test="${item.status == '8'}">
                                                <button class="btn btn-outline-secondary exchange-details-button" onclick="location.href='Controller?type=exchangeDetails&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">교환 상세</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="payment-info">
                                <h5>결제 정보</h5>
                                <ul class="payment-list">
                                    <c:set var="totalPrice" value="${requestScope.totalPrice}" />
                                    <c:set var="totalSaledPrice" value="${requestScope.totalSaledPrice}" />
                                    <c:set var="totalAmount" value="${requestScope.totalAmount}" />
                                    <c:set var="discountAmount" value="${totalPrice - totalSaledPrice}" />
                                    <c:set var="pointAmount" value="${requestScope.point_amount != null ? requestScope.point_amount : 0}" />
                                    <c:set var="usedPointAmount" value="${requestScope.totalUsedPointAmount != null ? requestScope.totalUsedPointAmount : 0}" />

                                    <!-- 화면에 표시 -->
                                    <li><span>상품 금액</span> <span class="item-price"><fmt:formatNumber value="${totalPrice}"/>원</span></li>
                                    <li><span>할인 금액</span> <span class="discount">- <fmt:formatNumber value="${discountAmount}"/>원</span></li><br/>

                                    <c:if test="${requestScope.coupon eq null}">
                                        <h5>쿠폰 할인</h5>
                                        <li><span>총 쿠폰 할인</span><span class="coupon-discount discount">0원</span></li><br/>
                                    </c:if>
                                    <c:if test="${requestScope.coupon ne null}">
                                        <h5>쿠폰 할인</h5>
                                        <c:forEach var="coupon" items="${requestScope.coupon}">
                                            <li>
                                                <span class="coupon_info">${coupon.coupon_name} (${coupon.sale_per}%)</span>
                                                <span>- <fmt:formatNumber value="${couponDiscounts[coupon.coupon_no]}" type="number" maxFractionDigits="0"/>원</span>
                                            </li>
                                        </c:forEach>
                                        <li><span>총 쿠폰 할인</span> <span class="coupon-discount discount">- <fmt:formatNumber value="${requestScope.totalCouponDiscount}" type="number" maxFractionDigits="0" />원</span></li><br/>
                                    </c:if>

                                    <li><span>적립금 사용</span> <span class="points-amount discount">- <fmt:formatNumber value="${pointAmount + usedPointAmount}"/>원</span></li><br/>

                                    <li class="total">
                                        <span class="payment-price">결제 금액</span>
                                        <span class="final-price"><fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/>원</span>
                                    </li>
                                    <li>
                                        <span>결제 수단</span>
                                        <c:choose>
                                            <c:when test="${requestScope.o_list[0].pay_type == '1'}">
                                                <span class="payment-method">계좌이체-[${requestScope.o_list[0].order_bank}]${requestScope.o_list[0].order_account}</span>
                                            </c:when>
                                            <c:when test="${requestScope.o_list[0].pay_type == '2'}">
                                                <span class="payment-method">토스페이</span>
                                            </c:when>
                                            <c:when test="${requestScope.o_list[0].pay_type == '3'}">
                                                <span class="payment-method">카카오페이</span>
                                            </c:when>
                                            <c:when test="${requestScope.o_list[0].pay_type == '4'}">
                                                <span class="payment-method">카드-${requestScope.o_list[0].card_name}</span>
                                            </c:when>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                            <div class="benefits-info">
                                <div class="benefits-header">
                                    <h5>이번 주문으로 받은 혜택</h5>
                                    <span class="svg-icon" data-toggle="modal" data-target="#benefitsModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                        <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z" />
                                    </svg>
                                </span>
                                </div>
                                <ul class="benefits-list">
                                    <!-- 총 할인 금액 계산 -->
                                    <c:set var="totalDiscount" value="${discountAmount + requestScope.totalCouponDiscount + pointAmount + usedPointAmount}" />

                                    <!-- 받은 총 혜택 계산 -->
                                    <c:set var="gradeBenefit" value="${totalAmount * (requestScope.grade.point_condition / 100)}" />
                                    <c:set var="totalBenefits" value="${totalDiscount + gradeBenefit}" />
                                    <li><span>총 할인 금액</span> <span><fmt:formatNumber value="${totalDiscount}" type="number" maxFractionDigits="0"/>원</span></li>
                                    <li><span>[${requestScope.grade.name}] ${requestScope.grade.point_condition}% 적립</span> <fmt:formatNumber value="${gradeBenefit}" type="number" maxFractionDigits="0"/>원</span></li>
                                    <li><span>배송비</span> <span>무료</span></li>
                                    <li class="total-benefits"><span class="result-benefits">받은 총 혜택</span> <span><fmt:formatNumber value="${totalBenefits}" type="number" maxFractionDigits="0"/>원</span></li>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>

                <%-- footer --%>
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

    <%-- 혜택 안내 모달 --%>
    <div class="modal fade" id="benefitsModal" tabindex="-1" role="dialog" aria-labelledby="benefitsModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="benefitsModalTitle">이번 주문으로 받은 혜택 안내</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul>
                        <li>이번 주문으로 회원님이 받게 될 총 혜택 금액입니다.</li>
                        <li>혜택 금액은 상품 및 쿠폰 할인 등 할인금액, 보유 적립금 및 선할인 사용액, 그리고 해당 주문으로 받을 수 있는 최대 적립금액의 총합입니다.</li>
                    </ul>
                    <br/>
                    <h5>등급 적립</h5>
                    <ul>
                        <li>상품 구매 시 지급되는 등급별 적립금의 총합으로, 선할인 미적용 시 적립됩니다.</li>
                        <li>일부 적립 불가한 상품이 있을 수 있습니다.</li>
                    </ul>
                    <br/>
                    <h5>구매 추가 적립</h5>
                    <ul>
                        <li>상품 구매 시 등급 적립 외 추가적으로 지급되는 적립금입니다.</li>
                        <li>일부 적립 불가한 상품이 있을 수 있습니다.</li>
                    </ul>
                    <br/>
                    <h5>후기 적립</h5>
                    <ul>
                        <li>작성 가능한 모든 후기 작성 시 지급되는 적립금의 총합입니다.</li>
                        <li>상품에 따라 적립 금액은 상이할 수 있습니다.</li>
                    </ul>
                    <br/>
                    <h5>후기 추가 적립</h5>
                    <ul>
                        <li>일부 상품 선착순 구매 시 추가 지급되는 후기 적립금의 총합입니다.</li>
                        <li>후기 추가 적립 대상자는 구매 선착순으로 선정됩니다.(가상계좌 결제의 경우, 입금 완료 기준)<br/>
                            후기 추가 적립대상 여부는 결제완료 후 최대 1시간 정도 소요될 수 있습니다.</li>
                    </ul>
                </div>
            </div>
        </div>
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
                                    <p class="address-detail">${deli.addr1} ${deli.addr2}<br>${deli.phone}</p>
                                </label>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-dark confirm-btn" onclick="updateDeliveryAddress()">변경하기</button>
                </div>
            </div>
        </div>
    </div>

    <%-- 옵션 변경 modal --%>
    <div class="modal fade" id="orderDetails_optionModal" tabindex="-1" role="dialog" aria-labelledby="orderDetails_optionModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">사이즈 변경</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <select class="form-select size-select" id="orderDetails-size-options">
                        <!-- 동적으로 사이즈 정보 조회 -->
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="ChangeProdSize()">변경</button>
                </div>
            </div>
        </div>
    </div>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/mypage/orderDetails.js"></script>

</body>
</html>
