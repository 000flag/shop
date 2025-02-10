package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.ProductVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class ProductDAO {

    public static ProductVO[] getAll(String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        ProductVO[] ar = null;
        List<ProductVO> list = ss.selectList("product.getAll",seller_no);

        if(list!=null){
            ar = new ProductVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static ProductVO[] searchProduct(String seller_no,String category,String prod_name){
        SqlSession ss = FactoryService.getFactory().openSession();
        ProductVO[] ar = null;
        HashMap<String,String> map = new HashMap<>();
        map.put("seller_no",seller_no);
        map.put("category",category);
        map.put("prod_name",prod_name);
        List<ProductVO> list = null;
        if(category.equals("0")){
            list = ss.selectList("product.search_product_all",map);
        }else {
            list = ss.selectList("product.search_product", map);
        }
        ar = new ProductVO[list.size()];
        System.out.println("ListSize: "+list.size());
        list.toArray(ar);

        ss.close();
        return ar;
    }
    public static ProductVO getProductOne(String prod_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        ProductVO vo=null;
        if(prod_no!=null) {
            vo = ss.selectOne("product.getProductOne",prod_no);
        }
        ss.close();
        return vo;
    }
    public static int changeActive(String prod_no,String active,String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        HashMap<String,String> map = new HashMap<>();
        map.put("prod_no",prod_no);
        map.put("active",active);
        map.put("seller_no",seller_no);
        map.put("writer_type", "1"); // 하드코딩된 값 추가
        map.put("log_type", "2");
        int cnt = ss.update("product.changeActive",map);
        ss.insert("product.log_update",map);

        if(cnt>0){
            ss.commit();
        }else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int deleteProduct(String prod_no,String seller_no){
        SqlSession ss= FactoryService.getFactory().openSession();
        int cnt = ss.update("product.delete_product",prod_no);
        HashMap<String,String> map = new HashMap<>();
        map.put("prod_no",prod_no);
        map.put("seller_no",seller_no);
        ss.insert("product.log_delete_product",map);
        if(cnt>0){
            ss.commit();
        }else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static String addProduct(String prod_name,String major_category ,String middle_category,String price,String sale,
                                    String seller_no, String prod_image, String additional_image ,String content,String saled_price,String content_image){
        HashMap<String,Object> map = new HashMap<>();
        map.put("prod_name",prod_name);
        map.put("major_category",major_category);
        map.put("middle_category",middle_category);
        map.put("price",price);
        map.put("sale",sale);
        map.put("seller_no",seller_no);
        map.put("prod_image",prod_image);
        map.put("additional_image",additional_image);
        map.put("content",content);
        map.put("saled_price",saled_price);
        map.put("content_image",content_image);

        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("product.addProduct",map);
        ss.insert("product.log_add_product",map);
        System.out.println(map.get("id").getClass());
        String prod_no=null;
        if(cnt>0) {
            ss.commit();
            prod_no =String.valueOf(map.get("id"));
        }
        else
            ss.rollback();
        ss.close();


        return prod_no;
    }
    public static int updateProduct(String prod_no,String prod_name, String major_category,String middle_category,String price,String sale,
                                    String seller_no,String prod_image, String additional_image ,String content,String saled_price,String content_image){
        HashMap<String,Object> map = new HashMap<>();

        map.put("prod_no",prod_no);
        map.put("prod_name",prod_name);
        map.put("major_category",major_category);
        map.put("middle_category",middle_category);
        map.put("seller_no",seller_no);
        map.put("price",price);
        map.put("sale",sale);
        map.put("prod_image",prod_image);
        map.put("additional_image",additional_image);
        map.put("content",content);
        map.put("saled_price",saled_price);
        map.put("content_image",content_image);
        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.update("product.updateProduct",map);
        ss.insert("product.log_update_product",map);
        if(cnt>0) {
            ss.commit();
        }
        else
            ss.rollback();
        ss.close();


        return cnt;
    }
}
