<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 24.
  Time: 오전 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="mdcl"  items="${dar}">
    <c:if test="${mdcl.is_del eq 0}">
    <tr>
        <td>${mdcl.major_name}</td>
        <td>${mdcl.name}</td>
        <td>${mdcl.type}</td>

    </tr>
    </c:if>
</c:forEach>
