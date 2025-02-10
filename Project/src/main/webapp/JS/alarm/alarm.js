document.addEventListener("DOMContentLoaded", function () {
  const alarmToggle = document.getElementById("alarm-toggle");
  const alarmContainer = document.querySelector(".alarm-container");

  alarmToggle.addEventListener("click", function (e) {
    e.preventDefault();
    alarmContainer.classList.toggle("d-none");
  });

  document.addEventListener("click", function (e) {
    if (!alarmContainer.contains(e.target) && !alarmToggle.contains(e.target)) {
      alarmContainer.classList.add("d-none");
    }
  });
});