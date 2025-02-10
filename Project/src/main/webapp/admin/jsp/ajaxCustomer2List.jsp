<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="cus2l"  items="${cus2ar}">
  <c:if test="${cus2l.is_del eq 2}">
    <tr>
      <td>${cus2l.grade_name}</td>


      <td>${cus2l.cus_id}</td>

      <th>${cus2l.name}</th>
      <td>${cus2l.nickname}</td>
      <td>
        <c:choose>
          <c:when test="${cus2l.gender == 1}">남자</c:when>
          <c:when test="${cus2l.gender == 2}">여자</c:when>
          <c:otherwise>알 수 없음</c:otherwise>
        </c:choose>
      </td>
      <td>${cus2l.birth_date}</td>
      <td>${cus2l.phone}</td>
      <th>${cus2l.email}</th>


      <td>${cus2l.weight}</td>
      <td>${cus2l.height}</td>
      <td>${cus2l.total}</td>
      <td>${cus2l.grade_expire_date}</td>

    </tr>
  </c:if>

</c:forEach>
