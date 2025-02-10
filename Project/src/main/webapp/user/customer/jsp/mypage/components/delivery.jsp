<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="delivery-section">
    <div class="delivery-header">
        <div class="delivery-title">배송지 목록</div>
        <c:choose>
            <c:when test="${fn:length(requestScope.d_list) ge 3}">
                <button type="button" class="btn btn-outline-primary add-address-button disabled" data-toggle="modal" data-target="#addrModal" onclick="insertDeliveryModal()">배송지 추가</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-outline-primary add-address-button" data-toggle="modal" data-target="#addrModal" onclick="insertDeliveryModal()">배송지 추가</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<c:if test="${requestScope.d_list eq null}">
    <div>
        <span>입력된 정보가 없습니다.</span>
    </div>
</c:if>
<c:if test="${requestScope.d_list ne null}">
    <c:set var="d_list" value="${requestScope.d_list}"/>
    <div class="custom-addr">
        <div class="wrap-addrList">
            <c:forEach var="dvo" items="${d_list}" varStatus="st">
                <div class="address-box" data-value="${dvo.id}">
                    <div class="address-details">
                        <p class="name">${dvo.name}</p>
                        <c:if test="${dvo.is_default eq '1'}">
                            <span class="default">
                                기본 배송지
                            </span>
                        </c:if>
                        <p class="address">(<span class="pos_code">${dvo.pos_code}</span>) &nbsp;<span class="addr1">${dvo.addr1}</span> <span class="addr2">${dvo.addr2}</span></p>
                        <p class="phone">${dvo.phone}</p>
                        <p class="request">${dvo.request}</p>
                        <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#addrModal" onclick="updateDeliveryModal('${dvo.id}')">수정</button>
                        <button type="button" class="btn btn-outline-danger ${dvo.is_default eq '1' && "disabled"} disabled" onclick="deleteDelivery('${dvo.id}')">삭제</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>
<div class="delivery-notice">
    <ol>
        <li>배송 주소록은 최대 3개까지 등록할 수 있으며, 별도로 등록하지 않을 경우 최근 배송 주소록 기준으로 자동 업데이트 됩니다.</li>
        <li>기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.</li>
    </ol>
</div>