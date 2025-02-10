<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코디 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/user/snap/css/Snap/mypage.css">
</head>
<style>
    .chat-meta {
        position: relative;  /* 부모 요소 설정 */
        display: flex;
        flex-direction: column; /* 요소를 세로로 정렬 */
        align-items: center; /* 가운데 정렬 */
    }
    .last-message-time {
        font-size: 12px;
        color: #666;
        margin-bottom: 10px; /* 시간과 배지 간격 조정 */
    }
    .unread-badge {
        position: absolute;
        bottom: -10px;  /* 숫자 뱃지를 아래쪽으로 이동 */
        left: 50%;
        transform: translateX(-50%); /* 가운데 정렬 */
        font-size: 12px;
        font-weight: bold;
        min-width: 20px;
        height: 20px;
        line-height: 18px;
        text-align: center;
        color: white;
        background-color: red;
        border-radius: 50%;
    }
    .unread-message-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: red;
        color: white;
        font-size: 12px;
        font-weight: bold;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>
<body>
<%-- 헤더, 왼쪽 메뉴 등 필요한 include --%>
<div class="container-fluid mt-4">
    <div class="row">
        <!-- 왼쪽 메뉴바 -->
        <div class="col-md-2 border-end position-fixed" style="height: 100vh;">
            <jsp:include page="/user/snap/jsp/layout/left.jsp"></jsp:include>
        </div>
        <!-- 콘텐츠 영역 -->
        <div class="col-md-10 offset-md-2">
            <div class="container-fluid">
                <div class="row">
                    <!-- 왼쪽 사이드바 (내 프로필 + 채팅 목록) -->
                    <div class="col-md-3 border-end p-3" style="height: 100vh; overflow-y: auto;">
                        <!-- 내 프로필 -->
                        <div class="d-flex align-items-center mb-4">
                            <img src="${myInfo.profile_image}" alt="Profile" class="rounded-circle" style="width: 50px; height: 50px;">
                            <span class="ms-2 fw-bold">${myInfo.nickname}</span>
                        </div>
                        <!-- 채팅방 목록 -->
                        <ul class="list-group">
                            <c:forEach var="room" items="${chatRooms}">
                                <li class="list-group-item d-flex justify-content-between align-items-center chat-room"
                                    data-room-id="${room.id}" data-profile="${room.otherUserProfileImage}"
                                    data-nickname="${room.otherUserNickname}">
                                    <div class="d-flex align-items-center">
                                        <img src="${room.otherUserProfileImage}" alt="Profile" class="rounded-circle" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <span class="fw-bold">${room.otherUserNickname}</span><br>
                                            <span class="text-muted">${room.lastMessage}</span>
                                        </div>
                                    </div>
                                    <div class="chat-meta">
                                        <span class="last-message-time">${room.lastMessageTimeStr}</span>
                                        <c:if test="${room.unreadCount > 0}">
                                            <span class="unread-badge">${room.unreadCount}</span>
                                        </c:if>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <!-- 오른쪽 대화창 -->
                    <div class="col-md-9 p-3">
                        <!-- 대화 상대 정보 -->
                        <div class="d-flex align-items-center p-3 border-bottom">
                            <img id="receiverProfileImg" src="" alt="상대방 프로필" class="rounded-circle" style="width: 50px; height: 50px; object-fit: cover;">
                            <span class="ms-2"><strong id="receiverNickname"></strong></span>
                        </div>
                        <!-- 채팅 메시지 영역 -->
                        <div id="chat-box" class="border p-3" style="height: 70vh; overflow-y: auto;">
                            <p class="text-muted text-center">대화를 선택하세요</p>
                        </div>
                        <!-- 메시지 입력 -->
                        <div class="d-flex mt-3 align-items-center">
                            <form id="uploadForm" enctype="multipart/form-data" class="d-flex w-100">
                                <label for="fileInput" class="btn btn-outline-secondary me-2 d-flex align-items-center justify-content-center"
                                       style="width: 40px; height: 40px; padding: 0;">
                                    <i class="bi bi-download" style="font-size: 20px;"></i>
                                </label>
                                <input type="file" id="fileInput" accept="image/*" style="display: none;">
                                <input type="text" id="messageInput" class="form-control me-2" placeholder="메시지를 입력하세요..." style="flex: 1;">
                                <button type="button" id="sendMessageBtn" class="btn btn-primary d-flex align-items-center justify-content-center"
                                        style="width: 100px;">전송</button>
                            </form>
                        </div>
                    </div><!-- 오른쪽 대화창 끝 -->
                </div><!-- row 끝 -->
            </div><!-- container-fluid 끝 -->
        </div><!-- 콘텐츠 영역 끝 -->
    </div><!-- row 끝 -->
