<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 2. 2.
  Time: 오후 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="sl2"  items="${s2ar}">
  <c:if test="${sl2.active eq 2}">
    <tr>







      <td>${sl2.seller_id}</td>
      <td>${sl2.name}</td>
      <td>${sl2.phone}</td>
      <th>${sl2.email}</th>
      <td>${sl2.desc}</td>
      <td>${sl2.courier}</td>
      <td>${sl2.address}</td>
      <td>${sl2.active}</td>



    </tr>
  </c:if>
</c:forEach>