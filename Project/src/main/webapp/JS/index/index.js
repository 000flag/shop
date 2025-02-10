// side menu
document.addEventListener('DOMContentLoaded', () => {
  const toggleButtons = document.querySelectorAll('.toggle-btn');

  toggleButtons.forEach(button => {
    button.addEventListener('click', function () {
      const allButtons = document.querySelectorAll('.toggle-btn i');
      const targetCollapse = this.getAttribute('data-target');
      const targetIcon = this.querySelector('i');

      allButtons.forEach(icon => {
        icon.classList.remove('bi-dash');
        icon.classList.add('bi-plus');
      });

      if (!document.querySelector(targetCollapse).classList.contains('show')) {
        targetIcon.classList.remove('bi-plus');
        targetIcon.classList.add('bi-dash');
      }
    });
  });
});

// sort
document.querySelectorAll('.dropdown-item').forEach(item => {
  item.addEventListener('click', function () {
    document.querySelectorAll('.dropdown-item').forEach(i => i.classList.remove('active'));
    this.classList.add('active');
  });
});

// selected
document.addEventListener("DOMContentLoaded", () => {
  const listItems = document.querySelectorAll(".list-unstyled .unstyled-btn");
  let activeItem = null;

  listItems.forEach((item) => {
    item.addEventListener("click", () => {
      // Remove active class from previously selected item
      if (activeItem) {
        activeItem.classList.remove("active");
      }

      item.classList.add("active");
      activeItem = item;

      const itemText = item.dataset.name;

      const selectedButton = document.querySelector(".selected-item");
      selectedButton.querySelector(".item-text").textContent = itemText;
      selectedButton.classList.remove("d-none");
    });
  });

  const removeItemBtn = document.querySelector(".remove-item");
  removeItemBtn.addEventListener("click", () => {
    if (activeItem) {
      activeItem.classList.remove("active");
      activeItem = null;
    }

    const selectedButton = document.querySelector(".selected-item");
    selectedButton.classList.add("d-none");
  });
});