<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table id="cart-table" class="table">
    <thead>
        <tr>
            <th>제품 번호</th>
            <th>상품정보</th>
            <th>개별 판매가</th>
            <th>수량</th>
            <th>
                <input type="checkbox" id="cart-all" onclick="toggleAllCheckboxes(this)"/>
            </th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${requestScope.cart_list ne null}">
            <c:forEach var="item" items="${requestScope.cart_list}" varStatus="st">
                <tr data-value="${item.id}">
                    <td class="order-id">${st.index + 1}</td>
                    <td class="product-info">
                        <div class="prod_info">
                            <div class="prod_img">
                                <img src="${item.prod_image}" alt="상품 이미지"/>
                            </div>
                            <div class="prod_details">
                                <div class="prod_brand">${item.brand}</div>
                                <div class="prod_name">${item.p_name}</div>
                                <div class="prod_option">
                                    <div class="prod_option_left">옵션&nbsp;:&nbsp;${item.option_name}</div>
                                    <div class="prod_option_right">
                                        <button type="button" class="btn btn-outline-secondary option-change-btn" onclick="onShowOptionModal(${item.id}, ${item.prod_no})">옵션 변경</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="product-price">
                        <c:set var="total_count" value="0"/>
                        <c:choose>
                            <c:when test="${not empty item.saled_price}">
                                <c:set var="total_count" value="${item.saled_price}"/>
                                <del class="default-price"><fmt:formatNumber value="${item.price * item.count}"/>원</del>
                                <div class="sale-price"><fmt:formatNumber value="${total_count * item.count}"/>원</div>
                            </c:when>
                            <c:otherwise>
                                <c:set var="total_count" value="${item.count}"/>
                                <div class="default-price"><fmt:formatNumber value="${total_count * item.count}"/>원</div>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="cart-count">
                        <button type="button" class="btn btn-secondary btn-minus" onclick="minusCount(this)">-</button>
                        <span class="cart-count-value">${item.count}</span>
                        <button type="button" class="btn btn-secondary btn-plus" onclick="plusCount(this)">+</button>
                    </td>
                    <td>
                        <input type="checkbox" name="chk-cart" class="cart-checkbox" data-item-id="${item.id}" onclick="toggleIndividualCheckbox()"/>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </tbody>
</table>
<div class="cart-notice">
    <div class="cart-notice-left">
        <ol>
            <li>무신사 스토어는 기본적으로 대한민국 내 제주도 및 도서 산간 지역 포함 <strong class="cart-notice-emphasize">전 지역, 전 상품
                무료배송입니다.</strong></li>
            <li>2개 이상의 브랜드를 주문하신 경우, 개별 배송됩니다.</li>
            <li>해외 배송 상품이나 일부 업체의 경우, 교환/환불 시 반송료가 다를 수 있으며 상품 페이지에 별도 표기되어 있습니다.</li>
            <li>장바구니에는 최대 10개의 상품을 보관할 수 있으며, 주문당 한번에 주문 가능한 상품수는 10개로 제한됩니다.</li>
        </ol>
    </div>
    <div class="cart-notice-right">
        <button type="button" class="btn btn-outline-dark delete-all-btn" onclick="deleteAllCart()">전체 삭제</button>
        <button type="button" class="btn btn-outline-dark delete-selected-btn" onclick="deleteCart()">선택 삭제</button>
    </div>
</div>
<div class="cart-button">
    <button type="button" class="btn btn-dark order-btn" onclick="onSendPayment()">주문하기</button>
</div>
