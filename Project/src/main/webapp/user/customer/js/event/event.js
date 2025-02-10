document.addEventListener("DOMContentLoaded", function () {
    const eventToggle = document.getElementById("event-toggle");
    const eventContainer = document.querySelector(".event-container");

    if (eventToggle && eventContainer) {
        eventToggle.addEventListener("click", function (e) {
            e.preventDefault();
            eventContainer.classList.toggle("d-none");
        });

        document.addEventListener("click", function (e) {
            if (!eventContainer.contains(e.target) && !eventToggle.contains(e.target)) {
                eventContainer.classList.add("d-none");
            }
        });

        // 30초마다 알림 새로고침
        setInterval(selectEvent, 30000);
        selectEvent();
    }
});

// 알림 목록 가져오기
function selectEvent() {
    $.ajax({
        url: 'Controller?type=event',
        method: 'GET',
        dataType: 'json',
        success: function (data) {
            // const notificationContainer = $('#notification-container');
            // notificationContainer.empty();
            //
            // data.forEach(notification => {
            //     const notifElement = $('<div></div>');
            //     notifElement.addClass('notification');
            //     notifElement.css('backgroundColor', notification.isRead ? 'lightgray' : '#fff');
            //
            //     notifElement.html(`
            //         <span>${notification.couponName} - ${notification.salePercentage}% 할인</span>
            //         <span>${new Date(notification.eventTime).toLocaleString()}</span>
            //         ${notification.isRead ? '' : '<span class="red-dot"></span>'}
            //         <button onclick="markAsRead(${notification.eventId})">읽음</button>
            //     `);
            //
            //     notificationContainer.append(notifElement);
            // });
        },
        error: function (xhr, status, error) {
            console.error('Error fetching notifications:', error);
        }
    });
}

// 읽음 처리
function markAsRead(eventId) {
    $.ajax({
        url: `Controller?type=event&action=read`,
        method: 'POST',
        data: {
            eventId: eventId
        },
        success: function () {
            fetchNotifications(); // 알림 목록 새로고침
        },
        error: function (xhr, status, error) {
            console.error('Error marking notification as read:', error);
        }
    });
}
