document.addEventListener("DOMContentLoaded", function () {
  let editingCommentId = null; // 현재 수정 중인 댓글 ID 저장


  //  "모든 댓글 보기" 버튼 클릭 시 모달 열기 + 댓글 불러오기
  document.getElementById("viewAllCommentsBtn").addEventListener("click", function () {
    const heartIcon = document.querySelector(".heart-icon");
    const boardNo = heartIcon ? heartIcon.getAttribute("data-board-no") : null;

    if (!boardNo) {
      console.error(" boardNo 값이 없습니다.");
      return;
    }

    console.log(" viewAllCommentsBtn 클릭됨 - boardNo:", boardNo);

    var modalElement = document.getElementById("commentModal");
    modalElement.setAttribute("data-board-no", boardNo); //  모달에 boardNo 저장

    loadComments(boardNo); //  댓글 목록 불러오기
    var commentModal = new bootstrap.Modal(modalElement);
    commentModal.show();
  });

  //  모달이 열릴 때 자동으로 댓글 불러오기
  document.getElementById("commentModal").addEventListener("shown.bs.modal", function () {
    const boardNo = document.getElementById("commentModal").getAttribute("data-board-no");
    if (boardNo) {
      loadComments(boardNo);
    }
  });

  //  댓글 입력 또는 수정 버튼 클릭
  document.getElementById("postCommentBtn1").addEventListener("click", function () {
    const commentInput = document.getElementById("commentInput1");
    const content = commentInput.value.trim();

    if (!content) {
      alert("댓글을 입력하세요!");
      return;
    }

    const modalElement = document.getElementById("commentModal");
    const boardNo = modalElement.getAttribute("data-board-no");
    editingCommentId = sessionStorage.getItem("editingCommentId");

    if (!boardNo) {
      console.error(" boardNo 값이 없습니다.");
      return;
    }
    console.log(" boardNo:", editingCommentId);
    if (editingCommentId != null) {
      //  댓글 수정 요청
      fetch(`/Controller?type=updateComment`, {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "comment_id=" + editingCommentId + "&content=" + encodeURIComponent(content)
      })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              commentInput.value = ""; // 입력창 초기화
              // editingCommentId = null;
              sessionStorage.removeItem("editingCommentId");
              editingCommentId = null; // 수정 완료 후 초기화
              loadComments(boardNo); // 수정된 댓글 즉시 반영
              setTimeout(() => loadComments(boardNo), 500); // 0.5초 뒤 추가 업데이트
            } else {
              alert("수정 실패: " + data.error);
            }
          })
          .catch(error => console.error(" 댓글 수정 오류:", error));


    } else {
      //  새 댓글 작성 요청
      fetch(`/Controller?type=reply`, {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"},
        body: "board_no=" + boardNo + "&content=" + encodeURIComponent(content)
      })
          .then(response => response.json())
          .then(data => {
            if (data) {
              commentInput.value = ""; // 입력창 초기화
              addCommentToDOM(data.nickname, data.profile_image, data.content); //  즉시 화면에 반영
              loadComments(boardNo); //  댓글 즉시 반영
              setTimeout(() => loadComments(boardNo), 500); //  추가 업데이트
            }
          })
          .catch(error => console.error(" 댓글 전송 오류:", error));
    }
  });

});

//  댓글 목록 불러오기 (비동기)
function loadComments(boardNo) {
  fetch(`/Controller?type=allComments&board_no=` + boardNo)
      .then(response => response.json())
      .then(comments => {
        commentList.innerHTML = ""; // 기존 목록 초기화
        comments.forEach(comment => {
          const commentItem = document.createElement("li");
          commentItem.classList.add("list-group-item", "comment-item");

          const relativeTime = timeAgo(comment.write_date);

          commentItem.innerHTML =
              "<div class='d-flex align-items-center w-100'>" +
              "<img src='" + comment.profile_image + "' class='comment-profile me-2'>" +
              "<div class='flex-grow-1'>" +
              "<span class='comment-nickname'>" + comment.nickname +
              " <small class='text-muted'>" + relativeTime + "</small></span>" +
              "<p class='comment-text mb-0'>" + comment.content + "</p>" +
              "</div>" +
              "<div class='dropdown'>" +
              "<button class='btn btn-light comment-options' type='button' data-bs-toggle='dropdown' aria-expanded='false'>⋮</button>" +
              "<ul class='dropdown-menu dropdown-menu-end'>" +
              "<li><a class='dropdown-item' href='#' onclick='editComment(" + comment.id + ", `" + comment.content + "`)'>수정하기</a></li>" +
              "<li><a class='dropdown-item text-danger' href='#' onclick='deleteComment(" + comment.id + ")'>삭제하기</a></li>" +
              "</ul>" +
              "</div>" +
              "</div>";

          commentList.appendChild(commentItem);
        });
        updateLatestComment(boardNo);

      })
      .catch(error => console.error(" 댓글 불러오기 오류:", error));
}

