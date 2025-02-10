<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 2. 2.
  Time: 오후 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="sl1"  items="${s1ar}">
  <c:if test="${sl1.active eq 1}">
    <tr>
      <td>${sl1.seller_id}</td>
      <td>${sl1.name}</td>
      <td>${sl1.phone}</td>
      <th>${sl1.email}</th>
      <td>${sl1.desc}</td>
      <td>${sl1.courier}</td>
      <td>${sl1.address}</td>
      <td>${sl1.active}</td>
    </tr>
  </c:if>
</c:forEach>
