package user.util;

// 페이징 기법에 필요한 것들을 저장하는 객체
public class Paging {
    private int nowPage = 1; // 현재 페이지 값 == cPage
    private int numPerPage = 10; // 한 페이지 당 보여질 게시물의 수

    // 페이징을 위한 변수
    private int totalRecord; // 총 게시물의 수

    private int pagePerBlock = 5; // 한 블럭 당 표현할 페이지 수
    private int totalPage; // 전체 페이지 수

    private int begin; // 현재 페이지 값에 따라 bbs_t 테이블에서 가져올 게시물의 시작 행 번호
    private int end; // 현재 페이지 값에 따라 bbs_t 테이블에서 가져올 게시물의 마지막 행 번호

    private int startPage; // 한 블럭의 시작 페이지 값
    private int endPage; // 한 블럭의 끝 페이지 값

    // 현재 객체를 생성할 때 기본 생성자를 부르면 한 페이지 당 게시물을 10개씩 보여주는 페이징 처리를 한다.
    public Paging() {}

    public Paging(int numPerPage, int pagePerBlock) {
        // 생성자는 멤버 변수들에 대한 초기화를 목적으로 한다.
        this.numPerPage = numPerPage;
        this.pagePerBlock = pagePerBlock;
    }

    public int getNowPage() {
        return nowPage;
    }

    public void setNowPage(int nowPage) { // 현재 페이지 값이 변경될 때
        this.nowPage = nowPage;

        // 현재 페이지 값이 변경되면 표현할 게시물들이 변경되어야 한다. 즉, begin과 end값이 변경되어 DB로부터 다시 게시물들을 가져와야 한다.

        // 현재 페이지 값은 전체 페이지 값을 넘지 못하도록 한다.
        if (this.nowPage > this.totalPage) {
            this.nowPage = this.totalPage;
        }

        // 각 페이지의 시작 행 번호(begin)와 마지막 행 번호(end)를 구한다.
        // 예) 현재 페이지가 1일 때 begin은 1, end는 10이어야 한다.
        // 예) 현재 페이지가 2일 때 begin은 11, end는 20이어야 한다.
        // 예) 현재 페이지가 3일 때 begin은 21, end는 30이어야 한다.
        // 예) 현재 페이지가 4일 때 begin은 31, end는 40이어야 한다.
        this.begin = (this.nowPage - 1) * this.numPerPage + 1;
        this.end = this.nowPage * this.numPerPage;

        // 현재 페이지 값에 의해 블럭의 시작 페이지(startPage)를 구한다.
        this.startPage = (int) ((this.nowPage - 1) / this.pagePerBlock) * this.pagePerBlock + 1;
        // 블럭의 마지막 페이지 값 구하기
        this.endPage = this.startPage + this.pagePerBlock - 1;

        // 위에서 구한 마지막 페이지 값이 전체 페이지 수보다 큳 때 우려된다.(만약 총 게시물이 32개 일 때 계산식으로 endPage가 35가 되는데, 이 때 33, 34, 35가 쓸모없는 빈 페이지가 된다.)
        if (this.endPage > this.totalPage) {
            this.endPage = this.totalPage;
        }
    }

    public int getNumPerPage() {
        return numPerPage;
    }

    public void setNumPerPage(int numPerPage) {
        this.numPerPage = numPerPage;
    }

    public int getTotalRecord() {
        return totalRecord;
    }

    // 총 게시물 수가 지정될 때 자동으로 전체 페이지 수를 구하면 좋을 것 같다.
    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
        
        // 총 게시물 수가 지정되었으니 전체 페이지 수를 구한다.
        /*this.totalPage = this.totalRecord / this.numPerPage;
        
        if (this.totalRecord % this.numPerPage != 0) { // 나머지가 있을 때
            this.totalPage++;
        }*/
        // 위 계산 로직을 아래와 같이 한 줄로 쓸 수 있다.
        this.totalPage = (int) Math.ceil((double) this.totalRecord / this.numPerPage);
    }

    public int getPagePerBlock() {
        return pagePerBlock;
    }

    public void setPagePerBlock(int pagePerBlock) {
        this.pagePerBlock = pagePerBlock;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBegin() {
        return begin;
    }

    public void setBegin(int begin) {
        this.begin = begin;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public int getStartPage() {
        return startPage;
    }

    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
}
