package user.action.customer;

import user.action.Action;
import user.dao.customer.*;
import user.vo.customer.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CartAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String viewPage = null;
        if (action != null) {
            switch (action) {
                case "select":
                    List<CartVO> cart_list = CartDAO.selectCart(cvo.getId());
                    request.setAttribute("cart_list", cart_list);
                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "insert":
                    String i_prod_no = request.getParameter("prod_no");
                    String i_inventory_no = request.getParameter("inventory_no");
                    String i_count = request.getParameter("count");

                    if (i_prod_no != null && i_inventory_no != null && i_count != null) {
                        // 존재 여부 확인
                        int exists = CartDAO.selectExistsCart(cvo.getId(), i_prod_no, i_inventory_no);

                        // 있다면 수량만 증가
                        if (exists > 0) {
                            CartDAO.updateExistsCart(cvo.getId(), i_prod_no, i_inventory_no, i_count);
                        } else {
                            // 없다면 추가
                            CartVO ivo = new CartVO();
                            ivo.setCus_no(cvo.getId());
                            ivo.setProd_no(i_prod_no);
                            ivo.setInventory_no(i_inventory_no);
                            ivo.setCount(i_count);
                            CartDAO.insertCart(ivo);
                        }
                    }

                    // 장바구니 수
                    int cart_count = CartDAO.selectCartCount(cvo.getId());
                    session.setAttribute("cart_count", cart_count);

                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "update_count":
                    String u_id = request.getParameter("id");
                    String u_count = request.getParameter("count");

                    if (u_id != null && u_count != null) {
                        CartVO uvo = new CartVO();
                        uvo.setCus_no(cvo.getId());
                        uvo.setId(u_id);
                        uvo.setCount(u_count);
                        CartDAO.updateCart(uvo);
                    }

                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "delete":
                    String id = request.getParameter("id");

                    if (id != null) {
                        CartDAO.deleteCart(cvo.getId(), id);
                    }

                    // 장바구니 수
                    cart_count = CartDAO.selectCartCount(cvo.getId());
                    session.setAttribute("cart_count", cart_count);

                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "deletes":
                    String[] idsArr = request.getParameterValues("ids");

                    List<String> itemIds = Arrays.asList(idsArr);

                    if (!itemIds.isEmpty()) {
                        CartDAO.deletesCart(cvo.getId(), itemIds);
                    }

                    // 장바구니 수
                    cart_count = CartDAO.selectCartCount(cvo.getId());
                    session.setAttribute("cart_count", cart_count);

                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "delete_all":
                    CartDAO.deleteAllCart(cvo.getId());

                    // 장바구니 수
                    cart_count = CartDAO.selectCartCount(cvo.getId());
                    session.setAttribute("cart_count", cart_count);

                    viewPage = "/user/customer/jsp/cart/components/cartList.jsp";
                    break;
                case "order":
                    // 선택된 상품
                    String[] selectedItems = request.getParameterValues("selectedItems");
                    List<CartVO> cartItems = new ArrayList<>();
                    if (selectedItems != null) {
                        for (String selectedItem : selectedItems) {
                            CartVO item = CartDAO.selectCartDetails(cvo.getId(), selectedItem);
                            cartItems.add(item);
                        }
                    }
                    session.setAttribute("cartItems", cartItems);

                    // 기본 배송지
                    DeliveryVO delivery = DeliveryDAO.selectDeliveryDefault(cvo.getId());
                    request.setAttribute("delivery", delivery);

                    // 배송지 목록
                    List<DeliveryVO> deli_list = DeliveryDAO.selectDelivery(cvo.getId());
                    request.setAttribute("deli_list", deli_list);

                    // 보유 적립금
                    int points = PointDAO.selectSavePoint(cvo.getId());
                    request.setAttribute("points", points);

                    // 등급 정보
                    List<GradeVO> grades = GradeDAO.selectGradeAll();
                    request.setAttribute("grades", grades);

                    viewPage = "/user/customer/jsp/payment/payment.jsp";
                    break;
                case "select_size":
                    String prod_no = request.getParameter("prod_no");

                    // 상품 사이즈 목록
                    List<ProductVO> productSize = ProductDAO.selectSize(prod_no);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        out.print("{");
                        out.print("\"success\": true,");
                        out.print("\"data\": [");

                        if (productSize != null && !productSize.isEmpty()) {
                            for (int i = 0; i < productSize.size(); i++) {
                                ProductVO vo = productSize.get(i);

                                out.print("{");
                                out.print("\"prod_no\": \"" + vo.getId() + "\",");
                                out.print("\"inventory_no\": \"" + vo.getInventory_no() + "\",");
                                out.print("\"option_name\": \"" + vo.getI_option_name() + "\"");
                                out.print("}");

                                if (i < productSize.size() - 1) {
                                    out.print(",");
                                }
                            }
                        }

                        out.print("]");
                        out.print("}");
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
                case "update_size":
                    // 사이즈 변경
                    String us_id = request.getParameter("cart_no");
                    String us_prod_no = request.getParameter("prod_no");
                    String us_inventory_no = request.getParameter("inventory_no");

                    CartVO us_vo = new CartVO();
                    us_vo.setId(us_id);
                    us_vo.setCus_no(cvo.getId());
                    us_vo.setProd_no(us_prod_no);
                    us_vo.setInventory_no(us_inventory_no);
                    CartDAO.updateCart(us_vo);

                    viewPage = "/user/customer/jsp/cart/cart.jsp";
                    break;
            }
        } else {
            viewPage = "/user/customer/jsp/cart/cart.jsp";
        }

        return viewPage;
    }
}