//  수정 버튼 클릭 시 댓글 내용을 입력창에 자동 입력
function editComment(commentId, content) {
  editingCommentId = commentId;
  sessionStorage.setItem("editingCommentId", commentId);
  console.log("✅ editComment 실행됨 - editingCommentId:", editingCommentId);

  const commentInput = document.getElementById("commentInput1");
  commentInput.value = content;
  commentInput.focus();

  //  boardNo 가져오기 및 모달에 저장
  const modalElement = document.getElementById("commentModal");
  const heartIcon = document.querySelector(".heart-icon");
  const boardNo = heartIcon ? heartIcon.getAttribute("data-board-no") : null;

  if (!boardNo) {
    console.error(" boardNo 값이 없습니다.");
    return;
  }
  modalElement.setAttribute("data-board-no", boardNo);
}

//  새 댓글을 DOM에 즉시 추가 (서버 응답을 기다리지 않음)
function addCommentToDOM(nickname, profile_image, content) {
  const commentList = document.getElementById("commentList");
  const commentItem = document.createElement("li");
  commentItem.classList.add("list-group-item", "comment-item");

  const now = new Date();
  const relativeTime = timeAgo(now.toISOString());

  commentItem.innerHTML =
      "<div class='d-flex align-items-center w-100'>" +
      "<img src='" + profile_image + "' class='comment-profile me-2'>" +
      "<div class='flex-grow-1'>" +
      "<span class='comment-nickname'>" + nickname +
      " <small class='text-muted'>" + relativeTime + "</small></span>" +
      "<p class='comment-text mb-0'>" + content + "</p>" +
      "</div>" +
      "</div>";

  commentList.prepend(commentItem); //  가장 위에 추가
}

//  작성 시간 → 상대적 시간 변환 함수
function timeAgo(writeDate) {
  const now = new Date();
  const past = new Date(writeDate);
  const diff = Math.floor((now - past) / 1000);

  if (diff < 60) return "방금 전";
  const minutes = Math.floor(diff / 60);
  if (minutes < 60) return minutes + "분 전";
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return hours + "시간 전";
  const days = Math.floor(hours / 24);
  if (days < 30) return days + "일 전";
  return Math.floor(days / 30) + "달 전";
}

// 삭제하기
function deleteComment(commentId) {
  if (!confirm("정말로 이 댓글을 삭제하시겠습니까?")) return;

  const modalElement = document.getElementById("commentModal");
  const boardNo = modalElement.getAttribute("data-board-no");

  if (!boardNo) {
    console.error(" boardNo 값이 없습니다.");
    return;
  }

  fetch(`/Controller?type=deleteComment`, {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: "comment_id=" + commentId
  })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert("댓글이 삭제되었습니다.");
          loadComments(boardNo); //  삭제 후 즉시 반영
          updateLatestComment(boardNo);
        } else {
          alert("삭제 실패: " + data.error);
        }
      })
      .catch(error => console.error(" 댓글 삭제 오류:", error));
}

//최신댓글 업데이트임
function updateLatestComment(boardNo) {
  fetch(`/Controller?type=reply&board_no=` + boardNo)
      .then(response => response.json())
      .then(comment => {
        const latestCommentContainer = document.getElementById("latestComment");

        if (!comment) {
          latestCommentContainer.innerHTML = "<p class='text-muted'>댓글이 없습니다.</p>";
          return;
        }

        //  최신 댓글 UI 업데이트
        latestCommentContainer.innerHTML =
            "<p class='mb-0'>" +
            "<strong>" + comment.nickname + "</strong>&nbsp;&nbsp;" + comment.content +
            "</p>";
      })
      .catch(error => console.error(" 최신 댓글 불러오기 오류:", error));
}


