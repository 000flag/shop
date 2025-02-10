<%--
  Created by IntelliJ IDEA.
  User: gjcks
  Date: 2025-01-29
  Time: 오후 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
<div class="modal fade" id="followListModal" tabindex="-1" aria-labelledby="followListModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="followListModalLabel">팔로우 목록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <ul id="followList" class="list-group">
                    <!-- 여기에 Ajax로 가져온 데이터 삽입 -->
                </ul>
            </div>
        </div>
    </div>
</div>

 <script>
   document.addEventListener('DOMContentLoaded', function () {
     document.querySelectorAll('.follow-btn').forEach(button => {
       button.addEventListener('click', function () {
         const userId = this.getAttribute('data-user-id');
         const action = this.textContent.trim() === '팔로우' ? 'follow' : 'unfollow';

         fetch(`/Controller?type=`+action, {
           method: 'POST',
           headers: { 'Content-Type': 'application/json' },
           body: JSON.stringify({ followingId: userId })
         })
             .then(response => response.json())
             .then(data => {
               if (data.success) {
                 if (action === 'follow') {
                   this.textContent = '팔로잉 취소';
                   this.classList.replace('btn-primary', 'btn-danger');
                 } else {
                   this.textContent = '팔로우';
                   this.classList.replace('btn-danger', 'btn-primary');
                 }
               }
             })
             .catch(error => console.error('Error:', error));
       });
     });
   });


 </script>
</body>
</html>
