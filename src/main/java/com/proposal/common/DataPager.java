package com.proposal.common;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class DataPager {

    private int pageIndex;
    private int pageSize;
    private int draw;
    private int recordsTotal;
    private int recordsFiltered;
    private String sort;
    private String order;
    private List<?> data;
    private String searchVal;

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getDraw() {
        return draw;
    }

    public void setDraw(int draw) {
        this.draw = draw;
    }

    public int getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(int recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public int getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(int recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
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

    public List<?> getData() {
        return data;
    }

    public void setData(List<?> data) {
        this.data = data;
    }

    public String getSearchVal() {
        return searchVal;
    }

    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }

    public void init(HttpServletRequest request) {
        int start = Integer.parseInt(request.getParameter("start"));
        int length = Integer.parseInt(request.getParameter("length"));
        this.setPageIndex(start / length + 1);
        this.setPageSize(Integer.parseInt(request.getParameter("length")));
        this.setDraw(Integer.parseInt(request.getParameter("draw")));
        int sortindex = Integer.parseInt(request.getParameter("order[0][column]"));
        this.setSort(request.getParameter("columns[" + sortindex + "][data]"));
        this.setOrder(request.getParameter("order[0][dir]"));
        this.setSearchVal(request.getParameter("search[value]"));
        this.toString();
    }

    @Override
    public String toString() {
        System.out.print("pageIndex = " + pageIndex + " ");
        System.out.print("pageSize = " + pageSize + " ");
        System.out.print("draw = " + draw + " ");
        System.out.print("recordsTotal = " + recordsTotal + " ");
        System.out.print("sort = " + sort + " ");
        System.out.print("recordsFiltered = " + recordsFiltered + " ");
        System.out.print("order = " + order + " ");
        System.out.print("data = " + data + " ");
        System.out.print("searchVal = " + searchVal + " ");
        return super.toString();
    }
}
