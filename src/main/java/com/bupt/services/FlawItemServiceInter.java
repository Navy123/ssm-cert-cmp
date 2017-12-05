package com.bupt.services;

import com.bupt.pojo.FlawItem;

/**
 * Created by hxg on 2017/9/10.
 */
public interface FlawItemServiceInter {

    public boolean saveFlawItem(FlawItem flawItem);

    public boolean editFlawItem(FlawItem flawItem);

    public boolean deleteFlawItems(String flawIds);

}
