package com.bupt.services.impl;

import com.bupt.dao.CodeInfoMapper;
import com.bupt.entity.CodeInfo;
import com.bupt.services.CodeInfoServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class CodeInfoServiceImpl implements CodeInfoServiceInter {
    @Autowired
    private CodeInfoMapper codeInfoDao;

    @Override
    public CodeInfo selectByBaseInfoID(Long baseId) {
        return codeInfoDao.selectByBaseInfoID(baseId);
    }

    @Override
    public int deleteByBaseInfoID(Long baseId) {
        return codeInfoDao.deleteByBaseInfoID(baseId);
    }
}
