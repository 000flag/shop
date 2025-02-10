<%@ page import="com.mysql.cj.x.protobuf.MysqlxCrud" %>
<%@ page import="comm.vo.seller.OrderVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%-- JSON표기법 --%>
<%
    Object obj = request.getAttribute("vo");
    if(obj!=null){
        OrderVO vo = (OrderVO) obj;

%>
{
"cus_id":"<%=vo.getCus_id()%>",
"prod_name":"<%=vo.getProd_name()%>",
"order_no":"<%=vo.getTid()%>",
"option_name":"<%=vo.getOption_name()%>",
"cus_name":"<%=vo.getCus_name()%>",
"count":"<%=vo.getOption_count()%>",
"order_status":"<%=vo.getStatus()%>",
"deli_name":"<%=vo.getDeli_name()%>",
"order_date":"<%=vo.getOrder_date()%>",
"phone":"<%=vo.getPhone()%>",
"addr1":"<%=vo.getAddr1()%>",
"addr2":"<%=vo.getAddr2()%>",
"reason":"<%=vo.getReason()%>"
}
<%
    }
%>