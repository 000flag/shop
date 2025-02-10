package user.action.Snap;

import user.action.Action;

import user.vo.snap.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignupAction implements Action {


      @Override
      public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 모든 입력 데이터를 가져오기
        String cus_id = request.getParameter("cus_id");
        String cus_pw = request.getParameter("cus_pw");
        String name = request.getParameter("name");
        String nickname = request.getParameter("nickname");
        String gender = request.getParameter("gender");
        String birth_date = request.getParameter("birth_date");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String height = request.getParameter("height");
        String weight = request.getParameter("weight");
        String is_del = "0";



        CustomerVO vo = new CustomerVO();
        vo.setCus_id(cus_id);
        vo.setCus_pw(cus_pw);
        vo.setName(name);
        vo.setNickname(nickname);;
        vo.setGender(gender);
        System.out.println("성별:"+gender);
        vo.setBirth_date(birth_date);
        vo.setPhone(phone);
        vo.setEmail(email);
        vo.setHeight(height);
        vo.setWeight(weight);
        vo.setIs_del(is_del);


        //customer cusid 세션에 저장하는값
          int customer_id = user.dao.snap.CustomerDao.getId(nickname);
          HttpSession session = request.getSession();
          session.setAttribute("cus_id", customer_id);
          System.out.println("현제접속중인 cus_id:"+cus_id);

        int cnt = user.dao.snap.CustomerDao.cusadd(vo);
        System.out.println("cnt:"+cnt);
        // 성공 시 로그인 페이지로 이동
        if (cnt > 0) {
          return "/user/snap/jsp/login/login.jsp";
        }
        else  {
          return "/user/snap/jsp/login/login.jsp";
        }


      }
}
