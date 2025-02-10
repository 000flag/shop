<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="log1l"  items="${log1ar}">
    <c:if test="${log1l.log_type eq 1}">
        <tr>
            <td>${log1l.root_no}</td>


            <td>${log1l.seller_no}</td>

            <td>${log1l.cus_no}</td>
            <td>${log1l.writer_type}</td>
            <td>${log1l.target}</td>
            <td>${log1l.prev}</td>
            <td>${log1l.current}</td>
            <td>${log1l.log_date}</td>


        </tr>
    </c:if>

</c:forEach>