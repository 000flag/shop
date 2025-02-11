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
    <style>
        /*.chat-message {*/
        /*    max-width: 60%; !* 메시지 박스 최대 너비 설정 *!*/
        /*    word-wrap: break-word;*/
        /*    overflow-wrap: break-word;*/
        /*    white-space: pre-wrap;*/
        /*}*/

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
        /* (옵션) 새 메시지 알림 버튼 – 필요 시 사용 */
        #newMessageButton {
            position: fixed;
            bottom: 80px;
            right: 20px;
            z-index: 1000;
            display: none;
        }
    </style>
</head>
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

<!-- 이미지 모달 (다운로드 버튼 그대로 둠) -->
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

<!-- 새 메시지 알림 버튼 (옵션) -->
<button id="newMessageButton" class="btn btn-primary">새 메시지 보기</button>

<jsp:include page="/user/snap/jsp/snap/snapModal.jsp"></jsp:include>
<script src="/JS/snapModal.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    // === 전역 변수 설정 ===
    var currentRoomId = '<%= request.getAttribute("selectedRoomId") %>';
    var currentUserId = '<%= session.getAttribute("cus_id") %>';
    var userId = currentUserId;

    // DOM 요소 캐싱
    var messageInput = document.getElementById("messageInput");
    var sendMessageBtn = document.getElementById("sendMessageBtn");
    var chatBox = document.getElementById("chat-box");
    var fileInput = document.getElementById("fileInput");
    var newMessageButton = document.getElementById("newMessageButton");

    // WebSocket 객체 (필요시 사용)
    var socket = null;

    // 폴링 간격 500ms
    var pollingInterval = 500;
    var messageInterval;

    // 마지막으로 추가된 메시지의 id (서버에서 id가 존재한다고 가정)
    var lastMessageId = 0;

    // 채팅창 스크롤 부드럽게
    chatBox.style.scrollBehavior = "smooth";

    // --- WebSocket 초기화 (기존과 동일) ---
    function initializeSocket(roomId) {
      if (socket && socket.readyState === WebSocket.OPEN) {
        socket.close();
      }
      var socketUrl = "ws://xxxxxx.execute-api.ap-northeast-2.amazonaws.com/dev/chatSocket/" + userId + "?roomId=" + roomId;
      console.log("Initializing WebSocket with URL: " + socketUrl);
      socket = new WebSocket(socketUrl);
      socket.onerror = (error) => {
        console.error("웹소켓 에러 발생:", error);
      };
      socket.onopen = function(event) {
        console.log("WebSocket 연결 성공");
      };
      socket.onmessage = function(event) {
        console.log("WebSocket 메시지 수신: " + event.data);
        var dataStr = event.data;
        var prefix = "서버 응답: ";
        if (dataStr.indexOf(prefix) === 0) {
          dataStr = dataStr.substring(prefix.length);
        }
        try {
          var msg = JSON.parse(dataStr);
          displayMessage(msg);
          if (msg.id && parseInt(msg.id) > lastMessageId) {
            lastMessageId = parseInt(msg.id);
          }
        } catch (e) {
          console.error("JSON 파싱 오류: " + e);
        }
      };
      socket.onclose = function(event) {
        console.log("WebSocket 연결 종료");
      };
    }

    // --- displayMessage 함수: 단일 메시지 추가 (실시간) ---
    // 텍스트가 없더라도 이미지가 있을 경우 빈 말풍선(공백 포함) 생성
    function displayMessage(msg) {
      if (msg.roomId != currentRoomId) return;
      var messageDate = new Date(msg.created_at || msg.createdAt);
      var formattedTime = messageDate.toLocaleTimeString("ko-KR", {
        hour: "2-digit", minute: "2-digit", hour12: true
      });
      var textHTML = "";
      if (msg.message && msg.message.trim() !== "") {
        textHTML = (parseInt(msg.senderId) === parseInt(currentUserId))
            ? '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%; border-radius:15px;">' + msg.message + '</div>'
            : '<div class="p-2 rounded bg-light" style="max-width:60%; border-radius:15px;">' + msg.message + '</div>';
      } else if (msg.imageUrl) {
        textHTML = (parseInt(msg.senderId) === parseInt(currentUserId))
            ? '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%; border-radius:15px;">&nbsp;</div>'
            : '<div class="p-2 rounded bg-light" style="max-width:60%; border-radius:15px;">&nbsp;</div>';
      }
      var messageHTML = "";
      if (parseInt(msg.senderId) === parseInt(currentUserId)) {
        messageHTML = '<div class="d-flex flex-column align-items-end mb-2">' +
            '<div class="d-flex flex-column align-items-end">' +
            (msg.imageUrl ? '<img src="' + msg.imageUrl + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : "") +
            '<div class="d-flex align-items-center">' +
            '<div class="small text-muted me-2">' + formattedTime + '</div>' +
            textHTML +
            '</div></div></div>';
      } else {
        messageHTML = '<div class="d-flex align-items-start mb-2">' +
            '<img src="' + document.getElementById("receiverProfileImg").src + '" class="rounded-circle me-2" style="width:40px; height:40px; object-fit:cover;">' +
            '<div>' +
            '<div class="fw-bold text-dark">' + document.getElementById("receiverNickname").textContent + '</div>' +
            '<div class="d-flex flex-column">' +
            (msg.imageUrl ? '<img src="' + msg.imageUrl + '" class="chat-image rounded mb-1" style="max-width:200px; max-height:250px; object-fit:cover; cursor:pointer;">' : "") +
            '<div class="d-flex align-items-center">' +
            textHTML +
            '<div class="small text-muted ms-2">' + formattedTime + '</div>' +
            '</div></div></div></div>';
      }
      chatBox.insertAdjacentHTML("beforeend", messageHTML);
      setTimeout(function() {
        chatBox.scrollTop = chatBox.scrollHeight;
      }, 20);
    }

    // --- buildMessageHTML 함수: 메시지 객체를 HTML 문자열로 변환 (폴링용) ---
    function buildMessageHTML(msg) {
      var messageDate = new Date(msg.created_at || msg.createdAt);
      var formattedTime = messageDate.toLocaleTimeString("ko-KR", {
        hour: "2-digit", minute: "2-digit", hour12: true
      });
      var html = "";
      var isMyMessage = parseInt(msg.sender_id) === parseInt(currentUserId);
      if (isMyMessage) {
        html = '<div class="d-flex flex-column align-items-end mb-2">' +
            '<div class="d-flex flex-column align-items-end">' +
            (msg.image_url ? '<img src="' + msg.image_url +
                '" class="chat-image rounded mb-1" style="max-width:200px;max-height:250px;object-fit:cover;cursor:pointer;">' : "") +
            '<div class="d-flex align-items-center">' +
            '<div class="small text-muted me-2">' + formattedTime + '</div>' +
            '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%;border-radius:15px;">' + msg.message + '</div>' +
            '</div></div></div>';
      } else {
        html = '<div class="d-flex align-items-start mb-2">' +
            '<img src="' + document.getElementById("receiverProfileImg").src +
            '" class="rounded-circle me-2" style="width:40px;height:40px;object-fit:cover;">' +
            '<div>' +
            '<div class="fw-bold text-dark">' + document.getElementById("receiverNickname").textContent + '</div>' +
            '<div class="d-flex flex-column">' +
            (msg.image_url ? '<img src="' + msg.image_url +
                '" class="chat-image rounded mb-1" style="max-width:200px;max-height:250px;object-fit:cover;cursor:pointer;">' : "") +
            '<div class="d-flex align-items-center">' +
            '<div class="p-2 rounded bg-light" style="max-width:60%;border-radius:15px;">' + msg.message + '</div>' +
            '<div class="small text-muted ms-2">' + formattedTime + '</div>' +
            '</div></div></div></div>';
      }
      return html;
    }

    // --- isUserAtBottom 함수 ---
    function isUserAtBottom() {
      return (chatBox.scrollHeight - chatBox.scrollTop - chatBox.clientHeight) < 50;
    }

    // --- loadChatMessages 함수: 폴링을 통한 메시지 업데이트 (새 메시지만 append) ---
    function loadChatMessages(roomId, forceScroll) {
      if (!roomId) return;
      fetch("/Controller?type=chatRoom&roomId=" + roomId)
          .then(function(response) { return response.json(); })
          .then(function(messages) {
            var newMessages = messages.filter(function(msg) {
              return parseInt(msg.id) > lastMessageId;
            });
            if (newMessages.length === 0) return;
            newMessages.forEach(function(msg) {
              chatBox.insertAdjacentHTML("beforeend", buildMessageHTML(msg));
              lastMessageId = Math.max(lastMessageId, parseInt(msg.id));
            });
            if (forceScroll || isUserAtBottom()) {
              chatBox.scrollTop = chatBox.scrollHeight;
            }
            markMessagesAsRead(roomId);
          })
          .catch(function(error) {
            console.error("메시지 로딩 오류:", error);
            chatBox.innerHTML = '<p class="text-muted text-center">채팅방을 선택해주세요.</p>';
          });
    }

    // --- markMessagesAsRead 함수 ---
    function markMessagesAsRead(roomId) {
      fetch("/Controller?type=markAsRead&roomId=" + roomId, { method: "POST" })
          .then(function(response) { return response.json(); })
          .then(function(data) {
            if (data.success) {
              console.log("메시지를 읽음 상태로 변경 완료");
              updateUnreadCount(roomId);
            }
          })
          .catch(function(error) {
            console.error("읽음 상태 업데이트 오류:", error);
          });
    }

    // --- updateUnreadCount 함수 ---
    function updateUnreadCount(roomId) {
      var chatRoomElement = document.querySelector('.chat-room[data-room-id="' + roomId + '"]');
      if (chatRoomElement) {
        var unreadBadge = chatRoomElement.querySelector(".unread-badge");
        if (unreadBadge) {
          unreadBadge.remove();
        }
      }
    }



    // --- 이미지 모달 이벤트 처리 (원본 그대로) ---
    chatBox.addEventListener("click", function(event) {
      if (event.target.tagName === "IMG" && event.target.classList.contains("chat-image")) {
        var imageUrl = event.target.src;
        var modalImage = document.getElementById("modalImage");
        var downloadImage = document.getElementById("downloadImage");
        if (modalImage && downloadImage) {
          modalImage.src = imageUrl;
          downloadImage.setAttribute("data-url", imageUrl);
          new bootstrap.Modal(document.getElementById("imageModal")).show();
        }
      }
    });

    //허찬희가 지울거
    function updateLastMessage(roomId, lastMessage, lastMessageTimeStr) {
      var chatRoomElement = document.querySelector('.chat-room[data-room-id="' + roomId + '"]');
      if (chatRoomElement) {
        var messagePreview = chatRoomElement.querySelector('.text-muted');
        var timePreview = chatRoomElement.querySelector('.last-message-time');

        if (messagePreview) messagePreview.textContent = lastMessage;
        if (timePreview) timePreview.textContent = lastMessageTimeStr;
      }
    }


    // --- 채팅방 클릭 이벤트: 오른쪽 대화창 업데이트 및 폴링 재설정 ---
    document.querySelectorAll(".chat-room").forEach(function(room) {
      room.addEventListener("click", function() {
        // 먼저 현재 채팅방 ID를 업데이트하고, lastMessageId 재설정
        lastMessageId = 0;
        currentRoomId = this.dataset.roomId;
        var selectedProfileImage = this.dataset.profile;
        var selectedNickname = this.dataset.nickname;
        document.getElementById("receiverProfileImg").src = selectedProfileImage;
        document.getElementById("receiverNickname").textContent = selectedNickname;
        document.querySelectorAll(".chat-room").forEach(function(r) {
          r.classList.remove("active");
        });
        this.classList.add("active");
        // 새 채팅방의 메시지를 로드하고 강제 스크롤
        loadChatMessages(currentRoomId, true);
        // 폴링 인터벌 재설정
        if (typeof messageInterval !== "undefined") {
          clearInterval(messageInterval);
        }
        messageInterval = setInterval(function() {
          loadChatMessages(currentRoomId);
        }, pollingInterval);
      });
    });

    // --- 메시지 전송 함수 (파일 업로드 포함) ---
    async function sendMessage() {
      if (!currentRoomId) {
        alert("채팅방을 선택해주세요.");
        return;
      }
      var text = messageInput.value.trim();
      var imageUrl = null;
      if (fileInput.files.length > 0) {
        var formData = new FormData();
        formData.append("file", fileInput.files[0]);
        console.log("파일 선택됨: " + fileInput.files[0].name);
        try {
          var response = await fetch("/UploadController?type=uploadImage", {
            method: "POST",
            body: formData
          });
          var data = await response.json();
          if (data.success) {
            imageUrl = data.imageUrl;
          } else {
            alert("이미지 업로드 실패");
            return;
          }
        } catch (error) {
          console.error("이미지 업로드 오류: " + error);
          return;
        }
      }
      var messageData = {
        roomId: currentRoomId,
        message: text,  // 텍스트가 없더라도 빈 문자열 전송 (백엔드에서 처리)
        senderId: currentUserId,
        imageUrl: imageUrl
      };
      var sendResponse = await fetch("/Controller?type=chatSend", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify(messageData)
      });
      var sendData = await sendResponse.json();
      if (sendData.success) {
        messageInput.value = "";
        fileInput.value = "";
        loadChatMessages(currentRoomId, true);

        var currentTime = new Date().toLocaleTimeString("ko-KR", { hour: "2-digit", minute: "2-digit", hour12: true });
        updateLastMessage(currentRoomId, messageData.message || "사진", currentTime);
      } else {
        throw new Error(sendData.message || "메시지 전송 실패");
      }
    }

    sendMessageBtn.addEventListener("click", sendMessage);
    messageInput.addEventListener("keydown", function(e) {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        sendMessage();
      }
    });
  });
</script>
</body>
</html>
