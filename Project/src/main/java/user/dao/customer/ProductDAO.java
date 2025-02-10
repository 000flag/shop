package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.BoardVO;
import user.vo.customer.MajorCategoryVO;
import user.vo.customer.ProductVO;

import java.util.HashMap;
import java.util.List;

public class ProductDAO {
    // 카테고리 가져오기
    public static List<MajorCategoryVO> selectCategory() {
        List<MajorCategoryVO> categories = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            categories = ss.selectList("category.select_major_category");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return categories;
    }
    
    // 상품 수 조회
    public static int selectTotalCountProduct(String category_no, String search) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("category_no", category_no);
            map.put("search", search);

            cnt = ss.selectOne("product.select_total_count_product", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 상품 조회(비로그인)
    public static ProductVO[] selectProduct(String category, String sort, String search, int begin, int end) {
        ProductVO[] products = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("category_no", category);
            map.put("sort", sort);
            map.put("search", search);
            map.put("begin", begin);
            map.put("end", end);

            List<ProductVO> p_list = ss.selectList("product.select_product", map);

            if (p_list != null && !p_list.isEmpty()) {
                products = new ProductVO[p_list.size()];
                p_list.toArray(products);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return products;
    }

    // 상품 조회(로그인)
    public static ProductVO[] selectProduct(String cus_no, String category, String sort, String search, int begin, int end) {
        ProductVO[] products = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("category_no", category);
            map.put("sort", sort);
            map.put("search", search);
            map.put("begin", begin);
            map.put("end", end);

            List<ProductVO> p_list = ss.selectList("product.select_product", map);

            if (p_list != null && !p_list.isEmpty()) {
                products = new ProductVO[p_list.size()];
                p_list.toArray(products);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return products;
    }

    // 상품 상세 조회(상품 상세 페이지)
    public static ProductVO selectProdDetails(String id) {
        ProductVO productDetails = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            productDetails = ss.selectOne("product.select_prod_details", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return productDetails;
    }

    // 상품 상세 정보(주문서)
    public static ProductVO selectProductDetails(String prod_no, String inventory_no) {
        ProductVO productDetails = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("prod_no", prod_no);
            map.put("inventory_no", inventory_no);

            productDetails = ss.selectOne("product.select_product_details", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return productDetails;
    }

    // 상품 사이즈 조회
    public static List<ProductVO> selectSize(String id) {
        List<ProductVO> productSize = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            productSize = ss.selectList("product.select_size", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return productSize;
    }

    // 상품 리뷰 조회
    public static List<BoardVO> selectReview(String id, String gender, String height, String weight) {
        List<BoardVO> r_list = null;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("prod_no", id);
            if (gender != null && !gender.equals("")) {
                map.put("gender", gender);
            }
            if (height != null && !height.equals("")) {
                map.put("height", height);
            }
            if (weight != null && !weight.equals("")) {
                map.put("weight", weight);
            }

            r_list = ss.selectList("product.select_review", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return r_list;
    }

    // 재고 수량 감소
    public static int updateInventory(String id, String count) {
        int cnt = 0;
        SqlSession ss= FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("count", count);

            cnt = ss.update("product.update_inventory", map);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }
}
