document.addEventListener('DOMContentLoaded', () => {
    // 기본 상태 설정
    const firstCollapse = document.querySelector('.product-menu .collapse');
    const firstCategory = document.querySelector(".list-unstyled .unstyled-btn");

    // 첫 번째 Collapse와 카테고리 기본 활성화
    if (firstCollapse) {
        firstCollapse.classList.add('show');
    }
    if (firstCategory) {
        firstCategory.classList.add('active');
    }

    // 기본 상태로 상품 조회 실행
    selectProducts();

    // Collapse 이벤트 처리
    $('#accordion').on('show.bs.collapse hide.bs.collapse', function (e) {
        const button = $(e.target).siblings('.card-header').find('.toggle-btn i');

        if (e.type === 'show') {
            button.removeClass('bi-plus').addClass('bi-dash');
        } else {
            button.removeClass('bi-dash').addClass('bi-plus');
        }
    });

    // 카테고리 선택 이벤트
    const listItems = document.querySelectorAll(".list-unstyled .unstyled-btn");
    let activeItem = document.querySelector(".list-unstyled .unstyled-btn.active");

    const updateActiveItem = (newActiveItem) => {
        if (activeItem) {
            activeItem.classList.remove("active");
        }
        newActiveItem.classList.add("active");
        activeItem = newActiveItem;

        const itemText = newActiveItem.dataset.name;
        const selectedButton = document.querySelector(".selected-item");
        selectedButton.querySelector(".item-text").textContent = itemText;
        selectedButton.classList.remove("d-none");

        selectProducts(1, newActiveItem);
    };

    listItems.forEach(item => {
        item.addEventListener("click", () => {
            updateActiveItem(item);
        });
    });

    // 정렬 선택 이벤트
    document.querySelectorAll('.dropdown-item').forEach(item => {
        item.addEventListener('click', function () {
            document.querySelectorAll('.dropdown-item').forEach(i => i.classList.remove('active'));
            this.classList.add('active');

            selectProducts();
        });
    });

    // 검색어 입력 이벤트
    document.getElementById("total-search-input").addEventListener("keydown", function (e) {
        if (e.key === 'Enter') {
            selectProducts();
        }
    });
});

// 카테고리와 정렬 값 추출
function getCategoryAndSort(clickedElement = null) {
    let parentCard = null;

    if (clickedElement) {
        parentCard = clickedElement.closest('.card');
    }

    if (!parentCard) {
        parentCard = document.querySelector('.card .collapse.show');  // 기본적으로 열린 Collapse 영역 가져오기
    }

    const categoryItem = parentCard ? parentCard.querySelector("#list-unstyled") : null;
    const sortItem = document.querySelector(".dropdown-items .dropdown-item.active");

    const category = categoryItem ? categoryItem.querySelector(".unstyled-btn.active")?.getAttribute("data-value") : null;
    const sort = sortItem ? sortItem.getAttribute("data-value") : "1";  // 기본 정렬 값 설정

    return { category, sort };
}

// 상품 조회
function selectProducts(page = 1, clickedElement = null) {
    const { category, sort } = getCategoryAndSort(clickedElement);
    const search = document.getElementById("total-search-input").value;

    if (!category) {
        console.warn('카테고리가 설정되지 않았습니다.');
        return;
    }

    $.ajax({
        url: 'Controller?type=index&action=select',
        method: 'POST',
        data: {
            category: category,
            sort: sort,
            search: search,
            page: page,
        },
        success: function (response) {
            $("#product-list").html(response);
        },
        error: function () {
            alert('상품 조회에 실패했습니다.');
        }
    });
}

// 좋아요 기능 (로그인 필요)
function notLoginLike() {
    if (confirm("로그인 후 이용할 수 있습니다. 로그인 페이지로 이동하시겠습니까?")) {
        window.location.href = "Controller?type=showlogin";
    }
}

// 좋아요 아이콘 클릭 시
function toggleProdHeart(obj, value) {
    if (obj.classList.contains('bi-heart')) {
        likeProduct(value);
        obj.classList.remove('bi-heart');
        obj.classList.add('bi-heart-fill', 'heart-animation', 'heart-active');
    } else {
        unlikeProduct(value);
        obj.classList.remove('bi-heart-fill', 'heart-active');
        obj.classList.add('bi-heart', 'heart-animation');
    }

    obj.addEventListener('animationend', function () {
        obj.classList.remove('heart-animation');
    }, { once: true });
}

// 좋아요 설정
function likeProduct(value) {
    $.ajax({
        url: "Controller?type=like&action=like",
        method: 'POST',
        data: { prod_no: value },
        success: function () {
            selectProducts();
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}

// 좋아요 해제
function unlikeProduct(value) {
    $.ajax({
        url: "Controller?type=like&action=unlike",
        method: 'POST',
        data: { prod_no: value },
        success: function () {
            selectProducts();
        },
        error: function (error) {
            alert("요청 처리 중 오류가 발생했습니다.");
            console.error(error);
        }
    });
}
