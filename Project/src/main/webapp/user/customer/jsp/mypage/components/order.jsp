<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="order-section">
    <div class="order-header">
        <div class="order-title">주문 목록</div>
    </div>
    <div class="search-bar">
        <label for="order-custom-date-picker">기간 조회</label>
        <div class="date-picker" id="order-custom-date-picker">
            <input type="date" class="form-control" id="order-start-date" name="order-start-date"> ~
            <input type="date" class="form-control" id="order-end-date" name="order-end-date">
        </div>
        <button type="button" class="btn btn-outline-primary search-button" onclick="searchOrder()">검색</button>
    </div>
</div>
<div class="custom-order-container">
    <c:if test="${requestScope.o_list ne null}">
        <c:set var="currentDate" value="" />
        <c:set var="currentOrderCode" value="" />
        <c:set var="lastItem" value="${fn:length(requestScope.o_list) - 1}" />

        <c:forEach var="item" items="${requestScope.o_list}" varStatus="status">
            <c:choose>
                <c:when test="${requestScope.o_list ne null}">
                    <!-- 날짜가 바뀌었을 때 새로운 날짜 블록 생성 -->
                    <c:if test="${currentDate != item.order_date}">
                        <c:set var="currentDate" value="${item.order_date}" />
                        <div class="custom-order-date-group">
                            <h3 class="custom-order-date">${item.order_date}</h3>
                        </div>
                    </c:if>

                    <!-- 주문 코드가 바뀌었을 때 새로운 주문 코드 블록 생성 -->
                    <c:if test="${currentOrderCode != item.order_code}">
                        <c:set var="currentOrderCode" value="${item.order_code}" />
                        <div class="custom-order-code-group">
                            <a href="Controller?type=orderDetails&action=select&order_code=${item.order_code}" class="custom-order-code custom-details-link">주문코드 ${item.order_code}</a>
                            <c:choose>
                                <c:when test="${item.status == '1'}">
                                    <div class="wrap-all-button">
                                        <button type="button" class="btn btn-outline-secondary" id="all-cancel" onclick="location.href='Controller?type=cancelOrder&action=select_all&order_code=${item.order_code}'">전체 구매취소</button>
                                    </div>
                                </c:when>
                                <c:when test="${item.status == '2' || item.status == '3' || item.status == '4'}">
                                    <div class="wrap-all-button">
                                        <button type="button" class="btn btn-outline-secondary" id="all-refund" onclick="location.href='Controller?type=refundRequest&action=select_all&order_code=${item.order_code}'">전체 반품신청</button>
                                    </div>
                                </c:when>
                            </c:choose>
                        </div>
                    </c:if>

                    <!-- 주문 내역 -->
                    <div class="custom-order-block" onclick="location.href='Controller?type=orderDetails&action=select&order_code=${item.order_code}'">
                        <div class="custom-order-header">
                            <c:choose>
                                <c:when test="${item.status == 1}"><span class="custom-order-status">결제 완료</span></c:when>
                                <c:when test="${item.status == 2}"><span class="custom-order-status">배송전</span></c:when>
                                <c:when test="${item.status == 3}"><span class="custom-order-status">배송중</span></c:when>
                                <c:when test="${item.status == 4}"><span class="custom-order-status">배송완료</span></c:when>
                                <c:when test="${item.status == 5}"><span class="custom-order-status">구매확정</span></c:when>
                                <c:when test="${item.status == 6}"><span class="custom-order-status">구매취소</span></c:when>
                                <c:when test="${item.status == 7}"><span class="custom-order-status">반품신청</span></c:when>
                                <c:when test="${item.status == 8}"><span class="custom-order-status">교환신청</span></c:when>
                                <c:when test="${item.status == 9}"><span class="custom-order-status">반품거부</span></c:when>
                                <c:when test="${item.status == 10}"><span class="custom-order-status">교환거부</span></c:when>
                                <c:when test="${item.status == 11}"><span class="custom-order-status">반품완료</span></c:when>
                            </c:choose>
                        </div>
                        <div class="custom-order-content">
                            <div class="custom-product-image">
                                <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지">
                            </div>
                            <div class="custom-product-details">
                                <p class="custom-product-name">${item.brand}</p>
                                <p class="custom-product-description">${item.prod_name}</p>
                                <p class="custom-product-size">${item.option_name} / ${item.count}개</p>
                                <p class="custom-product-price"><fmt:formatNumber value="${item.result_amount}"/>원</p>
                            </div>
                        </div>
                        <c:if test="${item.status == '4'}">
                            <button type="button" class="btn btn-outline-secondary custom-review-button" onclick="confirmPurchase('${item.order_code}')">구매 확정</button>
                        </c:if>
                        <c:if test="${item.status == '5' and item.is_write_review == '0'}">
                            <button type="button" class="btn btn-outline-secondary custom-review-button" onclick="location.href='Controller?type=review&action=write&prod_no=${item.prod_no}&order_code=${item.order_code}'">후기 작성</button>
                        </c:if>
                        <c:if test="${item.status == '6'}">
                            <button type="button" class="btn btn-outline-secondary cancel-details-button" onclick="location.href='Controller?type=cancelDetails&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">취소 상세</button>
                        </c:if>
                        <c:if test="${item.status == '7'}">
                            <button type="button" class="btn btn-outline-secondary refund-details-button" onclick="location.href='Controller?type=refundDetails&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">반품 상세</button>
                        </c:if>
                        <c:if test="${item.status == '8'}">
                            <button type="button" class="btn btn-outline-secondary exchange-details-button" onclick="location.href='Controller?type=exchangeDetails&action=select&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">교환 상세</button>
                        </c:if>
                        <c:if test="${item.status == '9'}">
                            <button type="button" class="btn btn-outline-secondary refund-details-button" onclick="location.href='Controller?type=refundDetails&action=select_reject&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">반품 상세</button>
                        </c:if>
                        <c:if test="${item.status == '10'}">
                            <button type="button" class="btn btn-outline-secondary exchange-details-button" onclick="location.href='Controller?type=exchangeDetails&action=select_reject&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">교환 상세</button>
                        </c:if>
                        <c:if test="${item.status == '11'}">
                            <button type="button" class="btn btn-outline-secondary refund-details-button" onclick="location.href='Controller?type=refundDetails&action=select_complete&order_id=${item.id}&order_code=${item.order_code}&prod_no=${item.prod_no}'">반품 상세</button>
                        </c:if>
                        <c:if test="${item.status != '6' && item.status != '9' && item.status != '11'}">
                            <div class="custom-product-actions">
                                <button type="button" class="btn btn-outline-secondary custom-action-button" onclick="location.href='Controller?type=deliveryStatus&order_code=${item.order_code}&brand=${item.brand}'">배송 조회</button>
                            </div>
                        </c:if>
                    </div>

                </c:when>
                <c:otherwise>
                    <div class="custom-order">
                        <span>주문 내역이 없습니다.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>
</div>
