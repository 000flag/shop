<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/board/faq.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <!-- header -->
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="text-title">
                            <h3>FAQ</h3>
                        </div>

                        <div class="faq-tabs">
                            <ul class="nav nav-tabs" id="faqTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="tab-all" data-toggle="tab" href="#all-accordion" role="tab">전체</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="tab-delivery" data-toggle="tab" href="#delivery-accordion" role="tab">배송</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="tab-exchange" data-toggle="tab" href="#exchange-accordion" role="tab">교환/취소(반품)</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">서비스</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">주문/결제</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">상품확인</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">회원정보</a>
                                </li>
                            </ul>
                        </div>

                        <div class="tab-content">
                            <%-- 전체 --%>
                            <div class="accordion tab-pane fade show active" id="all-accordion" role="tabpanel">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="all-headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#all-collapseOne" aria-expanded="true" aria-controls="all-collapseOne">
                                            <span class="accordion-type">배송 일반</span>
                                            <span class="accordion-title">고객 보상 지원 제도가 무엇인가요?</span>
                                        </button>
                                    </h2>
                                    <div id="all-collapseOne" class="accordion-collapse collapse show" aria-labelledby="all-headingOne" data-bs-parent="#all-accordion">
                                        <div class="accordion-body">
                                            <p>무신사 스토어에서 주문 결제 후 품절로 상품을 받지 못하거나, 영업일 기준으로 3일 이상 출고 지연되는 경우,&nbsp;<br>
                                                PLUS배송 상품이 도착보장일보다 지연되는 경우에 자동으로 보상 적립금을 드리는 제도입니다.<br>
                                                <img alt="" height="213" src="//image.musinsa.com/images/faq/2023102619381400000060981.png" width="592"><br>
                                                - 판매 금액 기준은 상품의 상세페이지 윗부분 가격 정보의 무신사 판매가 입니다.<br>
                                                모바일(앱/웹) : 가격 클릭 시 가장 위의 비회원 판매 금액<br>
                                                - 상품 별로 출고 일정이 다를 수 있으니 주문 상품의 각 상세페이지 상단의 '출고 정보'에서 확인해 주세요.<br>
                                                - 출고지연은 출고 예정일 다음 날 오전 7시 이후 출고 시 해당됩니다.<br>
                                                - 출고 지연 중 품절 취소 처리가 될 경우 보상 금액이 제일 큰 품절취소 보상 적립금으로만 지급됩니다.<br>
                                                - 보상 적립금의 최대 지급 금액은 1만5천원 입니다.<br>
                                                - 보상지원 적립금의 사용 기한은 30일(지급일 포함)입니다.<br>
                                                - 교환 상품은 보상지원 제도 대상이 아닙니다.<br>
                                                - PLUS배송 상품은 천재지변 및 기타 불가항력적인 사유, 또는 고객 귀책 사유로 배송이 지연되는 경우에는 도착지연 보상 적립금이 지급되지 않습니다.<br>
                                                &nbsp;<br>
                                                ※ PLUS배송 상품의 도착지연 일수는 영업일 수 기준으로 산정됩니다.&nbsp;<br>
                                                ※ PLUS배송 상품은 도착지연 발생 시 도착지연 보상 적립금만 지급되며, 출고지연 보상 적립금은 지급되지 않습니다.<br>
                                                ※ 출고 예정일 이전, 출고 일정 변경 관련 알림톡 수신 후 동의/거절을 선택한 경우 보상 적립금 지원 대상에서 제외됩니다.<br>
                                                <br>
                                                <strong><a href="https://www.musinsa.com/app/cs/notice_view/9897?page=1"><span style="color:#3498db;">고객 보상 지원 제도 공지 바로 가기</span></a></strong><br>
                                                <a href="https://www.musinsa.com/app/cs/faq?idx=8"><span style="color:#3498db;"><strong>[적립금 사용 FAQ 바로 가기] </strong></span></a><br>
                                                &nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="all-headingTwo">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#all-collapseTwo" aria-expanded="false" aria-controls="all-collapseTwo">
                                            <span class="accordion-type">기타</span>
                                            <span class="accordion-title">송장 흐름 확인이 안되고 있어요.</span>
                                        </button>
                                    </h2>
                                    <div id="all-collapseTwo" class="accordion-collapse collapse" aria-labelledby="all-headingTwo" data-bs-parent="#all-accordion">
                                        <div class="accordion-body">
                                            <p>배송 상태 또는 배송 지연으로 송장 흐름이 늦게 확인될 수 있습니다.&nbsp;<br>
                                                아래 내용을 확인해 주세요.&nbsp;<br>
                                                <br>
                                                ■ 해외 배송 상품 여부 확인&nbsp;<br>
                                                입력된 송장번호는 국내에 도착 시 발송되는 송장번호입니다. 국내 도착 후 송장 조회 가능하고 주문 후 실제 도착까지는 기간이 더 소요될 수 있습니다.&nbsp;<br>
                                                <br>
                                                ■ 배송 시작 후 평일 기준 1일 이내&nbsp;<br>
                                                상품이 택배사로 전달 되고 평일 기준 1일 뒤에 송장 흐름이 확인 됩니다.&nbsp;<br>
                                                <br>
                                                ■ 택배사 지연&nbsp;<br>
                                                택배사 물량이 많은 경우 송장 흐름 확인이 평일 기준 2일 ~ 3일 정도 소요될 수 있습니다.&nbsp;<br>
                                                <br>
                                                <a href="https://www.musinsa.com/app/cs/faq?idx=32"><span style="color:#3498db;"><strong>[배송조회 FAQ 바로 가기]</strong></span></a><br>
                                                &nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="all-headingThree">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#all-collapseThree" aria-expanded="false" aria-controls="all-collapseThree">
                                            <span class="accordion-type">교환/반품</span>
                                            <span class="accordion-title">포장(택배) 박스, 상품/상품 박스가 파손되어 배송됐어요.</span>
                                        </button>
                                    </h2>
                                    <div id="all-collapseThree" class="accordion-collapse collapse" aria-labelledby="all-headingThree" data-bs-parent="#all-accordion">
                                        <div class="accordion-body">
                                            <p>받아보신 포장(택배) 박스 및 상품/상품 박스가 파손된 상태로 배송이 되었나요?<br>
                                                아래 내용을 확인하여 1:1문의로 사진과 함께 남겨주세요.<br>
                                                <br>
                                                ■ 포장(택배) 박스 / 상품 박스 / 상품<br>
                                                1. 전체 사진<br>
                                                2. 파손된 부분의 사진<br>
                                                3. 받아보신 상품이 포장(택배) 박스에 담긴 상태의 사진<br>
                                                4. 송장이 정확하게 보이는 포장(택배) 박스 전체의 사진<br>
                                                <br>
                                                ※ 포장(택배) 박스, 제품 포장재, 상품 등을 받은 상태 그대로 보관해 주세요.<br>
                                                ※ 받아보신 상태 그대로를 보관하지 않을 경우, 파손 사고 접수 확인이 어려울 수 있습니다.<br>
                                                <br>
                                                <a href="http://www.musinsa.com/app/cs"><strong><span style="color:#3498db;">고객센터 바로가기</span></strong></a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- 배송 --%>
                            <div class="accordion tab-pane fade" id="delivery-accordion" role="tabpanel">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="delivery-headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#delivery-collapseOne" aria-expanded="true" aria-controls="delivery-collapseOne">
                                            <span class="accordion-type">기타</span>
                                            <span class="accordion-title">상품/구성품이 누락되어 배송됐어요.</span>
                                        </button>
                                    </h2>
                                    <div id="delivery-collapseOne" class="accordion-collapse collapse show" aria-labelledby="delivery-headingOne" data-bs-parent="#delivery-accordion">
                                        <div class="accordion-body">
                                            <p>무신사 스토어에서 주문 결제 후 품절로 상품을 받지 못하거나, 영업일 기준으로 3일 이상 출고 지연되는 경우,&nbsp;<br>
                                                PLUS배송 상품이 도착보장일보다 지연되는 경우에 자동으로 보상 적립금을 드리는 제도입니다.<br>
                                                <img alt="" height="213" src="//image.musinsa.com/images/faq/2023102619381400000060981.png" width="592"><br>
                                                - 판매 금액 기준은 상품의 상세페이지 윗부분 가격 정보의 무신사 판매가 입니다.<br>
                                                모바일(앱/웹) : 가격 클릭 시 가장 위의 비회원 판매 금액<br>
                                                - 상품 별로 출고 일정이 다를 수 있으니 주문 상품의 각 상세페이지 상단의 '출고 정보'에서 확인해 주세요.<br>
                                                - 출고지연은 출고 예정일 다음 날 오전 7시 이후 출고 시 해당됩니다.<br>
                                                - 출고 지연 중 품절 취소 처리가 될 경우 보상 금액이 제일 큰 품절취소 보상 적립금으로만 지급됩니다.<br>
                                                - 보상 적립금의 최대 지급 금액은 1만5천원 입니다.<br>
                                                - 보상지원 적립금의 사용 기한은 30일(지급일 포함)입니다.<br>
                                                - 교환 상품은 보상지원 제도 대상이 아닙니다.<br>
                                                - PLUS배송 상품은 천재지변 및 기타 불가항력적인 사유, 또는 고객 귀책 사유로 배송이 지연되는 경우에는 도착지연 보상 적립금이 지급되지 않습니다.<br>
                                                &nbsp;<br>
                                                ※ PLUS배송 상품의 도착지연 일수는 영업일 수 기준으로 산정됩니다.&nbsp;<br>
                                                ※ PLUS배송 상품은 도착지연 발생 시 도착지연 보상 적립금만 지급되며, 출고지연 보상 적립금은 지급되지 않습니다.<br>
                                                ※ 출고 예정일 이전, 출고 일정 변경 관련 알림톡 수신 후 동의/거절을 선택한 경우 보상 적립금 지원 대상에서 제외됩니다.<br>
                                                <br>
                                                <strong><a href="https://www.musinsa.com/app/cs/notice_view/9897?page=1"><span style="color:#3498db;">고객 보상 지원 제도 공지 바로 가기</span></a></strong><br>
                                                <a href="https://www.musinsa.com/app/cs/faq?idx=8"><span style="color:#3498db;"><strong>[적립금 사용 FAQ 바로 가기] </strong></span></a><br>
                                                &nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="delivery-headingTwo">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#delivery-collapseTwo" aria-expanded="false" aria-controls="delivery-collapseTwo">
                                            <span class="accordion-type">기타</span>
                                            <span class="accordion-title">포장(택배) 박스, 상품/상품 박스가 파손되어 배송됐어요.</span>
                                        </button>
                                    </h2>
                                    <div id="delivery-collapseTwo" class="accordion-collapse collapse" aria-labelledby="delivery-headingTwo" data-bs-parent="#delivery-accordion">
                                        <div class="accordion-body">
                                            <p>배송 상태 또는 배송 지연으로 송장 흐름이 늦게 확인될 수 있습니다.&nbsp;<br>
                                                아래 내용을 확인해 주세요.&nbsp;<br>
                                                <br>
                                                ■ 해외 배송 상품 여부 확인&nbsp;<br>
                                                입력된 송장번호는 국내에 도착 시 발송되는 송장번호입니다. 국내 도착 후 송장 조회 가능하고 주문 후 실제 도착까지는 기간이 더 소요될 수 있습니다.&nbsp;<br>
                                                <br>
                                                ■ 배송 시작 후 평일 기준 1일 이내&nbsp;<br>
                                                상품이 택배사로 전달 되고 평일 기준 1일 뒤에 송장 흐름이 확인 됩니다.&nbsp;<br>
                                                <br>
                                                ■ 택배사 지연&nbsp;<br>
                                                택배사 물량이 많은 경우 송장 흐름 확인이 평일 기준 2일 ~ 3일 정도 소요될 수 있습니다.&nbsp;<br>
                                                <br>
                                                <a href="https://www.musinsa.com/app/cs/faq?idx=32"><span style="color:#3498db;"><strong>[배송조회 FAQ 바로 가기]</strong></span></a><br>
                                                &nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="delivery-headingThree">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#delivery-collapseThree" aria-expanded="false" aria-controls="delivery-collapseThree">
                                            <span class="accordion-type">배송 일반</span>
                                            <span class="accordion-title">출고가 지연된다는 알림톡을 받았어요.</span>
                                        </button>
                                    </h2>
                                    <div id="delivery-collapseThree" class="accordion-collapse collapse" aria-labelledby="delivery-headingThree" data-bs-parent="#delivery--accordion">
                                        <div class="accordion-body">
                                            <p>받아보신 포장(택배) 박스 및 상품/상품 박스가 파손된 상태로 배송이 되었나요?<br>
                                                아래 내용을 확인하여 1:1문의로 사진과 함께 남겨주세요.<br>
                                                <br>
                                                ■ 포장(택배) 박스 / 상품 박스 / 상품<br>
                                                1. 전체 사진<br>
                                                2. 파손된 부분의 사진<br>
                                                3. 받아보신 상품이 포장(택배) 박스에 담긴 상태의 사진<br>
                                                4. 송장이 정확하게 보이는 포장(택배) 박스 전체의 사진<br>
                                                <br>
                                                ※ 포장(택배) 박스, 제품 포장재, 상품 등을 받은 상태 그대로 보관해 주세요.<br>
                                                ※ 받아보신 상태 그대로를 보관하지 않을 경우, 파손 사고 접수 확인이 어려울 수 있습니다.<br>
                                                <br>
                                                <a href="http://www.musinsa.com/app/cs"><strong><span style="color:#3498db;">고객센터 바로가기</span></strong></a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- 교환/취소(반품) --%>
                            <div class="accordion tab-pane fade" id="exchange-accordion" role="tabpanel">
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="exchange-headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#exchange-collapseOne" aria-expanded="true" aria-controls="exchange-collapseOne">
                                            <span class="accordion-type">웹/앱 이용 문의</span>
                                            <span class="accordion-title">발매판이 궁금해요.</span>
                                        </button>
                                    </h2>
                                    <div id="exchange-collapseOne" class="accordion-collapse collapse show" aria-labelledby="exchange-headingOne" data-bs-parent="#exchange-accordion">
                                        <div class="accordion-body">
                                            <p>발매판은 무신사 스토어 내에서 브랜드의 상품 출시 정보를 빠르게 확인하고 구매할 수 있는 공간입니다.&nbsp;<br>
                                                발매 알림 신청을 통해 브랜드의 신상품 또는 인기 상품의 재입고 소식과 다양한 혜택을 경험해 보세요!&nbsp;<br>
                                                <br>
                                                ※ 발매 알림 신청은 브랜드 별로 신청할 수 있습니다.&nbsp;<br>
                                                ※ 발매 알림 신청은 발매 하루 전 오후 11시 59분까지 신청 가능합니다.&nbsp;<br>
                                                ※ 브랜드 좋아요를 누른 경우, 발매 알림은 자동으로 신청됩니다.&nbsp;<br>
                                                ※ 발매 전 브랜드의 좋아요 취소 시 발매 알림은 발송되지 않습니다.&nbsp;<br>
                                                <br>
                                                ■ 발매 알림 신청 방법<br>
                                                - 모바일(앱/웹) : 발매판 &gt; 알림 &gt; 알림 받기&nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="exchange-headingTwo">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#exchange-collapseTwo" aria-expanded="false" aria-controls="exchange-collapseTwo">
                                            <span class="accordion-type">웹/앱 이용 문의</span>
                                            <span class="accordion-title">추천판이 궁금해요.</span>
                                        </button>
                                    </h2>
                                    <div id="exchange-collapseTwo" class="accordion-collapse collapse" aria-labelledby="exchange-headingTwo" data-bs-parent="#exchange-accordion">
                                        <div class="accordion-body">
                                            <p>추천판은 개인의 취향에 맞는 상품, 브랜드, 스타일을 추천해 주는 공간입니다. &nbsp;&nbsp;<br>
                                                구매 상품, 소비 성향, 패션 취향 등에 따른 다양한 상품과 브랜드를 확인해 보세요!<br>
                                                <br>
                                                ※ 개인화에 따라 추천되므로 개인 별 노출 화면이 다를 수 있습니다.&nbsp;<br>
                                                ※ 시기에 따라 노출 상품, 브랜드, 스타일 등이 달라질 수 있습니다.&nbsp;
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header" id="exchange-headingThree">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#exchange-collapseThree" aria-expanded="false" aria-controls="exchange-collapseThree">
                                            <span class="accordion-type">후기</span>
                                            <span class="accordion-title">후기 작성에 대해 알려주세요.</span>
                                        </button>
                                    </h2>
                                    <div id="exchange-collapseThree" class="accordion-collapse collapse" aria-labelledby="exchange-headingThree" data-bs-parent="#exchange-accordion">
                                        <div class="accordion-body">
                                            <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--<div class="board-button-container">
                            <button class="btn btn-dark">1:1 문의하기</button>
                        </div>--%>
                    </div>
                </div>

                <%-- footer --%>
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
</body>
</html>
