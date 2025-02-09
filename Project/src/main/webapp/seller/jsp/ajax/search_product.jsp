<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="comm.vo.seller.ProductVO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    // 서버에서 'ar' 데이터를 가져옴
    ProductVO[] ar = (ProductVO[]) request.getAttribute("ar");

    // JSON 변환 객체
    Gson gson = new Gson();
    Map<String, Object> responseMap = new HashMap<>();

    // 'ar'가 null이 아니면 JSON 응답을 설정
    if (ar != null) {
        responseMap.put("ar", ar);  // 데이터 포함
    } else {
        responseMap.put("error", "No products found");
    }

    // JSON 변환
    String json = gson.toJson(responseMap);

    // 응답 출력
    response.setContentType("application/json; charset=UTF-8");
    response.getWriter().write(json);
%>