<%@ page import="comm.vo.seller.ProductVO" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 1. 14.
  Time: 오후 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        #nav_product{
            background-color:#dddddd;
        }
        #table th{
            border: 1px solid black;
            border-collapse: collapse;
            text-align: center;
            background-color: #222222;
            color: white;
            height: 30px;
        }
        #content{
           margin: 0;
            margin-top: 100px;
        }
        #table td{
            border: 1px solid #999999;
            border-collapse: collapse;
            text-align: center;
            vertical-align: middle;
        }
        .stock {
            width: 80px;
        }
        .center{
            text-align: center;
        }
        .filter-section {
            margin-bottom: 20px;
        }
        .product-image {
            width: 100px;
            height: 80px;
            object-fit: cover; /* 이미지를 100x100으로 잘라줌 */
        }
        .flex{
            display: flex;
        }
        .search{
            height: 40px;
            margin-top: 23px;
            margin-left: 5px;}
        .form-group{
            margin-right: 10px;
        }
    </style>
    <jsp:include page="./layout/header.jsp"/>
</head>
<body>

<div class="container mt-5">
    <h3 class="center">상품/재고 관리</h3>
    <hr/>
    <div id="search">
    </div>
    <div id="content" class="table-container">
        <form method="post" action="Controller?type=searchProduct" accept-charset="utf-8">
            <div class="filter-section">
                <div class="form-row flex">
                    <div class="form-group col-md-3">
                        <label for="category">카테고리</label>
                        <select id="category" name="category" class="form-control">
                            <option value="0">전체</option>
                            <option value="1">상의</option>
                            <option value="2">하의</option>
                            <option value="3">아우터</option>
                            <option value="4">신발</option>
                            <option value="5">악세사리</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3" >
                        <label for="prod_name">검색어</label>
                        <input type="text" class="form-control" id="prod_name" name="prod_name">
                    </div>
                    <button type="button" class="btn btn-primary mb-4 search" onclick="searchProduct(this.form)">조회</button>
                </div>
            </div>
        </form>
        <table id="table" class="table table-bordered">
            <colgroup>
                <col width="90px">
                <col width="100px">
                <col width="*">
                <col width="100px">
                <col width="100px">

                <col width="120px">
                <col width="80px">
            </colgroup>
            <thead>
            <tr>
                <th>상품번호</th>
                <th>사진</th>
                <th>상품이름</th>
                <th>가격</th>
                <th>할인</th>

                <th>활성화</th>
                <th>삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prod" items="${ar}" varStatus="vs">
                <tr>
                    <td>${prod.id}</td>
                    <td><img src="${prod.prod_image}" class="card-img-top product-image" alt="Product Image"></td>
                    <td style="text-align: center">
                        <a href="Controller?type=productEdit&prod_no=${prod.id}&cPage=${pvo.nowPage}">
                                ${prod.name}
                        </a>
                    </td>
                    <td>${prod.price }원</td>
                    <td>${prod.sale }%</td>
                    <td>
                        <select id="active" onchange="changeActive(${prod.id})" name="active">
                            <option value="0" <c:if test="${prod.active == 0}">selected</c:if>>판매</option>
                            <option value="1" <c:if test="${prod.active == 1}">selected</c:if>>판매중지</option>
                        </select>
                    </td>
                    <td><button type="button" onclick="deleteProduct(this)">삭제</button></td>
                </tr>
            </c:forEach>
            <c:if test="${ar eq null or fn:length(ar) eq 0 }">
                <tr>
                    <td colspan="7">현재 등록된 데이터가 없습니다.</td>
                </tr>
            </c:if>

            </tbody>
            <tfoot>
            <tr>
                <td colspan="6">
                    <ol class="paging">
                        <c:if test="${requestScope.page ne null}">
                            <c:set var="pvo" value="${requestScope.page}"/>
                            <c:if test="${pvo.startPage<pvo.pagePerBlock}">
                                <li class="disable"><</li>
                            </c:if>
                            <c:if test="${pvo.startPage >= pvo.pagePerBlock }">
                                <li><a href="Controller?type=list&cPage=${pvo.startPage - pvo.pagePerBlock }">&lt;</a></li>
                            </c:if>
                            <c:forEach begin="${pvo.startPage }" end="${pvo.endPage }"
                                       varStatus="st">
                                <c:if test="${st.index eq pvo.nowPage }">
                                    <li class="now">${st.index }</li>
                                </c:if>
                                <c:if test="${st.index ne pvo.nowPage }">
                                    <li>
                                        <a href="Controller?type=list&cPage=${st.index }">${st.index }</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${pvo.endPage < pvo.totalPage }">
                                <li><a href="Controller?type=list&cPage=${pvo.startPage+pvo.pagePerBlock }">&gt;</a></li>
                            </c:if>
                            <c:if test="${pvo.endPage >= pvo.totalPage }">
                                <li class="disable">&gt;</li>
                            </c:if>
                        </c:if>
                    </ol>
                </td>
                <td>
                    <input type="button" value="상품추가"
                           onclick="javascript:location.href='Controller?type=productNew'"/>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    $(function(){
        $("#category, #prod_name").on("keydown", function(event) {
            if (event.key === "Enter") {
                event.preventDefault(); // 기본 엔터 동작(폼 제출) 방지
                $(".search").click();   // 조회 버튼 클릭 이벤트 실행
            }
        });
    });
    function changeActive(prod_no){
        const active = $("#active").val();  // 선택된 상태 값 (0 또는 1)

        // Ajax 요청 보내기
        $.ajax({
            url: "Controller?type=changeActive", // 서버에서 처리할 URL
            type: "POST",
            data: {
                prod_no: prod_no,
                active: active
            },
            dataType: "json",
        }).done(function(res){
            if(res.cnt>0){
                alert("변경완료!");

            }else{
                alert("변경 실패!");
            }
        });
    }
    function deleteProduct(button) {
        // 버튼에서 가장 가까운 행(Row) 찾기
        const row = $(button).closest('tr');

        // 필요한 데이터 가져오기
        const prodNo = row.find('td:first').text().trim(); // 상품 번호 (첫 번째 셀)

        if (!confirm("정말로 이 상품을 삭제하시겠습니까?")) {
            return;
        }

        // Ajax 요청 보내기
        $.ajax({
            url: "Controller?type=deleteProduct", // 서버에서 처리할 URL
            type: "POST",
            data: "prod_no=" + encodeURIComponent(prodNo),
            dataType: "json",
        }).done(function(res){
            if(res.cnt>0){
                alert("변경완료!");
                row.remove();
            }else{
                alert("변경 실패!");
            }
        });
    }
    function searchProduct(frm) {
        const category = frm.category.value;
        const prod_name = frm.prod_name.value;
        let param = "type=searchProduct&category="+encodeURIComponent(category)+"&prod_name="+encodeURIComponent(prod_name);

        $.ajax({
            url: "Controller", // 서버에서 JSON 응답을 받는 URL
            type: "POST",
            data: param,
            dataType: "json", // 서버에서 JSON 형태로 응답받음
            success: function(res) {
                const tableBody = $("#table tbody");
                tableBody.empty(); // 기존 테이블 내용 비우기

                // 서버에서 받은 JSON 데이터 처리
                if (res.ar.length > 0) {
                    // 반복문을 통해 테이블에 데이터 추가
                    res.ar.forEach(vo => {

                        const row = `
                            <tr>
                                <td>`+ vo.id +`</td>
                                <td><img src="${pageContext.request.contextPath}/seller/images/product2.jpg" class="product-image" alt="Product Image"></td>
                                <td style="text-align: center">
                                    <a href="Controller?type=productEdit&prod_no=`+ vo.id +`&cPage=${pvo.nowPage}">
                                        `+ vo.name +`
                                    </a>
                                </td>
                                <td>`+ vo.price +`원</td>
                                <td>`+ vo.sale +`%</td>
                                <td>
                                    <select id="active" onchange="changeActive(`+ vo.id +`)">
                                        <option value="0" `+ (vo.active == 0 ? 'selected' : '') +`>판매</option>
                                        <option value="1" `+ (vo.active == 1 ? 'selected' : '') +`>판매중지</option>
                                    </select>
                                </td>
                                <td><button type="button" onclick="deleteProduct(this)">삭제</button></td>
                            </tr>
                            `;
                        tableBody.append(row);
                    });
                } else {
                    // 검색 결과가 없는 경우
                    const emptyRow = `
                    <tr>
                        <td colspan="7" class="text-center">검색 결과가 없습니다.</td>
                    </tr>
                `;
                    tableBody.append(emptyRow);
                }
            },
            error: function() {
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });

        return false; // 폼 제출 방지
    }
</script>
</body>
<footer>
    <jsp:include page="./layout/footer.jsp"/>
</footer>
</html>
