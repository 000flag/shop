<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="/user/css/snapcommon.css">
<script>
  const isLoggedIn = ${isLoggedIn ? "true" : "false"};
</script>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코디 페이지</title>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">--%>
    <link rel="stylesheet" href="/user/css/mypage.css">
    <%--    <link rel="stylesheet" href="/user/css/SnapProfile/style.css">--%>
    <%--    <link rel="stylesheet" href="/user/css/SnapProfile/SnapProfile.css">--%>
</head>


<body>
<jsp:include page="/user/snap/jsp/layout/header.jsp"></jsp:include>

<c:set var="isLoggedIn" value="${not empty sessionScope.nickname}" />
<div class="container-fluid mt-4">
    <div class="row">
        <!-- 왼쪽 메뉴바 -->
        <div class="col-md-2 border-end position-fixed" style="height: 100vh;">
            <jsp:include page="/user/snap/jsp/layout/left.jsp"></jsp:include>
        </div>

        <!-- 콘텐츠 영역 -->
        <div class="col-md-10 offset-md-2">
            <!-- 프로필 섹션 -->
            <div class="container d-flex justify-content-center mt-4">
                <!-- 프로필 섹션 -->
                <div class="row align-items-center border-bottom pb-4 mb-4" style="width: 800px;"> <!-- 고정된 너비로 중앙 정렬 -->
                    <!-- 프로필 이미지 -->
                    <div class="col-auto me-4"> <!-- 오른쪽 여백 추가 -->
                        <img src="${board[0].profile_image}"  alt="Profile Picture" class="rounded-circle" style="width: 160px; height: 160px; object-fit: cover;"> <!-- 이미지 크기 키움 -->
                    </div>


                    <!-- 프로필 정보 -->
                    <div class="col">
                        <!-- 프로필 이름과 버튼 -->
                        <div class="d-flex align-items-center mb-2">
                             <h2 class="mb-0 me-3" style="font-size: 1.5rem; font-weight: 500;">${board[0].nickname}</h2> <!-- 폰트 스타일 조정 -->
                            <c:if test="${sessionScope.cus_id == board[0].id}">
                                <!-- 내 프로필인 경우 -->
                                <button class="btn btn-outline-secondary btn-sm" style="font-size: 0.875rem;">프로필 편집</button>
                            </c:if>
                            <c:if test="${sessionScope.cus_id != board[0].id}">
                                <!-- 다른 사람의 프로필인 경우 -->
                                <c:choose>
                                    <c:when test="${isFollowing}">
                                        <!-- 팔로우 중인 경우 -->
                                        <button id="followButton" class="btn btn-danger btn-sm" data-following-id="${board[0].id}" style="font-size: 0.875rem;">팔로잉 취소</button>

                                    </c:when>
                                    <c:otherwise>
                                        <!-- 팔로우하지 않은 경우 -->
                                        <button id="followButton" class="btn btn-primary btn-sm" data-following-id="${board[0].id}" style="font-size: 0.875rem;">팔로우</button>
                                    </c:otherwise>
                                </c:choose>
                                <form id="messageForm" action="Controller" method="get">
                                    <input type="hidden" name="type" value="dm">
                                    <input type="hidden" name="receiverId" value="${board[0].id}">
                                    <button id="messageButton" type="submit" class="btn btn-outline-secondary btn-sm" style="font-size: 0.875rem;">메시지 보내기</button>
                                </form>
                            </c:if>


                        </div>
                        <!-- 게시물 정보 -->
                        <p class="mb-2" style="font-size: 0.875rem;">

                            게시물  <strong>${boardCount}</strong>
                            팔로워  <strong id="followerCount" class="clickable" data-type="follower">${followerCount}</strong>
                            팔로우  <strong id="followingCount" class="clickable" data-type="following">${followingCount}</strong>

                        </p>

                        <!-- 추가 정보 -->
                        <p class="mb-1" style="font-size: 0.875rem;">${board[0].introduce}</p>
                        <a href="https://link.inpock.co.kr/amor08290722" target="_blank" style="font-size: 0.875rem; text-decoration: none; color: #007bff;"></a>
                        <p class="mt-2" style="font-size: 0.75rem; color: gray;"></p>

                    </div>
                </div>
            </div>


            <!-- 게시물 그리드 -->
            <c:set var="firstBoardId" value="${board1[0].id}" />
                <div class="d-flex flex-wrap justify-content-between" style="gap: 4px; max-width: 930px; margin: 0 auto;"> <!-- 고정 너비 설정 -->
                    <c:forEach var="image" items="${board}">
                        <div style="width: 307px; height: 307px;"> <!-- 고정 크기 -->
                            <div class="d-flex justify-content-center align-items-center" style="width: 100%; height: 100%; overflow: hidden;">
                                <c:if test="${boardCount>0}">
                                <img src="${image.snapshot_image}" onclick= "location.href='${pageContext.request.contextPath}/Controller?type=sns&id=${firstBoardId}'" alt="Post Image" class="img-fluid" style="object-fit: cover; width: 100%; height: 100%;">
                                </c:if>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>



        </div>
        </div>
    </div>

