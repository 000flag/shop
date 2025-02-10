<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="cus0l"  items="${cus0ar}">
    <c:if test="${cus0l.is_del eq 0}">
    <tr>
        <td>${cus0l.grade_name}</td>


        <td>${cus0l.cus_id}</td>

        <th>${cus0l.name}</th>
        <td>${cus0l.nickname}</td>
        <td>
            <c:choose>
                <c:when test="${cus0l.gender == 1}">남자</c:when>
                <c:when test="${cus0l.gender == 2}">여자</c:when>
                <c:otherwise>알 수 없음</c:otherwise>
            </c:choose>
        </td>
        <td>${cus0l.birth_date}</td>
        <td>${cus0l.phone}</td>
        <th>${cus0l.email}</th>


        <td>${cus0l.weight}</td>
        <td>${cus0l.height}</td>
        <td>${cus0l.total}</td>
        <td>${cus0l.grade_expire_date}</td>

    </tr>
    </c:if>


</c:forEach>


