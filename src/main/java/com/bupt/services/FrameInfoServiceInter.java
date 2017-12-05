package com.bupt.services;

import com.bupt.entity.FrameInfo;

/**
 * Created by hxg on 2017/9/8.
 */
public interface FrameInfoServiceInter {

    public FrameInfo selectByBaseInfoID(Long baseId);

    public int deleteByBaseInfoID(Long baseId);
}
