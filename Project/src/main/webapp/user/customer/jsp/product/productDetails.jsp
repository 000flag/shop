<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./user/images/share_musinsa.png">
    <title>무신사</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="./user/customer/css/product/productDetails.css"/>
</head>
<body>
    <!-- header -->
    <jsp:include page="../layout/header.jsp"></jsp:include>

    <div class="wrap">
        <div class="row">
            <div class="container">
                <c:if test="${not empty requestScope.productDetails}">
                    <c:set var="pvo" value="${requestScope.productDetails}"/>
                    <div class="product-overview">
                        <h2 class="product-title">${pvo.name}</h2>
                        <p class="brand"><strong>브랜드</strong> <a href="#">${pvo.brand}</a></p>
                        <p class="product-category"><strong>제품분류</strong> <a href="#">${pvo.ma_category_name}</a> | <a href="#">${pvo.mi_category_name}</a></p>
                    </div>
                    <div class="product-details">
                        <div class="image-section">
                            <div id="carouselControls" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <c:choose>
                                        <c:when test="${fn:length(fn:split(pvo.additional_images, ',')) > 1}">
                                            <c:forEach var="img" items="${fn:split(pvo.additional_images, ',')}" varStatus="st">
                                                <div class="carousel-item ${st.first ? 'active' : ''}">
                                                    <img class="d-block w-100 product-image" src="${img}" alt="slide_image_${st.index}">
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="carousel-item active">
                                                <img class="d-block w-100 product-image" src="${pvo.additional_images}" alt="single_image">
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <a class="carousel-control-prev" href="#carouselControls" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselControls" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                        <div class="info-section">
                            <div class="product-info">
                                <h3>PRODUCT INFO <span class="info-subtitle">제품정보</span></h3>
                                <p><i class="bi bi-dash"></i> 제품번호 <strong id="prod_id" data-item="${pvo.id}">${pvo.id}</strong></p>
                                <p><i class="bi bi-dash"></i> 성별 <strong id="prod_season">여</strong></p>
                                <p><i class="bi bi-dash"></i> 누적판매 <strong id="prod_sale_count"><fmt:formatNumber value="${pvo.sales_count}"/>개</strong></p>
                                <p><i class="bi bi-dash"></i> 좋아요 <span class="like-count"><i class="bi bi-heart-fill"></i> <strong id="prod_like_count"><fmt:formatNumber value="${pvo.like_count}"/></strong></span></p>
                                <p>
                                    <i class="bi bi-dash"></i> 구매후기
                                    <span class="stars">
                                        <c:if test="${pvo.avg_score ne null}">
                                            <c:choose>
                                                <c:when test="${pvo.avg_score >= 1.0 && pvo.avg_score < 1.5}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 1.5 && pvo.avg_score < 2.0}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-half"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 2.0 && pvo.avg_score < 2.5}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 2.5 && pvo.avg_score < 3.0}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-half"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 3.0 && pvo.avg_score < 3.5}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 3.5 && pvo.avg_score < 4.0}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-half"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 4.0 && pvo.avg_score < 4.5}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:when>
                                                <c:when test="${pvo.avg_score >= 4.5 && pvo.avg_score <= 5.0}">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                    <i class="bi bi-star"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                        <span class="star-count">
                                            <fmt:formatNumber value="${pvo.review_count}"/>개
                                        </span>
                                    </span>
                                </p>
                            </div>
                            <div class="delivery-info">
                                <h3>DELIVERY INFO <span class="info-subtitle">배송정보</span></h3>
                                <p><i class="bi bi-dash"></i> 배송방법 <strong>국내 배송 / 입점사 배송</strong></p>
                                <p><i class="bi bi-dash"></i> 평균 배송기간 <strong>1.2일 (${pvo.courier})</strong></p>
                            </div>
                            <div class="price-info">
                                <h3>PRICE INFO <span class="info-subtitle">가격정보</span></h3>
                                <p><i class="bi bi-dash"></i> 무신사 판매가 <span class="price-original"><strong><del><fmt:formatNumber value="${pvo.price}"/>원</del></strong></span></p>
                                <p><i class="bi bi-dash"></i> 무신사 세일가 <span class="price-sale"><strong><fmt:formatNumber value="${pvo.saled_price}"/>원</strong></span> <span class="discount">(${pvo.sale}% 할인)</span></p>
                            </div>
                            <c:if test="${empty sessionScope.isLoggedIn}">
                                <div class="alert alert-danger" role="alert">
                                    로그인 시 구매 가능합니다.
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.isLoggedIn}">
                                <div class="prod-size">
                                    <i class="bi bi-dash"></i> 사이즈
                                    <select class="form-select" aria-label="size select" id="cart-select-size">
                                        <option value="0">:: 선택하세요 ::</option>
                                        <c:if test="${requestScope.productSize ne null}">
                                            <c:forEach var="size" items="${requestScope.productSize}">
                                                <option value="${size.i_option_name}" data-value="${size.inventory_no}">
                                                        ${size.i_option_name}
                                                    <c:choose>
                                                        <c:when test="${size.count < 5}">
                                                            (${size.count}개 - 품절 임박!)
                                                        </c:when>
                                                        <c:otherwise>
                                                            (${size.count}개)
                                                        </c:otherwise>
                                                    </c:choose>
                                                </option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="cart-count">
                                    <i class="bi bi-dash"></i> 개수
                                    <button type="button" class="btn btn-outline-secondary btn-minus">-</button>
                                    <span class="cart-count-value" id="count-value">0</span>
                                    <button type="button" class="btn btn-outline-secondary btn-plus">+</button>
                                </div>
                                <div class="actions">
                                    <c:choose>
                                        <c:when test="${requestScope.product_like ne null}">
                                            <i class="bi bi-heart-fill like-btn" onclick="toggleProdDetailsHeart(this, ${pvo.id})"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-heart like-btn" onclick="toggleProdDetailsHeart(this, ${pvo.id})"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="btn btn-dark add-to-cart" onclick="insertCart()"><i class="bi bi-cart4"></i> 장바구니 담기</button>
                                    <button class="btn btn-dark buy-now" onclick="onMovePayment()"><i class="bi bi-credit-card"></i> 구매하기</button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="tabs">
                        <button class="tab-btn active" data-target="detail">상세 이미지</button>
                        <button class="tab-btn" data-target="size">사이즈</button>
                        <button class="tab-btn" data-target="review">리뷰</button>
                        <button class="tab-btn" data-target="question" data-value="${pvo.id}">문의</button>
                    </div>
                    <div class="tab-content">
                        <div id="detail" class="tab-panel active">
                            <div class="detail-images-section">
                                <img src="${pvo.content}" alt="Detail Image 1" class="detail-image">
                            </div>
                        </div>
                        <div id="size" class="tab-panel">
                            <div class="size-table-section">
                                <table class="size-table">
                                    <thead>
                                        <tr>
                                            <th>사이즈</th>
                                            <c:choose>
                                                <c:when test="${pvo.ma_category_name eq '상의' or pvo.ma_category_name eq '아우터'}">
                                                    <th>총장 (cm)</th>
                                                    <th>어깨너비 (cm)</th>
                                                    <th>가슴단면 (cm)</th>
                                                    <th>소매길이 (cm)</th>
                                                </c:when>
                                                <c:when test="${pvo.ma_category_name eq '하의'}">
                                                    <th>총장 (cm)</th>
                                                    <th>허리단면 (cm)</th>
                                                    <th>엉덩이단면 (cm)</th>
                                                    <th>허벅지단면 (cm)</th>
                                                    <th>밑위 (cm)</th>
                                                    <th>밑위단면 (cm)</th>
                                                </c:when>
                                                <c:when test="${pvo.ma_category_name eq '신발'}">
                                                    <th>신발길이 (cm)</th>
                                                    <th>발볼 (cm)</th>
                                                    <th>발목길이 (cm)</th>
                                                    <th>굽높이 (cm)</th>
                                                </c:when>
                                            </c:choose>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${requestScope.productSize ne null}">
                                            <c:forEach var="size" items="${requestScope.productSize}">
                                                <tr>
                                                    <td>${size.i_option_name}</td>
                                                    <c:if test="${size.total_length ne null and size.total_length ne '0'}">
                                                        <td>${size.total_length}</td>
                                                    </c:if>
                                                    <c:if test="${size.shoulder ne null and size.shoulder ne '0'}">
                                                        <td>${size.shoulder}</td>
                                                    </c:if>
                                                    <c:if test="${size.chest ne null and size.chest ne '0'}">
                                                        <td>${size.chest}</td>
                                                    </c:if>
                                                    <c:if test="${size.sleeve ne null and size.sleeve ne '0'}">
                                                        <td>${size.sleeve}</td>
                                                    </c:if>
                                                    <c:if test="${size.waist ne null and size.waist ne '0'}">
                                                        <td>${size.waist}</td>
                                                    </c:if>
                                                    <c:if test="${size.hip ne null and size.hip ne '0'}">
                                                        <td>${size.hip}</td>
                                                    </c:if>
                                                    <c:if test="${size.thigh ne null and size.thigh ne '0'}">
                                                        <td>${size.thigh}</td>
                                                    </c:if>
                                                    <c:if test="${size.rise ne null and size.rise ne '0'}">
                                                        <td>${size.rise}</td>
                                                    </c:if>
                                                    <c:if test="${size.hem ne null and size.hem ne '0'}">
                                                        <td>${size.hem}</td>
                                                    </c:if>
                                                    <c:if test="${size.foot_length ne null and size.foot_length ne '0'}">
                                                        <td>${size.foot_length}</td>
                                                    </c:if>
                                                    <c:if test="${size.foot_width ne null and size.foot_width ne '0'}">
                                                        <td>${size.foot_width}</td>
                                                    </c:if>
                                                    <c:if test="${size.ankle_height ne null and size.ankle_height ne '0'}">
                                                        <td>${size.ankle_height}</td>
                                                    </c:if>
                                                    <c:if test="${size.heel_height ne null and size.heel_height ne '0'}">
                                                        <td>${size.heel_height}</td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div id="review" class="tab-panel">
                            <div class="review-content">
                                <jsp:include page="./components/reviewList.jsp"></jsp:include>
                            </div>
                        </div>
                        <div id="question" class="tab-panel">
                            <div class="question-list" id="question-list">
                                <jsp:include page="./components/questionList.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- footer -->
        <jsp:include page="../layout/footer.jsp"></jsp:include>
    </div>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/product/productDetails.js"></script>
</body>
</html>
