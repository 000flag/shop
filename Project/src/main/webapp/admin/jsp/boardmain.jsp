<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 21.
  Time: 오후 2:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>게시판 관리</title>
    <style>
        /* 테이블의 레이아웃을 고정하여 각 열이 비례적으로 배분되지 않고 고정된 크기를 가지도록 설정 */
        table {
            table-layout: fixed;
            width: 100%; /* 테이블 전체의 너비 */
        }

        .group-list {
            background-color: #f8f9fa;
            border-right: 1px solid #dee2e6;
            height: 100%;
        }
        .add-user-btn {
            float: right;
        }
        .highlight {
            background-color: #efeff5;
            border: 1px solid #dcdce6;
        }

        th, td {
            padding: 8px 20px;
            text-align: center; /* 중앙 정렬 */
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 방지 */
        }
        thead  {
            text-align:  center;
        }

        /* 열에 대한 너비를 고정적으로 설정 */
        th:nth-child(1), td:nth-child(1) {
            width: 5%;
        }
        th:nth-child(2), td:nth-child(2) {
            width: 10%;
        }
        th:nth-child(3), td:nth-child(3) {
            width: 10%;
        }
        th:nth-child(4), td:nth-child(4) {
            width: 10%;
        }
        th:nth-child(5), td:nth-child(5) {
            width: 10%;
        }
        th:nth-child(6), td:nth-child(6) {
            width: 10%;
        }
        th:nth-child(7), td:nth-child(7) {
            width: 15%;
        }
        th:nth-child(8), td:nth-child(8) {
            width: 15%;
        }
        th:nth-child(9), td:nth-child(9) {
            width: 15%;
        }
        th:nth-child(10), td:nth-child(10) {
            width: 8%;
        }
        th:nth-child(11), td:nth-child(11) {
            width: 8%;
        }
        th:nth-child(12), td:nth-child(12) {
            width: 10%;
        }
        th:nth-child(13), td:nth-child(13) {
            width: 10%;
        }
        th:nth-child(14), td:nth-child(14) {
            width: 10%;
        }
        th:nth-child(15), td:nth-child(15) {
            width: 10%;
        }
        th:nth-child(16), td:nth-child(16) {
            width: 10%;
        }

    </style>
</head>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>

