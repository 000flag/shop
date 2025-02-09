package seller.action;

import user.action.Action;
import comm.dao.DashboardDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class DashBoardAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");

        int newOrder = 0;
        int readyDeli =0;
        int changeProd =0;
        int returnProd=0;
        Map<String,Object>[] ar = DashboardDAO.getDashboard(seller_no);
        request.setAttribute("ar",ar);
        for(Map<String,Object> map : ar){
            switch ((Integer)map.get("status")){
                case 1: newOrder=((Number)map.get("count")).intValue();
                    break;
                case 2: readyDeli=((Number)map.get("count")).intValue();
                    break;
                case 8: changeProd=((Number)map.get("count")).intValue();
                    break;
                case 7: returnProd=((Number)map.get("count")).intValue();

            }
        }
        int[] arr = DashboardDAO.getQuestConfirm(seller_no);
        int quest = arr[0];
        int confirm = arr[1];
        request.setAttribute("confirm",confirm);
        request.setAttribute("quest",quest);
        request.setAttribute("newOrder",newOrder);
        request.setAttribute("readyDeli",readyDeli);
        request.setAttribute("changeProd",changeProd);
        request.setAttribute("returnProd",returnProd);
        HashMap<String,Object>[] arMap = DashboardDAO.getTotal(seller_no);
        request.setAttribute("arMap",arMap);
        return "/seller/jsp/dash_board.jsp";
    }
}
