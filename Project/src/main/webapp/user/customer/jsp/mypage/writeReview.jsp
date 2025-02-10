<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/writeReview.css"/>
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
                        <c:if test="${requestScope.o_vo ne null}">
                        <c:set var="item" value="${requestScope.o_vo}"/>
                            <div class="review-container">
                                <div class="review-header">
                                    <div class="review-info">
                                        <span class="review-title">후기 작성</span>
                                        <div class="wrap-notice">
                                            <span class="review-notice" data-toggle="modal" data-target="#noticeModal">작성 시 유의사항</span>
                                            <span class="arrow-icon" data-toggle="modal" data-target="#noticeModal">&gt;</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-product">
                                    <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" class="product-img">
                                    <div class="product-details">
                                        <p class="product-brand">${item.brand}</p>
                                        <p class="product-name">${item.prod_name}</p>
                                        <p class="product-option">${item.option_name} / ${item.count}개</p>
                                    </div>
                                </div>
                                <form id="review-form" action="Controller?type=writeReview&action=insert" method="POST" enctype="multipart/form-data" onsubmit="event.preventDefault(); insertReview();">
                                    <div class="review-rating">
                                        <p class="section-title">이 상품 어떠셨나요?</p>
                                        <input type="hidden" id="prod_no" name="prod_no" value="${item.prod_no}">
                                        <input type="hidden" id="order_code" name="order_code" value="${item.order_code}">
                                        <input type="hidden" id="rating-value" name="rating" />
                                        <div class="rating-stars">
                                            <span class="star" data-value="1">&#9734;</span>
                                            <span class="star" data-value="2">&#9734;</span>
                                            <span class="star" data-value="3">&#9734;</span>
                                            <span class="star" data-value="4">&#9734;</span>
                                            <span class="star" data-value="5">&#9734;</span>
                                        </div>
                                    </div>
                                    <div class="review-comment">
                                        <label for="review-comment" class="section-title">어떤 점이 좋았나요?</label>
                                        <textarea id="review-comment" maxlength="500" placeholder="사용하시면서 느꼈던 장점에 대해 의견을 자세히 입력해주세요."></textarea>
                                        <div class="comment-footer">
                                            <span class="text-count">0/500</span>
                                        </div>
                                    </div>
                                    <!-- 사진 정보 -->
                                    <div class="photo-info">
                                        <div class="wrap-photo-title">
                                            <p class="section-title">사진 첨부</p>
                                        </div>
                                        <input type="file" id="photo-input" accept="image/*" style="display: none;">
                                        <div class="photo-box" onclick="triggerFileInput()">
                                            <span class="plus">+</span><br/>
                                            <span class="add-photo">사진 추가</span>
                                        </div>
                                    </div>
                                    <!-- 체형 정보 -->
                                    <%--<div class="body-info">
                                        <p class="section-title">내 체형정보를 입력해주세요 (필수)</p>
                                        <div class="gender-selection">
                                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                <label class="btn btn-outline-secondary active">
                                                    <input type="radio" name="options" id="option1" value="남성" autocomplete="off" checked>남성
                                                </label>
                                                <label class="btn btn-outline-secondary">
                                                    <input type="radio" name="options" id="option2" value="여성" autocomplete="off">여성
                                                </label>
                                            </div>
                                        </div>
                                        <div class="input-group">
                                            <input type="text" id="height" placeholder="키를 입력해주세요" />
                                            <span class="unit">cm</span>
                                        </div>
                                        <div class="input-group">
                                            <input type="text" id="weight" placeholder="몸무게를 입력해주세요" />
                                            <span class="unit">kg</span>
                                        </div>
                                        <div class="checkbox-group">
                                            <label>
                                                <input type="checkbox" id="update-body-info"> 나의 신체정보에 업데이트
                                            </label>
                                        </div>
                                    </div>--%>
                                    <!-- 등록 버튼 -->
                                    <div class="action-buttons">
                                        <button type="submit" class="btn btn-dark">등록하기</button>
                                    </div>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>

            <!-- 작성 유의사항 모달 -->
            <div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="noticeModalLabel">작성 시 유의사항</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div>
                                <ul>
                                    <li>구매 확정일로부터 30일 이내에 리뷰를 작성해야 합니다.</li>
                                    <li>리뷰는 텍스트나 사진으로 작성할 수 있습니다.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <script>
                window.location.href = "Controller?type=error";
            </script>
        </c:otherwise>
    </c:choose>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/mypage/writeReview.js"></script>
</body>
</html>
