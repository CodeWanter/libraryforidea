package com.wf.commons.result;

import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * @description：分页实体类 (结合jqery easyui)
 * @author：Wangzhixuan
 * @date：2015年4月23日 上午1:41:46
 */
@SuppressWarnings("rawtypes")
public class PageInfo {

    private final static int PAGESIZE = 10; //默认显示的记录数 

    private int total; // 总记录 
    private List rows; //显示的记录  

    @JsonIgnore
    private int from;
    @JsonIgnore
    private int size;
    @JsonIgnore
    private int nowpage; // 当前页 
    @JsonIgnore
    private int pagesize; // 每页显示的记录数 
    @JsonIgnore
    private Map<String, Object> condition; //查询条件

    @JsonIgnore
    private String sort = "seq";// 排序字段
    @JsonIgnore
    private String order = "asc";// asc，desc mybatis Order 关键字
    @JsonIgnore
    private String sortT = "title";
    @JsonIgnore
    private String sortA = "author";
    @JsonIgnore
    private String sortM = "time";
    @JsonIgnore
    private String title = "asc";// 题名
    @JsonIgnore
    private String author = "asc";// 作者
	@JsonIgnore
    private String time = "asc";// 时间
    public PageInfo() {}

    //构造方法
    public PageInfo(int nowpage, int pagesize) {
        //计算当前页  
        if (nowpage < 0) {
            this.nowpage = 1;
        } else {
            //当前页
            this.nowpage = nowpage;
        }
        //记录每页显示的记录数  
        if (pagesize < 0) {
            this.pagesize = PAGESIZE;
        } else {
            this.pagesize = pagesize;
        }
        //计算开始的记录和结束的记录  
        this.from = (this.nowpage - 1) * this.pagesize;
        this.size = this.pagesize;
    }

    // 构造方法
    public PageInfo(int nowpage, int pagesize, String sort, String order) {
        this(nowpage, pagesize) ;
        // 排序字段，正序还是反序
        this.sort = sort;
        this.order = order;
    }
    // 构造方法
    public PageInfo(int nowpage, int pagesize, String sortT, String title, String sortA, String author, String sortM, String time) {
        this(nowpage, pagesize) ;
        // 排序字段，正序还是反序
        this.sortT = sortT;
        this.sortA = sortA;
        this.sortM = sortM;
        this.title = title;
        this.author = author;
        this.time = time;
    }
    public String getSortT() {
		return sortT;
	}

	public void setSortT(String sortT) {
		this.sortT = sortT;
	}

	public String getSortA() {
		return sortA;
	}

	public void setSortA(String sortA) {
		this.sortA = sortA;
	}

	public String getSortM() {
		return sortM;
	}

	public void setSortM(String sortM) {
		this.sortM = sortM;
	}
    public String getTitle() {
 		return title;
 	}

 	public void setTitle(String title) {
 		this.title = title;
 	}

 	public String getAuthor() {
 		return author;
 	}

 	public void setAuthor(String author) {
 		this.author = author;
 	}

 	public String getTime() {
 		return time;
 	}

 	public void setTime(String time) {
 		this.time = time;
 	}
    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

    public int getFrom() {
        return from;
    }

    public void setFrom(int from) {
        this.from = from;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getNowpage() {
        return nowpage;
    }

    public void setNowpage(int nowpage) {
        this.nowpage = nowpage;
    }

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    public Map<String, Object> getCondition() {
        return condition;
    }

    public void setCondition(Map<String, Object> condition) {
        this.condition = condition;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }
}
