<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="product-container">
    <div class="pagination-container">
        <c:if test="${requestScope.paging ne null}">
            <c:set var="paging" value="${requestScope.paging}"/>
            <nav aria-label="Page navigation" class="navigation">
                <ul class="pagination">
                    <c:if test="${paging.startPage >= paging.pagePerBlock}">
                        <li class="page-item">
                            <a class="page-link" href="javascript:selectProducts(${paging.startPage - paging.pagePerBlock})" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" varStatus="st">
                        <c:if test="${st.index eq paging.nowPage}">
                            <li class="page-item">
                                <a class="page-link active" href="#">${st.index}</a>
                            </li>
                        </c:if>
                        <c:if test="${st.index ne paging.nowPage}">
                            <li class="page-item">
                                <a class="page-link" href="javascript:selectProducts(${st.index})">${st.index}</a>
                            </li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${paging.endPage < paging.totalPage}">
                        <li class="page-item">
                            <a class="page-link" href="javascript:selectProducts(${paging.startPage + paging.pagePerBlock})" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>

    <div class="product-grid">
        <c:if test="${requestScope.products ne null}">
            <c:forEach var="item" items="${requestScope.products}">
                <div class="product-item">
                    <img src="${fn:split(item.prod_image, ',')[0]}" alt="상품 이미지" class="product-image" onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.id}'">
                    <div class="product-info">
                        <p class="product-brand">
                            <strong onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.id}'">${item.brand}</strong>
                            <c:choose>
                                <c:when test="${not empty sessionScope.customer_info}">
                                    <c:choose>
                                        <c:when test="${item.user_like_status == '1'}">
                                            <i class="bi bi-heart-fill" onclick="toggleProdHeart(this, ${item.id})"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="bi bi-heart" onclick="toggleProdHeart(this, ${item.id})"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-heart" onclick="notLoginLike()"></i>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <div onclick="location.href='Controller?type=productDetails&action=select&prod_no=${item.id}'">
                            <p class="product-name">${item.name}</p>
                            <p class="product-price">
                                <del><fmt:formatNumber value="${item.price}"/>원</del>
                                <strong><fmt:formatNumber value="${item.saled_price}"/>원</strong>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
</div>
