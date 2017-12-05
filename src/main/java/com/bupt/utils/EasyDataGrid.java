package com.bupt.utils;

import java.util.List;

/**
 * Created by hxg on 2017/9/8.
 */
public class EasyDataGrid {
    private long total;
    private List<?> rows;

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }
}
