package com.bupt.services.impl;

import com.bupt.dao.FrameInfoMapper;
import com.bupt.entity.FrameInfo;
import com.bupt.services.FrameInfoServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class FrameInfoServiceImpl implements FrameInfoServiceInter {
    @Autowired
    private FrameInfoMapper frameInfoDao;

    @Override
    public FrameInfo selectByBaseInfoID(Long baseId) {
        return frameInfoDao.selectByBaseInfoID(baseId);
    }

    @Override
    public int deleteByBaseInfoID(Long baseId) {
        return frameInfoDao.deleteByBaseInfoID(baseId);
    }
}

