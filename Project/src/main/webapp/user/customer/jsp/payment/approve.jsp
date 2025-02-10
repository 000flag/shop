<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    window.location.replace("${pageContext.request.contextPath}/Controller?type=order&action=approve&pg_token=" + "${param.pg_token}");
</script>
