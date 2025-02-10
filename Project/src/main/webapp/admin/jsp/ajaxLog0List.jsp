<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="log0l"  items="${log0ar}">
    <c:if test="${log0l.log_type eq 0}">
        <tr>
            <td>${log0l.root_no}</td>


            <td>${log0l.seller_no}</td>

            <td>${log0l.cus_no}</td>
            <td>${log0l.writer_type}</td>
            <td>${log0l.target}</td>
            <td>${log0l.prev}</td>
            <td>${log0l.current}</td>
            <td>${log0l.log_date}</td>


        </tr>
    </c:if>

</c:forEach>