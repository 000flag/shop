package admin.dao;

import admin.vo.CustomerVO;
import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LogDao {
    public static List<LogVO> allLog(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<LogVO> vo = new ArrayList<LogVO>();
        vo = ss.selectList("root.allLog");
        ss.close();
        return vo;

    }
    public static LogVO[] searchLog(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<LogVO> list = ss.selectList("root.searchLog", map);
        LogVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new LogVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
}
