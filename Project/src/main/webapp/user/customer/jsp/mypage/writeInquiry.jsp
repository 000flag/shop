<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    <%-- SummerNote CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/summernote-lite.css"/>

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/writeInquiry.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <c:if test="${not empty response}">
                <script>
                    if ("${response}" === "true") {
                        /*window.location.href = "Contoller?type=myPage";*/
                    }
                </script>
            </c:if>

            <!-- content -->
            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="inquiry-title">
                            <h2 class="title">1:1 문의</h2>
                        </div>
                        <div class="tab-navigation">
                            <button class="btn btn-outline-secondary tab-button" data-target="delivery">배송</button>
                            <button class="btn btn-outline-secondary tab-button" data-target="payment">주문/결제</button>
                            <button class="btn btn-outline-secondary tab-button" data-target="order">취소/교환/환불</button>
                            <button class="btn btn-outline-secondary tab-button" data-target="customer">회원정보</button>
                            <button class="btn btn-outline-secondary tab-button" data-target="product">상품확인</button>
                            <button class="btn btn-outline-secondary tab-button" data-target="service">서비스</button>
                        </div>
                        <div class="inquiry-type">
                            <select class="inquiry-select" id="inquiry-select-delivery">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="1">예약 배송</option>
                                <option value="2">기타</option>
                                <option value="3">배송 일정</option>
                            </select>
                            <select class="inquiry-select" id="inquiry-select-payment">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="4">결제 수단</option>
                                <option value="5">기타</option>
                                <option value="6">주문 변경</option>
                            </select>
                            <select class="inquiry-select" id="inquiry-select-order">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="7">주문 취소</option>
                                <option value="8">교환/반품</option>
                                <option value="9">환불/반품</option>
                            </select>
                            <select class="inquiry-select" id="inquiry-select-customer">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="10">가입/인증</option>
                                <option value="11">로그인/정보</option>
                                <option value="12">탈퇴/기타</option>
                            </select>
                            <select class="inquiry-select" id="inquiry-select-product">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="13">상품 문의</option>
                                <option value="14">불량/하자</option>
                                <option value="15">AS</option>
                            </select>
                            <select class="inquiry-select" id="inquiry-select-service">
                                <option value="0">:: 문의 유형을 선택해주세요 ::</option>
                                <option value="16">후기</option>
                                <option value="17">기타</option>
                                <option value="18">신고</option>
                            </select>
                        </div>
                        <div class="input-group inquiry-order" id="inquiry-order">
                            <p>주문번호 <span class="text-red">필수 입력 항목</span></p>
                            <input type="text" class="form-control" placeholder="조회하세요" id="inquiry-order-code"/>
                            <div class="input-group-append">
                                <button class="btn btn-dark" type="button" data-toggle="modal" data-target="#inquiryOrderModal">조회</button>
                            </div>
                        </div>
                        <div class="inquiry-content">
                            <p>내용</p>
                            <textarea class="inquiry-textarea" id="content" name="content" cols="50" rows="8"></textarea>
                        </div>
                        <div class="inquiry-photo">
                            <p>사진</p>
                            <div class="photo-upload">
                                <label for="photo-input" class="photo-placeholder">
                                    <span class="plus-icon">+</span>
                                </label>
                                <input type="file" id="photo-input" name="additional" class="photo-input" accept="image/*" multiple />
                            </div>
                            <c:if test="${requestScope.filePaths ne null}">
                                <div id="uploaded-images" class="uploaded-images">
                                    <c:forEach var="item" items="${requestScope.filePaths}">
                                        <img src="${item}" alt="Uploaded Image"/>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                        <div class="notice">
                            <p class="notice-text">* 제품 사용, 오염, 전용 박스 손상, 라벨 제거, 사은품 및 부속 사용/분실 시, 교환/환불이 불가능합니다.</p>
                            <p class="notice-text">* 교환을 원하시는 상품(사이즈)의 재고가 부족 시, 교환이 불가능합니다.</p>
                            <p>* 고객님의 주문내역을 선택, 질문이 필요한 상품을 선택하시면 1:1 상담이 가능합니다.</p>
                            <p>* 상품 정보(사이즈, 실측, 예상 배송일 등) 관련 문의는 해당 상품 문의에 남기셔야 빠른 답변이 가능합니다.</p>
                        </div>
                        <div class="action-buttons">
                            <button class="btn btn-secondary cancel-btn">취소</button>
                            <button class="btn btn-dark submit-btn" onclick="onSendInquiry()">작성하기</button>
                        </div>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <%-- 주문번호 조회 모달 --%>
            <div class="modal fade" id="inquiryOrderModal" tabindex="-1" role="dialog" aria-labelledby="inquiryOrderModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="inquiryOrderModalTitle">주문번호 조회</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="filter-buttons">
                                <button class="btn btn-outline-secondary filter-button">1개월</button>
                                <button class="btn btn-outline-secondary filter-button">3개월</button>
                                <button class="btn btn-outline-secondary filter-button">6개월</button>
                                <button class="btn btn-outline-secondary filter-button">최대 5년</button>
                            </div>
                            <div class="order-list">
                                <div class="order-item">
                                    <img src="./user/images/product2.jpg" alt="Product Image" class="product-img" />
                                    <div class="order-info">
                                        <div class="order-title-wrapper">
                                            <span class="order-no">No. 202501171049450001</span>
                                            <span class="order-date">2025.01.17</span>
                                        </div>
                                        <p class="product-brand">커버낫</p>
                                        <p class="product-title">[2PACK] 쿨 코튼 티셔츠 블랙+화이트</p>
                                        <p class="product-option">옵션 M</p>
                                    </div>
                                    <button class="btn btn-dark inquiry-selected-btn">선택</button>
                                </div>
                                <div class="order-item">
                                    <img src="./user/images/product7.jpg" alt="Product Image" class="product-img" />
                                    <div class="order-info">
                                        <div class="order-title-wrapper">
                                            <span class="order-no">No. 202410201757510002</span>
                                            <span class="order-date">2024.10.20</span>
                                        </div>
                                        <p class="product-brand">팀코믹스</p>
                                        <p class="product-title">VAMOS LABEL CREWNECK BLACK</p>
                                        <p class="product-option">옵션 M</p>
                                    </div>
                                    <button class="btn btn-dark inquiry-selected-btn">선택</button>
                                </div>
                                <div class="order-item">
                                    <img src="./user/images/product5.jpg" alt="Product Image" class="product-img" />
                                    <div class="order-info">
                                        <div class="order-title-wrapper">
                                            <span class="order-no">No. 202409250113480003</span>
                                            <span class="order-date">2024.09.25</span>
                                        </div>
                                        <p class="product-brand">지프</p>
                                        <p class="product-title">[2PACK] 170g 에어+ 그램 반팔티</p>
                                        <p class="product-option">옵션 화이트+화이트^M</p>
                                    </div>
                                    <button class="btn btn-dark inquiry-selected-btn">선택</button>
                                </div>
                                <div class="order-item">
                                    <img src="./user/images/product6.jpg" alt="Product Image" class="product-img" />
                                    <div class="order-info">
                                        <div class="order-title-wrapper">
                                            <span class="order-no">No. 202407281259090004</span>
                                            <span class="order-date">2024.07.28</span>
                                        </div>
                                        <p class="product-brand">어커버</p>
                                        <p class="product-title">[세트상품] 린넨 9부 밴딩 팬츠</p>
                                        <p class="product-option">옵션 블랙^S</p>
                                    </div>
                                    <button class="btn btn-dark inquiry-selected-btn">선택</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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

    <%-- SummerNote JS --%>
    <script src="./user/customer/js/summernote-lite.js"></script>
    <script src="./user/customer/js/lang/summernote-ko-KR.js"></script>

    <script src="./user/customer/js/mypage/writeInquiry.js"></script>
</body>
</html>
