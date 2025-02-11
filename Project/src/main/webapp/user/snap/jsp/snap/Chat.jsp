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
        var currentRoomId = '<%= request.getAttribute("selectedRoomId") %>';
        var currentUserId = '<%= session.getAttribute("cus_id") %>';
        var userId = currentUserId;

        // DOM 요소 캐싱
        var messageInput = document.getElementById("messageInput");
        var sendMessageBtn = document.getElementById("sendMessageBtn");
        var chatBox = document.getElementById("chat-box");
        var fileInput = document.getElementById("fileInput");

        // WebSocket 객체 (필요시 사용)
        var socket = null;

        // 폴링 간격 500ms
        var pollingInterval = 500;
        var messageInterval;

        // 마지막으로 추가된 메시지의 id (초기값 0; 서버에서 id가 1 이상이면)
        var lastMessageId = 0;

        // 채팅창 스크롤 동작을 부드럽게 설정
        chatBox.style.scrollBehavior = "smooth";

        // --- WebSocket 관련 함수 (기존과 동일) ---
        function initializeSocket(roomId) {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.close();
            }
            var socketUrl = "ws://xxxxxx.execute-api.ap-northeast-2.amazonaws.com/dev/chatSocket/"
                + userId + "?roomId=" + roomId;
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
                    // 실시간 수신된 메시지는 바로 DOM에 추가
                    displayMessage(msg);
                    // 최신 메시지 id 업데이트 (단, msg.id가 존재할 경우)
                    if(msg.id && parseInt(msg.id) > lastMessageId) {
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

        // --- displayMessage 함수: 단일 메시지를 채팅창에 추가 (실시간 전용) ---
        function displayMessage(msg) {
            if (msg.roomId != currentRoomId) return;
            var messageDate = new Date(msg.created_at || msg.createdAt);
            var formattedTime = messageDate.toLocaleTimeString("ko-KR", {
                hour: "2-digit", minute: "2-digit", hour12: true
            });
            var messageHTML = "";
            var isMyMessage = parseInt(msg.senderId) === parseInt(currentUserId);
            if (isMyMessage) {
                messageHTML = '<div class="d-flex flex-column align-items-end mb-2">' +
                    '<div class="d-flex flex-column align-items-end">' +
                    (msg.imageUrl ? '<img src="' + msg.imageUrl +
                        '" class="chat-image rounded mb-1" style="max-width:200px;max-height:250px;object-fit:cover;cursor:pointer;">' : "") +
                    '<div class="d-flex align-items-center">' +
                    '<div class="small text-muted me-2">' + formattedTime + '</div>' +
                    '<div class="p-2 rounded bg-warning text-dark" style="max-width:60%;border-radius:15px;">' + msg.message + '</div>' +
                    '</div></div></div>';
            } else {
                messageHTML = '<div class="d-flex align-items-start mb-2">' +
                    '<img src="' + document.getElementById("receiverProfileImg").src +
                    '" class="rounded-circle me-2" style="width:40px;height:40px;object-fit:cover;">' +
                    '<div>' +
                    '<div class="fw-bold text-dark">' + document.getElementById("receiverNickname").textContent + '</div>' +
                    '<div class="d-flex flex-column">' +
                    (msg.imageUrl ? '<img src="' + msg.imageUrl +
                        '" class="chat-image rounded mb-1" style="max-width:200px;max-height:250px;object-fit:cover;cursor:pointer;">' : "") +
                    '<div class="d-flex align-items-center">' +
                    '<div class="p-2 rounded bg-light" style="max-width:60%;border-radius:15px;">' + msg.message + '</div>' +
                    '<div class="small text-muted ms-2">' + formattedTime + '</div>' +
                    '</div></div></div></div>';
            }
            chatBox.insertAdjacentHTML("beforeend", messageHTML);
            // 실시간 메시지 수신 시 항상 스크롤을 맨 아래로 이동
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        // --- buildMessageHTML 함수: 메시지 객체를 HTML 문자열로 변환 ---
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

        // --- isUserAtBottom 함수: 사용자가 채팅창 하단에 있는지 판단 ---
        function isUserAtBottom() {
            return (chatBox.scrollHeight - chatBox.scrollTop - chatBox.clientHeight) < 50;
        }

        // --- loadChatMessages 함수: 폴링을 통한 전체 메시지 업데이트 (새 메시지만 append) ---
        function loadChatMessages(roomId) {
            if (!roomId) return;
            fetch("/Controller?type=chatRoom&roomId=" + roomId)
                .then(function(response) { return response.json(); })
                .then(function(messages) {
                    // messages 배열은 오름차순 정렬되어 있다고 가정하고,
                    // 마지막 메시지의 id보다 큰 메시지만 새로운 메시지로 간주
                    var newMessages = messages.filter(function(msg) {
                        return parseInt(msg.id) > lastMessageId;
                    });
                    if (newMessages.length === 0) return;

                    // 새 메시지들을 append
                    newMessages.forEach(function(msg) {
                        chatBox.insertAdjacentHTML("beforeend", buildMessageHTML(msg));
                        lastMessageId = Math.max(lastMessageId, parseInt(msg.id));
                    });
                    // 사용자가 하단에 있었다면 부드럽게 맨 아래로 이동, 아니라면 스크롤 위치 보존
                    if (isUserAtBottom()) {
                        chatBox.scrollTop = chatBox.scrollHeight;
                    }
                    markMessagesAsRead(roomId);
                })
                .catch(function(error) {
                    console.error("메시지 로딩 오류:", error);
                    // 에러 발생 시, 현재 채팅방 안내 메시지를 표시
                    chatBox.innerHTML = '<p class="text-muted text-center">채팅방을 선택해주세요.</p>';
                });
        }

        // --- markMessagesAsRead 함수 (변경 없음) ---
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

        // --- updateUnreadCount 함수 (변경 없음) ---
        function updateUnreadCount(roomId) {
            var chatRoomElement = document.querySelector('.chat-room[data-room-id="' + roomId + '"]');
            if (chatRoomElement) {
                var unreadBadge = chatRoomElement.querySelector(".unread-badge");
                if (unreadBadge) {
                    unreadBadge.remove();
                }
            }
        }

        // --- 이미지 모달 이벤트 처리 (변경 없음) ---
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

        // --- 초기 메시지 로드 및 폴링 시작 (폴링 간격 500ms 적용) ---
        if (currentRoomId && currentRoomId !== "null") {
            loadChatMessages(currentRoomId);
            messageInterval = setInterval(function() {
                loadChatMessages(currentRoomId);
            }, pollingInterval);
        }

        // --- 채팅방 클릭 이벤트: 채팅방 변경 시 메시지 로드 및 폴링 재설정 (변경 없음) ---
        document.querySelectorAll(".chat-room").forEach(function(room) {
            room.addEventListener("click", function() {
                currentRoomId = this.dataset.roomId;
                var selectedProfileImage = this.dataset.profile;
                var selectedNickname = this.dataset.nickname;
                document.getElementById("receiverProfileImg").src = selectedProfileImage;
                document.getElementById("receiverNickname").textContent = selectedNickname;
                document.querySelectorAll(".chat-room").forEach(function(r) {
                    r.classList.remove("active");
                });
                this.classList.add("active");
                // 채팅창을 완전히 새로 렌더링하지 않고 loadChatMessages를 호출하여 새 메시지만 추가
                loadChatMessages(currentRoomId);
                if (typeof messageInterval !== "undefined") {
                    clearInterval(messageInterval);
                }
                messageInterval = setInterval(function() {
                    loadChatMessages(currentRoomId);
                }, pollingInterval);
            });
        });

        // --- 메시지 전송 함수 (파일 업로드 포함, 변경 없음) ---
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
                message: text,
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
                // 전송 후 즉시 loadChatMessages를 호출하여 새 메시지를 추가
                loadChatMessages(currentRoomId);
            } else {
                throw new Error(sendData.message || "메시지 전송 실패");
            }
        }

        sendMessageBtn.addEventListener("click", sendMessage);
    });
</script>
</body>
</html>