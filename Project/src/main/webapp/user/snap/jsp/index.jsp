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

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/css/index/index.css"/>
</head>
<body>
<%-- header --%>
<jsp:include page="/user/snap/jsp/layout/header.jsp"></jsp:include>

<div class="wrap">
    <div class="row">
        <div class="container">
            <div id="accordion" class="product-menu">
                <c:forEach var="major" items="${sessionScope.categories}">
                    <c:if test="${major.name ne null}">
                        <div class="card">
                            <div class="card-header" id="${major.ename}Heading">
                                <button class="btn btn-link d-flex justify-content-between align-items-center toggle-btn" data-toggle="collapse" data-target="#${major.ename}Collapse" aria-expanded="false" aria-controls="${major.ename}Collapse">
                                    <span class="text-left">${major.name} <span class="badge badge-secondary">${major.ename}</span></span>
                                    <i class="bi bi-plus"></i>
                                </button>
                            </div>
                            <div id="${major.ename}Collapse" class="collapse" aria-labelledby="${major.ename}Heading" data-parent="#accordion">
                                <div class="card-body">
                                    <ul class="list-unstyled">
                                        <c:forEach var="middle" items="${major.middleCategories}">
                                            <c:if test="${middle.major_no eq major.id}">
                                                <li><button class="unstyled-btn" data-name="${middle.name}" data-value="${middle.id}">${middle.name}</button></li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <div class="product-section">
                <div class="sorting-bar">
                    <div class="selected-filters">
                        <button class="unstyled-btn selected-item d-none">
                            <span class="item-text"></span>
                            <i class="bi bi-x remove-item"></i>
                        </button>
                    </div>

                    <div class="sort-pagination-container">
                        <div class="sort-dropdown">
                            <div class="dropdown-items">
                                <div class="dropdown-item active" data-value="recommend">추천순</div>
                                <div class="dropdown-item" data-value="new">신상품(재입고)순</div>
                                <div class="dropdown-item" data-value="low-price">낮은 가격순</div>
                                <div class="dropdown-item" data-value="high-price">높은 가격순</div>
                                <div class="dropdown-item" data-value="discount-rate">할인율순</div>
                                <div class="dropdown-item" data-value="review">후기순</div>
                                <div class="dropdown-item" data-value="sales">판매순</div>
                            </div>
                        </div>
                        <nav aria-label="Page navigation" class="navigation">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">1</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">2</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#">3</a>
                                </li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div class="product-list d-flex flex-wrap">
                    <c:forEach begin="1" end="9" varStatus="st">
                        <div class="product-item" onclick="location.href='Controller?type=productDetails'">
                            <img src="./user/images/product${st.index}.jpg" alt="상품 이미지" class="product-image">
                            <div class="product-info">
                                <p class="product-brand"><strong>브랜드명</strong></p>
                                <p class="product-name">상품 이름 상품 이름 상품 이름 상품 이름 상품 이름 상품 이름</p>
                                <p class="product-price">
                                    <del>29,100원</del>
                                    <strong>19,000원</strong>
                                </p>
                                <div class="product-rating">
                                        <span class="stars">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <span class="star-count">137</span>
                                        </span>
                                </div>
                                <div class="product-likes">
                                    <i class="bi bi-heart-fill"></i>
                                    <span class="like-count">100</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <%-- footer --%>
    <jsp:include page="/user/snap/jsp/layout/footer.jsp"></jsp:include>
</div>

<%-- JQuery --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<%-- Bootstrap --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="./user/JS/index/index.js"></script>
</body>
</html>