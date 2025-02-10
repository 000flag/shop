<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="question-button-container">
    <c:if test="${not empty sessionScope.customer_info}">
        <button type="button" class="btn btn-outline-dark" onclick="onMoveQuestionPage()">
            판매자에게 문의하기
        </button>
    </c:if>
</div>
<c:choose>
    <c:when test="${requestScope.questions ne null}">
        <c:forEach var="item" items="${requestScope.questions}">
            <div class="question-item">
                <c:choose>
                    <c:when test="${item.type == '19'}"><div class="question-type">사이즈</div></c:when>
                    <c:when test="${item.type == '20'}"><div class="question-type">배송</div></c:when>
                    <c:when test="${item.type == '21'}"><div class="question-type">재입고</div></c:when>
                    <c:when test="${item.type == '22'}"><div class="question-type">상품상세문의</div></c:when>
                </c:choose>

                <c:choose>
                    <c:when test="${item.is_private eq '0'}">
                        <c:choose>
                            <c:when test="${item.status eq '1'}">
                                <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변대기</div>
                            </c:when>
                            <c:when test="${item.status eq '2'}">
                                <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변확인중</div>
                            </c:when>
                            <c:when test="${item.status eq '3'}">
                                <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변완료</div>
                            </c:when>
                        </c:choose>
                        <div class="question-header">
                            <span class="question-title">${item.title}</span>
                        </div>
                        <c:choose>
                            <c:when test="${item.status ne '3'}">
                                <div class="question-content">
                                    <p class="question">${item.content}</p>
                                    <p class="answer">답변이 등록되지 않았습니다.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="question-content">
                                    <p class="question">${item.content}</p>
                                    <div class="answer">
                                        <strong>A. ${item.brand}</strong>
                                        <p>${item.r_content}</p>
                                        <span class="answer-date">${item.r_write_date}</span>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="question-meta">${item.write_date}</div>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${item.is_private eq '1' and not empty sessionScope.customer_info and (item.cus_no eq sessionScope.customer_info.id)}">
                                <c:choose>
                                    <c:when test="${item.status eq '1'}">
                                        <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변대기</div>
                                    </c:when>
                                    <c:when test="${item.status eq '2'}">
                                        <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변확인중</div>
                                    </c:when>
                                    <c:when test="${item.status eq '3'}">
                                        <div class="question-meta"><img src="./user/images/icon_q.png" alt="문의 아이콘"/> 답변완료</div>
                                    </c:when>
                                </c:choose>
                                <i class="bi bi-lock-fill"></i>
                                <span class="question-title">비밀글로 설정된 글입니다.</span>
                                <div class="question-header">
                                    <span class="question-title">${item.title}</span>
                                </div>
                                <c:choose>
                                    <c:when test="${item.status ne '3'}">
                                        <div class="question-content">
                                            <p class="question">${item.content}</p>
                                            <p class="answer">답변이 등록되지 않았습니다.</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="question-content">
                                            <p class="question">${item.content}</p>
                                            <div class="answer">
                                                <strong>A. ${item.brand}</strong>
                                                <p>${item.r_content}</p>
                                            <span class="answer-date">${item.r_write_date}</span>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="question-meta">${item.write_date}</div>
                            </c:when>
                            <c:when test="${(item.is_private eq '1' and sessionScope.customer_info eq null) or (item.is_private eq '1' and item.cus_no ne sessionScope.customer_info.id)}">
                                <div class="question-header">
                                    <i class="bi bi-lock-fill"></i>
                                    <span class="question-title">비밀글로 설정된 글입니다.</span>
                                </div>
                            </c:when>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="question-item">
            <span>해당 상품의 문의 내역이 없습니다.</span>
        </div>
    </c:otherwise>
</c:choose>