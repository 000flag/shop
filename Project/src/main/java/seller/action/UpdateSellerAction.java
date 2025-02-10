package seller.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.action.Action;
import comm.dao.SellerDAO;
import comm.service.S3Uploader;
import comm.vo.seller.SellerVO;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.File;
import java.util.List;
import java.util.UUID;

public class UpdateSellerAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 파일 업로드를 위한 설정
        String uploadPath = request.getServletContext().getRealPath("/upload");
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String sellerId = null;
        String name = null;
        String phone = null;
        String email = null;
        String address = null;
        String desc = null;
        String sellerIconUrl = null;

        try {
            // 멀티파트 폼 데이터 처리
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {
                if (item.isFormField()) {
                    // 일반 form 필드 처리
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");

                    switch (fieldName) {
                        case "sellerId":
                            sellerId = value;
                            break;
                        case "brandName":
                            name = value;
                            break;
                        case "brandPhone":
                            phone = value;
                            break;
                        case "brandEmail":
                            email = value;
                            break;
                        case "brandAddress":
                            address = value;
                            break;
                        case "brandDesc":
                            desc = value;
                            break;
                    }
                } else {
                    // 파일 업로드 처리 (이제 "brandImage" 필드인지 확인!)
                    if ("brandImage".equals(item.getFieldName()) && !item.getName().isEmpty()) {
                        String originalFileName = new File(item.getName()).getName();
                        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;

                        File file = new File(uploadPath + File.separator + uniqueFileName);
                        item.write(file);

                        // S3 업로드
                        S3Uploader s3Uploader = new S3Uploader();
                        sellerIconUrl = s3Uploader.uploadFile(file, "seller-icons/" + uniqueFileName);
                    }
                }
            }

            // SellerVO 객체 생성 및 값 설정
            SellerVO sellerVO = new SellerVO();
            sellerVO.setSeller_id(sellerId);
            sellerVO.setName(name);
            sellerVO.setPhone(phone);
            sellerVO.setEmail(email);
            sellerVO.setAddress(address);
            sellerVO.setDesc(desc);
            sellerVO.setId(seller_no);
            System.out.println("seller_id:"+sellerId);
            System.out.println("sds"+sellerIconUrl);

            // 파일이 존재할 경우에만 업데이트
            if (sellerIconUrl != null) {
                sellerVO.setSeller_icon(sellerIconUrl);
            }
            System.out.println("updateSeller");
            // DAO를 통해 데이터베이스 업데이트 실행
            int updateSuccess = SellerDAO.updateSeller(sellerVO);
            System.out.println("updateSuccess:"+updateSuccess);
            if (updateSuccess == 1) {
                System.out.println("success");
            } else {
                System.out.println("not success ");
            }

            // 업데이트 후 브랜드 정보 페이지로 리다이렉트
            SellerVO updatedVO = SellerDAO.getSellerInfo(seller_no);
            request.setAttribute("vo", updatedVO);
            return "/seller/jsp/brandinfo.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "파일 업로드 중 문제가 발생했습니다.");
            return "/seller/jsp/brandinfo.jsp";
        }
    }
}