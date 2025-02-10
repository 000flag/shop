<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-17
  Time: 오후 4:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Brand Management</h1>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
            <tr>
                <th>(브랜드) ID</th>

                <th>브랜드명</th>
                <th>전화번호</th>
                <th>Email</th>
                <th>Description</th>
                <th>Courier</th>
                <th>Address</th>
                <th>Is Deleted</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="seller" items="${sellerList}">
                <tr>
                    <td>${seller.id}</td>
                    <td>${seller.sellerId}</td>
                    <td>${seller.sellerPw}</td>
                    <td>${seller.name}</td>
                    <td>${seller.phone}</td>
                    <td>${seller.email}</td>
                    <td>${seller.desc}</td>
                    <td>${seller.courier}</td>
                    <td>${seller.address}</td>
                    <td>${seller.isDel ? 'Yes' : 'No'}</td>
                    <td>
                        <div class="d-flex">
                            <form action="editSeller" method="get" class="me-2">
                                <input type="hidden" name="id" value="${seller.id}">
                                <button type="submit" class="btn btn-sm btn-primary">Edit</button>
                            </form>
                            <form action="deleteSeller" method="post">
                                <input type="hidden" name="id" value="${seller.id}">
                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
