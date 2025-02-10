<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${requestScope.o_list ne null}">
    <input type="hidden" id="orderCode" value="${requestScope.o_list[0].order_code}">
    <div class="order-details-title">주문 상세 내역</div>
    <div class="delivery-info">
        <div class="info-header">
            <input type="hidden" class="deli-no" name="deli-no" value="${o_list[0].deli_no}">
            <p class="name">${o_list[0].deli_name}</p>
            <c:if test="${requestScope.o_list[0].status eq '0' or requestScope.o_list[0].status eq '1'}">
                <button class="btn btn-outline-secondary btn-sm change-address-button" data-toggle="modal" data-target="#completedDeliveryModal">배송지 변경</button>
            </c:if>
        </div>
        <p class="phone">${o_list[0].phone}</p>
        <div class="address-row">
            <p class="address">${o_list[0].pos_code} ${o_list[0].addr1} ${o_list[0].addr2}</p>
            <p class="request">${o_list[0].deli_request}</p>
        </div>
    </div>
    <div class="payment-info">
        <h5>결제 정보</h5>
        <ul class="payment-list">
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

            <div class="accordion" id="accordionExample">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                            <h5>총 결제 금액</h5>
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="accordion-body">
                                <c:set var="totalPrice" value="${requestScope.totalPrice}"/>
                                <c:set var="discountAmount" value="0"/>
                                <c:set var="pointAmount" value="${requestScope.point_amount}"/>
                                <c:set var="couponSalePer" value="${requestScope.coupon.sale_per}"/>
                                <c:set var="priceAfterDiscount" value="${totalPrice - totalAmount}"/>

                                <c:forEach var="item" items="${requestScope.o_list}" varStatus="status">
                                    <c:set var="discountAmount" value="${discountAmount + (item.prod_price - item.prod_saled_price)}"/>
                                </c:forEach>

                                <li>
                                    <span>상품 금액</span> <span class="item-price"><fmt:formatNumber value="${totalPrice}"/>원</span>
                                </li>
                                <li>
                                    <span>할인 금액</span> <span class="discount">- <fmt:formatNumber value="${discountAmount}"/>원</span>
                                </li>
                                <c:if test="${requestScope.discountList ne null}">
                                    <c:forEach var="discount" items="${requestScope.discountList}">
                                        <li>
                                            <span class="coupon_info">
                                                ${discount.coupon_name} (${discount.sale_per}%)
                                            </span>
                                            <span>
                                                - <fmt:formatNumber value="${discount.individualDiscount}" type="number" maxFractionDigits="0"/> 원
                                            </span>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <li>
                                    <span>보유 적립금 사용</span> <span class="points-amount discount">- <fmt:formatNumber value="${pointAmount}"/>원</span>
                                </li>
                                <li>
                                    <span>배송비 </span> <span class="text-blue">배송비 무료</span>
                                </li>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <li class="total">
                <span class="payment-price">결제 금액</span> <span class="final-price"><fmt:formatNumber value="${requestScope.totalAmount}" type="number" maxFractionDigits="0"/>원</span>
            </li>
        </ul>
    </div>
    <div class="benefits-info">
        <div class="benefits-header">
            <h5>이번 주문으로 받은 혜택</h5>
            <span class="svg-icon" data-toggle="modal" data-target="#benefitsModal">
                <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor"
                     class="bi bi-exclamation-circle" viewBox="0 0 16 16">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                    <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0M7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0z"/>
                </svg>
            </span>
        </div>
        <ul class="benefits-list">
            <!-- 총 할인 금액 계산 -->
            <c:set var="totalDiscount" value="${priceAfterDiscount}"/>

            <!-- 받은 총 혜택 계산 -->
            <c:set var="gradeBenefit" value="${totalAmount * (requestScope.grade.point_condition / 100)}"/>
            <c:set var="totalBenefits" value="${totalDiscount + gradeBenefit}"/>
            <li><span>총 할인 금액</span> <span><fmt:formatNumber value="${totalDiscount}" type="number" maxFractionDigits="0"/>원</span></li>
            <li><span>${requestScope.grade.name} ${requestScope.grade.point_condition}% 적립</span> <fmt:formatNumber value="${gradeBenefit}" type="number" maxFractionDigits="0"/>원</span></li>
            <li><span>배송비</span> <span>무료</span></li>
            <li class="total-benefits"><span class="result-benefits">받은 총 혜택</span> <span><fmt:formatNumber value="${totalBenefits}" type="number" maxFractionDigits="0"/>원</span></li>
        </ul>
    </div>
    <div class="product-section">
        <h5>주문 상품 ${fn:length(o_list)}개</h5>
        <c:forEach var="item" items="${requestScope.o_list}" varStatus="status">
            <div class="product-item">
                <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" class="product-img">
                <div class="product-details">
                    <div class="product-header">
                        <p class="product-brand"><strong>${item.brand}</strong></p>
                    </div>
                    <p class="product-name">${item.prod_name}<br>${item.option_name} / ${item.count}개</p>
                    <div class="product-price-row">
                        <p class="product-price">
                            <fmt:formatNumber value="${item.amount}"/>원
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="product-actions">
            <button class="btn btn-outline-secondary" onclick="location.href='Controller?type=orderDetails&action=select&order_code=${requestScope.order_code}'">
                주문 상세
            </button>
            <button class="btn btn-dark" onclick="location.href='Controller'">
                계속 쇼핑하기
            </button>
        </div>
    </div>
</c:if>

<%-- 배송지 변경 모달 --%>
<div class="modal fade" id="completedDeliveryModal" tabindex="-1" role="dialog" aria-labelledby="completedDeliveryModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completedDeliveryModalTitle">배송지 정보 <span class="change-delivery-notice">*배송지 추가 및 수정은 마이페이지에서 가능합니다.</span></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <c:if test="${requestScope.deli_list ne null}">
                    <c:forEach var="deli" items="${requestScope.deli_list}" varStatus="status">
                        <div class="address-item">
                            <input type="radio" id="address${status.index}" name="deliveryAddress" value="${deli.id}" ${o_list[0].deli_no == deli.id ? 'checked' : ''}>
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
                <button class="btn btn-dark confirm-btn" onclick="updateDeliAddr()">변경하기</button>
            </div>
        </div>
    </div>
</div>