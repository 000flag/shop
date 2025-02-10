package admin.action;

import admin.dao.CategoryDao;
import admin.dao.MajorCategoryDao;
import admin.dao.MiddleCategoryDao;
import admin.vo.CategoryVO;
import admin.vo.MajorCategoryVO;
import admin.vo.MiddleCategoryVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminCategoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        MajorCategoryDao mdao = new MajorCategoryDao();

        List<MajorCategoryVO> list1 = mdao.allMajor();
        List<String> list1_1 = mdao.allMajorCategory();
        request.setAttribute("majorcategoryList", list1);
        request.setAttribute("majorcategoryName", list1_1);



        MiddleCategoryDao mddao = new MiddleCategoryDao();

        List<MiddleCategoryVO> list2 = mddao.allMiddle();
        List<String> list2_1 = mddao.allMiddleCategory();

        request.setAttribute("middlecategoryList", list2);
        request.setAttribute("middlecategoryName", list2_1);
        CategoryDao cateDao = new CategoryDao();
        List<CategoryVO> list3 = cateDao.allCategory();


        request.setAttribute("category1List", list3);
        System.out.println("category1List: " + list3);
        return "/admin/jsp/categorymain.jsp";
    }
}
