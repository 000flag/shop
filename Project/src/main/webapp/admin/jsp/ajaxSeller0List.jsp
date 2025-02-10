<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 2. 2.
  Time: 오후 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="sl0"  items="${s0ar}">
    <c:if test="${sl0.active eq 0}">
    <tr>







            <td>${sl0.seller_id}</td>
            <td>${sl0.name}</td>
            <td>${sl0.phone}</td>
            <th>${sl0.email}</th>
            <td>${sl0.desc}</td>
            <td>${sl0.courier}</td>
            <td>${sl0.address}</td>
            <td>${sl0.active}</td>



    </tr>
    </c:if>
</c:forEach>
