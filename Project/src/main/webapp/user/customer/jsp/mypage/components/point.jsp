<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="point-section">
    <div class="point-header">
        <span class="point-title">적립금</span>
    </div>
</div>
<div class="loyalty-points-section">
    <div class="points-list">
        <div class="points-item">
            <div class="points-label text-left">예정 적립금</div>
            <div class="points-value text-right">
                <c:choose>
                    <c:when test="${not empty requestScope.upcomingTotal}">
                        <fmt:formatNumber value="${requestScope.upcomingTotal}"/>원
                    </c:when>
                    <c:otherwise>
                        0원
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="points-item">
            <div class="points-label text-left">소멸 예정 적립금(30일 이내)</div>
            <div class="points-value text-right">
                <c:choose>
                    <c:when test="${not empty requestScope.expireTotal}">
                        <fmt:formatNumber value="${requestScope.expireTotal}"/>원
                    </c:when>
                    <c:otherwise>
                        0원
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<div class="point-tabs">
    <ul class="nav nav-tabs" id="point-nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#" data-target="#point-all" onclick="selectPoint('all')">전체</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-target="#point-earned" onclick="selectPoint('earned')">적립</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-target="#point-used" onclick="selectPoint('used')">사용</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#" data-target="#point-upcoming" onclick="selectPoint('upcoming')">예정</a>
        </li>
    </ul>
</div>
<div id="point-list">
    <div id="point-all" class="list">
        <c:choose>
            <c:when test="${requestScope.all ne null}">
                <c:forEach var="item" items="${requestScope.all}">
                    <div class="custom-points-item">
                        <c:choose>
                            <c:when test="${item.p_type eq '0'}">
                                <div class="custom-points-title-container">
                                    <p class="custom-points-title">주문 적립</p>
                                    <p class="custom-points-amount">+${item.amount}</p>
                                </div>
                                <p class="custom-points-description">${item.order_code}</p>
                                <p class="custom-points-status">적립</p>
                            </c:when>
                            <c:otherwise>
                                <div class="custom-points-title-container">
                                    <p class="custom-points-title">적립금 결제</p>
                                    <p class="custom-points-amount custom-negative">-${item.amount}</p>
                                </div>
                                <p class="custom-points-status">사용</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3">표시할 포인트 데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </div>
    <div id="point-earned" class="list" style="display: none;">
        <c:choose>
            <c:when test="${requestScope.earned ne null}">
                <c:forEach var="item" items="${requestScope.earned}">
                    <tr>
                        <td>
                            <div class="custom-points-item">
                                <div class="custom-points-title-container">
                                    <p class="custom-points-title">주문 적립</p>
                                    <p class="custom-points-amount">+${item.amount}</p>
                                </div>
                                <p class="custom-points-status">적립・${item.save_date} (${item.expire_date} 소멸 예정)</p>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3">표시할 포인트 데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </div>
    <div id="point-used" class="list" style="display: none;">
        <c:choose>
            <c:when test="${requestScope.used ne null}">
                <c:forEach var="item" items="${requestScope.used}">
                    <tr>
                        <td>
                            <div class="custom-points-item">
                                <div class="custom-points-title-container">
                                    <p class="custom-points-title">적립금 결제</p>
                                    <p class="custom-points-amount custom-negative">-${item.amount}</p>
                                </div>
                                <p class="custom-points-status">사용・${item.use_date}</p>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3">표시할 포인트 데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </div>
    <div id="point-upcoming" class="list" style="display: none;">
        <c:choose>
            <c:when test="${requestScope.upcoming ne null}">
                <c:forEach var="item" items="${requestScope.upcoming}">
                    <tr>
                        <td>
                            <div class="custom-points-item">
                                <div class="custom-points-title-container">
                                    <p class="custom-points-title">주문 적립</p>
                                    <p class="custom-points-amount">+${item.amount}</p>
                                </div>
                                <p class="custom-points-description">${item.order_code}</p>
                                <p class="custom-points-status">예정</p>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3">표시할 포인트 데이터가 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<nav aria-label="Page navigation" class="navigation">
    <ul class="pagination">
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
        <li class="page-item">
            <a class="page-link" href="#">1</a>
        </li>
        <li class="page-item">
            <a class="page-link" href="#">2</a>
        </li>
        <li class="page-item">
            <a class="page-link" href="#">3</a>
        </li>
        <li class="page-item">
            <a class="page-link" href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>
