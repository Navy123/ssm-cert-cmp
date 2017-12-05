package com.bupt.services.impl;

import com.bupt.dao.LibInfoMapper;
import com.bupt.entity.LibInfo;
import com.bupt.services.LibInfoServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class LibInfoServiceImpl implements LibInfoServiceInter{
    @Autowired
    private LibInfoMapper libInfoDao;

    @Override
    public LibInfo selectByBaseInfoID(Long baseId) {
        return libInfoDao.selectByBaseInfoID(baseId);
    }

    @Override
    public int deleteByBaseInfoID(Long baseId) {
        return libInfoDao.deleteByBaseInfoID(baseId);
    }
}
