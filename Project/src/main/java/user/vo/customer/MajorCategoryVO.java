package user.vo.customer;

import java.util.List;

public class MajorCategoryVO {
    private String id, name, ename, type;
    List<MiddleCategoryVO> middleCategories;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<MiddleCategoryVO> getMiddleCategories() {
        return middleCategories;
    }

    public void setMiddleCategories(List<MiddleCategoryVO> middleCategories) {
        this.middleCategories = middleCategories;
    }
}
