package com.bupt.services.impl;

import com.bupt.dao.AffectedProductMapper;
import com.bupt.entity.AffectedProductWithBLOBs;
import com.bupt.services.AffectedProductServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by hxg on 2017/9/8.
 */
@Service
public class AffectedProductServiceImpl implements AffectedProductServiceInter {
    @Autowired
    private AffectedProductMapper affectedProductDao;

    @Override
    public AffectedProductWithBLOBs selectByBaseInfoID(Long baseId) {
        return affectedProductDao.selectByBaseInfoID(baseId);
    }
}
