package com.bupt.services.impl;

import com.bupt.dao.BaseInfoMapper;
import com.bupt.entity.BaseInfoWithBLOBs;
import com.bupt.services.BaseInfoServiceInter;
import com.bupt.utils.PageModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class BaseInfoServiceImpl implements BaseInfoServiceInter {
    @Autowired
    private BaseInfoMapper baseInfoDao;

    @Override
    public BaseInfoWithBLOBs selectByPrimaryKey(Long id) {
        return baseInfoDao.selectByPrimaryKey(id);
    }

    @Override
    public PageModel selectByPagination(Long pageNumber, int pageSize) {
        PageModel pageModel = new PageModel();
        pageModel.setCurrentPage(pageNumber);
        pageModel.setPageSize(pageSize);
        long totalRecords = baseInfoDao.countTotalSize();
        pageModel.setTotalRecords(totalRecords);
        long offset = (pageNumber-1)*pageSize;
        List<BaseInfoWithBLOBs> list =  baseInfoDao.selectByPagination(offset,pageSize);
        pageModel.setDatas(list);
        return pageModel;
    }
}
