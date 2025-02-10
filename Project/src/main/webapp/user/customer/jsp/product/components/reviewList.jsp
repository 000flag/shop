<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="review-options">
    <div class="option-group">
        <label for="gender-select">성별</label>
        <select id="gender-select" class="form-select custom-select">
            <option value="0">전체</option>
            <option value="1">남성</option>
            <option value="2">여성</option>
        </select>
    </div>
    <div class="option-group">
        <label for="height-input">키</label>
        <input id="height-input" type="text" class="form-control" placeholder="cm" onkeyup="onCheckInput()">
    </div>
    <div class="option-group">
        <label for="weight-input">몸무게</label>
        <input id="weight-input" type="text" class="form-control" placeholder="kg" onkeyup="onCheckInput()">
    </div>
    <div class="option-group btn-group">
        <button type="button" class="btn btn-outline-primary" id="review-search-btn" onclick="selectReview()">검색
        </button>
    </div>
</div>
<div class="review-list" id="review-list">
    <c:if test="${requestScope.reviews ne null}">
        <c:forEach var="item" items="${requestScope.reviews}">
            <div class="review-item">
                <div class="review-user">
                    <div class="user-profile">
                        <img src="${item.profile_image}" alt="프로필 사진">
                    </div>
                    <div class="user-info">
                        <span class="nickname">${item.nickname}</span>
                        <span class="write-date">${item.write_date}</span>
                        <div class="review-rating">
                            <c:choose>
                                <c:when test="${item.score == 1}">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                                </c:when>
                                <c:when test="${item.score == 2}">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                                </c:when>
                                <c:when test="${item.score == 3}">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                                </c:when>
                                <c:when test="${item.score == 4}">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>
                                </c:when>
                                <c:when test="${item.score == 5}">
                                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="user-info-detail">
                    <c:if test="${item.c_gender eq '1'}">남성</c:if>
                    <c:if test="${item.c_gender eq '2'}">여성</c:if>
                    <c:if test="${item.c_height ne null}">&nbsp;·&nbsp;${item.c_height}cm</c:if>
                    <c:if test="${item.c_weight ne null}">&nbsp;·&nbsp;${item.c_weight}kg</c:if>
                    <c:if test="${item.i_option_name ne null}">&nbsp;|&nbsp;${item.i_option_name}&nbsp;구매</c:if>
                </div>

                <div class="review-image-container">
                    <c:if test="${not empty item.additional_images}">
                        <c:choose>
                            <c:when test="${fn:contains(item.additional_images, ',')}">
                                <c:set var="add_img" value="${fn:split(item.additional_images, ',')}"/>
                                <c:forEach var="img" items="${add_img}" varStatus="st">
                                    <div class="review-image">
                                        <img src="${img}" alt="review image_${st.index}"/>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="review-image">
                                    <img src="${item.additional_images}" alt="review image_0"/>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>

                <div class="review-content">
                    <p>${item.content}</p>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>