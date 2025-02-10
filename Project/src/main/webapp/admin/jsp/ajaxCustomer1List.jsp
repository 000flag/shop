<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="cus1l"  items="${cus1ar}">
    <c:if test="${cus1l.is_del eq 1}">
        <tr>
            <td>${cus1l.grade_name}</td>


            <td>${cus1l.cus_id}</td>

            <th>${cus1l.name}</th>
            <td>${cus1l.nickname}</td>
            <td>
                <c:choose>
                    <c:when test="${cus1l.gender == 1}">남자</c:when>
                    <c:when test="${cus1l.gender == 2}">여자</c:when>
                    <c:otherwise>알 수 없음</c:otherwise>
                </c:choose>
            </td>
            <td>${cus1l.birth_date}</td>
            <td>${cus1l.phone}</td>
            <th>${cus1l.email}</th>

            <td>${cus1l.weight}</td>
            <td>${cus1l.height}</td>
            <td>${cus1l.total}</td>
            <td>${cus1l.grade_expire_date}</td>

        </tr>
    </c:if>

</c:forEach>
