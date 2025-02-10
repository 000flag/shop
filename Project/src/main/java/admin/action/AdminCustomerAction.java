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




        String c0 = cdao.getCountCustomer0();
        String c1 = cdao.getCountCustomer1();
        String c2 = cdao.getCountCustomer2();

        request.setAttribute("activeCount", c0);
        request.setAttribute("withdrawnCount", c1);
        request.setAttribute("stoppedCount", c2);



        return "/admin/jsp/customermain.jsp";
    }
}
