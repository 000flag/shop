<%@ page import="comm.vo.seller.ProductVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    String seller_no = (String) session.getAttribute("seller_no");
    session.setAttribute("seller_no",seller_no);
    %>

<html>
<header>
    <jsp:include page="./layout/header.jsp"/>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <style>
        .image-container {
            width: 150px;
            height: 150px;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px dashed #ddd;
            position: relative;
            background-color: #f9f9f9;
        }
        .image-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }

        .image-container .placeholder {
            font-size: 36px;
            color: #555; /* 진한 회색 */
            font-weight: bold;
        }

        .form-container {
            width: 50%;
            margin: 0 auto;
            text-align: left;
        }

        .button-container {
            display: flex;
            gap: 10px;
            justify-content: flex-end; /* 버튼들을 오른쪽으로 정렬 */
            margin-top: 20px;
        }

        .center{
            text-align: center;
        }

        .option-group {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .placeholder {
            background-color: #f9f9f9;
        }
        .naming{
            opacity: 0;
            color: transparent;
        }
    </style>
</header>
<body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js"></script>
<script>
    $(function(){
        $("#content").summernote({
            lang:"ko-KR",
            callbacks:{
                onImageUpload: function(files, editor){
                    // 이미지가 에디터에 추가될 때마다 수행하는 곳!!!!!!!!!
                    //이미지를 첨부하면 배열로 인식된다.
                    //이것을 서버로 비동기식 통신을 수행하면
                    //서버에 업로드를 시킬 수 있다.
                    for(let i=0; i<files.length; i++)
                        saveImg(files[i], editor);
                },
            }
        });
    });

    function saveImg(file, editor){
        // 서버로 이미지를 보내기 위해 폼객체 준비
        let frm = new FormData();

        // 서버로 파일을 보내기 위해 폼객체에 파라미터를 지정
        frm.append("upload", file);

        //비 동기식 통신
        $.ajax({
            url: "Controller?type=saveImg",
            data: frm,
            type: "post",
            contentType: false,
            processData: false,// 첨부파일을 보내는 것이고, 일반적인 데이터 전송이 아님!
            dataType: "json"
        }).done(function(res){
            //서버에서 보내는 json데이터는 res가 되며, 그 res안에 img_url을 가지고
            //img요소를 에디터에 추가
            $("#content").summernote("editor.insertImage", res.img_url);
        });
    }
    // 상품 옵션 추가
    function addOption() {
        const container = document.getElementById('productOptionsContainer');
        const newOptionGroup = document.createElement('div');
        newOptionGroup.className = 'productOptionsContainer';
        newOptionGroup.innerHTML = `
          <p class="center">+옵션</p>
          <div class="option-group">
            <input type="text" class="form-control" name="prod_option[]" placeholder="옵션을 입력하세요">

            <input type="number" class="form-control" name="inventory_option[]" placeholder="재고 수량을 입력하세요">
          </div>
          <div name="option_details"></div>
        `;
        container.appendChild(newOptionGroup);
        addDetail();
    }

    // 대표 이미지 미리보기
    function previewMainImage(event) {
        const reader = new FileReader();
        reader.onload = function () {
            const preview = document.getElementById('mainImagePreview');
            const placeholder = document.querySelector('#mainImageContainer .placeholder');
            preview.src = reader.result;
            preview.style.display = 'block';
            placeholder.style.display = 'none';

        };
        reader.readAsDataURL(event.target.files[0]);
    }

    // 추가 이미지 미리보기
    function previewAdditionalImage(event, inputElement) {
        const reader = new FileReader();
        reader.onload = function () {
            const container = inputElement.parentElement.querySelector('.additional-image');
            const previewImage = container.querySelector('.additional-image-preview');
            const placeholder = container.querySelector('.placeholder');
            previewImage.src = reader.result;
            previewImage.style.display = 'block';
            placeholder.style.display = 'none';
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    // 추가 이미지 입력 필드 트리거
    function triggerAdditionalImageInput(button) {
        const inputElement = button.nextElementSibling;
        inputElement.click();
    }
    function saveAsImage(){
        let contentHtml = $("#content").summernote("code");
        let tempDiv = document.createElement("div");
        tempDiv.innerHTML = contentHtml;
        document.body.appendChild(tempDiv);

        html2canvas(tempDiv).then(function(canvas) {
            document.body.removeChild(tempDiv);
            canvas.toBlob(function(blob) {
                if (!blob) {
                    console.error("Blob 생성 실패!");
                    return;
                }
                saveAs(blob, "content.png");
            }, "image/png");
        }).catch(error => {
            console.error("html2canvas 오류 발생:", error);
        });
    }
    function saveProduct(frm){
        let isValid=true;
        if($("#prod_name").val().trim().length==0){
            alert("상품 이름을 입력하세요.");
            $("#prod_name").focus();
            return;
        }

        $("input[name='prod_option[]']").each(function(){
            if(!$(this).val()){
                alert("모든 옵션을 입력하세요");
                isValid=false;
                $(this).focus();
                return;
            }
        });
        $("input[name='inventory_option[]']").each(function(){
            if(!$(this).val()){
                alert("모든 재고(수량)를 입력하세요");
                isValid=false;
                return false ;
            }
            return;
        });
        if($("#price").val().trim().length==0){
            alert("가격을 입력해주세요");
            isValid=false;
            return false;
        }
        if(!isValid){
            return;
        }
        frm.submit();
    }

    // 추가 이미지 필드 동적으로 추가
    function addAdditionalImage() {
        const container = document.getElementById('additionalImagesContainer');
        const newImageWrapper = document.createElement('div');
        newImageWrapper.className = 'additional-image-wrapper';

        newImageWrapper.innerHTML = `
            <div class="image-container additional-image">
                <span class="placeholder">+</span>
                <img src="" alt="추가 이미지 미리보기" class="additional-image-preview" style="display: none;"/>
            </div>
            <button type="button" class="btn btn-outline-secondary mt-2" onclick="triggerAdditionalImageInput(this)">이미지 선택</button>
            <input type="file" name="additionalImages[]" accept="image/*" style="display: none;" onchange="previewAdditionalImage(event, this)"/>
            <input type="hidden" name="additional_url[]"/>

        `;
        container.appendChild(newImageWrapper);
    }
    window.onload = function() {
        updateDiscountedPrice();
        const reader = new FileReader();
        const prod_image = document.getElementById("mainImageInput");
        prod_image.src = "${vo.prod_image}";

    };

    // 할인 후 가격 업데이트
    function updateDiscountedPrice() {
        const price = parseFloat(document.getElementById('price').value) || 0;
        const sale = parseFloat(document.getElementById('sale').value) || 0;

        if (sale >= 100 || sale<0) {
            alert("할인은 0~99%만 가능합니다.");
            document.getElementById('sale').value = 0;
            return;
        }
        const discountedPrice = price-price/100*sale;

        // discountedPriceElement를 가져오고 텍스트 업데이트
        const discountedPriceElement = document.getElementById('discountedPrice');
        if (discountedPriceElement) {
            discountedPriceElement.innerText = "할인 후 가격: " +parseInt(discountedPrice)+"원"; // innerText 사용
        }
    }

    function optionDetail(){
        const selectedCategory = $("#major_category").val();// major_category에서 선택된 값
        console.log("카테고리NO: "+selectedCategory);
        const container = $("[name='option_details']");

        // 카테고리별 입력 필드 데이터 정의
        const optionFields = {
            "1": [
                { name: "total_length[]", placeholder: "총 길이" },
                { name: "shoulder[]", placeholder: "어깨 너비" },
                { name: "chest[]", placeholder: "가슴 둘레" },
                { name: "sleeve[]", placeholder: "소매 길이" },
                { name: "waist[]", placeholder: "허리 둘레" }
            ],
            "3": [
                { name: "total_length[]", placeholder: "총 길이" },
                { name: "shoulder[]", placeholder: "어깨 너비" },
                { name: "chest[]", placeholder: "가슴 둘레" },
                { name: "sleeve[]", placeholder: "소매 길이" },
                { name: "waist[]", placeholder: "허리 둘레" }
            ],
            "2": [
                { name: "total_length[]", placeholder: "총 길이" },
                { name: "hip[]", placeholder: "엉덩이 둘레" },
                { name: "thigh[]", placeholder: "허벅지 둘레" },
                { name: "rise[]", placeholder: "밑위 길이" },
                { name: "hem[]", placeholder: "밑단 둘레" }
            ],
            "4": [
                { name: "foot_length[]", placeholder: "발 길이" },
                { name: "foot_width[]", placeholder: "발볼 너비" },
                { name: "ankle_height[]", placeholder: "발목 높이" },
                { name: "heel_height[]", placeholder: "굽 높이" }
            ]
        };
        // 각 option_details 요소를 순회하면서 업데이트
        container.each(function() {
            $(this).empty(); // 기존 입력 필드 삭제

            if (optionFields[selectedCategory]) {
                optionFields[selectedCategory].forEach(field => {
                    const label = $("<label>").text(field.placeholder);
                    const input = $("<input>")
                        .attr("type", "text")
                        .attr("class", "form-control")
                        .attr("name", field.name)
                        .attr("placeholder", field.placeholder);
                    $(this).append(label).append(input);
                });
            }
        });
    }
    function addDetail(){
        const selectedCategory = $("#major_category").val(); // major_category에서 선택된 값
        // 카테고리별 입력 필드 데이터 정의
        const optionFields = {
            "1": [
                {name: "total_length[]", placeholder: "총 길이"},
                {name: "shoulder[]", placeholder: "어깨 너비"},
                {name: "chest[]", placeholder: "가슴 둘레"},
                {name: "sleeve[]", placeholder: "소매 길이"},
                {name: "waist[]", placeholder: "허리 둘레"}
            ],
            "3": [
                {name: "total_length[]", placeholder: "총 길이"},
                {name: "shoulder[]", placeholder: "어깨 너비"},
                {name: "chest[]", placeholder: "가슴 둘레"},
                {name: "sleeve[]", placeholder: "소매 길이"},
                {name: "waist[]", placeholder: "허리 둘레"}
            ],
            "2": [
                {name: "total_length[]", placeholder: "총 길이"},
                {name: "hip[]", placeholder: "엉덩이 둘레"},
                {name: "thigh[]", placeholder: "허벅지 둘레"},
                {name: "rise[]", placeholder: "밑위 길이"},
                {name: "hem[]", placeholder: "밑단 둘레"}
            ],
            "4": [
                {name: "foot_length[]", placeholder: "발 길이"},
                {name: "foot_width[]", placeholder: "발볼 너비"},
                {name: "ankle_height[]", placeholder: "발목 높이"},
                {name: "heel_height[]", placeholder: "굽 높이"}
            ]
        };
        const option = $("[name='option_details']").last();
        const field = optionFields[selectedCategory].forEach(field=>{
            const label = $("<label>").text(field.placeholder);
            const input = $("<input>")
                .attr("type", "text")
                .attr("class", "form-control")
                .attr("name", field.name)
                .attr("placeholder", field.placeholder)
            option.append(label).append(input);
        });

    }
    // 정가나 할인 금액이 변경될 때마다 가격 업데이트
    document.getElementById('price').addEventListener('input', updateDiscountedPrice);
    document.getElementById('sale_price').addEventListener('input', updateDiscountedPrice);

</script>

<div class="container mt-5">
<h3 class="mb-3 center">상품 등록</h3>
<hr/>
<!-- 상품 정보 폼 -->
<form method="POST" action="Controller?type=saveProduct" class="form-container" enctype="multipart/form-data">
    <input type="hidden" name="prod_no" value="${vo.id}">
    <!-- 상품 명 -->
    <div style="flex-grow: 1;">
        <div class="mb-4">
            <label for="prod_name" class="form-label">상품명</label>
            <input type="text" class="form-control" id="prod_name" name="prod_name" value="${vo.name}" style="width: 100%;">
        </div>
        <hr/>
        <div class="mb-3">
            <label class="form-label">카테고리 설정</label>
            <div class="option-group">
                <select id="major_category" name="major_category" class="form-control">
                    <option value="${majorCategory.id}" selected>${majorCategory.name}</option>
                    <c:forEach var="major" items="${majorCategoryAr}">
                        <option value="${major.id}">${major.name}</option>
                    </c:forEach>
                </select>
                <select id="middle_category" name="middle_category" class="form-control">
                    <option value="${middleCategory.id}"  selected>${middleCategory.name}</option>
                </select>
                <script>
                    const middleCategoryData ={
                        <c:forEach var="major" items="${majorCategoryAr}">
                        "${major.id}" : [
                            <c:forEach var="middle" items="${middleCategoryAr}">
                            <c:if test="${major.id eq middle.major_no}">
                            { value: "${middle.id}",text: "${middle.name}"},
                            </c:if>
                            </c:forEach>
                        ],
                        </c:forEach>
                    };
                    document.getElementById('major_category').addEventListener('change', function() {
                        const majorValue = this.value;
                        const middleCategory = document.getElementById('middle_category');

                        // 기존 옵션 제거
                        middleCategory.innerHTML = '<option value="" disabled selected>중분류</option>';

                        if (majorValue && middleCategoryData[majorValue]) {
                            middleCategoryData[majorValue].forEach(item => {
                                let option = document.createElement('option');
                                option.textContent = item.text;
                                option.value = item.value;
                                middleCategory.appendChild(option);
                            });
                        }
                        optionDetail();
                    });
                </script>
            </div>
        </div>
        <hr/>
        <!-- 상품 옵션 -->
        <div class="mb-3">
            <label class="form-label"><h3>상품 옵션</h3></label>
            <div id="productOptionsContainer">
                <c:forEach var="option" items="${vo.options}" varStatus="vs">
                    <p class="center">옵션 ${vs.index+1}</p>
                    <div class="option-group">
                        <input type="text" class="form-control" name="prod_option[]" value="${option.option_name}"/>
                        <input type="number" class="form-control" name="inventory_option[]" value="${option.count}"/>
                    </div>
                    <div name="option_details">
                        <c:if test="${vo.major_category eq 1 or vo.major_category eq 3}">
                            <label>총 길이</label>
                            <input type="text" class="form-control" name="total_length[]" value="${option.total_length}">
                            <label>어깨 너비</label>
                            <input type="text" class="form-control" name="shoulder[]" value="${option.shoulder}">
                            <label>가슴 둘레</label>
                            <input type="text" class="form-control" name="chest[]" value="${option.chest}">
                            <label>소매 길이</label>
                            <input type="text" class="form-control" name="sleeve[]" value="${option.sleeve}">
                            <label>허리 둘레</label>
                            <input type="text" class="form-control" name="waist[]" value="${option.waist}">
                        </c:if>
                        <c:if test="${vo.major_category eq 2}">
                            <label>총 길이</label>
                            <input type="text" class="form-control" name="total_length[]" value="${option.total_length}">
                            <label>엉덩이 둘레</label>
                            <input type="text" class="form-control" name="hip[]" value="${option.hip}">
                            <label>허벅지 둘레</label>
                            <input type="text" class="form-control" name="thigh[]" value="${option.thigh}">
                            <label>밑위 길이</label>
                            <input type="text" class="form-control" name="rise[]" value="${option.rise}">
                            <label>밑단 둘레</label>
                            <input type="text" class="form-control" name="hem[]" value="${option.hem}">
                        </c:if>
                        <c:if test="${vo.major_category eq 4}">
                            <label>발 길이</label>
                            <input type="text" class="form-control" name="foot_length[]" value="${option.foot_length}">
                            <label>발볼 너비</label>
                            <input type="text" class="form-control" name="foot_width[]" value="${option.foot_width}">
                            <label>발목 높이</label>
                            <input type="text" class="form-control" name="ankle_height[]" value="${option.ankle_height}">
                            <label>굽 높이</label>
                            <input type="text" class="form-control" name="heel_height[]" value="${option.heel_height}">
                        </c:if>
                    </div>
                </c:forEach>
            </div>
            <button type="button" class="btn btn-outline-success mt-2" onclick="addOption()">옵션 추가</button>
        </div>
        <hr/>
        <!-- 가격 -->
        <div class="mb-3">
            <label for="price" class="form-label">판매가</label><br/>
            <input type="number" class="form-control" id="price" name="price" value="${vo.price}" style="width: 50%;display: inline-block;">
            <span>원</span>
        </div>
        <hr/>
        <!-- 할인 -->
        <div class="mb-3">
            <label for="sale" class="form-label">할인(%))</label><br/>
            <input type="number" class="form-control" id="sale" name="sale" value="${vo.sale}" style="width: 50%; display: inline-block;">
            <span>%</span>
        </div>

        <div class="mb-3" id="discountedPriceContainer">
            <p id="discountedPrice" style="font-weight: bold; color: #28a745;">할인 후 가격: 0 원</p>
        </div>
        <hr/>
        <!-- 대표 이미지 -->
        <!-- 대표 이미지 -->
        <label class="form-label">대표 이미지</label>
        <div>
            <div id="mainImageContainer" class="image-container">
                <img id="mainImagePreview" src="${vo.prod_image}" alt="대표 이미지 미리보기" style="max-width: 100%; max-height: 100%; object-fit: cover;" />
            </div>
        </div>
        <button type="button" class="btn btn-outline-primary mt-2" onclick="document.getElementById('mainImageInput').click();">대표 이미지 선택</button>
        <input type="file" id="mainImageInput" name="main_image" accept="image/*"
               style="display: none;" onchange="previewMainImage(event)" src="${vo.prod_image}">
        <input type="hidden" name="main_url" id="main_url" value="${vo.prod_image}" readOnly/>
        <!-- 추가 이미지 -->
        <hr/>
        <label class="form-label">추가 이미지</label>
        <div id="additionalImagesContainer" style="display: flex; gap: 10px; flex-wrap: wrap;">
            <c:choose>
                <c:when test ="${not empty vo.ar_images}">
                <c:forEach var="additionalImage" items="${vo.ar_images}">
                    <div class="additional-image-wrapper">
                        <div class="image-container additional-image" >
                            <img src="${additionalImage}" alt="추가 이미지 미리보기" class="additional-image-preview" style="max-width: 100%; max-height: 100%; object-fit: cover;" />
                        </div>
                        <button type="button" class="btn btn-outline-secondary mt-2" onclick="triggerAdditionalImageInput(this)">이미지 선택</button>
                        <input type="file" name="additional_images[]" accept="image/*" style="display: none;" onchange="previewAdditionalImage(event, this)" />
                        <input type="hidden" name="additional_url[]" value="${additionalImage}"/>
                    </div>
                </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="additional-image-wrapper">
                        <div class="image-container additional-image">
                            <span class="placeholder">+</span>
                            <img src="" alt="추가 이미지 미리보기" class="additional-image-preview" style="display: none;"/>
                        </div>
                        <button type="button" class="btn btn-outline-secondary mt-2" onclick="triggerAdditionalImageInput(this)">이미지 선택</button>
                        <input type="file" name="additional_images[]" accept="image/*" style="display: none;" multiple onchange="previewAdditionalImage(event, this)"/>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <button type="button" class="btn btn-outline-success mt-3" onclick="addAdditionalImage()">이미지 추가</button>
        <hr/>
     <!-- 추가 이미지 아래에 HTML 에디터 추가 -->
        <div class="mb-3" style="margin-top: 30px;">
            <label for="content">상세 설명(HTML)</label>
            <p>HTML 작성 후 이미지로 저장을 하실 수 있습니다.</p>
            <p>이미지로 저장 후 파일 선택을 통해 이미지로 저장된 상세 설명을 선택해주시거나 개별적으로 작성한 상세설명을 첨부하실 수 있습니다.</p>
            <textarea id="content" name="content">${vo.content}</textarea>
            <button type="button" class="btn btn-outline-secondary mt-2" onclick="saveAsImage()">이미지로 저장</button>
        </div>
        <label for="content_image" class="btn btn-outline-secondary" style="width: 200px;">이미지 선택하기</label>
        <input type="file"  id ="content_image" name="content_image" accept="image/*" class="btn btn-outline-secondary mt-2 naming" onchange="setValue()"/>
        <script>
            function setValue(){
                var fileName = document.getElementById("content_image").files[0]?.name; // Get the file name
                document.getElementById("url").textContent = fileName;
            }
        </script>
        <p id="url">${vo.content_image}</p>
        <input type="hidden" id="content_url" name="content_url" value="${vo.content_image}">
        <hr/>
    <!-- 저장 버튼 -->
    <div class="button-container">
        <button type="button" class="btn btn-success" onclick="saveProduct(this.form)">저장</button>
    </div>
    <hr/>
    </div>

    </form>
</div>

</body>
<footer>
    <jsp:include page="./layout/footer.jsp"></jsp:include>
</footer>
</html>