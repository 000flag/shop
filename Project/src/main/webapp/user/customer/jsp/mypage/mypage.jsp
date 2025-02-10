<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/mypage.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/coupon.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/delivery.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/order.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/point.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/review.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/inquiry.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/question.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/refund.css"/>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/components/exchange.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <%-- header --%>
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <%-- content --%>
            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="text-title">
                            <h3>마이 페이지</h3>
                        </div>

                        <div class="profile-container">
                            <div class="profile-row">
                                <div class="profile-header">
                                    <div class="profile-left">
                                        <div class="profile-image">
                                            <img src="${sessionScope.customer_info.profile_image}" alt="User Profile Image">
                                        </div>
                                        <div class="profile-info">
                                            <c:if test="${not empty sessionScope.customer_info}">
                                                <div class="profile-name">${sessionScope.customer_info.nickname} <button type="button" data-toggle="modal" data-target="#profileSettingModal"><i class="bi bi-gear"></i></button></div>
                                                <div class="profile-level">${sessionScope.customer_info.grade_name} · ${sessionScope.customer_info.point_condition}% 적립</div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-stats">
                                    <div class="stats-item">
                                        <div class="stats-label">적립금</div>
                                        <div class="stats-value"><fmt:formatNumber value="${requestScope.points}"/>원</div>
                                    </div>
                                    <div class="stats-item">
                                        <div class="stats-label">쿠폰</div>
                                        <div class="stats-value"><fmt:formatNumber value="${requestScope.coupons}"/>장</div>
                                    </div>
                                    <div class="stats-item">
                                        <div class="stats-label">후기 작성</div>
                                        <div class="stats-value"><fmt:formatNumber value="${requestScope.ableCount}"/>건</div>
                                    </div>
                                </div>
                                <div class="profile-buttons">
                                    <button type="button" class="btn btn-outline-secondary btn-sm profile-button" onclick="location.href='Controller?type=myPage&action=profile'">프로필</button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm snap-profile-button">스냅 프로필</button>
                                </div>
                            </div>
                        </div>

                        <div class="user-action-buttons">
                            <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-order" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-order" onclick="selectOrder()">주문내역</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-refund" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-refund" onclick="selectRefundTab('all')">취소/반품/교환</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-review" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-review" onclick="selectMypageReview()">구매후기</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-inquiry" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-inquiry" onclick="selectInquiry()">1:1문의</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-question" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-question" onclick="selectQuestion()">상품문의</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-point" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-point" onclick="selectPoint('all')">적립금</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-coupon" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-coupon" onclick="selectCoupons()">쿠폰</label>
                                <input type="radio" class="btn-check" name="btnradiotab" id="btnradio-delivery" autocomplete="off">
                                <label class="btn btn-outline-dark" for="btnradio-delivery" onclick="selectDelivery()">배송지</label>
                            </div>
                        </div>
                        <div class="order-section-container" id="order-article">
                            <jsp:include page="./components/order.jsp"/>
                        </div>
                        <div class="refund-section-container" id="refund-article">
                            <jsp:include page="./components/refund.jsp"/>
                        </div>
                        <div class="review-section-container" id="review-article">
                            <jsp:include page="./components/review.jsp"/>
                        </div>
                        <div class="point-section-container" id="point-article">
                            <jsp:include page="./components/point.jsp"/>
                        </div>
                        <div class="inquiry-section-container" id="inquiry-article">
                            <jsp:include page="./components/inquiry.jsp"/>
                        </div>
                        <div class="question-section-container" id="question-article">
                            <jsp:include page="./components/question.jsp"/>
                        </div>
                        <div class="coupon-section-container" id="coupon-article">
                            <jsp:include page="./components/coupon.jsp"/>
                        </div>
                        <div class="delivery-section-container" id="delivery-article">
                            <jsp:include page="./components/delivery.jsp"/>
                        </div>
                    </div>
                </div>

                <%-- footer --%>
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <%-- 프로필 변경 모달 --%>
            <div class="modal fade" id="profileSettingModal" tabindex="-1" role="dialog" aria-labelledby="profileSettingModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="profileSettingModalTitle">프로필 변경</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="change-profile-form" action="Controller?type=myPage&action=update_profile" method="POST" enctype="multipart/form-data" onsubmit="event.preventDefault(); updateProfile();">
                                <div class="profile-settings-form">
                                    <div class="form-group">
                                        <label class="form-label">프로필 사진 <span class="profile-change-notice">(변경 시 프로필 사진을 클릭해 주세요)</span></label>
                                        <div class="d-flex align-items-center">
                                            <div class="photo-box" onclick="triggerProfileInput()">
                                                <img src="${sessionScope.customer_info.profile_image}" alt="프로필 사진" class="profile-image-preview mr-3"/>
                                            </div>
                                            <input type="file" id="profile-input" accept="image/*" style="display: none;">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="nickname-input" class="form-label">닉네임</label>
                                        <input type="text" class="form-control" id="nickname-input" value="${sessionScope.customer_info.nickname}"/>
                                    </div>
                                </div>
                                <div class="profile-actions">
                                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                                    <button type="submit" class="btn btn-outline-secondary">변경</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 배송지 추가 Modal -->
            <div class="modal fade" id="addrModal" tabindex="-1" role="dialog" aria-labelledby="addrModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addrModalTitle">배송지 추가</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="modal-table-container">
                                <input type="hidden" id="addr_id" name="addr_id"/>
                                <table class="modal-table">
                                    <caption>배송지 정보 입력 테이블</caption>
                                    <tbody>
                                        <tr>
                                            <th class="modal-table-info">
                                                <span>이름</span>
                                                <span class="asterisk"></span>
                                            </th>
                                            <td>
                                                <input type="text" class="text" id="name" name="name" placeholder="받는 분의 이름을 입력하세요"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="modal-table-info">
                                                <span>연락처</span>
                                                <span class="asterisk"></span>
                                            </th>
                                            <td>
                                                <input type="text" class="text" id="phone" name="phone" placeholder="받는 분의 연락처를 입력하세요"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="modal-table-info">
                                                <span>주소</span>
                                                <span class="asterisk"></span>
                                            </th>
                                            <td>
                                                <input type="text" class="addr1" id="pos_code" name="pos_code" placeholder="우편번호"/>
                                                <button class="btn btn-primary" onclick="getPostcode()">우편번호 찾기</button><br/>
                                                <input type="text" class="addr2" id="addr1" name="addr1" placeholder="주소"/><br/>
                                                <input type="text" class="addr2" id="addr2" name="addr2" placeholder="상세주소"/><br/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="modal-table-info">
                                                <span>배송 요청사항 (선택)</span>
                                            </th>
                                            <td>
                                                <select id="request-select" name="request-select" onchange="addInput()">
                                                    <option value="0" disabled selected>:: 배송 요청사항을 선택하세요 ::</option>
                                                    <option value="문 앞에 놔주세요">문 앞에 놔주세요</option>
                                                    <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
                                                    <option value="택배함에 넣어주세요">택배함에 넣어주세요</option>
                                                    <option value="배송 전에 연락주세요">배송 전에 연락주세요</option>
                                                    <option value="직접 입력">직접 입력</option>
                                                </select>
                                                <br/>
                                                <!-- '직접 입력'을 선택할 때만 보이는 새로운 입력 필드 -->
                                                <div id="custom-input">
                                                    <input type="text" class="toggle" id="deli_request" name="deli_request" placeholder="배송 요청 사항을 직접 입력하세요"/>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <input type="checkbox" id="chkDefault" name="chkDefault"/>
                                                <label for="chkDefault">기본 배송지로 설정</label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="modal-footer-right">
                                <button type="button" class="btn btn-outline-secondary btn-close-modal" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-outline-primary btn-delivery-event" onclick="onSendDeliveryInfo()">등록</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 배송조회 모달 -->
            <div class="modal fade" id="deliveryModal" tabindex="-1" role="dialog" aria-labelledby="deliveryModalTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deliveryModalTitle">배송 조회</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>배송 조회 내용을 여기에 표시합니다.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 재구매 모달 -->
            <div class="modal fade" id="repurchaseModal" tabindex="-1" role="dialog" aria-labelledby="repurchaseModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="repurchaseModalLabel">동일한 옵션/수량으로 재구매 하시겠습니까?</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>다른 옵션/수량으로 구매하려면 장바구니에 담은 후 변경해 보세요.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-dark button" onclick="location.href='Controller?type=cart'">장바구니 담기</button>
                            <button type="button" class="btn btn-dark button" onclick="location.href='Controller?type=order&action=order'">구매하기</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 후기 작성 모달 -->
            <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="reviewModalLabel">후기 작성</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul class="review-list">
                                <li>
                                    <div class="review-item" onclick="location.href='<%= request.getContextPath() %>/Controller?type=review&action=write'">
                                    <span class="review-title">후기</span>
                                        <span class="arrow-icon">&gt;</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="review-item" onclick="location.href='Controller?type=review'">
                                        <span class="review-title">스타일 후기</span>
                                        <span class="arrow-icon">&gt;</span>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 반송 운송장 모달 -->
            <div class="modal fade" id="returnModal" tabindex="-1" role="dialog" aria-labelledby="returnModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="returnModalLabel">반송 운송장 입력</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form>
                                <!-- 택배사 -->
                                <div class="form-group">
                                    <label for="option-color" class="form-label">택배사</label>
                                    <select class="form-select select" id="option-color" name="option-color">
                                        <option selected>CJ대한통운</option>
                                        <option>한진택배</option>
                                        <option>로젠택배</option>
                                        <option>우체국택배</option>
                                    </select>
                                </div>
                                <!-- 송장번호 -->
                                <div class="form-group">
                                    <label for="trackingNumber" class="form-label">송장번호</label>
                                    <input type="text" id="trackingNumber" class="form-control" placeholder="송장번호를 입력하세요">
                                    <div class="form-check mt-2">
                                        <input type="checkbox" class="form-check-input" id="unknownTracking">
                                        <label class="form-check-label" for="unknownTracking">송장번호 모름</label>
                                    </div>
                                </div>
                                <!-- 반송인 -->
                                <div class="form-group">
                                    <label for="senderName" class="form-label">반송인</label>
                                    <input type="text" id="senderName" class="form-control" placeholder="반송인을 입력하세요">
                                </div>
                                <!-- 안내 메시지 -->
                                <div class="info-message">
                                    <p>- 보내신 반품의 운송장 정보를 기입해주세요.</p>
                                    <p>- 배송정보가 업데이트되면 반품의 배송 상태를 확인할 수 있습니다.</p>
                                    <p>- 배송완료가 되었다더라도 입고 및 검수까지 3일 이상 소요될 수 있습니다.</p>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-dark button">입력 완료</button>
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

    <%-- 카카오맵 --%>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script src="./user/customer/js/mypage/components/delivery.js"></script>
    <script src="./user/customer/js/mypage/components/point.js"></script>
    <script src="./user/customer/js/mypage/components/inquiry.js"></script>
    <script src="./user/customer/js/mypage/components/question.js"></script>
    <script src="./user/customer/js/mypage/components/order.js"></script>
    <script src="./user/customer/js/mypage/components/refund.js"></script>
    <script src="./user/customer/js/mypage/components/review.js"></script>
    <script src="./user/customer/js/mypage/components/coupon.js"></script>
    <script src="./user/customer/js/mypage/myPage.js"></script>

    <script>
        $(function () {
            // 초기 상태 설정 - 주문 내역 선택
            $('#btnradio-order').prop('checked', true);

            // 장바구니 체크 박스 전체 선택 / 해제 기능
            $("#cart-table #cart-all").on("click", function () {
                let ar = $("#cart-table > tbody").find(":checkbox");
                ar.prop("checked", this.checked);
            });

            // 장바구니 체크 박스 개별 선택 / 해제 기능
            $("#cart-table > tbody").find(":checkbox").on("click", function () {
                let allCheck = true;
                $("#cart-table > tbody").find(":checkbox").not("#cart-table #cart-all").each(function () {
                    if (!this.checked) {
                        allCheck = false;
                        return allCheck;
                    }
                });
                $("#cart-table #cart-all").prop("checked", allCheck);
            });

            const tabActions = {
                "#btnradio-order": "#order-article",
                "#btnradio-refund": "#refund-article",
                "#btnradio-review": "#review-article",
                "#btnradio-inquiry": "#inquiry-article",
                "#btnradio-question": "#question-article",
                "#btnradio-point": "#point-article",
                "#btnradio-coupon": "#coupon-article",
                "#btnradio-delivery": "#delivery-article"
            };

            const allTabs = Object.values(tabActions);

            // 초기 상태 설정 - 주문 내역만 보이도록
            allTabs.forEach((tab) => {
                document.querySelector(".user-action-buttons .btn-group")
                const element = document.querySelector(tab);
                if (element) {
                    element.style.display = tab === "#order-article" ? "block" : "none";
                }
            });

            // 마이페이지 클릭 이벤트 설정
            Object.keys(tabActions).forEach((buttonSelector) => {
                const button = document.querySelector(buttonSelector);
                if (button) {
                    button.addEventListener("click", function () {
                        allTabs.forEach((tab) => {
                            const element = document.querySelector(tab);
                            if (element) {
                                element.style.display = "none";
                            }
                        });

                        const toShow = tabActions[buttonSelector];
                        const showElement = document.querySelector(toShow);
                        if (showElement) {
                            showElement.style.display = "block";
                        }
                    });
                } else {
                    console.error(`Button with selector '${buttonSelector}' not found.`);
                }
            });

            // // 반품/취소/교환 탭 클릭 이벤트
            // $("#refund-nav-tabs .nav-item .nav-link").on("click", function (event) {
            //     event.preventDefault();
            //
            //     $("#refund-nav-tabs .nav-item .nav-link").removeClass("active");
            //     $(this).addClass("active");
            //
            //     $("#refund-list .list").hide();
            //     const targetTable = $(this).data("target");
            //     $(targetTable).show();
            // });
        });
    </script>
</body>
</html>
