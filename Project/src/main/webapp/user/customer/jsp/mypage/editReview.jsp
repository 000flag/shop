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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/mypage/editReview.css"/>
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
                                    <img src="${item.prod_image}" alt="상품 이미지" class="product-img">
                                    <div class="product-details">
                                        <p class="product-brand">${item.brand}</p>
                                        <p class="product-name">${item.prod_name}</p>
                                        <p class="product-option">${item.option_name} / ${item.count}개</p>
                                    </div>
                                </div>
                                <form id="review-form" action="Controller?type=review&action=update" method="POST" enctype="multipart/form-data" onsubmit="event.preventDefault(); updateReview();">
                                    <div class="review-rating">
                                        <p class="section-title">이 상품 어떠셨나요?</p>
                                        <input type="hidden" id="board_no" name="board_no" value="${item.id}">
                                        <input type="hidden" id="rating-value" name="rating" value="${item.score}" />
                                        <div class="review-score" id="review-score">
                                            <c:forEach var="i" begin="1" end="5">
                                                <i class="bi ${item.score >= i ? 'bi-star-fill' : 'bi-star'}" data-star="${i}" onclick="updateStarRating(${i})"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="review-comment">
                                        <label for="review-comment" class="section-title">어떤 점이 좋았나요?</label>
                                        <textarea id="review-comment" maxlength="500" placeholder="사용하시면서 느꼈던 장점에 대해 의견을 자세히 입력해주세요.">${item.content}</textarea>
                                        <div class="comment-footer">
                                            <span class="text-count">${fn:length(item.content)}/500</span>
                                        </div>
                                    </div>
                                    <!-- 사진 정보 -->
                                    <div class="photo-info">
                                        <div class="wrap-photo-title">
                                            <p class="section-title">사진 첨부</p>
                                        </div>
                                        <input type="file" id="photo-input" accept="image/*" style="display: none;">
                                        <div class="photo-box" onclick="triggerFileInput()">
                                            <c:choose>
                                                <c:when test="${not empty item.additional_images}">
                                                    <c:forEach var="i" items="${item.additional_images}" varStatus="st">
                                                        <img src="${fn:split(item.additional_images, ',')[st.index]}" alt="Review Image">
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="plus">+</span><br/>
                                                    <span class="add-photo">사진 추가</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <!-- 수정 버튼 -->
                                    <div class="action-buttons">
                                        <button type="submit" class="btn btn-dark">수정하기</button>
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

    <script src="./user/customer/js/mypage/editReview.js"></script>
</body>
</html>
