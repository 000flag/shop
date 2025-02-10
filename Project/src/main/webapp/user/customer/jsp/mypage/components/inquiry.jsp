<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="inquiry-section">
    <div class="inquiry-header">
        <div class="inquiry-title">1:1문의 내역</div>
    </div>
</div>
<div class="inquiry-option-container">
    <div class="inquiry-search-bar">
        <label for="inquiry-status">처리 상태</label>
        <select class="form-select" id="inquiry-status" name="inquiry-status">
            <option value="0">전체 보기</option>
            <option value="1">답변 대기</option>
            <option value="2">답변 확인 중</option>
            <option value="3">답변 완료</option>
        </select>
        <label for="inquiry-date-range">기간 조회</label>
        <select class="form-select" id="inquiry-date-range" name="inquiry-date-range" onchange="inquiry_onChangeDateRange()">
            <option value="all-date">전체 시기</option>
            <option value="1-week">1주일</option>
            <option value="1-month">1개월</option>
            <option value="3-months">3개월</option>
        </select>
        <div class="inquiry-date-picker" id="inquiry-custom-datepicker">
            <input type="date" class="form-control" id="inquiry-start-date" name="inquiry-start-date" onchange="onChageInquiryStartDate()"/> ~
            <input type="date" class="form-control" id="inquiry-end-date" name="inquiry-end-date" onchange="onChageInquiryEndDate()"/>
        </div>
        <button type="button" class="btn btn-outline-secondary search-button" onclick="inquiry_onSearchInquiry()">검색</button>
    </div>
    <div class="register-button-container">
        <button type="button" class="btn btn-outline-primary" onclick="location.href='Controller?type=board&action=inquiry'">문의 등록</button>
    </div>
</div>
<div class="inquiry-container">
    <c:choose>
        <c:when test="${requestScope.inquiry_list ne null}">
            <c:forEach var="item" items="${requestScope.inquiry_list}">
                <div class="inquiry">
                    <div class="inquiry-question">
                        <p><strong>Q</strong>
                            <c:choose>
                                <c:when test="${item.status eq '1'}">
                                    <span class="inquiry-order-code">답변 대기</span>
                                </c:when>
                                <c:when test="${item.status eq '2'}">
                                    <span class="inquiry-order-code">답변 확인 중</span>
                                </c:when>
                                <c:when test="${item.status eq '3'}">
                                    <span class="inquiry-order-code">답변 완료</span>
                                </c:when>
                            </c:choose>
                        </p>
                        <p>No. ${item.order_code}</p>
                        <p>${item.content}</p>
                        <p class="date">${item.write_date}</p>
                    </div>
                    <div class="inquiry-answer">
                        <c:choose>
                            <c:when test="${item.brand ne null and item.r_content ne null}">
                                <p><strong>A &nbsp;</strong>${item.brand}</p>
                                <p>${item.r_content}</p>
                                <p class="inquiry-date">${item.write_date}</p>
                            </c:when>
                            <c:otherwise>
                                <p>답변이 등록되지 않았습니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="inquiry">
                <span>1:1문의 내역이 없습니다.</span>
            </div>
        </c:otherwise>
    </c:choose>
</div>