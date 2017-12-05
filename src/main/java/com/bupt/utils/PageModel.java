package com.bupt.utils;


import java.util.List;

/**
 * Created by bearsmall on 2017/7/16.
 * 分页工具类
 */
public class PageModel {
    //当前页号
    private long currentPage = 1;
    //每页显示的记录数
    private int pageSize=12;
    //总记录数
    private long totalRecords;
    //总页数
    private long totalPage;
    //存放分页数据的集合
    private List<?> datas;
    public PageModel() {
        super();
    }
    public PageModel(long currentPage, int pageSize) {
        super();
        this.currentPage = currentPage;
        this.pageSize = pageSize;
    }
    public long getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(long currentPage) {
        this.currentPage = currentPage;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public long getTotalRecords() {
        return totalRecords;
    }
    public void setTotalRecords(long totalRecords) {
        this.totalRecords = totalRecords;
    }
    public long getTotalPage() {
        if(getTotalRecords()<=0){
            return 0;
        }
        else{
            totalPage = (totalRecords+pageSize-1)/pageSize;
        }
        return totalPage;
    }
    public void setTotalPage(long totalPage) {
        this.totalPage = totalPage;
    }
    public List<?> getDatas() {
        return datas;
    }
    public void setDatas(List<?> datas) {
        this.datas = datas;
    }
}

