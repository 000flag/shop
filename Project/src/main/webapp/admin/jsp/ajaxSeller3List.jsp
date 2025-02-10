<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 2. 2.
  Time: 오후 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="sl3"  items="${s3ar}">
    <c:if test="${sl3.active eq 3}">
        <tr>






            <td>${sl3.seller_id}</td>
            <td>${sl3.name}</td>
            <td>${sl3.phone}</td>
            <th>${sl3.email}</th>
            <td>${sl3.desc}</td>
            <td>${sl3.courier}</td>
            <td>${sl3.address}</td>
            <td>${sl3.active}</td>



        </tr>
    </c:if>
</c:forEach>
