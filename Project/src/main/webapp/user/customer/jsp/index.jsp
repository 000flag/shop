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
    <link rel="stylesheet" type="text/css" href="./user/customer/css/index/index.css"/>
</head>
<body>
    <%-- header --%>
    <jsp:include page="layout/header.jsp"></jsp:include>

    <div class="wrap" id="index">
        <div class="row">
            <div class="container">
                <div id="accordion" class="product-menu">
                    <c:forEach var="major" items="${requestScope.categories}" varStatus="st">
                        <c:if test="${major.name ne null}">
                            <div class="card">
                                <div class="card-header" id="${major.ename}Heading">
                                    <button class="btn btn-link d-flex justify-content-between align-items-center toggle-btn" data-toggle="collapse" data-target="#${major.ename}Collapse" aria-expanded="false" aria-controls="${major.ename}Collapse">
                                        <span class="text-left">${major.name} <span class="badge badge-secondary">${major.ename}</span></span>
                                        <i class="bi bi-plus"></i>
                                    </button>
                                </div>
                                <div id="${major.ename}Collapse" class="collapse <c:if test='${st.first}'>show</c:if>" aria-labelledby="${major.ename}Heading" data-parent="#accordion">
                                    <div class="card-body">
                                        <ul class="list-unstyled" id="list-unstyled">
                                            <c:forEach var="middle" items="${major.middleCategories}" varStatus="subSt">
                                                <c:if test="${middle.major_no eq major.id}">
                                                    <li>
                                                        <button class="unstyled-btn <c:if test='${subSt.first}'>active</c:if>" data-name="${middle.name}" data-value="${middle.id}">
                                                                ${middle.name}
                                                        </button>
                                                    </li>
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
                            </button>
                        </div>
                        <div class="sort-pagination-container">
                            <div class="sort-dropdown">
                                <div class="dropdown-items">
                                    <div class="dropdown-item active" data-value="1">신상품(재입고)순</div>
                                    <div class="dropdown-item" data-value="2">낮은 가격순</div>
                                    <div class="dropdown-item" data-value="3">높은 가격순</div>
                                    <div class="dropdown-item" data-value="4">할인율순</div>
                                    <div class="dropdown-item" data-value="5">판매순</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="product-list" id="product-list">
                        <jsp:include page="product/components/productList.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>

        <%-- footer --%>
        <jsp:include page="layout/footer.jsp"></jsp:include>
    </div>

    <%-- JQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <%-- Bootstrap --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script src="./user/customer/js/index/index.js"></script>
</body>
</html>
