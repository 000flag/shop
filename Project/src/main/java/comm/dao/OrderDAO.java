package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.OrderVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class OrderDAO {
    public static OrderVO[] getOrderList(String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        OrderVO[] ar = null;
        List<OrderVO> list = ss.selectList("order.new_order_list",seller_no);
        if(list!=null){
            ar = new OrderVO[list.size()];
            System.out.println("배열 길이 : "+ar.length);
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static OrderVO getOrderOne(String order_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        OrderVO vo = ss.selectOne("order.get_order_one",order_no);
        if(vo.getReason_seller()==null)
            vo.setReason_seller("사유를 입력하지 않았습니다");
        switch (vo.getStatus()){
            case "1": vo.setStatus("신규주문"); break;
            case "2": vo.setStatus("발송준비"); break;
            case "3": vo.setStatus("발송완료"); break;
            case "4": vo.setStatus("배송완료"); break;
            case "5": vo.setStatus("구매확정"); break;
            case "6": vo.setStatus("구매취소"); break;
            case "7": vo.setStatus("반품신청"); break;
            case "8": vo.setStatus("교환신청"); break;
            case "9": vo.setStatus("반품거부"); break;
            case "10": vo.setStatus("교환거부"); break;
            case "11": vo.setStatus("반품완료"); break;
        }

        ss.close();
        return vo;
    }
    public static int changeStatus(String[] selectedOrders,String[] status,String seller_no){
        SqlSession ss= FactoryService.getFactory().openSession();
        int cnt = -1;
        boolean chk = true;
        HashMap<String,String> map = new HashMap<>();
        String str = new String();
        for(String s : status){
            System.out.println("status: "+s);
        }
        if(selectedOrders!=null && selectedOrders.length>0){
            for(int i=0;i<selectedOrders.length;i++){
                map.put("tid",selectedOrders[i].trim());
                if(status.length>1)
                    str= status[i].trim();
                else
                    str=status[0].trim();
                map.put("status",str);
                map.put("seller_no",seller_no);
                if(ss.update("order.change_status",map)<0)
                    chk=false;
                ss.insert("order.log_change_status",map);
            }
        }
        if(chk) {
            cnt = 1;
            ss.commit();
        }else{
            ss.rollback();
        }

        ss.close();
        return cnt;
    }
    public static int cancelOrder(String order_no,String reason_seller,String status,String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        HashMap<String,String> map = new HashMap<>();
        map.put("order_no",order_no);
        map.put("reason_seller",reason_seller);
        map.put("status",status);
        map.put("seller_no",seller_no);
        int cnt = ss.update("order.cancel_order",map);
        ss.insert("order.log_cancel_order",map);
        if(cnt>0){
            ss.commit();
        }else
            ss.rollback();

        ss.close();
        return cnt;
    }
}