<div class="container-fluid mt-4">
    <!-- 일반 게시판 목록 영역 -->
    <div class="col-9">
        <div class="d-flex justify-content-between align-items-center">
            <h5>게시판 목록 announcement</h5>
            <div>
                <!-- 게시판 추가 버튼, 모달 연결 -->
                <button class="btn btn-primary add-user-btn" data-bs-toggle="modal" data-bs-target="#boardModal">공지사항(announcement) 추가</button>
            </div>
        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="board_name">
                    <c:forEach var="name" items="${boardName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'cus_no' && name ne 'season' && name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                            <option value="${name}" class="column-name">${name}</option>
                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="board_word">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="board_search_btn">
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

        <table class="table mt-3" id="board_table">
        <thead class="table-light">

        <tr>

            <c:forEach var="name" items="${boardName}">
                <c:if test="${name ne 'id' && name ne 'cus_no' &&name ne 'season' &&  name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                    <th class="column-name">${name}</th>
                </c:if>
            </c:forEach>

            <th> </th>

        </tr>
        </thead>
        <tbody>
        <c:forEach var ="bl"  items="${boardList}">
            <c:if test="${bl.bname eq 'announcement'}">

            <%--tr의 해당 레코드를 id로 지정해줘 삭제하면 된다--%>
            <tr id="row-${bl.id}">

                <td>${bl.bname}</td>
                <td>${bl.title}</td>
                <td>${bl.content}</td>
                <td>${bl.score}</td>
                <td>${bl.write_date}</td>


                <td>

                    <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteBoardModal"
                            onclick="setBoardInfo('${bl.id}', '${bl.cus_no}')"> 삭제</button>
                    <button class="btn btn-outline-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#seeboardModal">
                        자세히
                    </button>

                </td>
            </tr>
            </c:if>
        </c:forEach>
        </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=boardmain'">초기화</button>
        </div>

        <hr/><!---------------------------------------------->
        <div class="d-flex justify-content-between align-items-center">
            <h5>게시판 목록 snap</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="board_name_snap">
                    <c:forEach var="name" items="${boardName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'cus_no' && name ne 'season' && name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                            <option value="${name}" class="column-name">${name}</option>
                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="board_word_snap">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="board_search_btn_snap">
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

        <table class="table mt-3" id="board_table_snap">
            <thead class="table-light">

            <tr>

                <c:forEach var="name" items="${boardName}">
                    <c:if test="${name ne 'id' && name ne 'cus_no' &&name ne 'season' &&  name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                        <th class="column-name">${name}</th>
                    </c:if>
                </c:forEach>

                <th> </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var ="bl"  items="${boardList}">
                <c:if test="${bl.bname eq 'snap'}">
                <%--tr의 해당 레코드를 id로 지정해줘 삭제하면 된다--%>
                <tr id="row-${bl.id}">

                    <td>${bl.bname}</td>
                    <td>${bl.title}</td>
                    <td>${bl.content}</td>
                    <td>${bl.score}</td>
                    <td>${bl.write_date}</td>


                    <td>

                        <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteBoardModal"
                                onclick="setBoardInfo('${bl.id}', '${bl.cus_no}')"> 삭제</button>
                        <button class="btn btn-outline-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#seeboardModal"
                                onclick="setBoardId('${bl.id}')">
                            자세히
                        </button>

                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=boardmain'">초기화</button>
        </div>
        <hr/><!---------------------------------------------->
        <div class="d-flex justify-content-between align-items-center">
            <h5>게시판 목록 Inquiry</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="board_name_inquiry">
                    <c:forEach var="name" items="${boardName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'cus_no' && name ne 'season' && name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                            <option value="${name}" class="column-name">${name}</option>
                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="board_word_inquiry">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="board_search_btn_inquiry">
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

        <table class="table mt-3" id="board_table_inquiry">
            <thead class="table-light">

            <tr>

                <c:forEach var="name" items="${boardName}">
                    <c:if test="${name ne 'id' && name ne 'cus_no' &&name ne 'season' &&  name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                        <th class="column-name">${name}</th>
                    </c:if>
                </c:forEach>

                <th> </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var ="bl"  items="${boardList}">
                <c:if test="${bl.bname eq 'inquiry'}">
                    <%--tr의 해당 레코드를 id로 지정해줘 삭제하면 된다--%>
                    <tr id="row-${bl.id}">

                        <td>${bl.bname}</td>
                        <td>${bl.title}</td>
                        <td>${bl.content}</td>
                        <td>${bl.score}</td>
                        <td>${bl.write_date}</td>


                        <td>

                            <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteBoardModal"
                                    onclick="setBoardInfo('${bl.id}', '${bl.cus_no}')"> 삭제</button>
                            <button class="btn btn-outline-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#seeboardModal"
                                    onclick="setBoardId('${bl.id}')">
                                자세히
                            </button>

                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=boardmain'">초기화</button>
        </div>
        <hr/><!---------------------------------------------->
        <div class="d-flex justify-content-between align-items-center">
            <h5>게시판 목록 Question</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="board_name_question">
                    <c:forEach var="name" items="${boardName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'cus_no' && name ne 'season' && name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                            <option value="${name}" class="column-name">${name}</option>
                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="board_word_question">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="board_search_btn_question">
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

        <table class="table mt-3" id="board_table_question">
            <thead class="table-light">

            <tr>

                <c:forEach var="name" items="${boardName}">
                    <c:if test="${name ne 'id' && name ne 'cus_no' &&name ne 'season' &&  name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                        <th class="column-name">${name}</th>
                    </c:if>
                </c:forEach>

                <th> </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var ="bl"  items="${boardList}">
                <c:if test="${bl.bname eq 'question'}">
                    <%--tr의 해당 레코드를 id로 지정해줘 삭제하면 된다--%>
                    <tr id="row-${bl.id}">

                        <td>${bl.bname}</td>
                        <td>${bl.title}</td>
                        <td>${bl.content}</td>
                        <td>${bl.score}</td>
                        <td>${bl.write_date}</td>


                        <td>

                            <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteBoardModal"
                                    onclick="setBoardInfo('${bl.id}', '${bl.cus_no}')"> 삭제</button>
                            <button class="btn btn-outline-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#seeboardModal"
                                    onclick="setBoardId('${bl.id}')">
                                자세히
                            </button>

                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=boardmain'">초기화</button>
        </div>
        <hr/><!---------------------------------------------->
        <div class="d-flex justify-content-between align-items-center">
            <h5>게시판 목록 Review</h5>

        </div>

        <div class="mt-3">
            <div class="input-group">
                <!-- 검색 아이콘 -->
                <span class="input-group-text">
                    <i class="bi bi-search"></i>
                </span>
                <select class="form-select" aria-label="Default select example" id="board_name_review">
                    <c:forEach var="name" items="${boardName}" varStatus="st">
                        <c:if test="${name ne 'id' && name ne 'cus_no' && name ne 'season' && name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                            <option value="${name}" class="column-name">${name}</option>
                        </c:if>
                    </c:forEach>

                </select>


                <!-- 검색 입력 -->
                <input type="text" class="form-control" placeholder="검색할 열을 선택" aria-label="Search" id="board_word_review">
                <!-- 드롭다운 버튼 -->
                <button class="btn btn-outline-secondary" type="button" aria-expanded="false" id="board_search_btn_review">
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

        <table class="table mt-3" id="board_table_review">
            <thead class="table-light">

            <tr>

                <c:forEach var="name" items="${boardName}">
                    <c:if test="${name ne 'id' && name ne 'cus_no' &&name ne 'season' &&  name ne 'prod_no' && name ne 'snapshot_image' && name ne 'additional_images' && name ne 'tags' && name ne 'gender' && name ne 'style' && name ne 'like_count' && name ne 'order_code' && name ne 'type' && name ne 'order_code' && name ne 'type' && name ne 'status' && name ne 'is_del' && name ne 'is_private' }">
                        <th class="column-name">${name}</th>
                    </c:if>
                </c:forEach>

                <th> </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var ="bl"  items="${boardList}">
                <c:if test="${bl.bname eq 'review'}">
                    <%--tr의 해당 레코드를 id로 지정해줘 삭제하면 된다--%>
                    <tr id="row-${bl.id}">

                        <td>${bl.bname}</td>
                        <td>${bl.title}</td>
                        <td>${bl.content}</td>
                        <td>${bl.score}</td>
                        <td>${bl.write_date}</td>


                        <td>

                            <button class="btn btn-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#deleteBoardModal"
                                    onclick="setBoardInfo('${bl.id}', '${bl.cus_no}')"> 삭제</button>
                            <button class="btn btn-outline-secondary add-user-btn" data-bs-toggle="modal" data-bs-target="#seeboardModal"
                                    onclick="setBoardId('${bl.id}')">
                                자세히
                            </button>

                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-3 mb-4">
            <button class="btn btn-outline-secondary" onclick = "location.href='Controller?type=boardmain'">초기화</button>
        </div>









    </div>



    <%--보드 삭제 모달 창--%>
    <div class="modal fade" id="deleteBoardModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="rejectModalLabel">게시판 사유</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="deleteBoardForm">
                    <div class="modal-body">
                        <input type="hidden" id="deleteBoardId" name="id">
                        <input type="hidden" id="deleteBoardCusNo" name="id">
                        <textarea class="form-control" id="deleteReason" name="content" rows="3">보드를 삭제할 이유를 적어주세요.</textarea>
                        <span class="text-danger">*특수문자사용시 스마트스토어 정책에 따라 전송 에러가 발생합니다. 텍스트와 숫자로 안내문구를 작성해주시기 바랍니다.</span>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Modal에서 사진 갤러리 출력 -->
    <!-- 모달 시작 -->
    <div class="modal fade" id="seeBoardModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageModalLabel">사진 갤러리</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="seeBoardForm">
                    <input type="hidden" name="id" id="seeBoardId" value="${boardOne.id}">
                </form>
                <div class="modal-body">
                    <!-- 캐러셀 (사진 넘기는 기능) -->
                    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <!-- Main snapshot image -->
                            <div class="carousel-item active">
                                <img src="${boardOne.snapshot_image}" class="d-block w-100" alt="메인이미지">
                            </div>

                            <!-- Additional images -->
                            <c:forEach var="image" items="${fn:split(boardOne.additional_images, ',')}">
                                <div class="carousel-item">
                                    <img src="${image}" class="d-block w-100" alt="서브이미지">
                                </div>
                            </c:forEach>
                        </div>

                        <!-- 좌우 컨트롤 버튼 -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">이전</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">다음</span>
                        </button>
                    </div>

                    <!-- 설명 영역 -->
                    <div class="mt-3">
                        <h5>내용</h5>
                        <p>${boardOne.content}</p> <!-- 내용 출력 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 모달 끝 -->







    <!-- 부트스트랩 관련 스크립트 -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
      $(function () {
          $("#board_search_btn").click(function () {
              //검색버튼을 클릭할 때마다 수행하는 곳
              let category_name = $("#board_name_snap").val();
              let word = $("#board_word").val();
              alert(category_name + "/" + word);
              let param = "type=searchBoard&searchType=" +
                  encodeURIComponent(category_name) +
                  "&searchValue=" + encodeURIComponent(word);
              //비동기식 통신
              $.ajax({
                  url: "Controller",
                  type: "POST",
                  data: param,
              }).done(function (data) {
                  $("#board_table tbody").html(data);
              });
          });
          $("#board_search_btn_snap").click(function () {
              //검색버튼을 클릭할 때마다 수행하는 곳
              let category_name = $("#board_name_snap").val();
              let word = $("#board_word_snap").val();
              alert(category_name + "/" + word);
              let param = "type=searchBoardSnap&searchType=" +
                  encodeURIComponent(category_name) +
                  "&searchValue=" + encodeURIComponent(word);
              //비동기식 통신
              $.ajax({
                  url: "Controller",
                  type: "POST",
                  data: param,
              }).done(function (data) {
                  $("#board_table_snap tbody").html(data);
              });
          });
          $("#board_search_btn_inquiry").click(function () {
              //검색버튼을 클릭할 때마다 수행하는 곳
              let category_name = $("#board_name_inquiry").val();
              let word = $("#board_word_inquiry").val();
              alert(category_name + "/" + word);
              let param = "type=searchBoardInquiry&searchType=" +
                  encodeURIComponent(category_name) +
                  "&searchValue=" + encodeURIComponent(word);
              //비동기식 통신
              $.ajax({
                  url: "Controller",
                  type: "POST",
                  data: param,
              }).done(function (data) {
                  $("#board_table_inquiry tbody").html(data);
              });
          });
          $("#board_search_btn_question").click(function () {
              //검색버튼을 클릭할 때마다 수행하는 곳
              let category_name = $("#board_name_question").val();
              let word = $("#board_word_question").val();
              alert(category_name + "/" + word);
              let param = "type=searchBoardQuestion&searchType=" +
                  encodeURIComponent(category_name) +
                  "&searchValue=" + encodeURIComponent(word);
              //비동기식 통신
              $.ajax({
                  url: "Controller",
                  type: "POST",
                  data: param,
              }).done(function (data) {
                  $("#board_table_question tbody").html(data);
              });
          });
          $("#board_search_btn_review").click(function () {
              //검색버튼을 클릭할 때마다 수행하는 곳
              let category_name = $("#board_name_review").val();
              let word = $("#board_word_review").val();
              alert(category_name + "/" + word);
              let param = "type=searchBoardReview&searchType=" +
                  encodeURIComponent(category_name) +
                  "&searchValue=" + encodeURIComponent(word);
              //비동기식 통신
              $.ajax({
                  url: "Controller",
                  type: "POST",
                  data: param,
              }).done(function (data) {
                  $("#board_table_review tbody").html(data);
              });
          });

      });


        $(document).ready(function () {<%--폼태그--%>
        $("#deleteBoardForm").submit(function (event) {
          event.preventDefault(); // 기본 form 제출 막기

          let boardId = $("#deleteBoardId").val();
          let cusNo = $("#deleteBoardCusNo").val();
          let content = $("#deleteReason").val();

          if (!boardId) {
            alert("삭제할 게시판 ID가 없습니다.");
            return;
          }

          $.ajax({
            url: "Controller",
            type: "POST",
            data: {
              type: "deleteBoard",
              id: boardId,
              cus_no: cusNo,
              content: content
            },
            dataType: "json", <%--보내지는 데이터 타입--%>
              <%--삭제의 경우 기존 값에서 하나의 행만 지우는 식이로 해야해서 이렇게 했다--%>
              <%--삭제시 반드시 1로 만들어준다-->
              <%--추가는 전부 불러오는 방식으로 하길 권장한다--%>
              <%--spring에서도 자주 사용하니 반드시 알아야한다--%>

            success: function (response) {
              if (response.status === "success") {
                console.log("삭제 성공:", response);

                <%--테이블의 열의 id를 레코드를 삭제--%>
                $("#row-" + response.deletedId).remove();


                $("#deleteBoardModal").modal("hide");

                alert("게시글이 삭제되었습니다.");
              } else {
                console.error("삭제 실패:", response.message);
                alert("게시글 삭제에 실패했습니다: " + response.message);
              }
            },
            error: function (xhr, status, error) {
              console.error("삭제 실패:", error);
              alert("게시글 삭제 중 오류가 발생했습니다.");
            }
          });
        });
      });

        function setBoardInfo(boardId, cusNo) {
        console.log("전달된 게시판 ID:", boardId);
        console.log("전달된 고객 번호:", cusNo);

        $("#deleteBoardId").val(boardId);
        $("#deleteBoardCusNo").val(cusNo);


      }
      function setBoardId(boardId) {
          // 서버에서 게시글 상세 정보를 가져오는 부분
          fetch(`/board/details/${boardId}`)
              .then(response => response.json())
              .then(data => {
                  // Main snapshot image
                  const snapshotImageElement = document.querySelector("#carouselExample .carousel-item.active img");
                  snapshotImageElement.src = data.snapshot_image;  // main snapshot 이미지 설정

                  // Additional images
                  const carouselInner = document.querySelector("#carouselExample .carousel-inner");
                  carouselInner.innerHTML = ''; // 기존 이미지를 비워둠

                  // Add main snapshot image to the carousel
                  carouselInner.innerHTML += `
                <div class="carousel-item active">
                    <img src="${data.snapshot_image}" class="d-block w-100" alt="메인이미지">
                </div>
            `;

                  // 추가 이미지들
                  data.additional_images.split(',').forEach(image => {
                      carouselInner.innerHTML += `
                    <div class="carousel-item">
                        <img src="${image}" class="d-block w-100" alt="서브이미지">
                    </div>
                `;
                  });

                  // Content
                  document.querySelector("#seeBoardModal .modal-body .mt-3 p").innerText = data.content; // 내용 설정
              })
              .catch(error => console.error("Error fetching board details:", error));
      }
      const columnTranslations = {
          'bname': '종류',
          'title': `제목`,
          'content': '내용',
          'score': '점수',
          'write_date': '작성일자'
      };

      // 페이지 로딩 후 컬럼 이름을 한국어로 변환
      document.addEventListener('DOMContentLoaded', function() {
          const columnElements = document.querySelectorAll('.column-name'); // 'column-name' 클래스를 가진 요소들

          columnElements.forEach(element => {
              const columnName = element.innerText.trim();
              if (columnTranslations[columnName]) {
                  element.innerText = columnTranslations[columnName];  // 한국어로 번역
              }
          });
      });



    </script>
</body>
</html>