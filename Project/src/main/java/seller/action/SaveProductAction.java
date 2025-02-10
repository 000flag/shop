package seller.action;

import user.action.Action;
import comm.dao.InventoryDAO;
import comm.dao.ProductDAO;
import comm.service.S3Uploader;
import comm.vo.seller.InventoryVO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class SaveProductAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if(ServletFileUpload.isMultipartContent(request)){
            try{
                String uploadPath=request.getServletContext().getRealPath("/upload");
                File uploadDir = new File(uploadPath);
                if(!uploadDir.exists()){
                    uploadDir.mkdir();
                }
                String mainImageUrl =null;
                List<String> additionalImageUrls=new ArrayList<>();
                String contentUrl=null;
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);
                String prod_name = null;
                String middle_category = null;
                String major_category = null;
                List<String> prod_options = new ArrayList<>();
                List<String> inventory_options =  new ArrayList<>();
                List<String> total_length = new ArrayList<>();
                List<String> shoulder = new ArrayList<>();
                List<String> chest = new ArrayList<>();
                List<String> sleeve = new ArrayList<>();
                List<String> waist = new ArrayList<>();
                List<String> hip = new ArrayList<>();
                List<String> thigh = new ArrayList<>();
                List<String> rise = new ArrayList<>();
                List<String> hem = new ArrayList<>();
                List<String> foot_length = new ArrayList<>();
                List<String> foot_width = new ArrayList<>();
                List<String> ankle_height = new ArrayList<>();
                List<String> heel_height = new ArrayList<>();

                String seller_no = (String) session.getAttribute("seller_no");
                String price = null;
                String sale =null;
                String prod_no = null;
                String additional_images = null;
                String content = null;
                String saled_price = null;

                for(FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String value = item.getString("UTF-8");
                        if(value!=null) {
                            switch (fieldName) {
                                case "prod_name":
                                    prod_name = value;
                                    break;
                                case "middle_category":
                                    middle_category = value;
                                    break;
                                case "major_category":
                                    major_category = value;
                                    break;
                                case "prod_option[]":
                                    prod_options.add(value);
                                    break;
                                case "inventory_option[]":
                                    inventory_options.add(value);
                                    break;
                                case "price":
                                    price = value;
                                    break;
                                case "sale":
                                    sale = value;
                                    break;
                                case "prod_no":
                                    prod_no = value;
                                    break;
                                case "content":
                                    content = value;
                                    break;
                                case "total_length[]":
                                    total_length.add(value);
                                    break;
                                case "shoulder[]":
                                    shoulder.add(value);
                                    break;
                                case "chest[]":
                                    chest.add(value);
                                    break;
                                case "sleeve[]":
                                    sleeve.add(value);
                                    break;
                                case "waist[]":
                                    waist.add(value);
                                    break;
                                case "hip[]":
                                    hip.add(value);
                                    break;
                                case "thigh[]":
                                    thigh.add(value);
                                    break;
                                case "rise[]":
                                    rise.add(value);
                                    break;
                                case "hem":
                                    hem.add(value);
                                    break;
                                case "foot_length[]":
                                    foot_length.add(value);
                                    break;
                                case "foot_width[]":
                                    foot_width.add(value);
                                    break;
                                case "ankle_height[]":
                                    ankle_height.add(value);
                                    break;
                                case "heel_height[]":
                                    heel_height.add(value);
                                    break;
                                case "content_url":
                                    contentUrl = value;
                                    break;
                                case "main_url":
                                    mainImageUrl = value;
                            }
                        }
                    } else {
                        String fieldName = item.getFieldName();
                        System.out.println("----------------------------------");
                        System.out.println(item);
                        String originalFileName = new File(item.getName()).getName();
                        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;

                        File file = new File(uploadPath + File.separator + uniqueFileName);
                        item.write(file);

                        S3Uploader s3Uploader = new S3Uploader();
                        String s3Path = null;
                        switch (fieldName){
                            case "main_image": s3Path= "product/"+middle_category+"/"+seller_no+"/main/"+uniqueFileName;break;
                            case "additional_images[]": s3Path="product/"+middle_category+"/"+seller_no+"/additional/"+uniqueFileName;break;
                            case "content_image": s3Path="product/"+middle_category+"/"+seller_no+"/content/"+uniqueFileName;break;
                        }
                        if(s3Path!=null) {
                            String fileUrl = s3Uploader.uploadFile(file, s3Path);
                            if (fieldName.equals("main_image")) {
                                mainImageUrl = fileUrl;
                            } else if (fieldName.equals("additional_images[]")) {
                                additionalImageUrls.add(fileUrl);
                            } else if (fieldName.equals("content_image")) {
                                System.out.println("contentUrl 입력: "+fileUrl);
                                contentUrl = fileUrl;
                            }
                        }
                    }
                }
                additional_images = String.join(",",additionalImageUrls);
                if(sale.length()!=0)
                    saled_price = String.valueOf((int) (Double.parseDouble(price) - (Double.parseDouble(price) * Double.parseDouble(sale) / 100)));
                else {
                    saled_price = price;
                    sale = null;
                }
                System.out.println("prod_no: "+prod_no);
                if(prod_no == null){
                    prod_no = ProductDAO.addProduct(prod_name,major_category, middle_category, price, sale, seller_no, mainImageUrl,additional_images, content, saled_price,contentUrl);

                }else{
                    ProductDAO.updateProduct(prod_no,prod_name,major_category, middle_category, price, sale,seller_no, mainImageUrl, additional_images, content, saled_price,contentUrl);
                }
                InventoryDAO.deleteOptions(prod_no,seller_no);
                InventoryDAO.addOptions(setArr(prod_no,prod_options,inventory_options,total_length,shoulder,chest,sleeve,waist,
                        hip,thigh,rise,hem,foot_length,foot_width,ankle_height,heel_height));

            }catch (Exception e){
                e.printStackTrace();

            }
        }
        return "Controller?type=productList";
    }
    public InventoryVO[] setArr(String prod_no,List<String> p_options, List<String> i_options,List<String> total_length,List<String> shoulder,
                                List<String> chest,List<String> sleeve,List<String> waist,List<String> hip,List<String> thigh,List<String> rise,
                                List<String> hem,List<String> foot_length,List<String> foot_width,List<String> ankle_height,List<String> heel_height ) {
        String[] p_option = new String[p_options.size()];
        String[] i_option = new String[i_options.size()];
        String[] total = new String[p_options.size()];
        String[] shouldd = new String[p_options.size()];
        String[] chestt = new String[p_options.size()];
        String[] sleevee=new String[p_options.size()];
        String[] waistt = new String[p_options.size()];
        String[] hipp = new String[p_options.size()];
        String[] thighh=new String[p_options.size()];
        String[] risee=new String[p_options.size()];
        String[] hemm=new String[p_options.size()];
        String[] f_length = new String[p_options.size()];
        String[] f_width = new String[p_options.size()];
        String[] a_height = new String[p_options.size()];
        String[] h_height = new String[p_options.size()];

        InventoryVO[] ar = new InventoryVO[p_option.length];
        InventoryVO[] ex_ar = InventoryDAO.getOptions(prod_no);
        p_options.toArray(p_option);
        i_options.toArray(i_option);
        total_length.toArray(total);
        shoulder.toArray(shouldd);
        chest.toArray(chestt);
        sleeve.toArray(sleevee);
        waist.toArray(waistt);
        hip.toArray(hipp);
        thigh.toArray(thighh);
        rise.toArray(risee);
        hem.toArray(hemm);
        foot_length.toArray(f_length);
        foot_width.toArray(f_width);
        ankle_height.toArray(a_height);
        heel_height.toArray(h_height);

        for (int i = 0; i < ar.length; i++) {
            ar[i] = new InventoryVO();
            ar[i].setOption_name(p_option[i]);
            ar[i].setCount(i_option[i]);
            ar[i].setProd_no(prod_no);
            ar[i].setTotal_length(total[i]);
            ar[i].setChest(chestt[i]);
            ar[i].setShoulder(shouldd[i]);
            ar[i].setSleeve(sleevee[i]);
            ar[i].setWaist(waistt[i]);
            ar[i].setHip(hipp[i]);
            ar[i].setThigh(thighh[i]);
            ar[i].setRise(risee[i]);
            ar[i].setHem(hemm[i]);
            ar[i].setFoot_length(f_length[i]);
            ar[i].setFoot_width(f_width[i]);
            ar[i].setAnkle_height(a_height[i]);
            ar[i].setHeel_height(h_height[i]);
        }
        return ar;
    }
}
