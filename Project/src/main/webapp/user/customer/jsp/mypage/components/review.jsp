<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="review-section">
    <span class="review-title">후기</span>
</div>
<div class="review-option-container">
    <div class="review-search-bar">
        <label for="review-date-range" class="review-label">기간 조회</label>
        <select class="form-select review-select" id="review-date-range" name="review-date-range" onchange="review_onChangeDateRange()">
            <option value="all-date">전체 시기</option>
            <option value="1-week">1주일</option>
            <option value="1-month">1개월</option>
            <option value="3-months">3개월</option>
        </select>
        <div class="review-date-picker" id="review-custom-datepicker">
            <input type="date" class="form-control review-input" id="review-start-date" name="review-start-date" onchange="onChagereviewStartDate()"/> ~
            <input type="date" class="form-control review-input" id="review-end-date" name="review-end-date" onchange="onChagereviewEndDate()"/>
        </div>
        <button type="button" class="btn btn-outline-secondary search-button" onclick="review_onSearchreview()">검색</button>
    </div>
</div>
<div class="review-container">
    <div class="review-content">
        <c:if test="${requestScope.r_list eq null}">
            <div class="product-item">
                <span>작성한 리뷰가 없습니다.</span>
            </div>
        </c:if>
        <c:if test="${requestScope.r_list ne null}">
            <c:forEach var="item" items="${requestScope.r_list}">
                <div class="review-item" data-value="${item.id}">
                    <div class="review-header">
                        <img src="${item.profile_image}" alt="사용자 프로필 사진" class="profile-img">
                        <div class="review-info">
                            <span class="review-author">${item.nickname}</span>
                            <span class="review-date">${item.write_date}</span>
                            <div class="review-score">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${item.score >= i}">
                                            <i class="bi bi-star-fill"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <span class="score-text">${item.score}</span>
                            </div>
                        </div>
                        <div class="dropdown review-dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="Controller?type=review&action=edit&board_no=${item.id}">수정</a>
                                <a class="dropdown-item" href="javascript:void(0);" onclick="onDeleteReview('${item.id}')">삭제</a>
                            </div>
                        </div>
                    </div>
                    <div class="purchase-type">
                        <a href="Controller?type=productDetails&action=select&prod_no=${item.prod_no}" class="product-link">${item.p_name}</a> · ${item.option_name} 구매
                    </div>
                    <div class="product-img-container">
                        <c:forEach var="img" items="${fn:split(item.additional_images, ',')}" varStatus="st">
                            <img src="${fn:split(item.additional_images, ',')[st.index]}" alt="상품 이미지_${st.index}" class="product-img">
                        </c:forEach>
                    </div>
                    <div class="review-content">${item.content}</div>
                    <div class="review-footer">
                        <i class="bi bi-heart"></i>
                        <span>${item.like_count}</span>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>
