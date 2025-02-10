<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-22
  Time: 오후 8:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
  var contextPath = "${pageContext.request.contextPath}";
</script>


<div class="d-flex flex-column flex-shrink-0 p-3" id="left-bar">
    <h5 class="text-center mb-4">로고</h5>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="/Controller?type=snap" class="nav-link text-dark d-flex align-items-center">
                <i class="bi bi-house fs-4 me-2"></i>
                <span>홈</span>
            </a>
        </li>
        <li>
            <a href="#" id="searchBtn" class="nav-link text-dark d-flex align-items-center">
                <i class="bi bi-search fs-4 me-2"></i>
                <span>검색</span>
            </a>
        </li>
        <%--                    <li>--%>
        <%--                        <a href="#" class="nav-link text-dark d-flex align-items-center">--%>
        <%--                            <i class="bi bi-compass fs-4 me-2"></i>--%>
        <%--                            <span>탐색 탭</span>--%>
        <%--                        </a>--%>
        <%--                    </li>--%>
        <%--                    <li>--%>
        <%--                        <a href="#" class="nav-link text-dark d-flex align-items-center">--%>
        <%--                            <i class="bi bi-camera-reels fs-4 me-2"></i>--%>
        <%--                            <span>릴스</span>--%>
        <%--                        </a>--%>
        <%--                    </li>--%>
        <li>
<c:choose>
    <c:when test="${not empty sessionScope.nickname}">
            <a href="${pageContext.request.contextPath}/Controller?type=dm" class="nav-link text-dark d-flex align-items-center">
                <i class="bi bi-chat-dots fs-4 me-2"></i>
                <span>메시지</span>
            </a>
    </c:when>
    <c:otherwise>
                <a href="#" class="nav-link text-dark d-flex align-items-center">
                    <i class="bi bi-chat-dots fs-4 me-2"></i>
                    <span>메시지</span>
                    <a/>
    </c:otherwise>
                </c:choose>
            </a>
         </li>
        <li>
            <a href="#" class="nav-link text-dark d-flex align-items-center">
                <i class="bi bi-bell fs-4 me-2"></i>
                <span>알림</span>
            </a>
        </li>
        <li>
            <c:choose>
                <c:when test="${not empty sessionScope.nickname}">
                    <a href="#" class="nav-link text-dark d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#snapModal">
                        <i class="bi bi-plus-circle fs-4 me-2"></i>
                        <span>만들기</span>
                    </a>

                </c:when>
                <c:otherwise>
                <a href="#" class="nav-link text-dark d-flex align-items-center" >
                    <i class="bi bi-plus-circle fs-4 me-2"></i>
                    <span>만들기</span>
                </c:otherwise>
            </c:choose>

            </a>
        </li>
        <li>
            <a href="/Controller?type=profile&cus_no=${sessionScope.cus_id}" class="nav-link text-dark d-flex align-items-center">
                <i class="bi bi-person-circle fs-4 me-2"></i>
                <span>프로필</span>
            </a>
        </li>
    </ul>
</div>



<!-- 검색 패널 (기본적으로 숨김) -->
<div id="searchPanel" class="search-panel">
    <div class="search-header">
        <input type="text" id="searchInput" placeholder="검색" onkeyup="searchUsers()">
        <button id="closeSearch" onclick="closeSearchPanel()">✕</button>
    </div>
    <ul id="searchResults"></ul>
</div>


<!-- 스타일 -->
<style>
    .left-bar {
        position: relative; /* 기본값 확인 */
        z-index: 10000; /* 충분히 높게 설정 */
    }
    .search-panel {
        position: fixed;
        top: 160px;
        left: 0px; /* LEFT 메뉴 옆 */
        width: 231px;
        height: 100%;
        background: white;
        box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        display: none;
        flex-direction: column;
        padding: 15px;
        z-index: 99999 !important;
    }
    .search-header {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 15px;
    }
    #searchInput {
        flex: 1;
        padding: 8px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    #searchResults {
        list-style: none;
        padding: 0;
        max-height: 500px;
        overflow-y: auto;
    }
    #searchResults li {
        display: flex;
        align-items: center;
        padding: 8px;
        cursor: pointer;
        transition: background 0.2s;
    }
    #searchResults li:hover {
        background: #f0f0f0;
    }
    #searchResults img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 10px;
    }
    #closeSearch {
        background: none;
        border: none;
        font-size: 18px;
        cursor: pointer;
    }
</style>

<!-- JavaScript -->
<script>
  document.getElementById("searchBtn").addEventListener("click", function() {
    let searchPanel = document.getElementById("searchPanel");
    searchPanel.style.display = "flex";

    // left 바의 정확한 위치를 가져와서 패널 배치 조정
    let leftBar = document.getElementById("leftBar");
    let rect = leftBar.getBoundingClientRect();
    searchPanel.style.left = rect.right + "px";
    searchPanel.style.top = rect.top + "px";
    searchPanel.style.zIndex = "9999";

    document.getElementById("searchInput").focus();
  });

  // ESC 키로 검색 창 닫기
  document.addEventListener("keydown", function(event) {
    if (event.key === "Escape") closeSearchPanel();
  });

  function closeSearchPanel() {
    document.getElementById("searchPanel").style.display = "none";
  }

  function searchUsers() {
    let query = document.getElementById("searchInput").value.trim();
    if (query.length === 0) {
      document.getElementById("searchResults").innerHTML = "";
      return;
    }

    fetch("/Controller?type=searchUsers&query=" + encodeURIComponent(query))
        .then(response => response.json())
        .then(data => {
          let results = document.getElementById("searchResults");
          results.innerHTML = ""; // 기존 검색 결과 초기화

          if (!data.users || data.users.length === 0) {
            results.innerHTML = "<li>검색 결과가 없습니다.</li>";
            return;
          }

          data.users.forEach(user => {
            let li = document.createElement("li");
            li.innerHTML = `
               <img src="` + user.profile_image + `" alt="Profile"  ">
                    <div>
                        <strong>` + user.nickname + `</strong><br>
                        <span>` + user.follower_count + `명 팔로워</span>
                    </div>
                `;
            li.addEventListener("click", function() {
              window.location.href = contextPath + "/Controller?type=profile&cus_no=" + encodeURIComponent(user.id);
            });
            results.appendChild(li);
          });
        })
        .catch(error => console.error("검색 오류:", error));
  }

</script>