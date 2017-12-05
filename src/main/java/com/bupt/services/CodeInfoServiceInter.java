package com.bupt.services;

import com.bupt.entity.CodeInfo;

/**
 * Created by hxg on 2017/9/8.
 */
public interface CodeInfoServiceInter {

    public CodeInfo selectByBaseInfoID(Long baseId);

    public int deleteByBaseInfoID(Long baseId);
}
