<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="question-section">
    <div class="question-header">
        <div class="question-title">상품 문의 내역</div>
    </div>
</div>
<div class="search-container">
    <div class="search-bar">
        <label for="question-status">처리 상태</label>
        <select class="form-select" id="question-status" name="question-status">
            <option value="all">전체 보기</option>
            <option value="wait">답변 대기</option>
            <option value="checking">답변 확인 중</option>
            <option value="complete">답변 완료</option>
        </select>
        <label for="question-custom-date-picker">기간 조회</label>
        <div class="date-picker" id="question-custom-date-picker">
            <input type="date" class="form-control" id="question-start-date" name="question-start-date"> ~
            <input type="date" class="form-control" id="question-end-date" name="question-end-date">
        </div>
        <button type="button" class="btn btn-outline-primary search-button" onclick="searchQuestion()">검색</button>
    </div>
</div>
<div class="question-container">
    <c:if test="${requestScope.list eq null}">
        <div class="wrap-question">
            <span>작성한 상품문의가 없습니다.</span>
        </div>
    </c:if>
    <c:if test="${requestScope.list ne null}">
        <c:forEach var="item" items="${requestScope.list}">
        <div class="wrap-question">
            <div class="question">
                <p><strong>Q</strong> [배송] ${item.title}</p>
                <p>${item.content}</p>
                <p class="date">${item.write_date}</p>
            </div>
            <c:if test="${item.r_content ne null}">
                <div class="answer">
                    <p><strong>A</strong> ${item.brand}</p>
                    <p>${item.r_content}</p>
                    <p class="date">${item.r_write_date}</p>
                </div>
            </c:if>
            <div class="product-info">
                <a href="#" class="product-link">
                    <img src="./user/images/product7.jpg" alt="상품 이미지" class="product-image">
                    <div class="product-details">
                        <p><strong>[라퍼지스토어]</strong></p>
                        <p class="product-name">헤비 코튼 오버 럭비 맨투맨_Melange Gray</p>
                    </div>
                </a>
            </div>
        </div>
        </c:forEach>
    </c:if>
</div>