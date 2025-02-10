<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/like/like.css"/>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.customer_info}">
            <%-- header --%>
            <jsp:include page="../layout/header.jsp"></jsp:include>

            <div class="wrap">
                <div class="row">
                    <div class="container">
                        <div class="text-title">
                            <h3>좋아요</h3>
                        </div>

                        <div id="prod-like-list" class="product-list">
                            <c:choose>
                                <c:when test="${not empty requestScope.like_list}">
                                    <c:forEach var="item" items="${requestScope.like_list}">
                                        <div class="product-item">
                                            <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.prod_no}'">
                                            <div class="product-info">
                                                <div class="brand-like">
                                                    <h4 onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.prod_no}'">${item.brand}</h4>
                                                    <i class="bi bi-heart-fill" onclick="toggleHeart(this, ${item.prod_no})"></i>
                                                </div>
                                                <div class="product-card" onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.prod_no}'">
                                                    <p>${item.p_name}</p>
                                                    <span class="price">
                                                <c:if test="${item.sale ne null}">
                                                    <span class="discount">${item.sale}%</span>
                                                </c:if>
                                                <c:choose>
                                                    <c:when test="${item.saled_price ne null}">
                                                        <fmt:formatNumber value="${item.saled_price}"/>원
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${item.price}"/>원
                                                    </c:otherwise>
                                                </c:choose>
                                                </span>
                                                    <span class="rating-like">
                                                    <i class="bi bi-heart-fill"></i>
                                                    <fmt:formatNumber value="${item.like_count}"/>
                                                </span>
                                                    <span class="rating-review">
                                                    <i class="bi bi-star-fill"></i>
                                                    <fmt:formatNumber value="${item.avg_score}"/> (<fmt:formatNumber value="${item.review_count}"/>)
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-message-container">
                                        <span>좋아요한 상품이 없습니다.</span>
                                        <span>관심 있는 상품을 모아보세요.</span>
                                        <a href="Controller">
                                            <button type="button" class="btn btn-outline-secondary">상품 보러가기</button>
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
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

    <script src="./user/customer/js/like/like.js"></script>
</body>
</html>
