<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty requestScope.session_expired}">
    <script>
        if ("${requestScope.session_expired}" === "true") {
            alert("세션이 만료되었습니다. 다시 로그인해 주세요.");
            window.location.href = 'Controller?type=login';
        }
    </script>
</c:if>