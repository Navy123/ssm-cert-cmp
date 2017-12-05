package com.bupt.services;

import com.bupt.entity.AffectedProductWithBLOBs;

/**
 * Created by hxg on 2017/9/8.
 */
public interface AffectedProductServiceInter{

    public AffectedProductWithBLOBs selectByBaseInfoID(Long baseId);
}