</div><!-- container-fluid 끝 -->

<!-- 이미지 모달 -->
<div id="imageModal" class="modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">이미지 보기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" class="img-fluid" style="max-height: 500px; object-fit: contain;">
            </div>
            <div class="modal-footer">
                <a id="downloadImage" href="#" class="btn btn-primary" download>다운로드</a>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/user/snap/jsp/snap/snapModal.jsp"></jsp:include>
<script src="/JS/snapModal.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // === 전역 변수 설정 ===
    // 서버에서 전달된 값 (채팅방이 선택된 경우)
    let currentRoomId = '<%= request.getAttribute("selectedRoomId") %>';
    const currentUserId = '<%= session.getAttribute("cus_id") %>';
    const userId = currentUserId; // 동일하게 사용

    // DOM 요소 캐싱
    const messageInput = document.getElementById("messageInput");
    const sendMessageBtn = document.getElementById("sendMessageBtn");
    const chatBox = document.getElementById("chat-box");
    const fileInput = document.getElementById("fileInput");

    // WebSocket 및 Interval 변수
    let socket = null;
    let messageInterval;

    // === WebSocket 초기화 함수 ===
    function initializeSocket(roomId) {
      // 기존 소켓이 열려 있다면 닫기
      if (socket && socket.readyState === WebSocket.OPEN) {
        socket.close();
      }
      // EC2 서버의 퍼블릭 IP와 포트, 컨텍스트 경로를 사용하여 WebSocket URL 구성
      // 예시: ws://43.201.217.68:8080/yourapp/chatSocket/{userId}?roomId={roomId}
      const socketUrl = "ws://43.201.217.68:8080/yourapp/chatSocket/" + userId + "?roomId=" + roomId;
      console.log("Initializing WebSocket with URL:", socketUrl);
      console.log("userId:", userId, "currentRoomId:", roomId);
      socket = new WebSocket(socketUrl);
      socket.onopen = function(event) {
        console.log("WebSocket 연결 성공");
      };
      socket.onmessage = function(event) {
        console.log("WebSocket 메시지 수신:", event.data);
        // 만약 서버 메시지가 "서버 응답: " 접두어로 시작하면 제거
        let dataStr = event.data;
        const prefix = "서버 응답: ";
        if (dataStr.startsWith(prefix)) {
          dataStr = dataStr.substring(prefix.length);
        }
        try {
          const msg = JSON.parse(dataStr);
          displayMessage(msg);
        } catch (e) {
          console.error("JSON 파싱 오류:", e);
        }
      };
      socket.onclose = function(event) {
        console.log("WebSocket 연결 종료");
      };
    }

    // === displayMessage 함수: 메시지를 채팅창에 추가 ===
    function displayMessage(msg) {
      // 수신된 메시지의 roomId가 현재 채팅방과 다르면 무시
      if (msg.roomId != currentRoomId) return;
      const messageDate = new Date(msg.created_at || msg.createdAt);
      const formattedTime = messageDate.toLocaleTimeString('ko-KR', {
        hour: '2-digit', minute: '2-digit', hour12: true
      });
      let messageHTML = "";
      const isMyMessage = parseInt(msg.senderId) === parseInt(currentUserId);
      if (isMyMessage) {
        messageHTML = '<div class="d-flex flex-column align-items-end mb-2">' +
            '<div class="d-flex flex-column align-items-end">' +
            (msg.imageUrl ? '<img src="' + msg.imageUrl + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : '') +
            '<div class="d-flex align-items-center">' +
            '<div class="small text-muted me-2">' + formattedTime + '</div>' +
            '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%; border-radius:15px;">' +
            msg.message +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';
      } else {
        messageHTML = '<div class="d-flex align-items-start mb-2">' +
            '<img src="' + document.getElementById("receiverProfileImg").src + '" class="rounded-circle me-2" style="width:40px; height:40px; object-fit:cover;">' +
            '<div>' +
            '<div class="fw-bold text-dark">' + document.getElementById("receiverNickname").textContent + '</div>' +
            '<div class="d-flex flex-column">' +
            (msg.imageUrl ? '<img src="' + msg.imageUrl + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : '') +
            '<div class="d-flex align-items-center">' +
            '<div class="p-2 rounded bg-light" style="max-width:60%; border-radius:15px;">' + msg.message + '</div>' +
            '<div class="small text-muted ms-2">' + formattedTime + '</div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';
      }
      chatBox.insertAdjacentHTML('beforeend', messageHTML);
      chatBox.scrollTop = chatBox.scrollHeight;
    }

    // === loadChatMessages 함수: 서버로부터 메시지 목록 불러오기 ===
    function loadChatMessages(roomId) {
      if (!roomId) return;
      fetch("/Controller?type=chatRoom&roomId=" + roomId)
          .then(response => response.json())
          .then(messages => {
            chatBox.innerHTML = "";
            let lastDate = "";
            messages.forEach(msg => {
              const isMyMessage = parseInt(msg.sender_id) === parseInt(currentUserId);
              const messageDate = new Date(msg.created_at);
              // 언어 코드 오타 수정 ('ko-KsR' -> 'ko-KR')
              const formattedDate = messageDate.toLocaleDateString('ko-KR', {
                year: 'numeric', month: 'long', day: 'numeric', weekday: 'long'
              });
              const formattedTime = messageDate.toLocaleTimeString('ko-KR', {
                hour: '2-digit', minute: '2-digit', hour12: true
              });
              if (formattedDate !== lastDate) {
                chatBox.insertAdjacentHTML('beforeend', `<div class="text-center my-3 text-muted fw-bold">${formattedDate}</div>`);
                lastDate = formattedDate;
              }
              let messageHTML = "";
              if (isMyMessage) {
                messageHTML = '<div class="d-flex flex-column align-items-end mb-2">' +
                    '<div class="d-flex flex-column align-items-end">' +
                    (msg.image_url ? '<img src="' + msg.image_url + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : '') +
                    '<div class="d-flex align-items-center">' +
                    '<div class="small text-muted me-2">' + formattedTime + '</div>' +
                    '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%; border-radius:15px;">' + msg.message + '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
              } else {
                messageHTML = '<div class="d-flex align-items-start mb-2">' +
                    '<img src="' + document.getElementById("receiverProfileImg").src + '" class="rounded-circle me-2" style="width:40px; height:40px; object-fit:cover;">' +
                    '<div>' +
                    '<div class="fw-bold text-dark">' + document.getElementById("receiverNickname").textContent + '</div>' +
                    '<div class="d-flex flex-column">' +
                    (msg.image_url ? '<img src="' + msg.image_url + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : '') +
                    '<div class="d-flex align-items-center">' +
                    '<div class="p-2 rounded bg-light" style="max-width:60%; border-radius:15px;">' + msg.message + '</div>' +
                    '<div class="small text-muted ms-2">' + formattedTime + '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
              }
              chatBox.insertAdjacentHTML('beforeend', messageHTML);
            });
            chatBox.scrollTop = chatBox.scrollHeight;
            // 읽음 처리: 불러온 후 해당 roomId의 메시지를 읽음 상태로 업데이트
            markMessagesAsRead(roomId);
          })
          .catch(error => {
            console.error("메시지 로딩 오류:", error);
            chatBox.innerHTML = '<p class="text-muted text-center">채팅방을 선택해주세요.</p>';
          });
    }

    // === markMessagesAsRead 함수: 서버에 읽음 상태 업데이트 요청 ===
    function markMessagesAsRead(roomId) {
      fetch("/Controller?type=markAsRead&roomId=" + roomId, { method: "POST" })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              console.log("메시지를 읽음 상태로 변경 완료");
              updateUnreadCount(roomId);
            }
          })
          .catch(error => console.error("읽음 상태 업데이트 오류:", error));
    }

    // === updateUnreadCount 함수: 채팅방 목록에서 unread 배지 제거 ===
    function updateUnreadCount(roomId) {
      const chatRoomElement = document.querySelector('.chat-room[data-room-id="' + roomId + '"]');
      if (chatRoomElement) {
        const unreadBadge = chatRoomElement.querySelector(".unread-badge");
        if (unreadBadge) {
          unreadBadge.remove();
        }
      }
    }

    // === 이미지 모달 이벤트 처리 ===
    chatBox.addEventListener("click", function(event) {
      if (event.target.tagName === "IMG" && event.target.classList.contains("chat-image")) {
        const imageUrl = event.target.src;
        const modalImage = document.getElementById("modalImage");
        const downloadImage = document.getElementById("downloadImage");
        if (modalImage && downloadImage) {
          modalImage.src = imageUrl;
          downloadImage.setAttribute("data-url", imageUrl);
          new bootstrap.Modal(document.getElementById("imageModal")).show();
        }
      }
    });

    // === 초기 WebSocket 연결 (페이지 로드시 선택된 채팅방이 있다면) ===
    if (currentRoomId && currentRoomId !== "null") {
      initializeSocket(currentRoomId);
    }

    // === 채팅방 클릭 이벤트: 채팅방 변경 시 WebSocket 재설정 및 메시지 로드 ===
    document.querySelectorAll('.chat-room').forEach(room => {
      room.addEventListener("click", function() {
        currentRoomId = this.dataset.roomId;
        const selectedProfileImage = this.dataset.profile;
        const selectedNickname = this.dataset.nickname;
        document.getElementById("receiverProfileImg").src = selectedProfileImage;
        document.getElementById("receiverNickname").textContent = selectedNickname;
        document.querySelectorAll('.chat-room').forEach(r => r.classList.remove("active"));
        this.classList.add("active");
        loadChatMessages(currentRoomId);
        initializeSocket(currentRoomId);
        if (typeof messageInterval !== "undefined") {
          clearInterval(messageInterval);
        }
        messageInterval = setInterval(() => {
          loadChatMessages(currentRoomId);
        }, 1000000);
      });
    });

    // === 메시지 전송 함수 (파일 업로드 포함) ===
    async function sendMessage() {
      if (!currentRoomId) {
        alert("채팅방을 선택해주세요.");
        return;
      }
      const message = messageInput.value.trim();
      let imageUrl = null;
      if (fileInput.files.length > 0) {
        const formData = new FormData();
        formData.append("file", fileInput.files[0]);
        console.log("파일 선택됨:", fileInput.files[0].name);
        try {
          let response = await fetch("/Controller?type=uploadImage", {
            method: "POST",
            body: formData
          });
          let data = await response.json();
          if (data.success) {
            imageUrl = data.imageUrl;
          } else {
            alert("이미지 업로드 실패");
            return;
          }
        } catch (error) {
          console.error("이미지 업로드 오류:", error);
          return;
        }
      }
      const messageData = {
        roomId: currentRoomId,
        message: message,
        senderId: currentUserId,
        imageUrl: imageUrl
      };
      if (socket && socket.readyState === WebSocket.OPEN) {
        socket.send(JSON.stringify(messageData));
        messageInput.value = "";
        fileInput.value = "";
      } else {
        alert("WebSocket 연결이 열려 있지 않습니다. 잠시 후 다시 시도해주세요.");
      }
    }

    // === 메시지 전송 버튼 이벤트 등록 ===
    sendMessageBtn.addEventListener("click", sendMessage);
  });
</script>

<!-- 이미지 모달: 다운로드 버튼 이벤트 처리 -->
<script>
  document.addEventListener("DOMContentLoaded", function() {
    const downloadImageBtn = document.getElementById("downloadImage");
    if (downloadImageBtn) {
      downloadImageBtn.addEventListener("click", function() {
        const imageUrl = this.getAttribute("data-url");
        if (!imageUrl) {
          alert("이미지를 찾을 수 없습니다.");
          return;
        }
        fetch(imageUrl)
            .then(response => response.blob())
            .then(blob => {
              const url = window.URL.createObjectURL(blob);
              const a = document.createElement("a");
              a.style.display = "none";
              a.href = url;
              a.download = imageUrl.split("/").pop();
              document.body.appendChild(a);
              a.click();
              window.URL.revokeObjectURL(url);
              document.body.removeChild(a);
            })
            .catch(error => {
              console.error("다운로드 오류:", error);
              alert("파일을 다운로드할 수 없습니다.");
            });
      });
    }
  });
</script>



</body>
</html>
