<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="event-header">
    <h2>알림</h2>
</div>
<div class="event-tabs">
    <ul class="nav nav-tabs" id="eventTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="tab-all" data-toggle="tab" href="#table-all" role="tab">전체</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="tab-sale" data-toggle="tab" href="#table-sale" role="tab">세일/쿠폰</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="tab-order" data-toggle="tab" href="#table-order" role="tab">주문/배송</a>
        </li>
    </ul>
</div>
<div class="tab-content">
    <table id="table-all" class="table tab-pane fade show active" role="tabpanel">
        <tbody>
            <c:forEach begin="0" end="9">
                <tr>
                    <td>
                        <div class="event-item">
                            <div class="event-content">
                                <h5>무신사 체험단</h5>
                                <p>피곤한워싱턴버튼님! 체험단 당첨 확률이 약 20명 중 1명인 거 알고 계신가요?</p>
                                <span class="event-time">8시간 전</span>
                            </div>
                            <div class="event-img">
                                <img src="./user/images/share_musinsa.png" alt="Logo">
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <table id="table-sale" class="table tab-pane fade" role="tabpanel">
        <tbody>
            <c:forEach begin="0" end="1">
                <tr>
                    <td>
                        <div class="event-item">
                            <div class="event-content">
                                <h5>무신사 체험단</h5>
                                <p>피곤한워싱턴버튼님! 체험단 당첨 확률이 약 20명 중 1명인 거 알고 계신가요?</p>
                                <span class="event-time">8시간 전</span>
                            </div>
                            <div class="event-img">
                                <img src="./user/images/share_musinsa.png" alt="Logo">
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <table id="table-order" class="table tab-pane fade" role="tabpanel">
        <tbody>
            <c:forEach begin="0" end="2">
                <tr>
                    <td>
                        <div class="event-item">
                            <div class="event-content">
                                <h5>무신사 체험단</h5>
                                <p>피곤한워싱턴버튼님! 체험단 당첨 확률이 약 20명 중 1명인 거 알고 계신가요?</p>
                                <span class="event-time">8시간 전</span>
                            </div>
                            <div class="event-img">
                                <img src="./user/images/share_musinsa.png" alt="Logo">
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>