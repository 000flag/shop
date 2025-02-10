<%--
  Created by IntelliJ IDEA.
  User: aaa
  Date: 25. 1. 23.
  Time: 오후 5:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var ="bl"  items="${bqar}">
  <c:if test="${bl.bname eq 'question'}">
    <tr>


      <td>${bl.bname}</td>

      <td>${bl.title}</td>

      <td>${bl.content}</td>
      <td>${bl.score}</td>
      <td>${bl.write_date}</td>




    </tr>
  </c:if>
</c:forEach>