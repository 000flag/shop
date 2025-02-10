document.addEventListener("DOMContentLoaded", function () {
    const reasonSelect = document.getElementById("reason-select");
    const feedbackSection = document.querySelector(".feedback");

    reasonSelect.addEventListener("change", function () {
        if (reasonSelect.value === "") {
            feedbackSection.style.display = "none";
        } else {
            feedbackSection.style.display = "block";
        }
    });
});
