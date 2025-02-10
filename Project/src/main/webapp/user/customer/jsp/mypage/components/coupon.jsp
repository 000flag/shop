<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="coupon-section">
    <div class="coupon-header">
        <span class="coupon-title">쿠폰 목록</span>
    </div>
</div>
<div class="coupon-search">
    <input type="text" class="form-control search-input" id="coupon-search-input" placeholder="브랜드, 쿠폰명으로 검색해보세요." onkeydown="onKeydownCoupon(event)">
</div>
<div class="coupon-controls">
    <c:if test="${not empty requestScope.coupon_count}">
        <div class="coupon-count">전체 <fmt:formatNumber value="${requestScope.coupon_count}"/>개</div>
    </c:if>
    <div class="coupon-sort">
        <select class="form-select sort-select" id="coupon-select" onchange="onChangeCouponSort()">
            <option value="0">:: 선택하세요 ::</option>
            <option value="1">할인순</option>
            <option value="2">만료순</option>
        </select>
    </div>
</div>
<div class="coupon-list">
    <c:if test="${not empty requestScope.c_list}">
        <c:forEach var="item" items="${requestScope.c_list}">
            <div class="coupon-item">
                <c:choose>
                    <c:when test="${item.brand ne null}">
                        <div class="coupon-discount">${item.sale_per}% <span class="discount-label">브랜드</span></div>
                    </c:when>
                    <c:otherwise>
                        <div class="coupon-discount">${item.sale_per}%</div>
                    </c:otherwise>
                </c:choose>
                <div class="coupon-title">${item.name}</div>
                <div class="coupon-expiry">${item.end_date}까지</div>
            </div>
        </c:forEach>
    </c:if>
</div>
