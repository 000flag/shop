<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 2. 7.
  Time: 오후 4:46
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/table.css">
</head>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>
<div class="col-9">


    <div class="d-flex justify-content-between align-items-center">

        <h5>로그 목록 0-삭제</h5>

    </div>

    <div class="mt-3">
        <div class="input-group">
            <!-- 검색 아이콘 -->
            <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
            <select class="form-select" aria-label="Default select example" id="log0_name">

                <option value="root_no"> 관리자번호</option>
                <option value="seller_no">판매자번호</option>
                <option value="cus_no">고객번호</option>
                <option value="writer_type">작성자종류</option>
                <option value="target">대상</option>
                <option value="prev">이전</option>
                <option value="current">현재</option>
                <option value="log_date">로그일자</option>
            </select>


            <!-- 검색 입력 -->
            <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="log0_word">
            <!-- 드롭다운 버튼 -->
            <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="log0_search_btn">
                검색
            </button>
            <!-- 드롭다운 메뉴 -->
            <%--<ul class="dropdown-menu dropdown-menu-end">
                <c:forEach var="name" items="${majorcategoryName}" begin="1">
                    <li><a class="dropdown-item" href="#">${name}</a></li>
                </c:forEach>
            </ul>--%>
        </div>
    </div>

    <table class="table mt-3" id="log0_table">
        <thead class="table-light">

        <tr>

            <th>관리자번호</th>
            <th>판매자번호</th>
            <th>고객번호</th>
            <th>작성자종류</th>
            <th>대상</th>
            <th>이전</th>
            <th>현재</th>
            <th>로그일자</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var ="log0l"  items="${logList}">
            <c:if test="${log0l.log_type eq 0}">

                <tr >

                    <td>${log0l.root_no}</td>
                    <td>${log0l.seller_no}</td>
                    <td>${log0l.cus_no}</td>
                    <td>${log0l.writer_type}</td>
                    <td>${log0l.target}</td>
                    <td>${log0l.prev}</td>
                    <td>${log0l.current}</td>
                    <td>${log0l.log_date}</td>

                </tr>
            </c:if>

        </c:forEach>
        </tbody>
    </table>

    <div class="mt-3 mb-4">
        <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=logsee'">초기화</button>
    </div>
    <hr/>
    <div class="d-flex justify-content-between align-items-center">

        <h5>로그 목록 1-추가</h5>

    </div>

    <div class="mt-3">
        <div class="input-group">
            <!-- 검색 아이콘 -->
            <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
            <select class="form-select" aria-label="Default select example" id="log1_name">

                <option value="root_no"> 관리자번호</option>
                <option value="seller_no">판매자번호</option>
                <option value="cus_no">고객번호</option>
                <option value="writer_type">작성자종류</option>
                <option value="target">대상</option>
                <option value="prev">이전</option>
                <option value="current">현재</option>
                <option value="log_date">로그일자</option>
            </select>


            <!-- 검색 입력 -->
            <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="log1_word">
            <!-- 드롭다운 버튼 -->
            <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="log1_search_btn">
                검색
            </button>
            <!-- 드롭다운 메뉴 -->
            <%--<ul class="dropdown-menu dropdown-menu-end">
                <c:forEach var="name" items="${majorcategoryName}" begin="1">
                    <li><a class="dropdown-item" href="#">${name}</a></li>
                </c:forEach>
            </ul>--%>
        </div>
    </div>

    <table class="table mt-3" id="log1_table">
        <thead class="table-light">

        <tr>

            <th>관리자번호</th>
            <th>판매자번호</th>
            <th>고객번호</th>
            <th>작성자종류</th>
            <th>대상</th>
            <th>이전</th>
            <th>현재</th>
            <th>로그일자</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var ="log1l"  items="${logList}">
            <c:if test="${log1l.log_type eq 1}">

                <tr >

                    <td>${log1l.root_no}</td>
                    <td>${log1l.seller_no}</td>
                    <td>${log1l.cus_no}</td>
                    <td>${log1l.writer_type}</td>
                    <td>${log1l.target}</td>
                    <td>${log1l.prev}</td>
                    <td>${log1l.current}</td>
                    <td>${log1l.log_date}</td>

                </tr>
            </c:if>

        </c:forEach>
        </tbody>
    </table>

    <div class="mt-3 mb-4">
        <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=logsee'">초기화</button>
    </div>
    <hr/>

    <div class="d-flex justify-content-between align-items-center">

        <h5>로그 목록 2-삭제</h5>

    </div>

    <div class="mt-3">
        <div class="input-group">
            <!-- 검색 아이콘 -->
            <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
            <select class="form-select" aria-label="Default select example" id="log2_name">

                <option value="root_no"> 관리자번호</option>
                <option value="seller_no">판매자번호</option>
                <option value="cus_no">고객번호</option>
                <option value="writer_type">작성자종류</option>
                <option value="target">대상</option>
                <option value="prev">이전</option>
                <option value="current">현재</option>
                <option value="log_date">로그일자</option>
            </select>


            <!-- 검색 입력 -->
            <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="log2_word">
            <!-- 드롭다운 버튼 -->
            <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="log2_search_btn">
                검색
            </button>
            <!-- 드롭다운 메뉴 -->
            <%--<ul class="dropdown-menu dropdown-menu-end">
                <c:forEach var="name" items="${majorcategoryName}" begin="1">
                    <li><a class="dropdown-item" href="#">${name}</a></li>
                </c:forEach>
            </ul>--%>
        </div>
    </div>

    <table class="table mt-3" id="log2_table">
        <thead class="table-light">

        <tr>

            <th>관리자번호</th>
            <th>판매자번호</th>
            <th>고객번호</th>
            <th>작성자종류</th>
            <th>대상</th>
            <th>이전</th>
            <th>현재</th>
            <th>로그일자</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var ="log2l"  items="${logList}">
            <c:if test="${log2l.log_type eq 2}">

                <tr >

                    <td>${log2l.root_no}</td>
                    <td>${log2l.seller_no}</td>
                    <td>${log2l.cus_no}</td>
                    <td>${log2l.writer_type}</td>
                    <td>${log2l.target}</td>
                    <td>${log2l.prev}</td>
                    <td>${log2l.current}</td>
                    <td>${log2l.log_date}</td>

                </tr>
            </c:if>

        </c:forEach>
        </tbody>
    </table>

    <div class="mt-3 mb-4">
        <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=logsee'">초기화</button>
    </div>
</div>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    $(function (){
        $("#log0_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#log0_name").val();
            let word = $("#log0_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchLog0&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#log0_table tbody").html(data);
            });
        });
        $("#log1_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#log1_name").val();
            let word = $("#log1_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchLog1&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#log1_table tbody").html(data);
            });
        });
        $("#log2_search_btn").click(function(){
            //검색버튼을 클릭할 때마다 수행하는 곳
            let category_name = $("#log2_name").val();
            let word = $("#log2_word").val();
            alert(category_name+"/"+word);
            let param = "type=searchLog2&searchType="+
                encodeURIComponent(category_name)+
                "&searchValue="+encodeURIComponent(word);
            //비동기식 통신
            $.ajax({
                url: "Controller",
                type: "POST",
                data: param,
            }).done(function(data){
                $("#log2_table tbody").html(data);
            });
        });
    });


</script>
</body>
</html>
