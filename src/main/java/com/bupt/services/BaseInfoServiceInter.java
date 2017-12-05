package com.bupt.services;

import com.bupt.entity.BaseInfoWithBLOBs;
import com.bupt.utils.PageModel;

/**
 * Created by hxg on 2017/9/8.
 */
public interface BaseInfoServiceInter {

    public BaseInfoWithBLOBs selectByPrimaryKey(Long id);

    public PageModel selectByPagination(Long pageNumber, int pageSize);

}
