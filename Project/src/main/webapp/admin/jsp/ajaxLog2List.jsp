<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 31.
  Time: 오전 2:36
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="log2l"  items="${log2ar}">
  <c:if test="${log2l.log_type eq 1}">
    <tr>
      <td>${log2l.root_no}</td>


      <td>${log2l.seller_no}</td>

      <td>${log2l.cus_no}</td>
      <td>${log2l.writer_type}</td>
      <td>${log2l.target}</td>
      <td>${log2l.prev}</td>
      <td>${log2l.current}</td>
      <td>${log2l.log_date}</td>


    </tr>
  </c:if>

</c:forEach>