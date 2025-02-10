<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<table class="profile-table">
    <tbody>
    <tr>
        <th>이름</th>
        <td>${sessionScope.customer_info.name}</td>
    </tr>
    <tr>
        <th>생년월일</th>
        <td>${sessionScope.customer_info.birth_date}</td>
    </tr>
    <tr>
        <th>이메일</th>
        <td>${sessionScope.customer_info.email}</td>
    </tr>
    <tr>
        <th>휴대폰 번호</th>
        <td>${sessionScope.customer_info.phone}</td>
    </tr>
    </tbody>
</table>
<div class="button-container">
    <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#editModal">회원정보 변경</button>
    <button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#changePwModal">비밀번호 변경</button>
</div>
