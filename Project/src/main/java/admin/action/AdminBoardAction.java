package admin.action;

import admin.dao.BoardDao;

import admin.vo.BoardVO;

import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminBoardAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {





        BoardDao bdao = new BoardDao();

        List<BoardVO> list1 = bdao.allBoard();
        request.setAttribute("boardList", list1);
        List<String> list1_1 = bdao.allBoardCategory();
        request.setAttribute("boardName", list1_1);
        BoardVO bvo = new BoardVO();
        String id = (String) request.getParameter("boardId");
        bvo =bdao.getBoardById(id);
        request.setAttribute("boardOne", bvo);










      return "/admin/jsp/boardmain.jsp";
    }
}