<%--로그인모달--%>

<!-- 로그인 필요 모달 -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인이 필요합니다.</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                로그인 화면으로 이동하시겠습니까?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" id="confirmLoginBtn" class="btn btn-dark">확인</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/user/snap/jsp/snap/FollowList.jsp"></jsp:include>
<jsp:include page="/user/snap/jsp/snap/snapModal.jsp"></jsp:include>
<script src="/JS/snapModal.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha384-o1w6FrH+XWZfPchvjBsnYpBIwM9tDn58q+SttIbcSDthcu78WnW62XTNVS/qs6wE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      const followButton = document.getElementById('followButton');
      const loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
      const confirmLoginBtn = document.getElementById('confirmLoginBtn');
      const messageForm = document.getElementById('messageForm');
      const messageButton = document.getElementById("messageButton");
      const currentUserId = ${board[0].id};

      // const isLoggedIn = followButton.getAttribute('data-logged-in') === "true";
      //  console.log(isLoggedIn);


      followButton.addEventListener('click', function () {
        if (!isLoggedIn) {
          // loginModal.show();
          return;
        }
            const followingId = this.getAttribute('data-following-id');
            const isCurrentlyFollowing = this.classList.contains('btn-danger');
            const action = isCurrentlyFollowing ? 'unfollow' : 'follow';

            // 즉시 UI 업데이트
            updateButtonUI(this, !isCurrentlyFollowing);

            // 버튼 비활성화
            this.disabled = true;

            // Ajax 요청 (재시도 로직 포함)
            sendRequest(action, followingId, this);
          });
      // confirmLoginBtn.addEventListener('click', function () {
      //   window.location.href = "/Controller?type=showlogin&action=profile"; // 로그인 페이지로 이동
      // });

      // messageForm?.addEventListener('submit', function (event) {
      //   if (!isLoggedIn) {
      //     event.preventDefault();
      //     loginModal.show();
      //   }
      // });


      function updateButtonUI(button, isFollowing) {
        if (isFollowing) {
          button.textContent = '팔로잉 취소';
          button.classList.replace('btn-primary', 'btn-danger');
        } else {
          button.textContent = '팔로우';
          button.classList.replace('btn-danger', 'btn-primary');
        }
      }

      function sendRequest(action, followingId, button, retryCount = 0) {
        fetch(`/Controller?type=`+action, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ followingId }),
          timeout: 5000 // 5초 타임아웃 설정
        })
            .then(response => {
              if (!response.ok) {
                throw new Error('서버 응답 오류');

              }
              return response.json();
            })
            .then(data => {
              if (!data.success) {
                throw new Error('처리 실패');
              }
              // 성공 시 추가 작업 (필요한 경우)
            })
            .catch(error => {
              console.error('Error:', error);
             // if (retryCount < 2) { // 최대 2번 재시도
             //    se tTimeout(() => sendRequest(action, followingId, button, retryCount + 1), 1000);
             //  } else {
             //    // 최종 실패 시 사용자에게 알림
             //
             //    // UI를 원래 상태로 복구하지 않음 (서버에 변경이 적용되었을 가능성이 있으므로)
             //  }
            })
            .finally(() => {
              button.disabled = false;
            });
      }



      // 팔로우 팔로잉 버튼누를때
      document.addEventListener('click', function (event) {
        // 클릭된 요소가 .clickable 클래스를 가진 경우
        if (event.target.classList.contains('clickable')) {
          const type = event.target.getAttribute('data-type'); // follower or following
          const userId = document.getElementById('followButton').getAttribute('data-following-id'); // 현재 프로필 사용자의 ID

          console.log("클릭됨: ", type, userId); // 디버깅 로그

          // 모달 제목 변경
          document.getElementById('followListModalLabel').textContent = (type === 'follower') ? '팔로워 목록' : '팔로잉 목록';

          // AJAX 요청
          fetch("/Controller?type=followList&typeValue=" + type + "&userId=" + userId)
              .then(response => response.json())
              .then(data => {
                const followList = document.getElementById('followList');
                followList.innerHTML = ''; // 기존 목록 초기화
                data.forEach(user => {
                  let followStatus = user.is_following ? '팔로잉 취소' : '팔로우';
                  let followClass = user.is_following ? 'btn-danger' : 'btn-primary';
                  let userId = user.user_id ? user.user_id : currentUserId;  // 기본값을 currentUserId로 설정

                  followList.innerHTML +=
                      '<li class="list-group-item d-flex justify-content-between align-items-center">' +
                      '<div class="d-flex align-items-center">' +
                      '<img src="' + user.profile_image + '" alt="Profile" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">' +
                      '<span class="ms-2">' + user.nickname + '</span>' +
                      '</div>' +
                      '<button id="followButton" class="btn ' + followClass + ' btn-sm follow-btn" data-user-id="' + userId + '">' +
                      followStatus +
                      '</button>' +
                      '</li>';
                });

                // 모달 열기
                const modalElement = document.getElementById('followListModal');
                if (modalElement) {
                  console.log("모달을 찾음, 열기 시도");
                  new bootstrap.Modal(modalElement).show();
                } else {
                  console.error("모달을 찾을 수 없음!");
                }

              })
              .catch(error => console.error('팔로우 목록을 가져오는 중 오류 발생:', error));
        }
      });

      document.addEventListener('click', function (event) {
        if (event.target.classList.contains('follow-btn')) {
          const followButton = event.target;

          let userId = followButton.getAttribute('data-user-id');
          if (!userId) {
            userId = currentUserId; // 현재 프로필의 사용자 ID 사용
          }

          const isCurrentlyFollowing = followButton.classList.contains('btn-danger');
          const action = isCurrentlyFollowing ? 'unfollow' : 'follow';

          updateButtonUI(followButton, !isCurrentlyFollowing);
          followButton.disabled = true;
          sendRequest(action, userId, followButton);
        }
      });
      function updateButtonUI(button, isFollowing) {
        if (isFollowing) {
          button.textContent = '팔로잉 취소';
          button.classList.replace('btn-primary', 'btn-danger');
        } else {
          button.textContent = '팔로우';
          button.classList.replace('btn-danger', 'btn-primary');
        }
      }

      function sendRequest(action, userId, button, retryCount = 0) {
        fetch('/Controller?type=' + action, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ userId }),
        })
            .then(response => {
              if (!response.ok) {
                throw new Error('서버 응답 오류');
              }
              return response.json();
            })
            .then(data => {
              if (!data.success) {
                throw new Error('처리 실패');
              }
              // 성공 시 추가 작업 (필요한 경우)
            })
            .catch(error => {
              console.error('Error:', error);
            })
            .finally(() => {
              button.disabled = false;
            });
      }

    </script>
</body>
</html>

<%--<%@ include file="../layout/footer.jsp" %>--%>