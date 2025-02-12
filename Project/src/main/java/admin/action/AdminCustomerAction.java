package admin.action;

import admin.dao.CustomerDao;
import user.action.Action;
import admin.vo.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminCustomerAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        CustomerDao cdao = new CustomerDao();

        List<CustomerVO> list = cdao.allCustomer();
        System.out.println("list:"+list.size());

        request.setAttribute("customerList", list);
        List<String> list1 = cdao.allCustomerName();

        request.setAttribute("customerName", list1);
        System.out.println("CC"+list1.size());

        String cnt0 = cdao.countcus0();
        String cnt1 = cdao.countcus1();
        String cnt2 = cdao.countcus2();
        request.setAttribute("cnt0", cnt0);
        request.setAttribute("cnt1", cnt1);
        request.setAttribute("cnt2", cnt2);

        //request.setAttribute("cus0",string0);





        String c0 = cdao.getCountCustomer0();
        String c1 = cdao.getCountCustomer1();
        String c2 = cdao.getCountCustomer2();

        request.setAttribute("activeCount", c0);
        request.setAttribute("withdrawnCount", c1);
        request.setAttribute("stoppedCount", c2);



        return "/admin/jsp/customermain.jsp";
    }
}
