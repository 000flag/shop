<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/refundRequest.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <!-- content -->
            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <c:if test="${requestScope.o_list ne null and requestScope.d_list ne null}">
                        <c:set var="o_list" value="${requestScope.o_list}"/>
                            <div class="wrap-title">
                                <span class="left bold">반품요청</span>

                            </div>

                            <div class="box">
                                <!-- 반품 상품 정보 -->
                                <section class="wrap-product">
                                    <div class="wrap-product-content">
                                        <c:forEach var="item" items="${o_list}">
                                            <div class="product-content">
                                                <input type="hidden" name="order_id" value="${item.id}"/>
                                                <input type="hidden" name="prod_no" value="${item.prod_no}"/>
                                                <input type="hidden" name="point-used" value="${requestScope.point_amount}"/>
                                                <input type="hidden" name="orderCode" value="${item.order_code}"/>
                                                <input type="hidden" name="benefit_type" value="${item.benefit_type}"/>
                                                <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" class="product-img">
                                                <div class="product-detail">
                                                    <span>${item.brand}</span><br/>
                                                    ${item.prod_name}
                                                    <div class="option-text">${item.option_name} / ${item.count}개</div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </section>
                                <hr/>

                                <!-- 반품 사유 선택 -->
                                <div class="wrap-reason">
                                    <span class="bold">반품사유</span><br/>
                                    <select class="form-select select" id="select" name="select" onchange="addReasonInput()">
                                        <option value="0" selected="selected">:: 반품 사유를 선택하세요 ::</option>
                                        <option value="단순 변심">단순 변심</option>
                                        <option value="상품 불량">상품 불량</option>
                                        <option value="배송 지연">배송 지연</option>
                                        <option value="상품정보와 상이">상품정보와 상이</option>
                                        <option value="직접 입력">직접 입력</option>
                                    </select>

                                    <!-- '직접 입력'을 선택할 때만 보이는 새로운 입력 필드 -->
                                    <div id="refund-input">
                                        <input type="text" class="toggle" name="request-reason" placeholder="환불 사유를 입력해주세요"/>
                                    </div>
                                    <hr/>
                                </div>

                                <div class="custom-addr">
                                    <span class="bold">회수지 선택</span><br/>
                                    <div class="wrap-addrList">
                                        <c:forEach var="delivery" items="${requestScope.d_list}" varStatus="status">
                                            <div class="address-box">
                                                <input type="radio" id="address-${status.index}" name="retrieve_deli_no" value="${delivery.id}">
                                                <label for="address-${status.index}">
                                                    <div class="address-details">
                                                        <input type="hidden" id="retrieve_deli_no" name="retrieve_deli_no" value="${delivery.id}">
                                                        <p class="name">${delivery.name} <c:if test="${delivery.is_default == '1'}"><span class="default">기본 배송지</span></c:if></p>
                                                        <p class="address">(${delivery.pos_code}) ${delivery.addr1} ${delivery.addr2}</p>
                                                        <p class="phone">${delivery.phone}</p>
                                                        <p class="deli_request">${delivery.request}</p>
                                                    </div>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <hr/>

                                <!-- 반품 계좌 정보-->
                                <div class="refund-account">
                                    <span class="bold">반품 계좌 정보</span><br/>

                                    <!-- 은행 선택 -->
                                    <div class="margin">
                                        <label for="bank-select" class="bold">은행 선택</label><br>
                                        <select class="form-select select" id="bank-select" name="bank">
                                            <option value="" selected disabled>:: 은행을 선택하세요 ::</option>
                                            <option value="KB국민은행">KB국민은행</option>
                                            <option value="신한은행">신한은행</option>
                                            <option value="우리은행">우리은행</option>
                                            <option value="NH농협은행">NH농협은행</option>
                                        </select>
                                    </div>

                                    <!-- 계좌 번호 입력 -->
                                    <div class="margin">
                                        <label for="account-number" class="bold">계좌번호</label><br>
                                        <input type="text" class="toggle" id="account-number" name="account-number" placeholder="계좌번호를 입력하세요"/><br/>
                                    </div><hr/>

                                    <!-- 환불 정보 -->
                                    <div class="refund-info">
                                        <span class="bold">환불 정보</span><br/>
                                        <ul>
                                                <%-- 상품 결제 금액 및 적립금 사용 값 변환 및 계산 --%>
                                            <c:set var="totalAmount" value="0" />
                                            <c:forEach var="item" items="${requestScope.o_list}">
                                                <!-- 쉼표 제거 후 숫자로 변환 -->
                                                <c:set var="resultAmountInt" value="${fn:replace(item.result_amount, ',', '')}" />

                                                <!-- 누적 합계 계산 -->
                                                <c:set var="totalAmount" value="${totalAmount + resultAmountInt}" />
                                            </c:forEach>

                                            <c:set var="pointUsed" value="${not empty requestScope.point_amount ? requestScope.point_amount : '0'}" />
                                            <c:set var="coupon" value="${requestScope.coupon}"/>

                                                <%-- 숫자만 추출하여 int형으로 변환 --%>
                                            <c:set var="totalAmountInt" value="${fn:replace(totalAmount, ',', '')}" />
                                            <c:set var="pointUsedInt" value="${fn:replace(pointUsed, ',', '')}" />

                                            <li><span>상품 결제 금액</span><span class="item-price"><fmt:formatNumber value="${totalAmountInt}"/>원</span></li>

                                            <c:if test="${requestScope.point_amount ne null}">
                                                <li><span>적립금 사용</span><span class="cancel-point-used"><fmt:formatNumber value="${pointUsedInt}"/>원</span></li>
                                            </c:if>
                                            <li><span>기본 배송비</span><span>무료</span></li>

                                            <!-- 환불 예정 금액 계산 (총 결제 금액 - 적립금 - 쿠폰) -->
                                                    <c:set var="refundAmount" value="${totalAmountInt - pointUsedInt}" />
                                            <li><span>환불 예정 금액</span><span class="refund-amount"><fmt:formatNumber value="${refundAmount}" type="number" maxFractionDigits="0"/>원</span></li>
                                        </ul>
                                    </div>
                                    <!-- 반품요청 버튼-->
                                    <button type="button" class="btn btn-outline-secondary add-address-button" id="refundRequestButton">반품 신청</button>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

        </c:when>
        <c:otherwise>
            <script>
                alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
                window.location.href = 'Controller?type=login';
            </script>
        </c:otherwise>
    </c:choose>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <%-- JS --%>
    <script src="./user/customer/js/mypage/refundRequest.js"></script>
</body>
</html>
