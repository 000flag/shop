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

    <%-- Google Font : Gothic A1 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <%-- CSS --%>
    <link rel="stylesheet" type="text/css" href="./user/customer/css/product/writeQuestion.css"/>
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
                        <div class="question-title">
                            <h2 class="title">판매자에게 문의하기</h2>
                        </div>
                        <div class="product-info">
                            <c:if test="${requestScope.prod_details ne null}">
                                <input type="hidden" id="prod_no" value="${requestScope.prod_details.id}"/>
                                <img src="${fn:split(requestScope.prod_details.prod_image, ',')[0]}" alt="상품 이미지" class="product-image">
                                <div class="product-details">
                                    <p class="product-title">${requestScope.prod_details.name}</p>
                                    <span class="discount">${requestScope.prod_details.sale}%</span> <span class="price"><fmt:formatNumber value="${requestScope.prod_details.saled_price}"/>원</span>
                                </div>
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label for="question-type" class="form-label">문의 유형 (필수)</label>
                            <select id="question-type" name="question-type" class="form-control">
                                <option value="0" selected>:: 문의 유형을 선택하세요 ::</option>
                                <option value="19">사이즈</option>
                                <option value="20">배송</option>
                                <option value="21">재입고</option>
                                <option value="22">상품상세문의</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="question-title" class="form-label">제목 (필수)</label>
                            <input type="text" id="question-title" name="question-title" class="form-control" placeholder="30자 이내로 입력해주세요">
                        </div>
                        <div class="form-check">
                            <input type="checkbox" id="question-private-check" name="question-private-check" class="form-check-input">
                            <label for="question-private-check" class="form-check-label">비밀글</label>
                        </div>
                        <div class="form-group">
                            <label for="question-content" class="form-label">내용 (필수)</label>
                            <textarea id="question-content" name="question-content" cols="135" rows="8"></textarea>
                        </div>
                        <div class="form-group">
                            <input type="file" id="question-image" style="display: none;" />
                            <label for="question-image" class="form-label">사진</label>
                            <div class="upload-box" onclick="openFileExplorer()">
                                <span class="plus-sign">+</span>
                            </div>
                        </div>
                        <div class="notice">
                            <p>* 상품문의는 재입고, 사이즈, 배송 등 상품에 대하여 브랜드 담당자에게 문의하는 게시판입니다.</p>
                            <p>* 욕설, 비방, 개인 거래, 논쟁 유발, 판매처, 허위 사실 유포, 타 쇼핑몰 언급, 광고성 등의 부적절한 게시글은 금지됩니다. 답변이 임의 삭제되며 작성이 제한됩니다.</p>
                            <p>* 주문번호, 연락처, 계좌번호 등의 개인 정보는 공개되지 않도록 비밀글로 문의해 주시기 바랍니다. 공개 게시판은 비밀글로 설정할 수 있으며, 개인 정보 노출로 인한 피해는 무신사 스토어가 책임지지 않습니다.</p>
                        </div>
                        <div class="action-buttons">
                            <button class="btn btn btn-secondary cancel-btn" onclick="location.href='Controller?type=productDetails'">취소</button>
                            <button class="btn btn-dark submit-btn" onclick="insertQuestion()">등록</button>
                        </div>
                    </div>
                </div>

                <!-- footer -->
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

    <script src="./user/customer/js/product/writeQuestion.js"></script>
</body>
</html>
