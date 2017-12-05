package com.bupt.services;

import com.bupt.entity.LibInfo;

/**
 * Created by hxg on 2017/9/8.
 */
public interface LibInfoServiceInter {

    public LibInfo selectByBaseInfoID(Long baseId);

    public int deleteByBaseInfoID(Long baseId);
}
