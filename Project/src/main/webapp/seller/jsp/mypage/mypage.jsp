<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코디 페이지</title>
    <!-- Bootstrap CSS -->

    <style>

        .category-menu {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 15px;
        }

        .category-header {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .category-buttons .btn {
            font-size: 12px;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .thumbnail img {
            max-width: 100%;
            height: auto;
        }

        .thumbnail .info {
            font-size: 12px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<jsp:include page="/user/jsp/layout/header.jsp"></jsp:include>


<div class="container-fluid mt-4" style="padding-left: 20px; padding-right: 0;">
    <div class="row">

        <div class="col-md-2" style="padding-left: 0">
            <div class="category-menu ms-0">
                <div class="category-header">분류</div>
                <button class="btn btn-outline-secondary btn-sm category-btn mb-2 me-2" data-category="스포츠">스포츠</button>
                <button class="btn btn-outline-secondary btn-sm category-btn mb-2 me-2" data-category="브랜드">브랜드</button>
                <button class="btn btn-outline-secondary btn-sm category-btn mb-2 me-2" data-category="지역별">지역별</button>


                <div class="category-header mt-3">연도</div>
                <button class="btn btn-outline-secondary btn-sm category-btn" data-category="2021">2021</button>
                <button class="btn btn-outline-secondary btn-sm category-btn" data-category="2020">2020</button>
                <button class="btn btn-outline-secondary btn-sm category-btn" data-category="2019">2019</button>

                <div class="category-header mt-3">색상</div>
                <div class="d-flex flex-wrap">
                    <div class="p-1">
                        <div class="rounded-circle bg-danger" style="width: 20px; height: 20px;"></div>
                    </div>
                    <div class="p-1">
                        <div class="rounded-circle bg-primary" style="width: 20px; height: 20px;"></div>
                    </div>
                    <div class="p-1">
                        <div class="rounded-circle bg-success" style="width: 20px; height: 20px;"></div>
                    </div>

                </div>
            </div>
        </div>


        <div class="col-md-10">
            <div class="border-bottom pb-2 mb-3">
               무신사>스냅>스트릿 스냅
            </div>
            <div class="border-bottom pb-2 mb-3">
                <h3 style="margin: 0; font-weight: bold;">Street Snap</h3>
            </div>
            <div class="border-bottom pb-2 mb-3" id="selectedCategoryDiv">
                <!-- 이 영역은 비워져 있으므로 여백으로 사용 -->
            </div>


            <div class="row row-cols-1 row-cols-md-4 g-4">

                <div class="col">
                    <div class="card">
                        <img src="../../images/shot1.jpg" class="card-img-top" alt="코디 이미지">
                        <div class="card-body">
                            <h5 class="card-title">서울 [홍대입구]</h5>
                            <p class="card-text info">16-03-29 | 조회수: 123</p>
                        </div>
                    </div>
                </div>


                <div class="col">
                    <div class="card">
                        <img src="../../images/shot2.jpg" class="card-img-top" alt="코디 이미지">
                        <div class="card-body">
                            <h5 class="card-title">Kenila [강남]</h5>
                            <p class="card-text info">16-03-29 | 조회수: 456</p>
                        </div>
                    </div>
                </div>


                <div class="col">
                    <div class="card">
                        <img src="../../images/shot3.jpg" class="card-img-top" alt="코디 이미지">
                        <div class="card-body">
                            <h5 class="card-title">정우 [신촌]</h5>
                            <p class="card-text info">16-03-29 | 조회수: 789</p>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="card">
                        <img src="../../images/shot4.jpg" class="card-img-top" alt="코디 이미지">
                        <div class="card-body">
                            <h5 class="card-title">최윤영 [홍대]</h5>
                            <p class="card-text info">16-03-29 | 조회수: 101</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

<footer>
    <jsp:include page="../layout/footer.jsp"></jsp:include>
</footer>
<script>
  const selectedCategoryDiv = document.getElementById('selectedCategoryDiv');
  const categoryButtons = document.querySelectorAll('.category-btn');

  const selectedCategories = {};

  categoryButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const category = button.textContent.trim();

      if (selectedCategories[category]) return;

      selectedCategories[category] = true;

      const categoryItem = document.createElement('span');
      categoryItem.className = 'badge bg-secondary me-2 mb-2';
      categoryItem.innerHTML = `
        ${category}
        <button type="button" class="btn-close btn-close-white" aria-label="Close"></button>
      `;

      categoryItem.querySelector('.btn-close').addEventListener('click', (e) => {
        e.stopPropagation();
        delete selectedCategories[category];
        selectedCategoryDiv.removeChild(categoryItem);
        button.classList.remove('active');
      });

      selectedCategoryDiv.appendChild(categoryItem);
      button.classList.add('active');
    });
  });
</script>



</html>