// 일반 댓글 입력 (모달이 아닌 곳에서)
document.getElementById("postCommentBtn").addEventListener("click", function () {
  const commentInput = document.getElementById("commentInput");
  const content = commentInput.value.trim();

  if (!content) {
    alert("댓글을 입력하세요!");
    return;
  }

  const heartIcon = document.querySelector(".heart-icon");
  const boardNo = heartIcon ? heartIcon.getAttribute("data-board-no") : null;

  if (!boardNo) {
    console.error(" boardNo 값이 없습니다.");
    return;
  }

  console.log("✅ 일반 댓글 게시 버튼 클릭 - boardNo:", boardNo);

  fetch(`/Controller?type=reply`, {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8 "},
    body: "board_no=" + boardNo + "&content=" + encodeURIComponent(content),
  })
      .then(response => response.json())
      .then(data => {
        if (data) {
          console.log(" 댓글 추가 성공:", data);
          commentInput.value = ""; // 입력창 초기화
          updateLatestComment(boardNo);
          addCommentToDOM(data.nickname, data.profile_image, data.content);
          loadComments(boardNo); //  댓글 목록 즉시 업데이트
          setTimeout(() => loadComments(boardNo), 500); //  추가 업데이트
        }
      })
      .catch(error => console.error(" 댓글 전송 오류:", error));
});



// 페이지 로딩 시 각 게시글 내용에 대해 더보기 버튼 표시 여부를 결정
document.addEventListener("DOMContentLoaded", function() {
  // 모든 게시글 내용 요소를 순회
  var contentElements = document.querySelectorAll(".snap-content");
  contentElements.forEach(function(el) {
    // 실제 내용 높이와 클램프된 높이를 비교해서 더보기 버튼을 보여줌
    // 클램프된 경우 대략 2줄의 높이를 가지므로, 2줄보다 높으면 버튼을 보임
    if (el.scrollHeight > el.clientHeight + 5) { // 여유 5px
      var id = el.id.split("_")[1]; // 예: "snapContent_123" → "123"
      var moreBtnContainer = document.getElementById("moreBtnContainer_" + id);
      if (moreBtnContainer) {
        moreBtnContainer.style.display = "block";
      }
    }
  });
});

// 더보기 버튼 클릭 시 확장/축소 기능
function toggleContent(id) {
  var contentEl = document.getElementById("snapContent_" + id);
  var btnContainer = document.getElementById("moreBtnContainer_" + id);
  if (contentEl.classList.contains("expanded")) {
    // 접기: 클램프 효과 적용
    contentEl.classList.remove("expanded");
    btnContainer.innerHTML = '<span class="more-btn" onclick="toggleContent(\''+id+'\')">더보기</span>';
  } else {
    // 펼치기: clamped 효과 제거
    contentEl.classList.add("expanded");
    btnContainer.innerHTML = '<span class="more-btn" onclick="toggleContent(\''+id+'\')">접기</span>';
  }
}




// $(document).on('click', '.edit-snap-btn', function(e) {
//   e.preventDefault();
//   var snapId = $(this).data('snap-id');
//   console.log("수정 버튼 클릭, snapId:", snapId);
//   // AJAX로 수정 모달 컨텐츠 로드
//   $.ajax({
//     url: "${pageContext.request.contextPath}/Controller?type=snapUpdate&id=" + snapId,
//     method: "GET",
//     success: function(response) {
//       // 수정 모달 내부의 .modal-content 영역에 로드된 HTML 삽입
//       $('#snapEditModal .modal-content').html(response);
//       // 모달은 이미 data-bs-toggle, data-bs-target 속성에 의해 열림
//     },
//     error: function() {
//       alert("게시글 정보를 불러오는데 실패했습니다.");
//     }
//   });
// });
// document.addEventListener("DOMContentLoaded", function () {
//   var carouselElement = document.getElementById("photoCarousel");
//   var currentIndexElement = document.getElementById("currentIndex");
//
//
//   var totalPhotos = document.querySelectorAll("#photoCarousel .carousel-item").length;
//   document.getElementById("totalPhotos").innerText = totalPhotos; // 총 사진 개수 업데이트
//
//
//   carouselElement.addEventListener("slid.bs.carousel", function (event) {
//     currentIndexElement.innerText = event.to + 1; // 현재 슬라이드의 인덱스 (1부터 시작)
//   });
// });